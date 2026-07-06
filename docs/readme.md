# DOCUMENTAZIONE PROGETTO

## Gestionale Magazzino Universale

Versione: 1.0.0
Stato: APPROVATO
Data: 6 luglio 2026
-------------------

# 1. Scopo del documento

Questo file è l'indice generale della cartella `docs`.
Serve a spiegare dove si trova la documentazione ufficiale del progetto e in quale ordine deve essere letta.
Non sostituisce i singoli documenti tecnici.
Non contiene codice.
Non introduce nuove regole architetturali.
Il suo scopo è rendere la documentazione:

* ordinata;
* facile da consultare;
* utile per il lavoro manuale;
* utile per la revisione con AI;
* utile per futuri coding agent;
* stabile nel tempo.

---

# 2. Progetto

Nome progetto:

```text
Gestionale Magazzino Universale
```

Obiettivo dell'MVP 1:

```text
costruire un gestionale magazzino accessibile, sicuro e multi-tenant,
basato su Flutter e Supabase.
```

Il cuore dell'MVP 1 è:

* registrazione account;
* autenticazione utente;
* creazione azienda e profilo;
* gestione categorie;
* gestione fornitori;
* gestione prodotti;
* registrazione movimenti di magazzino;
* aggiornamento scorte;
* consultazione storico movimenti;
* utilizzo tramite screen reader.

---

# 3. Principio guida della documentazione

La documentazione segue questo principio:

```text
prima si definiscono le regole,
poi si scrive il codice.
```

Il progetto non deve procedere con codice improvvisato.
Ogni blocco importante deve avere:

1. una regola chiara;
2. un piano comprensibile;
3. un todo operativo;
4. codice scritto in modo progressivo;
5. test;
6. aggiornamento del changelog;
7. commit;
8. push;
9. merge in `main` dopo validazione, quando previsto.

---

# 4. Struttura generale della cartella docs

La cartella `docs` è organizzata così:

```text
docs/
  README.md
  0-architettura/
  1-database/
  2-flussi-applicativi/
  3-backend/
  4-flutter/
```

## Ogni cartella ha una responsabilità specifica.

# 5. Cartella 0-architettura

Percorso:

```text
docs/0-architettura/
```

Contiene la visione architetturale generale del progetto.
Documento principale:

```text
001-ARCHITETTURA_mvp1_v1.0.0.md
```

Questo documento definisce:

* obiettivo dell'MVP 1;
* visione futura del gestionale;
* principio della scorta;
* ruolo dei movimenti di magazzino;
* architettura multi-tenant;
* entità principali;
* scelta Supabase;
* scelta Flutter;
* accessibilità come requisito architetturale;
* evoluzioni future.
  Questo è il primo documento da leggere per capire il senso generale del progetto.

---

# 6. Cartella 1-database

Percorso:

```text
docs/1-database/
```

Contiene la documentazione e gli script relativi alla base dati Supabase.
Documento principale:

```text
001-DATABASE_SCHEMA_mvp1_v1.0.0.md
```

Questo documento definisce:

* tabelle;
* campi;
* vincoli;
* relazioni;
* UUID;
* multi-tenant;
* scorta;
* movimenti;
* barcode;
* soft delete;
* indici;
* trigger previsti.

## 6.1 Script Supabase

Gli script SQL si trovano nella sottocartella dedicata a Supabase.
Percorso consigliato:

```text
docs/1-database/supabase/
```

Script principali:

```text
001_schema.sql
002_rpc.sql
003_rls.sql
004_onboarding_rpc.sql
```

### 001_schema.sql

Contiene:

* estensioni;
* tabelle;
* vincoli;
* indici;
* trigger `updated_at`;
* protezione di `prodotti.scorta_attuale`;
* immutabilità dei movimenti.

### 002_rpc.sql

Contiene la RPC:

```text
registra_movimento
```

Questa RPC è il punto unico per modificare la scorta.
Supporta:

* carico;
* vendita;
* reso;
* rettifica.

