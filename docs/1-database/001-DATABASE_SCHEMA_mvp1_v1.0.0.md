
# DATABASE SCHEMA MVP 1.0

## Gestionale Magazzino Universale

Versione: 1.0.0
Stato: APPROVATO
Data: 12 Giugno 2026

---

# 1. Scopo del documento

Questo documento definisce lo schema dati ufficiale dell'MVP 1 del progetto Gestionale Magazzino Universale.

Lo schema rappresenta la base dati sulla quale verranno costruiti:

* backend Supabase;
* logica di magazzino;
* autenticazione utenti;
* frontend Flutter.

L'obiettivo dell'MVP 1 è consentire:

* autenticazione;
* gestione prodotti;
* gestione categorie;
* gestione fornitori;
* registrazione movimenti;
* aggiornamento scorte;
* consultazione storico.

---

# 2. Principi architetturali

## 2.1 Multi Tenant

Ogni dato appartiene a una azienda.

Tutte le tabelle applicative sono isolate tramite:

```text
azienda_id
```

Le policy RLS garantiscono che ogni utente possa accedere esclusivamente ai dati della propria azienda.

---

## 2.2 UUID

Tutte le chiavi primarie utilizzano UUID.

Motivazioni:

* maggiore sicurezza;
* migliore supporto futuro all'offline;
* assenza di collisioni;
* migliore supporto multi-dispositivo.

---

## 2.3 Storico come fonte della verità

La fonte ufficiale della verità del magazzino è la tabella:

```text
movimenti_magazzino
```

La colonna:

```text
prodotti.scorta_attuale
```

è una copia aggiornata utilizzata esclusivamente per performance.

---

## 2.4 Nessuna modifica diretta della scorta

La scorta non può essere modificata direttamente dal frontend.

Ogni modifica deve passare attraverso:

```text
RPC registra_movimento()
```

---

## 2.5 Storico immutabile

I movimenti di magazzino sono considerati storico ufficiale.

Una volta creato un movimento:

* non può essere modificato;
* non può essere eliminato.

Eventuali errori vengono corretti tramite nuovi movimenti.

---

# 3. Modello Relazionale

```text
auth.users
    │
    ▼
profili
    │
    ▼
aziende
    │
    ├── categorie
    │
    ├── fornitori
    │
    ├── prodotti
    │
    └── movimenti_magazzino
```

---

# 4. Tabella aziende

## Scopo

Contiene le attività commerciali proprietarie dei dati.

## Campi

```text
id UUID PK
nome TEXT NOT NULL
created_at TIMESTAMPTZ NOT NULL
updated_at TIMESTAMPTZ NOT NULL
```

---

# 5. Tabella profili

## Scopo

Collega Supabase Auth al dominio applicativo.

## Campi

```text
id UUID PK
user_id UUID NOT NULL
azienda_id UUID NOT NULL
nome TEXT
email TEXT
created_at TIMESTAMPTZ NOT NULL
updated_at TIMESTAMPTZ NOT NULL
```

## Vincoli

```text
UNIQUE(user_id)
```

## Regole

Ogni utente appartiene ad una sola azienda.

---

# 6. Tabella categorie

## Scopo

Classificazione dei prodotti.

## Campi

```text
id UUID PK
azienda_id UUID NOT NULL
nome TEXT NOT NULL
descrizione TEXT
attiva BOOLEAN NOT NULL DEFAULT true
created_at TIMESTAMPTZ NOT NULL
updated_at TIMESTAMPTZ NOT NULL
```

## Vincoli

```text
UNIQUE(azienda_id, nome)
```

---

# 7. Tabella fornitori

## Scopo

Anagrafica fornitori.

## Campi

```text
id UUID PK
azienda_id UUID NOT NULL
nome TEXT NOT NULL
telefono TEXT
email TEXT
note TEXT
attivo BOOLEAN NOT NULL DEFAULT true
created_at TIMESTAMPTZ NOT NULL
updated_at TIMESTAMPTZ NOT NULL
```

## Vincoli

```text
UNIQUE(azienda_id, nome)
```

---

# 8. Tabella prodotti

## Scopo

Anagrafica principale del magazzino.

## Campi

```text
id UUID PK

azienda_id UUID NOT NULL

categoria_id UUID NULL

fornitore_preferito_id UUID NULL

barcode TEXT NULL

nome TEXT NOT NULL

descrizione TEXT NULL

unita_misura TEXT NOT NULL DEFAULT 'pz'

prezzo_acquisto NUMERIC(12,2) NULL

prezzo_vendita NUMERIC(12,2) NULL

aliquota_iva NUMERIC(5,2) NULL

scorta_attuale NUMERIC(12,3) NOT NULL DEFAULT 0

scorta_minima NUMERIC(12,3) NOT NULL DEFAULT 0

attributi_extra JSONB NOT NULL DEFAULT '{}'

attivo BOOLEAN NOT NULL DEFAULT true

created_at TIMESTAMPTZ NOT NULL

updated_at TIMESTAMPTZ NOT NULL
```

## Vincoli

```text
UNIQUE(azienda_id, barcode)

CHECK(scorta_attuale >= 0)

CHECK(scorta_minima >= 0)

CHECK(prezzo_acquisto >= 0)

CHECK(prezzo_vendita >= 0)

CHECK(aliquota_iva >= 0)
```

## Regole Barcode

Se il prodotto non possiede barcode:

```text
barcode = NULL
```

Non devono essere utilizzate stringhe vuote.

Il frontend Flutter deve convertire automaticamente:

```text
''
```

in:

