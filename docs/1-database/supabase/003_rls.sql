-- ============================================================
-- 003_rls.sql
-- Gestionale Magazzino Universale
-- MVP 1.0
--
-- Stato: APPROVATO
--
-- Contenuto:
-- - abilitazione Row Level Security
-- - policy RLS per aziende
-- - policy RLS per profili
-- - policy RLS per categorie
-- - policy RLS per fornitori
-- - policy RLS per prodotti
-- - policy RLS per movimenti_magazzino
-- - grant base per ruolo authenticated
--
-- Dipende da:
-- - 001_schema.sql
-- - 002_rpc.sql
--
-- Nota importante:
-- il flusso di onboarding verrà completato tramite RPC dedicata
-- nel file successivo:
--
-- 004_onboarding_rpc.sql
--
-- La RPC crea_azienda_e_profilo() eviterà il blocco logico
-- tra creazione azienda e creazione profilo.
-- ============================================================


-- ============================================================
-- 1. ABILITAZIONE RLS
-- ============================================================

alter table public.aziende enable row level security;
alter table public.profili enable row level security;
alter table public.categorie enable row level security;
alter table public.fornitori enable row level security;
alter table public.prodotti enable row level security;
alter table public.movimenti_magazzino enable row level security;


-- ============================================================
-- 2. PULIZIA POLICY ESISTENTI
-- ============================================================

drop policy if exists aziende_select_membri on public.aziende;
drop policy if exists aziende_insert_authenticated on public.aziende;
drop policy if exists aziende_update_membri on public.aziende;

drop policy if exists profili_select_own on public.profili;
drop policy if exists profili_insert_own on public.profili;
drop policy if exists profili_update_own on public.profili;

drop policy if exists categorie_select_membri on public.categorie;
drop policy if exists categorie_insert_membri on public.categorie;
drop policy if exists categorie_update_membri on public.categorie;

drop policy if exists fornitori_select_membri on public.fornitori;
drop policy if exists fornitori_insert_membri on public.fornitori;
drop policy if exists fornitori_update_membri on public.fornitori;

drop policy if exists prodotti_select_membri on public.prodotti;
drop policy if exists prodotti_insert_membri on public.prodotti;
drop policy if exists prodotti_update_membri on public.prodotti;

drop policy if exists movimenti_select_membri on public.movimenti_magazzino;


-- ============================================================
-- 3. TABELLA aziende
-- ============================================================

create policy aziende_select_membri
on public.aziende
for select
to authenticated
using (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = aziende.id
  )
);


create policy aziende_insert_authenticated
on public.aziende
for insert
to authenticated
with check (
  auth.role() = 'authenticated'
);


create policy aziende_update_membri
on public.aziende
for update
to authenticated
using (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = aziende.id
  )
)
with check (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = aziende.id
  )
);


-- Nessuna policy DELETE su aziende.


-- ============================================================
-- 4. TABELLA profili
-- ============================================================
--
-- Nota:
-- qui NON si usa una policy basata su EXISTS dentro profili,
-- per evitare ricorsione RLS.
-- ============================================================

create policy profili_select_own
on public.profili
for select
to authenticated
using (
  user_id = auth.uid()
);


create policy profili_insert_own
on public.profili
for insert
to authenticated
with check (
  user_id = auth.uid()
);


create policy profili_update_own
on public.profili
for update
to authenticated
using (
  user_id = auth.uid()
)
with check (
  user_id = auth.uid()
);


-- Nessuna policy DELETE su profili.


-- ============================================================
-- 5. TABELLA categorie
-- ============================================================

create policy categorie_select_membri
on public.categorie
for select
to authenticated
using (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = categorie.azienda_id
  )
);


create policy categorie_insert_membri
on public.categorie
for insert
to authenticated
with check (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = categorie.azienda_id
  )
);


create policy categorie_update_membri
on public.categorie
for update
to authenticated
using (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = categorie.azienda_id
  )
)
with check (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = categorie.azienda_id
  )
);


-- Nessuna policy DELETE su categorie.
-- Archiviazione tramite attiva = false.


-- ============================================================
-- 6. TABELLA fornitori
-- ============================================================

create policy fornitori_select_membri
on public.fornitori
for select
to authenticated
using (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = fornitori.azienda_id
  )
);


create policy fornitori_insert_membri
on public.fornitori
for insert
to authenticated
with check (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = fornitori.azienda_id
  )
);


create policy fornitori_update_membri
on public.fornitori
for update
to authenticated
using (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = fornitori.azienda_id
  )
)
with check (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = fornitori.azienda_id
  )
);


-- Nessuna policy DELETE su fornitori.
-- Archiviazione tramite attivo = false.


-- ============================================================
-- 7. TABELLA prodotti
-- ============================================================

create policy prodotti_select_membri
on public.prodotti
for select
to authenticated
using (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = prodotti.azienda_id
  )
);


create policy prodotti_insert_membri
on public.prodotti
for insert
to authenticated
with check (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = prodotti.azienda_id
  )
);


create policy prodotti_update_membri
on public.prodotti
for update
to authenticated
using (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = prodotti.azienda_id
  )
)
with check (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = prodotti.azienda_id
  )
);


-- Nessuna policy DELETE su prodotti.
-- Archiviazione tramite attivo = false.
-- La colonna scorta_attuale è protetta dal trigger di 001_schema.sql.


-- ============================================================
-- 8. TABELLA movimenti_magazzino
-- ============================================================

create policy movimenti_select_membri
on public.movimenti_magazzino
for select
to authenticated
using (
  exists (
    select 1
    from public.profili p
    where p.user_id = auth.uid()
      and p.azienda_id = movimenti_magazzino.azienda_id
  )
);


-- Nessuna policy INSERT su movimenti_magazzino.
-- Nessuna policy UPDATE su movimenti_magazzino.
-- Nessuna policy DELETE su movimenti_magazzino.
--
-- I movimenti vengono creati solo tramite:
-- public.registra_movimento()


-- ============================================================
-- 9. GRANT BASE AL RUOLO authenticated
-- ============================================================

grant usage on schema public to authenticated;

grant select, insert, update
on public.aziende
to authenticated;

grant select, insert, update
on public.profili
to authenticated;

grant select, insert, update
on public.categorie
to authenticated;

grant select, insert, update
on public.fornitori
to authenticated;

grant select, insert, update
on public.prodotti
to authenticated;

grant select
on public.movimenti_magazzino
to authenticated;


-- ============================================================
-- 10. COMMENTI DOCUMENTALI
-- ============================================================

comment on policy aziende_select_membri
on public.aziende is
  'Permette agli utenti autenticati di leggere solo la propria azienda.';

comment on policy aziende_insert_authenticated
on public.aziende is
  'Permette la creazione iniziale di una azienda. Il completamento onboarding avviene tramite RPC dedicata.';

comment on policy profili_select_own
on public.profili is
  'Permette a ogni utente di leggere solo il proprio profilo, evitando ricorsione RLS.';

comment on policy profili_insert_own
on public.profili is
  'Permette a ogni utente autenticato di creare solo il proprio profilo.';

comment on policy movimenti_select_membri
on public.movimenti_magazzino is
  'Permette la lettura dei movimenti solo ai membri della stessa azienda.';


-- ============================================================
-- FINE 003_rls.sql
-- ============================================================