### 003_rls.sql

Contiene:

* abilitazione Row Level Security;
* policy multi-tenant;
* permessi base per utenti autenticati;
* protezione delle tabelle applicative.

### 004_onboarding_rpc.sql

Contiene la RPC:

```text
crea_azienda_e_profilo
```

Questa RPC gestisce l'onboarding iniziale creando azienda e profilo in una singola operazione.

## 6.2 Piano test backend

Documento:

```text
TEST_PLAN_MVP1_v1.0.0.md
```

Questo documento contiene il piano di test del backend Supabase.
È stato usato per validare:

* database;
* RLS;
* RPC;
* onboarding;
* movimenti;
* isolamento multi-tenant;
* protezione della scorta;
* immutabilità dello storico.
  Il backend MVP 1.0 è stato approvato dopo l'esecuzione dei test.

---

# 7. Cartella 2-flussi-applicativi

Percorso:

```text
docs/2-flussi-applicativi/
```

Documento principale:

```text
001-FLOWS_mvp1_v1.0.0.md
```

Questo documento descrive i flussi funzionali dell'applicazione.
Contiene cosa deve succedere quando l'utente esegue operazioni come:

* registrazione;
* onboarding;
* creazione categoria;
* creazione fornitore;
* creazione prodotto;
* carico magazzino;
* vendita;
* reso cliente;
* rettifica inventario;
* consultazione prodotto;
* storico movimenti;
* disattivazione categoria;
* disattivazione fornitore;
* disattivazione prodotto.
  Questo documento non descrive i widget Flutter.
  Descrive il comportamento applicativo.
  Nota:
  il flusso funzionale F001 descrive l'obiettivo completo per l'utente finale.
  La fase Flutter lo implementa in blocchi separati:

```text
003 Registrazione account
004 Onboarding azienda/profilo
```

---

# 8. Cartella 3-backend

Percorso:

```text
docs/3-backend/
```

Contiene le regole backend e il contratto tra Flutter e Supabase.
Documenti principali:

```text
001-BACKEND_RULES_mvp1_v1.0.0.md
002-API_CONTRACTS_mvp1_v1.0.0.md
```

## 8.1 Backend Rules

Documento:

```text
001-BACKEND_RULES_mvp1_v1.0.0.md
```

Definisce le regole operative del backend.
Stabilisce:

* backend come fonte della verità;
* RLS obbligatorie;
* nessuna fiducia nel client;
* movimenti immutabili;
* nessuna modifica diretta della scorta;
* nessun inserimento diretto dei movimenti;
* soft delete per categorie, fornitori e prodotti;
* RPC obbligatoria per modificare la scorta.

## 8.2 API Contracts

Documento:

```text
002-API_CONTRACTS_mvp1_v1.0.0.md
```

Definisce il contratto operativo tra Flutter e Supabase.
Spiega:

* cosa Flutter può leggere;
* cosa Flutter può creare;
* cosa Flutter può modificare;
* cosa Flutter non deve mai fare;
* quali RPC deve chiamare;
* quali parametri deve usare;
* quali errori deve tradurre;
* quali messaggi deve mostrare;
* quali regole di sicurezza deve rispettare.
  Questo documento è fondamentale prima di scrivere i servizi Flutter.
  Nota:
  gli API Contracts potranno essere aggiornati dopo il design del blocco 003 se sarà necessario precisare meglio il contratto di registrazione account tramite Supabase Auth.

---

# 9. Cartella 4-flutter

Percorso:

```text
docs/4-flutter/
```

Contiene la documentazione della fase Flutter.
Documento principale approvato:

```text
001-FLUTTER_PLAN_mvp1_v1.0.0.md
```

Questo documento definisce:

* ordine di sviluppo Flutter;
* core Dart minimo;
* sistema messaggi centralizzato;
* sistema errori centralizzato;
* feedback persistente;
* accessibilità;
* sessione;
* registrazione account;
* onboarding azienda/profilo;
* navigazione semplice;
* gestione assenza rete;
* test manuali minimi;
* regole operative di sviluppo.

