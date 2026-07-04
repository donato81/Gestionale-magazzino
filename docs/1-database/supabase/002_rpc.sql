
-- ============================================================
-- 002_rpc.sql
-- Gestionale Magazzino Universale
-- MVP 1.0
--
-- Stato: APPROVATO
--
-- Contenuto:
-- - funzione RPC registra_movimento()
--
-- Dipende da:
-- - 001_schema.sql
--
-- NON contiene:
-- - RLS policy
-- ============================================================


-- ============================================================
-- 1. RPC registra_movimento()
-- ============================================================
--
-- Scopo:
-- gestire in modo atomico ogni variazione di scorta.
--
-- Operazioni supportate:
-- - carico
-- - vendita
-- - reso
-- - rettifica
--
-- Regole principali:
-- - nessun p_azienda_id dal client
-- - azienda derivata da auth.uid() -> profili
-- - prodotto bloccato con SELECT ... FOR UPDATE
-- - scorta negativa vietata
-- - rettifica tramite nuova scorta finale
-- - quantità sempre positiva nello storico
-- - aggiornamento scorta consentito tramite app.allow_stock_update
-- - funzione SECURITY DEFINER
-- ============================================================

create or replace function public.registra_movimento(
  p_prodotto_id uuid,
  p_tipo_movimento text,
  p_quantita numeric default null,
  p_nuova_scorta numeric default null,
  p_fornitore_id uuid default null,
  p_prezzo_unitario numeric default null,
  p_note text default null
)
returns table (
  out_movimento_id uuid,
  out_nuova_scorta numeric,
  out_tipo_movimento text
)
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  v_user_id uuid;
  v_azienda_id uuid;

  v_prodotto_id uuid;
  v_prodotto_attivo boolean;
  v_scorta_prima numeric(12,3);
  v_scorta_dopo numeric(12,3);
  v_quantita_movimento numeric(12,3);

  v_fornitore_valido boolean;
  v_movimento_id uuid;
  v_differenza numeric(12,3);