```text
NULL
```

---

# 9. Tabella movimenti_magazzino

## Scopo

Storico ufficiale del magazzino.

## Campi

```text
id UUID PK

azienda_id UUID NOT NULL

prodotto_id UUID NOT NULL

fornitore_id UUID NULL

tipo_movimento TEXT NOT NULL

quantita NUMERIC(12,3) NOT NULL

scorta_prima NUMERIC(12,3) NOT NULL

scorta_dopo NUMERIC(12,3) NOT NULL

prezzo_unitario NUMERIC(12,2) NULL

note TEXT NULL

data_movimento TIMESTAMPTZ NOT NULL

creato_da UUID NOT NULL

created_at TIMESTAMPTZ NOT NULL
```

## Tipi Movimento

```text
carico
vendita
reso
rettifica
```

## Vincoli

```text
CHECK(quantita > 0)

CHECK(scorta_prima >= 0)

CHECK(scorta_dopo >= 0)

CHECK(prezzo_unitario >= 0)

CHECK(
tipo_movimento IN (
'carico',
'vendita',
'reso',
'rettifica'
)
)
```

## Regole

Le quantità vengono sempre salvate positive.

La direzione del movimento è determinata da:

```text
tipo_movimento
```

e da:

```text
scorta_prima
scorta_dopo
```

Non vengono mai registrate quantità negative.

---

# 10. Gestione Fornitori nei Movimenti

Un prodotto può essere acquistato da fornitori diversi nel tempo.

Per questo motivo:

```text
prodotti.fornitore_preferito_id
```

identifica il fornitore abituale.

Mentre:

```text
movimenti_magazzino.fornitore_id
```

identifica il fornitore reale associato a quel carico.

Questo garantisce la tracciabilità completa della provenienza della merce.

---

# 11. RPC registra_movimento

## Scopo

Centralizzare tutta la logica di modifica delle scorte.

Nessun client può aggiornare direttamente:

```text
prodotti.scorta_attuale
```

---

## Operazioni supportate

### Carico

Riceve:

```text
quantita
```

Aggiorna:

```text
scorta + quantita
```

---

### Vendita

Riceve:

```text
quantita
```

Aggiorna:

```text
scorta - quantita
```

---

### Reso

Riceve:

```text
quantita
```

Aggiorna:

```text
scorta + quantita
```

---

### Rettifica

Riceve:

```text
nuova_scorta
```

Non riceve quantità.

La funzione calcola automaticamente:

```text
differenza =
nuova_scorta - scorta_attuale
```

e registra il movimento.

---

## Controlli obbligatori

La RPC deve:

1. verificare che il prodotto appartenga all'azienda;
2. verificare che il fornitore appartenga all'azienda;
3. leggere la scorta corrente;
4. impedire scorte negative;
5. inserire il movimento;
6. aggiornare il prodotto;
7. completare tutto in una singola transazione.

---

## Risultato

La RPC dovrebbe restituire:

```text
movimento_id
nuova_scorta
esito
```

---

# 12. Sicurezza RLS

Le RLS devono essere attivate su:

```text
aziende
profili
categorie
fornitori
prodotti
movimenti_magazzino
```

---

## Regola Generale

Un utente può accedere esclusivamente ai dati della propria azienda.

---

## Eccezione Tabella Profili

La tabella:

```text
profili
```

non deve utilizzare la policy generica basata su EXISTS.

Deve utilizzare:

```text
user_id = auth.uid()
```

per evitare ricorsioni nelle policy.

---

## Setup iniziale

Un utente appena registrato deve poter:

1. creare azienda;
2. creare il proprio profilo.

Le policy iniziali devono consentire questo flusso.

---

# 13. Indici

## Obbligatori

```text
profili(user_id)

profili(user_id, azienda_id)

categorie(azienda_id)

fornitori(azienda_id)

prodotti(azienda_id)

prodotti(azienda_id, barcode)

prodotti(azienda_id, nome)

prodotti(categoria_id)

prodotti(fornitore_preferito_id)

movimenti_magazzino(azienda_id)

movimenti_magazzino(prodotto_id)

movimenti_magazzino(data_movimento)
```

---

# 14. Trigger Tecnici

## updated_at

Tutte le tabelle principali devono aggiornare automaticamente:

```text
updated_at
```

tramite trigger PostgreSQL.

Il frontend non deve gestire questo campo.

---

# 15. Eliminazioni

## Prodotti

Vietato delete fisico.

Utilizzare:

```text
attivo = false
```

---

## Categorie

Vietato delete fisico.

Utilizzare:

```text
attiva = false
```

---

## Fornitori

Vietato delete fisico.

Utilizzare:

```text
attivo = false
```

---

## Movimenti

Delete fisico vietato.

Lo storico deve rimanere immutabile.

---

# 16. Predisposizione Evolutiva

Lo schema è già predisposto per:

* Template di settore
* Scanner barcode HID
* Immagini prodotto
* Offline Sync
* Collaboratori multipli
* Multi-azienda evoluto

senza richiedere modifiche sostanziali alle tabelle principali.

---

# 17. Approvazione Finale

Stato: APPROVATO

Versione: 1.0.0

Data: 12 Giugno 2026

Documento validato tramite revisione congiunta:

* ChatGPT (coordinatore)
* Gemini
* DeepSeek

Passo successivo:

> progettazione dello script SQL Supabase MVP 1.0

Questo documento può essere considerato la baseline ufficiale del database. Il prossimo artefatto non sarà più un documento di analisi, ma direttamente il file SQL da eseguire in Supabase.
