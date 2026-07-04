  ```sql
-- ============================================================
-- 001_schema.sql
-- Gestionale Magazzino Universale
-- MVP 1.0
--
-- Stato: APPROVATO
--
-- Contenuto:
-- - estensioni
-- - tabelle
-- - vincoli
-- - indici
-- - trigger updated_at
-- - trigger protezione scorta_attuale
-- - trigger immutabilità movimenti_magazzino
--
-- NON contiene:
-- - RPC registra_movimento
-- - RLS policy
-- ============================================================


-- ============================================================
-- 1. ESTENSIONI
-- ============================================================

create extension if not exists pgcrypto;


-- ============================================================
-- 2. FUNZIONE TECNICA updated_at
-- ============================================================

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;


-- ============================================================
-- 3. TABELLA aziende
-- ============================================================

create table if not exists public.aziende (
  id uuid primary key default gen_random_uuid(),

  nome text not null,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint aziende_nome_not_empty
    check (btrim(nome) <> '')
);

drop trigger if exists trg_aziende_updated_at on public.aziende;

create trigger trg_aziende_updated_at
before update on public.aziende
for each row
execute function public.set_updated_at();


-- ============================================================
-- 4. TABELLA profili
-- ============================================================

create table if not exists public.profili (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references auth.users(id) on delete cascade,
  azienda_id uuid not null references public.aziende(id) on delete restrict,

  nome text,
  email text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint profili_user_id_unique
    unique (user_id),

  constraint profili_nome_not_empty
    check (nome is null or btrim(nome) <> ''),

  constraint profili_email_not_empty
    check (email is null or btrim(email) <> '')
);

drop trigger if exists trg_profili_updated_at on public.profili;

create trigger trg_profili_updated_at
before update on public.profili
for each row
execute function public.set_updated_at();


-- ============================================================
-- 5. TABELLA categorie
-- ============================================================

create table if not exists public.categorie (
  id uuid primary key default gen_random_uuid(),

  azienda_id uuid not null references public.aziende(id) on delete restrict,

  nome text not null,
  descrizione text,

  attiva boolean not null default true,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint categorie_nome_not_empty
    check (btrim(nome) <> ''),

  constraint categorie_nome_unique_per_azienda
    unique (azienda_id, nome)
);

drop trigger if exists trg_categorie_updated_at on public.categorie;

create trigger trg_categorie_updated_at
before update on public.categorie
for each row
execute function public.set_updated_at();


-- ============================================================
-- 6. TABELLA fornitori
-- ============================================================

create table if not exists public.fornitori (
  id uuid primary key default gen_random_uuid(),

  azienda_id uuid not null references public.aziende(id) on delete restrict,

  nome text not null,
  telefono text,
  email text,
  note text,

  attivo boolean not null default true,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint fornitori_nome_not_empty
    check (btrim(nome) <> ''),

  constraint fornitori_telefono_not_empty
    check (telefono is null or btrim(telefono) <> ''),

  constraint fornitori_email_not_empty
    check (email is null or btrim(email) <> ''),

  constraint fornitori_nome_unique_per_azienda
    unique (azienda_id, nome)
);

drop trigger if exists trg_fornitori_updated_at on public.fornitori;

create trigger trg_fornitori_updated_at
before update on public.fornitori
for each row
execute function public.set_updated_at();


-- ============================================================
-- 7. TABELLA prodotti
-- ============================================================

create table if not exists public.prodotti (
  id uuid primary key default gen_random_uuid(),

  azienda_id uuid not null references public.aziende(id) on delete restrict,

  categoria_id uuid references public.categorie(id) on delete restrict,
  fornitore_preferito_id uuid references public.fornitori(id) on delete restrict,

  barcode text,

  nome text not null,
  descrizione text,

  unita_misura text not null default 'pz',

  prezzo_acquisto numeric(12,2),
  prezzo_vendita numeric(12,2),
  aliquota_iva numeric(5,2),

  scorta_attuale numeric(12,3) not null default 0,
  scorta_minima numeric(12,3) not null default 0,

  attributi_extra jsonb not null default '{}'::jsonb,

  attivo boolean not null default true,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint prodotti_nome_not_empty
    check (btrim(nome) <> ''),

  constraint prodotti_unita_misura_not_empty
    check (btrim(unita_misura) <> ''),

  constraint prodotti_barcode_not_empty
    check (barcode is null or btrim(barcode) <> ''),

  constraint prodotti_scorta_attuale_non_negative
    check (scorta_attuale >= 0),

  constraint prodotti_scorta_minima_non_negative
    check (scorta_minima >= 0),

  constraint prodotti_prezzo_acquisto_non_negative
    check (prezzo_acquisto is null or prezzo_acquisto >= 0),

  constraint prodotti_prezzo_vendita_non_negative
    check (prezzo_vendita is null or prezzo_vendita >= 0),

  constraint prodotti_aliquota_iva_non_negative
    check (aliquota_iva is null or aliquota_iva >= 0),

  constraint prodotti_attributi_extra_object
    check (jsonb_typeof(attributi_extra) = 'object'),

  constraint prodotti_barcode_unique_per_azienda
    unique (azienda_id, barcode)
);

drop trigger if exists trg_prodotti_updated_at on public.prodotti;

create trigger trg_prodotti_updated_at
before update on public.prodotti
for each row
execute function public.set_updated_at();


-- ============================================================
-- 8. PROTEZIONE scorta_attuale
-- ============================================================
--
-- Regola:
-- la scorta non può essere modificata direttamente.
--
-- La futura RPC registra_movimento potrà aggiornare scorta_attuale
-- impostando temporaneamente:
--
-- set_config('app.allow_stock_update', 'on', true)
--
-- dentro la propria transazione.
-- ============================================================

create or replace function public.prevent_direct_stock_update()
returns trigger
language plpgsql
as $$
begin
  if new.scorta_attuale is distinct from old.scorta_attuale
     and coalesce(current_setting('app.allow_stock_update', true), '') <> 'on'
  then
    raise exception
      'Aggiornamento diretto della scorta non consentito. Usare registra_movimento().';
  end if;

  return new;
end;
$$;

drop trigger if exists trg_prodotti_prevent_direct_stock_update on public.prodotti;

create trigger trg_prodotti_prevent_direct_stock_update
before update on public.prodotti
for each row
execute function public.prevent_direct_stock_update();


-- ============================================================
-- 9. TABELLA movimenti_magazzino
-- ============================================================

create table if not exists public.movimenti_magazzino (
  id uuid primary key default gen_random_uuid(),

  azienda_id uuid not null references public.aziende(id) on delete restrict,

  prodotto_id uuid not null references public.prodotti(id) on delete restrict,
  fornitore_id uuid references public.fornitori(id) on delete restrict,

  tipo_movimento text not null,

  quantita numeric(12,3) not null,

  scorta_prima numeric(12,3) not null,
  scorta_dopo numeric(12,3) not null,

  prezzo_unitario numeric(12,2),

  note text,

  data_movimento timestamptz not null default now(),

  creato_da uuid references auth.users(id) on delete set null,

  created_at timestamptz not null default now(),

  constraint movimenti_tipo_movimento_valid
    check (
      tipo_movimento in (
        'carico',
        'vendita',
        'reso',
        'rettifica'
      )
    ),

  constraint movimenti_quantita_positive
    check (quantita > 0),

  constraint movimenti_scorta_prima_non_negative
    check (scorta_prima >= 0),

  constraint movimenti_scorta_dopo_non_negative
    check (scorta_dopo >= 0),

  constraint movimenti_prezzo_unitario_non_negative
    check (prezzo_unitario is null or prezzo_unitario >= 0)
);


-- ============================================================
-- 10. IMMUTABILITÀ movimenti_magazzino
-- ============================================================
--
-- Regola:
-- i movimenti sono storico ufficiale.
-- Dopo la creazione non possono essere modificati né eliminati.
-- Eventuali errori si correggono con nuovi movimenti.
-- ============================================================

create or replace function public.prevent_movements_modification()
returns trigger
language plpgsql
as $$
begin
  raise exception
    'I movimenti di magazzino sono immutabili.';
end;
$$;

drop trigger if exists trg_movimenti_immutable on public.movimenti_magazzino;

create trigger trg_movimenti_immutable
before update or delete
on public.movimenti_magazzino
for each row
execute function public.prevent_movements_modification();


-- ============================================================
-- 11. INDICI
-- ============================================================

create index if not exists idx_profili_user_id
  on public.profili(user_id);

create index if not exists idx_profili_user_id_azienda_id
  on public.profili(user_id, azienda_id);

create index if not exists idx_profili_azienda_id
  on public.profili(azienda_id);


create index if not exists idx_categorie_azienda_id
  on public.categorie(azienda_id);

create index if not exists idx_categorie_azienda_id_attiva
  on public.categorie(azienda_id, attiva);


create index if not exists idx_fornitori_azienda_id
  on public.fornitori(azienda_id);

create index if not exists idx_fornitori_azienda_id_attivo
  on public.fornitori(azienda_id, attivo);


create index if not exists idx_prodotti_azienda_id
  on public.prodotti(azienda_id);

create index if not exists idx_prodotti_azienda_id_barcode
  on public.prodotti(azienda_id, barcode);

create index if not exists idx_prodotti_azienda_id_nome
  on public.prodotti(azienda_id, nome);

create index if not exists idx_prodotti_azienda_id_attivo
  on public.prodotti(azienda_id, attivo);

create index if not exists idx_prodotti_categoria_id
  on public.prodotti(categoria_id);

create index if not exists idx_prodotti_fornitore_preferito_id
  on public.prodotti(fornitore_preferito_id);


create index if not exists idx_movimenti_azienda_id
  on public.movimenti_magazzino(azienda_id);

create index if not exists idx_movimenti_prodotto_id
  on public.movimenti_magazzino(prodotto_id);

create index if not exists idx_movimenti_fornitore_id
  on public.movimenti_magazzino(fornitore_id);

create index if not exists idx_movimenti_data_movimento
  on public.movimenti_magazzino(data_movimento);

create index if not exists idx_movimenti_azienda_id_data_movimento
  on public.movimenti_magazzino(azienda_id, data_movimento);

create index if not exists idx_movimenti_prodotto_id_data_movimento
  on public.movimenti_magazzino(prodotto_id, data_movimento);

create index if not exists idx_movimenti_tipo_movimento
  on public.movimenti_magazzino(tipo_movimento);


-- ============================================================
-- 12. COMMENTI DOCUMENTALI
-- ============================================================

comment on table public.aziende is
  'Contenitore logico dei dati aziendali del gestionale.';

comment on table public.profili is
  'Collega auth.users alle aziende applicative.';

comment on table public.categorie is
  'Categorie prodotti, archiviate tramite attiva=false e mai eliminate fisicamente.';

comment on table public.fornitori is
  'Anagrafica fornitori, archiviata tramite attivo=false e mai eliminata fisicamente.';

comment on table public.prodotti is
  'Anagrafica prodotti. La scorta_attuale è copia aggiornata, modificabile solo tramite RPC registra_movimento.';

comment on table public.movimenti_magazzino is
  'Storico ufficiale e immutabile delle variazioni di magazzino. UPDATE e DELETE non consentiti.';

comment on column public.prodotti.attributi_extra is
  'Campo JSONB predisposto per futuri template di settore.';

comment on column public.prodotti.scorta_attuale is
  'Copia aggiornata della scorta corrente. Non modificare direttamente.';

comment on column public.movimenti_magazzino.quantita is
  'Quantità sempre positiva. La direzione è determinata da tipo_movimento e da scorta_prima/scorta_dopo.';

comment on column public.movimenti_magazzino.creato_da is
  'Utente Supabase che ha creato il movimento. Se l’utente viene eliminato, il movimento resta e questo campo diventa NULL.';


-- ============================================================
-- FINE 001_schema.sql
-- ============================================================
```
