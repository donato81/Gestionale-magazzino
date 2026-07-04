# BACKEND RULES MVP 1.0

## Gestionale Magazzino Universale

Versione: 1.0.0
Stato: APPROVATO
Data: 12 Giugno 2026

---

# 1. Scopo del documento

Questo documento definisce le regole operative del backend.

L'obiettivo è stabilire:

* chi può accedere ai dati;
* chi può modificarli;
* quali operazioni sono consentite;
* quali operazioni sono vietate;
* quali responsabilità appartengono al backend;
* quali responsabilità appartengono al frontend.

Il documento è indipendente da Flutter e definisce esclusivamente le regole lato Supabase.

---

# 2. Principi Fondamentali

## 2.1 Il backend è la fonte della verità

Il frontend non è considerato affidabile.

Ogni regola di business importante deve essere verificata dal backend.

---

## 2.2 Le RLS sono obbligatorie

Tutte le tabelle applicative devono essere protette da Row Level Security.

Nessuna tabella applicativa deve essere accessibile senza policy.

---

## 2.3 Nessuna fiducia nel client

Il backend non deve mai assumere che il frontend abbia eseguito correttamente i controlli.

Ogni validazione importante deve essere ripetuta lato server.

---

## 2.4 Storico immutabile

I movimenti di magazzino sono storico ufficiale.

Una volta creati:

* non possono essere modificati;
* non possono essere eliminati.

Gli errori devono essere corretti tramite nuovi movimenti.

---

# 3. Modello di Sicurezza

## Relazione Utente → Azienda

```text
auth.users
↓
profili
↓
azienda
↓
dati aziendali
```

---

## Regola Generale

Un utente può accedere esclusivamente ai dati della propria azienda.

---

## Operazioni vietate

Un utente non può:

* leggere dati di altre aziende;
* modificare dati di altre aziende;
* creare dati associati ad altre aziende;
* eliminare dati di altre aziende.

---

# 4. Responsabilità del Frontend

Il frontend Flutter deve:

* raccogliere dati;
* validare i form;
* mostrare errori;
* mostrare conferme;
* invocare RPC;
* eseguire query consentite.

---

## Il frontend NON deve

* modificare direttamente la scorta;
* applicare regole di business critiche;
* bypassare le RPC;
* fidarsi dei dati locali.

---

# 5. Responsabilità del Backend

Il backend deve:

* applicare le RLS;
* verificare appartenenza aziendale;
* validare operazioni sensibili;
* garantire consistenza dei dati;
* eseguire transazioni atomiche.

---

# 6. Regole per Tabella Aziende

## Lettura

Consentita ai membri dell'azienda.

---

## Inserimento

Consentito agli utenti autenticati durante il processo di onboarding.

Regola prevista:

```text
Utente autenticato
↓
Può creare una azienda
```

---

## Modifica

Consentita ai membri dell'azienda.

---

## Eliminazione

Vietata.

---

# 7. Regole per Tabella Profili

## Lettura

Consentita esclusivamente al proprietario del profilo.

---

## Inserimento

Consentito durante onboarding.

Regola prevista:

```text
user_id = auth.uid()
```

L'utente può creare esclusivamente il proprio profilo.

---

## Modifica

Consentita esclusivamente sul proprio profilo.

---

## Eliminazione

Vietata.

---

# 8. Regole per Tabella Categorie

## Lettura

Consentita ai membri dell'azienda.

---

## Inserimento

Consentito ai membri dell'azienda.

---

## Modifica

Consentita ai membri dell'azienda.

---

## Eliminazione

Vietata.

Utilizzare:

```text
attiva = false
```

---

# 9. Regole per Tabella Fornitori

## Lettura

Consentita ai membri dell'azienda.

---

## Inserimento

Consentito ai membri dell'azienda.

---

## Modifica

Consentita ai membri dell'azienda.

---

## Eliminazione

Vietata.

Utilizzare:

```text
attivo = false
```

---

# 10. Regole per Tabella Prodotti

## Lettura

Consentita ai membri dell'azienda.

---

## Inserimento

Consentito ai membri dell'azienda.

---

## Modifica

Consentita ai membri dell'azienda.

---

## Eliminazione

Vietata.

Utilizzare:

```text
attivo = false
```

---

## Protezione della Scorta

La colonna:

```text
prodotti.scorta_attuale
```

non può essere modificata direttamente dal frontend.

La modifica della scorta è consentita esclusivamente tramite:

```text
RPC registra_movimento()
```

---