## 9.1 Decisione Flutter attuale

La sequenza Flutter è stata aggiornata per separare registrazione account e onboarding.
Nuova sequenza ufficiale:

```text
001 Core Dart minimo
002 Login, logout e sessione
003 Registrazione account
004 Onboarding azienda/profilo
005 Home
006 Categorie
007 Fornitori
008 Prodotti
009 Movimenti di magazzino
010 Storico movimenti
011 Revisione accessibilità
012 Stabilizzazione MVP 1
```

Motivazione:

* la registrazione crea l'utente Supabase Auth;
* l'onboarding crea azienda e profilo applicativo tramite RPC `crea_azienda_e_profilo`;
* ogni blocco mantiene una sola missione;
* il lavoro resta più facile da testare e correggere.

## 9.2 Sottocartelle Flutter

La cartella Flutter contiene tre sottocartelle operative:

```text
docs/4-flutter/1-design/
docs/4-flutter/2-coding-plans/
docs/4-flutter/3-todos/
```

---

# 10. Cartella 1-design

Percorso:

```text
docs/4-flutter/1-design/
```

Contiene i documenti di design dei blocchi Flutter.
I design spiegano:

* cosa deve fare un blocco;
* quali responsabilità ha;
* quali regole deve rispettare;
* quali messaggi deve mostrare;
* quali aspetti di accessibilità sono obbligatori;
* quali errori deve gestire.
  Documenti approvati:

```text
001-DESIGN_CORE_mvp1_v1.0.0.md
002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
```

Documenti futuri previsti:

```text
003-DESIGN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
004-DESIGN_ONBOARDING_mvp1_v1.0.0.md
005-DESIGN_HOME_mvp1_v1.0.0.md
006-DESIGN_CATEGORIES_mvp1_v1.0.0.md
007-DESIGN_SUPPLIERS_mvp1_v1.0.0.md
008-DESIGN_PRODUCTS_mvp1_v1.0.0.md
009-DESIGN_MOVEMENTS_mvp1_v1.0.0.md
010-DESIGN_MOVEMENT_HISTORY_mvp1_v1.0.0.md
011-DESIGN_ACCESSIBILITY_REVIEW_mvp1_v1.0.0.md
012-DESIGN_STABILIZATION_mvp1_v1.0.0.md
```

---

# 11. Cartella 2-coding-plans

Percorso:

```text
docs/4-flutter/2-coding-plans/
```

Contiene i piani di codifica.
I coding plan spiegano:

* quali file creare;
* quali file modificare;
* in che ordine lavorare;
* quali responsabilità ha ogni file;
* quali test eseguire dopo il blocco;
* cosa non deve essere fatto in quel blocco.
  Documenti approvati:

```text
001-CODING_PLAN_CORE_mvp1_v1.0.0.md
002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
```

Documenti futuri previsti:

```text
003-CODING_PLAN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
004-CODING_PLAN_ONBOARDING_mvp1_v1.0.0.md
005-CODING_PLAN_HOME_mvp1_v1.0.0.md
006-CODING_PLAN_CATEGORIES_mvp1_v1.0.0.md
007-CODING_PLAN_SUPPLIERS_mvp1_v1.0.0.md
008-CODING_PLAN_PRODUCTS_mvp1_v1.0.0.md
009-CODING_PLAN_MOVEMENTS_mvp1_v1.0.0.md
010-CODING_PLAN_MOVEMENT_HISTORY_mvp1_v1.0.0.md
011-CODING_PLAN_ACCESSIBILITY_REVIEW_mvp1_v1.0.0.md
012-CODING_PLAN_STABILIZATION_mvp1_v1.0.0.md
```

---

# 12. Cartella 3-todos

Percorso:

```text
docs/4-flutter/3-todos/
```

Contiene il todo master e i todo operativi dei singoli blocchi.
File principale:

```text
000-todo-master.md
```