begin
  -- ==========================================================
  -- 1. Utente autenticato
  -- ==========================================================

  v_user_id := auth.uid();

  if v_user_id is null then
    raise exception 'Utente non autenticato';
  end if;


  -- ==========================================================
  -- 2. Recupero azienda dell'utente
  -- ==========================================================

  select p.azienda_id
    into v_azienda_id
  from public.profili p
  where p.user_id = v_user_id;

  if v_azienda_id is null then
    raise exception 'Profilo non trovato';
  end if;


  -- ==========================================================
  -- 3. Validazione tipo movimento
  -- ==========================================================

  if p_tipo_movimento not in ('carico', 'vendita', 'reso', 'rettifica') then
    raise exception 'Tipo movimento non valido';
  end if;


  -- ==========================================================
  -- 4. Validazione prezzo unitario
  -- ==========================================================

  if p_prezzo_unitario is not null and p_prezzo_unitario < 0 then
    raise exception 'Prezzo unitario non valido';
  end if;


  -- ==========================================================
  -- 5. Validazione parametri per carico / vendita / reso
  -- ==========================================================

  if p_tipo_movimento in ('carico', 'vendita', 'reso') then

    if p_quantita is null then
      raise exception 'Quantità obbligatoria';
    end if;

    if p_quantita <= 0 then
      raise exception 'Quantità non valida';
    end if;

    if p_nuova_scorta is not null then
      raise exception 'Nuova scorta non consentita per questo tipo movimento';
    end if;

  end if;


  -- ==========================================================
  -- 6. Validazione parametri per rettifica
  -- ==========================================================

  if p_tipo_movimento = 'rettifica' then

    if p_nuova_scorta is null then
      raise exception 'Nuova scorta obbligatoria';
    end if;

    if p_nuova_scorta < 0 then
      raise exception 'Nuova scorta non valida';
    end if;

    if p_quantita is not null then
      raise exception 'Quantità non consentita per rettifica';
    end if;

  end if;


  -- ==========================================================
  -- 7. Regole fornitore per tipo movimento
  -- ==========================================================
  --
  -- MVP 1:
  -- - il fornitore è obbligatorio per il carico
  -- - il fornitore non viene usato per vendita, reso cliente, rettifica
  -- ==========================================================

  if p_tipo_movimento = 'carico' and p_fornitore_id is null then
    raise exception 'Fornitore obbligatorio per il carico';
  end if;

  if p_tipo_movimento in ('vendita', 'reso', 'rettifica')
     and p_fornitore_id is not null
  then
    raise exception 'Fornitore non consentito per questo tipo movimento';
  end if;


  -- ==========================================================
  -- 8. Lock pessimistico del prodotto
  -- ==========================================================
  --
  -- SELECT ... FOR UPDATE impedisce race condition:
  -- due movimenti simultanei sullo stesso prodotto vengono serializzati.
  -- ==========================================================

  select
    pr.id,
    pr.attivo,
    pr.scorta_attuale
  into
    v_prodotto_id,
    v_prodotto_attivo,
    v_scorta_prima
  from public.prodotti pr
  where pr.id = p_prodotto_id
    and pr.azienda_id = v_azienda_id
  for update;

  if v_prodotto_id is null then
    raise exception 'Prodotto non trovato';
  end if;

  if v_prodotto_attivo is false then
    raise exception 'Prodotto disattivato';
  end if;


  -- ==========================================================
  -- 9. Verifica fornitore
  -- ==========================================================

  if p_fornitore_id is not null then

    select exists (
      select 1
      from public.fornitori f
      where f.id = p_fornitore_id
        and f.azienda_id = v_azienda_id
        and f.attivo = true
    )
    into v_fornitore_valido;

    if v_fornitore_valido is not true then
      raise exception 'Fornitore non valido';
    end if;

  end if;


  -- ==========================================================
  -- 10. Calcolo nuova scorta
  -- ==========================================================

  if p_tipo_movimento = 'carico' then

    v_scorta_dopo := v_scorta_prima + p_quantita;
    v_quantita_movimento := p_quantita;

  elsif p_tipo_movimento = 'vendita' then

    v_scorta_dopo := v_scorta_prima - p_quantita;
    v_quantita_movimento := p_quantita;

    if v_scorta_dopo < 0 then
      raise exception 'Scorta insufficiente';
    end if;

  elsif p_tipo_movimento = 'reso' then

    v_scorta_dopo := v_scorta_prima + p_quantita;
    v_quantita_movimento := p_quantita;

  elsif p_tipo_movimento = 'rettifica' then

    v_scorta_dopo := p_nuova_scorta;
    v_differenza := v_scorta_dopo - v_scorta_prima;

    if v_differenza = 0 then
      raise exception 'La nuova scorta coincide con quella attuale';
    end if;

    v_quantita_movimento := abs(v_differenza);

  end if;


  -- ==========================================================
  -- 11. Controllo finale scorta negativa
  -- ==========================================================

  if v_scorta_dopo < 0 then
    raise exception 'Scorta insufficiente';
  end if;


  -- ==========================================================
  -- 12. Abilitazione temporanea aggiornamento scorta
  -- ==========================================================
  --
  -- Necessaria per superare il trigger prevent_direct_stock_update().
  -- Il terzo parametro true rende il flag locale alla transazione.
  -- ==========================================================

  perform set_config('app.allow_stock_update', 'on', true);


  -- ==========================================================
  -- 13. Inserimento movimento
  -- ==========================================================

  insert into public.movimenti_magazzino (
    azienda_id,
    prodotto_id,
    fornitore_id,
    tipo_movimento,
    quantita,
    scorta_prima,
    scorta_dopo,
    prezzo_unitario,
    note,
    creato_da
  )
  values (
    v_azienda_id,
    p_prodotto_id,
    p_fornitore_id,
    p_tipo_movimento,
    v_quantita_movimento,
    v_scorta_prima,
    v_scorta_dopo,
    p_prezzo_unitario,
    p_note,
    v_user_id
  )
  returning id
  into v_movimento_id;


  -- ==========================================================
  -- 14. Aggiornamento scorta prodotto
  -- ==========================================================

  update public.prodotti
  set scorta_attuale = v_scorta_dopo
  where id = p_prodotto_id
    and azienda_id = v_azienda_id;


  -- ==========================================================
  -- 15. Risultato
  -- ==========================================================

  out_movimento_id := v_movimento_id;
  out_nuova_scorta := v_scorta_dopo;
  out_tipo_movimento := p_tipo_movimento;

  return next;
end;
$$;


-- ============================================================
-- 2. COMMENTO DOCUMENTALE
-- ============================================================

comment on function public.registra_movimento(
  uuid,
  text,
  numeric,
  numeric,
  uuid,
  numeric,
  text
) is
  'RPC centrale per registrare movimenti di magazzino e aggiornare la scorta in modo atomico.';


-- ============================================================
-- 3. PERMESSI DI ESECUZIONE
-- ============================================================
--
-- Le RLS verranno definite in 003_rls.sql.
-- Qui si abilita solo l'esecuzione della RPC agli utenti autenticati.
-- ============================================================

grant execute on function public.registra_movimento(
  uuid,
  text,
  numeric,
  numeric,
  uuid,
  numeric,
  text
) to authenticated;


-- ============================================================
-- FINE 002_rpc.sql
-- ============================================================