## Protezione Tecnica

Lo schema SQL dovrà prevedere un meccanismo server-side che impedisca modifiche dirette a:

```text
prodotti.scorta_attuale
```

durante gli aggiornamenti dell'anagrafica prodotto.

La protezione sarà implementata tramite trigger PostgreSQL.

---

# 11. Regole per Tabella Movimenti

## Lettura

Consentita ai membri dell'azienda.

---

## Inserimento

NON consentito direttamente.

---

## Modifica

Vietata.

---

## Eliminazione

Vietata.

---

## Regola Fondamentale

I movimenti possono essere creati esclusivamente tramite:

```text
RPC registra_movimento()
```

---

## Policy previste

La tabella movimenti non deve consentire:

```text
INSERT
UPDATE
DELETE
```

agli utenti autenticati.

La lettura rimane consentita tramite RLS.

---

# 12. RPC registra_movimento

## Scopo

Gestire tutte le variazioni di scorta.

---

## Operazioni supportate

* carico
* vendita
* reso
* rettifica

---

## Modalità di esecuzione

La RPC deve essere creata utilizzando:

```text
SECURITY DEFINER
```

in modo da poter operare sulle tabelle protette.

---

## Verifica autorizzazione

La RPC deve verificare esplicitamente:

```text
auth.uid()
↓
profilo
↓
azienda
```

prima di eseguire qualsiasi operazione.

Non deve fidarsi dei parametri ricevuti dal frontend.

---

## Controlli obbligatori

La RPC deve verificare:

### Azienda

* prodotto appartenente all'azienda dell'utente

### Stato prodotto

* prodotto attivo

### Quantità

* maggiore di zero

### Scorte

* impossibile generare scorta negativa

### Fornitore

* se presente deve appartenere alla stessa azienda

---

## Rettifica

La rettifica riceve:

```text
nuova_scorta
```

e calcola automaticamente la differenza.

---

## Atomicità

La RPC deve:

1. inserire movimento;
2. aggiornare prodotto;

all'interno della stessa transazione.

---

# 13. Operazioni Vietate

Il backend deve rifiutare:

---

## Aggiornamento diretto scorta

Vietato.

```text
UPDATE prodotti.scorta_attuale
```

non deve essere consentito al frontend.

---

## Inserimento diretto movimenti

Vietato.

```text
INSERT movimenti_magazzino
```

non deve essere consentito al frontend.

---

## Modifica movimenti

Vietata.

---

## Eliminazione movimenti

Vietata.

---

## Scorta negativa

Vietata.

---

## Barcode duplicato

Vietato.

All'interno della stessa azienda.

---

# 14. Gestione Errori

Il backend deve restituire errori comprensibili.

Esempi:

```text
Prodotto non trovato
```

```text
Prodotto disattivato
```

```text
Scorta insufficiente
```

```text
Barcode già utilizzato
```

```text
Fornitore non valido
```

```text
Operazione non autorizzata
```

---

# 15. Regole Future

Questo documento deve rimanere valido anche dopo l'introduzione di:

* template di settore;
* immagini prodotto;
* scanner barcode;
* offline sync;
* collaboratori;
* ruoli avanzati.

---

# 16. Decisioni Architetturali Confermate

1. Backend fonte della verità.
2. RLS obbligatorie.
3. Nessuna fiducia nel client.
4. Movimenti immutabili.
5. Nessuna modifica diretta della scorta.
6. Nessun inserimento diretto dei movimenti.
7. RPC obbligatoria per ogni variazione di magazzino.
8. RPC creata con SECURITY DEFINER.
9. Verifica autorizzazione interna alla RPC.
10. Soft delete per categorie, fornitori e prodotti.
11. Multi-tenant basato su azienda.
12. Controlli critici sempre lato backend.
13. Protezione server-side della colonna scorta_attuale.

---

# Stato Documento

Stato: APPROVATO

Versione: 1.0.0

Data approvazione: 12 Giugno 2026

Documento validato tramite revisione congiunta:

* ChatGPT (coordinatore)
* Gemini
* DeepSeek

---

# Conclusione

Con questo documento risultano approvati:

001-ARCHITETTURA_mvp1_v1.0.0.md

001-DATABASE_SCHEMA_mvp1_v1.0.0.md

001-FLOWS_mvp1_v1.0.0.md

001-BACKEND_RULES_mvp1_v1.0.0.md

La fase di progettazione dell'MVP 1 è considerata completata.

Passo successivo:

> progettazione e scrittura dello schema SQL Supabase.