Il todo master contiene le macro-fasi del lavoro Flutter.
I todo specifici contengono task più piccoli e verificabili.
Documenti approvati:

```text
001-TODO_CORE_mvp1_v1.0.0.md
002-TODO_AUTH_SESSION_mvp1_v1.0.0.md
```

Documenti futuri previsti:

```text
003-TODO_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
004-TODO_ONBOARDING_mvp1_v1.0.0.md
005-TODO_HOME_mvp1_v1.0.0.md
006-TODO_CATEGORIES_mvp1_v1.0.0.md
007-TODO_SUPPLIERS_mvp1_v1.0.0.md
008-TODO_PRODUCTS_mvp1_v1.0.0.md
009-TODO_MOVEMENTS_mvp1_v1.0.0.md
010-TODO_MOVEMENT_HISTORY_mvp1_v1.0.0.md
011-TODO_ACCESSIBILITY_REVIEW_mvp1_v1.0.0.md
012-TODO_STABILIZATION_mvp1_v1.0.0.md
```

---

# 13. Ordine consigliato di lettura

Per capire il progetto da zero, leggere in questo ordine:

```text
1. docs/0-architettura/001-ARCHITETTURA_mvp1_v1.0.0.md
2. docs/1-database/001-DATABASE_SCHEMA_mvp1_v1.0.0.md
3. docs/2-flussi-applicativi/001-FLOWS_mvp1_v1.0.0.md
4. docs/3-backend/001-BACKEND_RULES_mvp1_v1.0.0.md
5. docs/1-database/supabase/001_schema.sql
6. docs/1-database/supabase/002_rpc.sql
7. docs/1-database/supabase/003_rls.sql
8. docs/1-database/supabase/004_onboarding_rpc.sql
9. docs/1-database/TEST_PLAN_MVP1_v1.0.0.md
10. docs/3-backend/002-API_CONTRACTS_mvp1_v1.0.0.md
11. docs/4-flutter/001-FLUTTER_PLAN_mvp1_v1.0.0.md
12. docs/4-flutter/3-todos/000-todo-master.md
13. docs/4-flutter/1-design/001-DESIGN_CORE_mvp1_v1.0.0.md
14. docs/4-flutter/2-coding-plans/001-CODING_PLAN_CORE_mvp1_v1.0.0.md
15. docs/4-flutter/3-todos/001-TODO_CORE_mvp1_v1.0.0.md
16. docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
17. docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
18. docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md
```

Quando saranno creati, andranno letti anche:

```text
19. docs/4-flutter/1-design/003-DESIGN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
20. docs/4-flutter/2-coding-plans/003-CODING_PLAN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
21. docs/4-flutter/3-todos/003-TODO_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
```

---

# 14. Ordine consigliato per riprendere il lavoro

Quando si riprende il progetto dopo una pausa, leggere prima:

```text
CHANGELOG.md
```

poi:

```text
README.md
```

poi:

```text
docs/README.md
```

poi:

```text
docs/4-flutter/3-todos/000-todo-master.md
```

poi il documento relativo alla fase in corso.
Per la fase attuale, i documenti più importanti sono:

```text
docs/4-flutter/3-todos/000-todo-master.md
docs/4-flutter/001-FLUTTER_PLAN_mvp1_v1.0.0.md
```

Il prossimo documento da creare sarà:

```text
docs/4-flutter/1-design/003-DESIGN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
```

Documenti di contesto ancora importanti per il blocco attuale:

```text
docs/3-backend/002-API_CONTRACTS_mvp1_v1.0.0.md
docs/3-backend/001-BACKEND_RULES_mvp1_v1.0.0.md
docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md
```

---

# 15. Stato attuale del progetto

Alla data di questo documento risultano approvati:

