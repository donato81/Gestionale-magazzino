-- ============================================================
-- 004_onboarding_rpc.sql
-- Gestionale Magazzino Universale
-- MVP 1.0
--
-- Stato: APPROVATO
--
-- Contenuto:
-- - funzione RPC crea_azienda_e_profilo()
--
-- Dipende da:
-- - 001_schema.sql
-- - 003_rls.sql
--
-- Scopo:
-- completare il primo onboarding utente evitando il blocco logico
-- tra creazione azienda e creazione profilo.
-- ============================================================


-- ============================================================
-- 1. RPC crea_azienda_e_profilo()
-- ============================================================
--
-- Flusso:
-- utente autenticato
-- ?
-- crea azienda
-- ?
-- crea profilo
-- ?
-- restituisce azienda_id e profilo_id
--
-- Regole:
-- - l'utente deve essere autenticato
-- - l'utente non deve avere già un profilo
-- - il nome azienda è obbligatorio
-- - il profilo creato appartiene sempre ad auth.uid()
-- - l'operazione è atomica
-- - richieste simultanee dello stesso utente vengono serializzate
-- ============================================================

create or replace function public.crea_azienda_e_profilo(
  p_nome_azienda text,
  p_nome_profilo text default null,
  p_email text default null
)
returns table (
  out_azienda_id uuid,
  out_profilo_id uuid,
  out_nome_azienda text
)
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  v_user_id uuid;
  v_azienda_id uuid;
  v_profilo_id uuid;
  v_existing_profile_id uuid;
begin
  -- ==========================================================
  -- 1. Utente autenticato
  -- ==========================================================

  v_user_id := auth.uid();

  if v_user_id is null then
    raise exception 'Utente non autenticato';
  end if;


  -- ==========================================================
  -- 2. Lock pessimistico sull'utente
  -- ==========================================================
  --
  -- Evita race condition in caso di doppia chiamata simultanea
  -- alla RPC di onboarding per lo stesso utente.
  -- ==========================================================

  perform 1
  from auth.users
  where id = v_user_id
  for update;


  -- ==========================================================
  -- 3. Validazione nome azienda
  -- ==========================================================

  if p_nome_azienda is null or btrim(p_nome_azienda) = '' then
    raise exception 'Nome azienda obbligatorio';
  end if;


  -- ==========================================================
  -- 4. Verifica profilo già esistente
  -- ==========================================================
  --
  -- MVP 1:
  -- ogni utente può avere un solo profilo.
  -- Se il profilo esiste già, l'onboarding non deve ripartire.
  -- ==========================================================

  select p.id
    into v_existing_profile_id
  from public.profili p
  where p.user_id = v_user_id;

  if v_existing_profile_id is not null then
    raise exception 'Profilo già esistente';
  end if;


  -- ==========================================================
  -- 5. Creazione azienda
  -- ==========================================================

  insert into public.aziende (
    nome
  )
  values (
    btrim(p_nome_azienda)
  )
  returning id
  into v_azienda_id;


  -- ==========================================================
  -- 6. Creazione profilo
  -- ==========================================================

  insert into public.profili (
    user_id,
    azienda_id,
    nome,
    email
  )
  values (
    v_user_id,
    v_azienda_id,
    nullif(btrim(coalesce(p_nome_profilo, '')), ''),
    nullif(btrim(coalesce(p_email, '')), '')
  )
  returning id
  into v_profilo_id;


  -- ==========================================================
  -- 7. Risultato
  -- ==========================================================

  out_azienda_id := v_azienda_id;
  out_profilo_id := v_profilo_id;
  out_nome_azienda := btrim(p_nome_azienda);

  return next;
end;
$$;


-- ============================================================
-- 2. COMMENTO DOCUMENTALE
-- ============================================================

comment on function public.crea_azienda_e_profilo(
  text,
  text,
  text
) is
  'RPC di onboarding: crea azienda e profilo utente in una singola operazione atomica.';


-- ============================================================
-- 3. PERMESSI DI ESECUZIONE
-- ============================================================

grant execute on function public.crea_azienda_e_profilo(
  text,
  text,
  text
) to authenticated;


-- ============================================================
-- FINE 004_onboarding_rpc.sql
-- ============================================================