```text
001-ARCHITETTURA_mvp1_v1.0.0.md
001-DATABASE_SCHEMA_mvp1_v1.0.0.md
001-FLOWS_mvp1_v1.0.0.md
001-BACKEND_RULES_mvp1_v1.0.0.md
001-FLUTTER_PLAN_mvp1_v1.0.0.md
002-API_CONTRACTS_mvp1_v1.0.0.md
000-todo-master.md
001-DESIGN_CORE_mvp1_v1.0.0.md
001-CODING_PLAN_CORE_mvp1_v1.0.0.md
001-TODO_CORE_mvp1_v1.0.0.md
002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
002-TODO_AUTH_SESSION_mvp1_v1.0.0.md
```

Risultano inoltre eseguiti e validati:

```text
001_schema.sql
002_rpc.sql
003_rls.sql
004_onboarding_rpc.sql
TEST_PLAN_MVP1_v1.0.0.md
```

Il backend MVP 1.0 è considerato validato.
Il blocco 001 Core Dart minimo è completato.
Il blocco 001 è stato:

* codificato;
* testato;
* committato;
* pushato;
* mergiato in `main`.
  Il blocco 002 Auth/Session è completato.
  Il blocco 002 è stato:
* codificato;
* testato;
* corretto per accessibilità feedback NVDA;
* committato;
* pushato;
* mergiato in `main`.
  Dopo il merge del blocco 002 in `main`, risultano superati:

```text
flutter analyze
flutter test
```

La decisione organizzativa attuale è:

```text
registrazione account separata dall'onboarding azienda/profilo
```

Il prossimo blocco è:

```text
003 Registrazione account
```

---

# 16. Prossimi documenti o attività

I documenti del blocco 001 Core Flutter sono completati:

```text
docs/4-flutter/1-design/001-DESIGN_CORE_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/001-CODING_PLAN_CORE_mvp1_v1.0.0.md
docs/4-flutter/3-todos/001-TODO_CORE_mvp1_v1.0.0.md
```

Il codice del blocco 001 Core Dart minimo è completato.
I documenti del blocco 002 Auth/Session sono completati:

```text
docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md
```

Il codice del blocco 002 Auth/Session è completato.
La prossima attività documentale è:

```text
scrivere il design del blocco 003 Registrazione account
```

Documenti da creare:

```text
docs/4-flutter/1-design/003-DESIGN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/003-CODING_PLAN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
docs/4-flutter/3-todos/003-TODO_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
```

Il blocco 003 dovrà creare:

* accesso alla registrazione dalla login;
* schermata registrazione;
* form email;
* form password;
* form conferma password;
* creazione account tramite Supabase Auth;
* gestione email già registrata;
* gestione password non valida;
* feedback persistente;
* annunci accessibili;
* test automatici;
* test manuali con Supabase reale.
  Il blocco 003 non dovrà creare:
* azienda;
* profilo applicativo;
* onboarding reale;
* home reale;
* categorie;
* fornitori;
* prodotti;
* movimenti;
* storico movimenti.

---

# 17. Regole per aggiornare la documentazione

Ogni modifica strutturale deve essere documentata.
Quando viene completato un blocco importante, aggiornare:

```text
CHANGELOG.md
```

Se la modifica riguarda la documentazione, aggiornare anche questo file quando necessario.
Esempi di casi in cui aggiornare `docs/README.md`:

* nuova cartella documentale;
* nuovo documento ufficiale;
* documento rinominato;
* documento spostato;
* cambio dell'ordine di lettura;
* nuova fase del progetto;
* cambio dello stato di un documento importante;
* cambio della sequenza dei blocchi Flutter.
  Per la fase attuale, il prossimo aggiornamento importante di questo file sarà necessario quando:
* verrà creato il design del blocco 003;
* verrà creato il coding plan del blocco 003;
* verrà creato il TODO del blocco 003;
* verrà completata la codifica del blocco 003;
* si passerà al blocco 004 Onboarding azienda/profilo.

---

# 18. Regole sui nomi dei file

I documenti ufficiali devono usare nomi chiari e ordinati.
Formato consigliato:

```text
NUMERO-NOME_DOCUMENTO_mvp1_vVERSIONE.md
```

Esempio:

```text
001-FLUTTER_PLAN_mvp1_v1.0.0.md
```

Per documenti operativi Flutter:

```text
001-DESIGN_CORE_mvp1_v1.0.0.md
001-CODING_PLAN_CORE_mvp1_v1.0.0.md
001-TODO_CORE_mvp1_v1.0.0.md
002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
002-TODO_AUTH_SESSION_mvp1_v1.0.0.md
003-DESIGN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
003-CODING_PLAN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
003-TODO_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
004-DESIGN_ONBOARDING_mvp1_v1.0.0.md
004-CODING_PLAN_ONBOARDING_mvp1_v1.0.0.md
004-TODO_ONBOARDING_mvp1_v1.0.0.md
```

Per il todo master:

```text
000-todo-master.md
```

---

# 19. Regole di stato dei documenti

Ogni documento importante dovrebbe indicare uno stato.
Stati consigliati:

```text
BOZZA
IN REVISIONE
APPROVATO
SUPERATO
```

## BOZZA

Documento scritto ma non ancora validato.

## IN REVISIONE

Documento inviato a revisori o consiglieri AI.

## APPROVATO

Documento confermato e utilizzabile come riferimento operativo.

## SUPERATO

## Documento non più attuale, mantenuto solo per storico.

# 20. Regole per i consiglieri AI

Non tutti i documenti richiedono revisione esterna.
Richiedono revisione con consiglieri AI:

* architettura;
* schema database;
* regole backend;
* SQL critici;
* RLS;
* RPC;
* API contracts;
* design complessi;
* coding plan importanti prima della codifica;
* scelte importanti su Supabase Auth.
  Non richiedono normalmente revisione esterna:
* README indice;
* todo master semplice;
* aggiornamenti di changelog;
* piccoli documenti di orientamento;
* correzioni puramente editoriali.
  La revisione esterna serve quando il documento introduce scelte tecniche o rischi architetturali.
  Non serve quando il documento organizza materiale già approvato.
  Nota:
  il design del blocco 003 Registrazione account è consigliato per revisione con consiglieri AI, perché riguarda Supabase Auth e il flusso iniziale dell'utente.

---

# 21. Regole di commit

Dopo ogni modifica documentale importante:

1. salvare il file;
2. controllare GitHub Desktop;
3. verificare i file modificati;
4. scrivere un messaggio commit chiaro;
5. eseguire commit;
6. eseguire push.
   Esempi di messaggi commit:

```text
Aggiunge README documentazione
Approva API contracts MVP 1.0
Aggiunge todo master Flutter
Aggiunge design core Flutter
Aggiunge TODO auth session Flutter
Aggiorna documentazione per blocco auth session
Aggiorna documentazione per registrazione separata
Aggiunge design registrazione account
```

---

# 22. Relazione con il README principale del repository

Il file:

```text
README.md
```

nella root del repository descrive il progetto a livello generale.
Il file:

```text
docs/README.md
```

descrive invece la documentazione interna del progetto.
Quindi:

```text
README.md
```

serve a capire che cos'è il progetto.

```text
docs/README.md
```

## serve a capire dove trovare le informazioni tecniche e progettuali.

# 23. Conclusione

La cartella `docs` è la memoria ufficiale del progetto.
Ogni decisione importante deve essere ritrovabile qui.
Ogni documento deve avere uno scopo chiaro.
La documentazione non deve diventare burocrazia inutile.
Deve servire a:

* mantenere ordine;
* ridurre errori;
* aiutare la ripresa del lavoro dopo una pausa;
* guidare la codifica;
* aiutare le revisioni;
* proteggere il progetto da modifiche confuse.
  Con questo indice, la documentazione del Gestionale Magazzino Universale è aggiornata alla fase attuale:

```text
Backend validato.
Core Dart minimo completato.
Auth/Session completato e mergiato in main.
Decisione registrazione account separata da onboarding documentata.
Prossimo passo: design del blocco 003 Registrazione account.
```
