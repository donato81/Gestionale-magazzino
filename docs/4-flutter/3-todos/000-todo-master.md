# TODO MASTER MVP 1.0

## Gestionale Magazzino Universale

Versione: 1.0.0
Stato: APPROVATO
Data: 6 luglio 2026
-------------------

# 1. Scopo del documento

Questo documento è il todo master della fase Flutter dell'MVP 1.
Serve a tenere traccia delle macro-fasi di lavoro necessarie per costruire l'app Flutter del Gestionale Magazzino Universale.
Questo file non contiene codice.
Questo file non sostituisce:

* i documenti di design;
* i coding plan;
* i todo specifici;
* il changelog;
* i test manuali.
  Il suo scopo è rispondere sempre a questa domanda:
  **A che punto siamo e qual è il prossimo blocco logico da fare?**

---

# 2. Ruolo del todo master

Il todo master è la bussola generale del lavoro Flutter.
Deve aiutare a:

* riprendere il progetto dopo una pausa;
* capire quali fasi sono già completate;
* capire quale fase è in corso;
* capire quale fase viene dopo;
* collegare ogni macro-fase ai suoi documenti specifici;
* evitare di saltare passaggi importanti;
* mantenere il lavoro ordinato e verificabile.
  Il todo master deve restare semplice.
  I dettagli operativi devono stare nei todo specifici.

---

# 3. Differenza tra todo master e todo specifici

## Todo master

Il file:
`000-todo-master.md`
contiene la visione generale.
Esempio:

* Core Dart minimo;
* login e sessione;
* registrazione account;
* onboarding azienda/profilo;
* home;
* categorie;
* fornitori;
* prodotti;
* movimenti;
* accessibilità;
* stabilizzazione.

## Todo specifici

I file specifici, come:
`001-TODO_CORE_mvp1_v1.0.0.md`
contengono i passi piccoli e concreti di una singola fase.
Esempio:

* creare cartella `core/messages`;
* creare `app_messages.dart`;
* creare `supabase_error_mapper.dart`;
* creare `app_feedback_controller.dart`;
* creare `app_session_controller.dart`;
* creare i test automatici obbligatori del blocco;
* eseguire `flutter analyze`;
* eseguire `flutter test`;
* aggiornare changelog;
* fare commit.
  Regola:
  **Il todo master dice dove andare.
  Il todo specifico dice come fare quel pezzo.**

---

# 4. Legenda stati

Per mantenere il file semplice e leggibile anche con screen reader, si usano questi stati:

* `[ ]` Da fare
* `[~]` In corso
* `[x]` Completato
* `[!]` Bloccato
  Significato:

## `[ ]` Da fare

La fase è prevista ma non ancora iniziata.

## `[~]` In corso

La fase è stata iniziata ma non ancora completata.

## `[x]` Completato

La fase è stata completata, verificata e committata.

## `[!]` Bloccato

## La fase non può proseguire finché non viene risolto un problema.

# 5. Stato generale del progetto

Alla data di questo documento, il progetto si trova in questa situazione:

* backend Supabase progettato;
* database approvato;
* script SQL eseguiti;
* RLS approvate;
* RPC movimenti approvata;
* RPC onboarding approvata;
* test backend completati;
* repository GitHub creato;
* documentazione principale salvata;
* Flutter plan approvato;
* API Contracts approvato;
* README documentazione creato;
* todo master Flutter approvato;
* design core Flutter approvato;
* coding plan core Flutter approvato;
* TODO core Flutter approvato;
* blocco 001 Core Dart minimo codificato;
* blocco 001 Core Dart minimo testato;
* blocco 001 Core Dart minimo committato;
* blocco 001 Core Dart minimo pushato;
* blocco 001 Core Dart minimo mergiato in `main`;
* dopo il merge del blocco 001, `flutter analyze` passa senza errori;
* dopo il merge del blocco 001, `flutter test` passa con tutti i test superati;
* design auth/session Flutter approvato;
* coding plan auth/session Flutter approvato;
* TODO auth/session Flutter approvato;
* blocco 002 Auth/Session codificato;
* blocco 002 Auth/Session testato;
* blocco 002 Auth/Session corretto per accessibilità feedback NVDA;
* blocco 002 Auth/Session committato;
* blocco 002 Auth/Session pushato;
* blocco 002 Auth/Session mergiato in `main`;
* dopo il merge del blocco 002, `flutter analyze` passa senza errori;
* dopo il merge del blocco 002, `flutter test` passa con tutti i test superati;
* test manuali principali login/logout/sessione superati;
* test manuali NVDA sui feedback principali superati.
  La codifica del blocco 001 Core Dart minimo è completata.
  La codifica del blocco 002 Login, logout e sessione è completata.
  La prossima fase non è più onboarding diretto.
  La prossima fase riguarda l'aggiornamento documentale della sequenza Flutter e poi la preparazione del nuovo blocco 003:
  `Registrazione account`.

---

# 6. Decisione organizzativa — Registrazione separata da onboarding

Durante la validazione del blocco 002 è emerso un punto importante:
l'app permette il login di utenti già esistenti, ma non permette ancora a un nuovo utente di registrarsi dall'app.
Per l'MVP 1 questa possibilità è necessaria.
Un utente finale non deve dover entrare in Supabase, creare utenti manualmente, resettare password o lanciare query SQL.
Decisione:

```text
la registrazione account viene separata dall'onboarding azienda/profilo
```

Significato:

* registrazione account = crea l'utente Supabase Auth;
* onboarding = crea azienda e profilo applicativo tramite RPC `crea_azienda_e_profilo`.
  Nuova sequenza ufficiale:

```text
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

* ogni blocco mantiene una sola missione;
* Antigravity riceve istruzioni più piccole e meno ambigue;
* se un problema nasce nella registrazione, resta isolato nel blocco 003;
* se un problema nasce nell'onboarding, resta isolato nel blocco 004;
* si evita di mischiare creazione utente, creazione azienda e creazione profilo nello stesso blocco;
* il flusso finale resta coerente con l'MVP 1.
  Esempio logico:

```text
Blocco 003 risponde alla domanda:
come nasce un utente Supabase?
Blocco 004 risponde alla domanda:
a quale azienda appartiene questo utente?
Blocco 005 risponde alla domanda:
cosa vede l'utente quando entra?
```

---

# 7. Documenti già approvati

## Architettura

Documento:
`docs/0-architettura/001-ARCHITETTURA_mvp1_v1.0.0.md`
Stato:
`APPROVATO`

## Database schema

Documento:
`docs/1-database/001-DATABASE_SCHEMA_mvp1_v1.0.0.md`
Stato:
`APPROVATO`

## Script Supabase

Documenti:

* `docs/1-database/supabase/001_schema.sql`
* `docs/1-database/supabase/002_rpc.sql`
* `docs/1-database/supabase/003_rls.sql`
* `docs/1-database/supabase/004_onboarding_rpc.sql`
  Stato:
  `APPROVATI ED ESEGUITI`

## Test backend

Documento:
`docs/1-database/TEST_PLAN_MVP1_v1.0.0.md`
Stato:
`APPROVATO`
Esito:
`TEST BACKEND SUPERATI`

## Flussi applicativi

Documento:
`docs/2-flussi-applicativi/001-FLOWS_mvp1_v1.0.0.md`
Stato:
`APPROVATO`

## Backend rules

Documento:
`docs/3-backend/001-BACKEND_RULES_mvp1_v1.0.0.md`
Stato:
`APPROVATO`

## API Contracts

Documento:
`docs/3-backend/002-API_CONTRACTS_mvp1_v1.0.0.md`
Stato:
`APPROVATO`
Nota:
gli API Contracts potranno essere aggiornati dopo il design del blocco 003, se sarà necessario precisare meglio il contratto della registrazione account.

## Flutter plan

Documento:
`docs/4-flutter/001-FLUTTER_PLAN_mvp1_v1.0.0.md`
Stato:
`APPROVATO`
Nota:
il Flutter plan deve essere aggiornato per riflettere la decisione di separare registrazione account e onboarding azienda/profilo.

## README documentazione

Documento:
`docs/README.md`
Stato:
`APPROVATO`

## Design core Flutter

Documento:
`docs/4-flutter/1-design/001-DESIGN_CORE_mvp1_v1.0.0.md`
Stato:
`APPROVATO`

## Coding plan core Flutter

Documento:
`docs/4-flutter/2-coding-plans/001-CODING_PLAN_CORE_mvp1_v1.0.0.md`
Stato:
`APPROVATO`

## TODO core Flutter

Documento:
`docs/4-flutter/3-todos/001-TODO_CORE_mvp1_v1.0.0.md`
Stato:
`APPROVATO`

## Design auth/session Flutter

Documento:
`docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md`
Stato:
`APPROVATO`

## Coding plan auth/session Flutter

Documento:
`docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md`
Stato:
`APPROVATO`

## TODO auth/session Flutter

Documento:
`docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md`
Stato:
`APPROVATO`
-----------

# 8. Regola di lavoro per la fase Flutter

Ogni blocco Flutter importante deve seguire questo ordine:

1. design;
2. coding plan;
3. todo specifico;
4. codice;
5. test automatici obbligatori, quando previsti dal blocco;
6. test manuale e verifica accessibilità, quando previsti dal blocco;
7. eventuali correzioni;
8. aggiornamento changelog;
9. commit;
10. push;
11. merge in `main`, quando il blocco è validato.
    Questa regola evita di scrivere codice senza una direzione chiara.
    Per ogni blocco codificato devono essere eseguiti almeno:

```text
flutter analyze
flutter test
```

entrambi con esito positivo, salvo blocchi esclusivamente documentali.
Per i blocchi con UI o feedback utente, la verifica manuale con screen reader è obbligatoria.
---------------------------------------------------------------------------------------------

# 9. Macro-fasi Flutter MVP 1.0

## 9.1 Preparazione operativa Flutter

Stato:
`[x] Completato`
Obiettivo:
preparare i documenti operativi necessari prima di scrivere il core Dart minimo.
Documenti collegati:

* `docs/4-flutter/3-todos/000-todo-master.md`
  Documenti completati:
* `docs/4-flutter/1-design/001-DESIGN_CORE_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/001-CODING_PLAN_CORE_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/001-TODO_CORE_mvp1_v1.0.0.md`
  Criterio di completamento:
  questa fase è completata quando esistono e sono approvati:
* design core;
* coding plan core;
* todo core.
  Esito:

```text
COMPLETATO
```

Note:

* design core approvato;
* coding plan core approvato;
* TODO core approvato;
* documenti salvati e committati.

---

## 9.2 Core Dart minimo

Stato:
`[x] Completato`
Obiettivo:
creare la base comune dell'app Flutter prima delle schermate complete.
Il core contiene, in forma minima:

* messaggi centralizzati;
* errori centralizzati;
* mapper errori Supabase;
* feedback persistente;
* controller feedback;
* supporto accessibilità minimo;
* gestione sessione minima;
* controller sessione minimo;
* test automatici obbligatori.
  Documenti approvati:
* `docs/4-flutter/1-design/001-DESIGN_CORE_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/001-CODING_PLAN_CORE_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/001-TODO_CORE_mvp1_v1.0.0.md`
  Criterio di completamento:
* cartelle core create;
* otto file core di produzione creati;
* quattro file di test automatici obbligatori creati;
* nessuna stringa utente importante sparsa nel codice iniziale;
* sistema messaggi base presente;
* sistema errori base presente;
* mapper errori Supabase presente;
* feedback applicativo base presente;
* controller feedback presente;
* accessibilità minima predisposta;
* sessione minima predisposta;
* controller sessione minimo presente;
* nessuna UI reale anticipata;
* nessun login reale anticipato;
* nessun onboarding reale anticipato;
* nessun servizio Supabase verticale anticipato;
* `flutter analyze` senza errori;
* `flutter test` con esito positivo;
* changelog aggiornato;
* commit eseguito;
* push eseguito;
* merge in `main` eseguito;
* verifica su `main` eseguita.
  File di produzione:

```text
lib/core/messages/app_messages.dart
lib/core/errors/app_exception.dart
lib/core/errors/supabase_error_mapper.dart
lib/core/feedback/app_feedback_message.dart
lib/core/feedback/app_feedback_controller.dart
lib/core/accessibility/accessibility_service.dart
lib/core/session/app_session_state.dart
lib/core/session/app_session_controller.dart
```

File di test:

```text
test/core/errors/supabase_error_mapper_test.dart
test/core/feedback/app_feedback_controller_test.dart
test/core/session/app_session_controller_test.dart
test/core/accessibility/accessibility_service_test.dart
```

Esito:

```text
COMPLETATO
```

Note:

* blocco core codificato;
* test automatici superati;
* `flutter analyze` superato;
* commit eseguito;
* push eseguito;
* merge in `main` eseguito;
* dopo merge su `main`, `flutter analyze` e `flutter test` risultano superati.

---

## 9.3 Login, logout e sessione

Stato:
`[x] Completato`
Obiettivo:
gestire l'accesso dell'utente e lo stato iniziale dell'app.
Funzionalità implementate:

* login con email e password;
* logout;
* controllo sessione all'avvio;
* gestione utente non autenticato;
* gestione utente autenticato senza profilo;
* gestione utente autenticato con profilo;
* controllo profilo applicativo;
* controllo azienda collegata al profilo;
* gestione utente con profilo assente;
* gestione utente con profilo incompleto;
* gestione azienda non leggibile o non trovata;
* gestione sessione persistente;
* gestione eventi auth Supabase;
* gestione `tokenRefreshed`;
* gestione eventi auth non previsti come no-op esplicito;
* protezione da doppi login, doppi logout e doppi retry;
* feedback persistente;
* annunci accessibili dei feedback principali;
* placeholder onboarding;
* placeholder home.
  Documenti approvati:
* `docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md`
  Criterio di completamento:
* login funzionante;
* logout funzionante;
* sessione letta all'avvio;
* sessione persistente recuperata correttamente;
* eventi auth gestiti in un solo punto centrale;
* nessun listener auth duplicato;
* errori login tradotti in messaggi comprensibili;
* feedback persistente presente;
* schermata corretta mostrata in base allo stato utente;
* utente senza profilo portato a placeholder onboarding;
* utente con profilo e azienda portato a placeholder home;
* errore lettura profilo non confuso con profilo assente;
* azienda non leggibile non confusa con profilo incompleto;
* RLS silenti gestite correttamente quando `maybeSingle()` restituisce `null`;
* `tokenRefreshed` gestito tramite confronto `user.id`;
* eventi auth non previsti gestiti come no-op esplicito;
* `AuthPlaceholderPage` coperta da test;
* test automatici del blocco superati;
* test manuali login/sessione superati;
* verifica accessibilità minima eseguita;
* correzione annunci NVDA eseguita;
* `flutter analyze` senza errori;
* `flutter test` con esito positivo;
* changelog aggiornato;
* commit eseguito;
* push eseguito;
* merge in `main` eseguito;
* verifica su `main` eseguita.
  File di produzione:

```text
app/lib/features/auth/domain/auth_profile_check_result.dart
app/lib/features/auth/data/auth_service.dart
app/lib/features/auth/data/profile_service.dart
app/lib/features/auth/application/auth_session_coordinator.dart
app/lib/features/auth/presentation/session_gate.dart
app/lib/features/auth/presentation/login_page.dart
app/lib/features/auth/presentation/auth_placeholder_page.dart
app/lib/core/feedback/app_feedback_view.dart
app/lib/app/app_root.dart
```

File di test:

```text
app/test/features/auth/domain/auth_profile_check_result_test.dart
app/test/features/auth/data/profile_service_test.dart
app/test/features/auth/application/auth_session_coordinator_test.dart
app/test/features/auth/presentation/session_gate_test.dart
app/test/features/auth/presentation/login_page_test.dart
app/test/features/auth/presentation/auth_placeholder_page_test.dart
app/test/core/feedback/app_feedback_view_test.dart
```

Esito:

```text
COMPLETATO
```

Note:

* blocco 002 codificato;
* 77 test automatici superati;
* login reale verificato con utenti Supabase di test;
* logout verificato;
* sessione persistente verificata;
* feedback principali verificati con NVDA;
* merge in `main` completato.

---

## 9.4 Registrazione account

Stato:
`[ ] Da fare`
Obiettivo:
permettere a un nuovo utente di creare un account Supabase Auth direttamente dall'app, senza usare Supabase Dashboard.
Questo blocco risponde alla domanda:

```text
come nasce un utente Supabase?
```

Funzionalità previste:

* accesso alla schermata registrazione dalla login;
* form registrazione minimale;
* inserimento email;
* inserimento password;
* conferma password;
* validazione campi obbligatori;
* validazione password e conferma password coerenti;
* gestione email già registrata;
* gestione password non valida o troppo debole;
* creazione account tramite Supabase Auth;
* feedback persistente;
* annunci accessibili dei messaggi principali;
* ritorno alla login se l'utente annulla;
* gestione dell'esito dopo registrazione secondo configurazione Supabase Auth.
  Documenti previsti:
* `docs/4-flutter/1-design/003-DESIGN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/003-CODING_PLAN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/003-TODO_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md`
  Criterio di completamento:
* schermata registrazione raggiungibile dalla login;
* form registrazione accessibile;
* account Supabase creato correttamente dall'app;
* email già esistente gestita con messaggio comprensibile;
* password vuota o non valida gestita con messaggio comprensibile;
* conferma password errata gestita con messaggio comprensibile;
* feedback persistente e annunci NVDA verificati;
* nessuna azienda creata in questo blocco;
* nessun profilo applicativo creato in questo blocco;
* nessuna chiamata a `crea_azienda_e_profilo` in questo blocco;
* test automatici del blocco superati;
* test manuali con Supabase reale superati;
* `flutter analyze` senza errori;
* `flutter test` con esito positivo;
* changelog aggiornato;
* commit eseguito;
* push eseguito.
  Regola:

```text
questo blocco crea l'account utente, non crea ancora l'azienda
```

---

## 9.5 Onboarding azienda/profilo

Stato:
`[ ] Da fare`
Obiettivo:
permettere a un utente autenticato senza profilo di creare azienda e profilo applicativo.
Questo blocco risponde alla domanda:

```text
a quale azienda appartiene questo utente?
```

Funzionalità previste:

* rilevamento profilo assente;
* sostituzione del placeholder onboarding con schermata reale;
* inserimento nome azienda;
* eventuale nome profilo;
* chiamata RPC `crea_azienda_e_profilo`;
* gestione onboarding duplicato;
* gestione nome azienda obbligatorio;
* gestione errori RPC;
* passaggio alla home dopo onboarding riuscito.
  Documenti previsti:
* `docs/4-flutter/1-design/004-DESIGN_ONBOARDING_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/004-CODING_PLAN_ONBOARDING_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/004-TODO_ONBOARDING_mvp1_v1.0.0.md`
  Criterio di completamento:
* onboarding funzionante;
* azienda creata tramite RPC;
* profilo creato tramite RPC;
* nessun insert separato diretto su `aziende`;
* nessun insert separato diretto su `profili`;
* doppio onboarding gestito;
* messaggi chiari;
* feedback persistente;
* annunci NVDA verificati;
* test automatici del blocco superati;
* test manuali onboarding superati;
* `flutter analyze` senza errori;
* `flutter test` con esito positivo;
* changelog aggiornato;
* commit eseguito;
* push eseguito.
  Regola:

```text
questo blocco crea azienda e profilo, ma solo per un utente già autenticato
```

---

## 9.6 Home

Stato:
`[ ] Da fare`
Obiettivo:
creare la schermata iniziale reale dopo login e onboarding.
Funzionalità previste:

* sostituzione del placeholder home;
* mostrare nome azienda;
* mostrare utente o profilo corrente;
* collegamenti principali;
* accesso a categorie;
* accesso a fornitori;
* accesso a prodotti;
* accesso a movimenti;
* logout raggiungibile.
  Documenti previsti:
* `docs/4-flutter/1-design/005-DESIGN_HOME_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/005-CODING_PLAN_HOME_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/005-TODO_HOME_mvp1_v1.0.0.md`
  Criterio di completamento:
* home leggibile;
* navigazione principale funzionante;
* elementi letti correttamente da screen reader;
* logout raggiungibile;
* test home superati;
* commit eseguito.

---

## 9.7 Categorie

Stato:
`[ ] Da fare`
Obiettivo:
gestire le categorie prodotto.
Funzionalità previste:

* lista categorie;
* creazione categoria;
* modifica categoria;
* disattivazione categoria;
* gestione nome obbligatorio;
* gestione nome duplicato;
* visualizzazione stato attiva/inattiva.
  Documenti previsti:
* `docs/4-flutter/1-design/006-DESIGN_CATEGORIES_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/006-CODING_PLAN_CATEGORIES_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/006-TODO_CATEGORIES_mvp1_v1.0.0.md`
  Criterio di completamento:
* lista categorie funzionante;
* creazione funzionante;
* modifica funzionante;
* disattivazione funzionante;
* errori tradotti;
* feedback accessibile;
* commit eseguito.

---

## 9.8 Fornitori

Stato:
`[ ] Da fare`
Obiettivo:
gestire l'anagrafica fornitori.
Funzionalità previste:

* lista fornitori;
* creazione fornitore;
* modifica fornitore;
* disattivazione fornitore;
* gestione nome obbligatorio;
* gestione nome duplicato;
* gestione campi facoltativi;
* visualizzazione stato attivo/inattivo.
  Documenti previsti:
* `docs/4-flutter/1-design/007-DESIGN_SUPPLIERS_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/007-CODING_PLAN_SUPPLIERS_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/007-TODO_SUPPLIERS_mvp1_v1.0.0.md`
  Criterio di completamento:
* lista fornitori funzionante;
* creazione funzionante;
* modifica funzionante;
* disattivazione funzionante;
* errori tradotti;
* feedback accessibile;
* commit eseguito.

---

## 9.9 Prodotti

Stato:
`[ ] Da fare`
Obiettivo:
gestire l'anagrafica prodotti.
Funzionalità previste:

* lista prodotti;
* dettaglio prodotto;
* creazione prodotto;
* modifica prodotto;
* disattivazione prodotto;
* gestione barcode;
* gestione categoria;
* gestione fornitore preferito;
* gestione prezzi;
* gestione scorta minima;
* visualizzazione scorta attuale;
* blocco modifica diretta scorta.
  Documenti previsti:
* `docs/4-flutter/1-design/008-DESIGN_PRODUCTS_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/008-CODING_PLAN_PRODUCTS_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/008-TODO_PRODUCTS_mvp1_v1.0.0.md`
  Criterio di completamento:
* lista prodotti funzionante;
* dettaglio prodotto funzionante;
* creazione funzionante;
* modifica funzionante;
* disattivazione funzionante;
* barcode vuoto salvato come `NULL`;
* scorta attuale non modificata direttamente;
* errori tradotti;
* feedback accessibile;
* commit eseguito.

---

## 9.10 Movimenti di magazzino

Stato:
`[ ] Da fare`
Obiettivo:
registrare le variazioni di scorta tramite RPC.
Funzionalità previste:

* carico;
* vendita;
* rettifica;
* eventuale reso cliente dopo carico/vendita/rettifica;
* chiamata RPC `registra_movimento`;
* blocco movimenti su prodotti inattivi;
* gestione scorta insufficiente;
* gestione scorta minima;
* motivazione obbligatoria per rettifica.
  Documenti previsti:
* `docs/4-flutter/1-design/009-DESIGN_MOVEMENTS_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/009-CODING_PLAN_MOVEMENTS_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/009-TODO_MOVEMENTS_mvp1_v1.0.0.md`
  Criterio di completamento:
* carico funzionante;
* vendita funzionante;
* rettifica funzionante;
* RPC usata correttamente;
* nessun inserimento diretto in `movimenti_magazzino`;
* nessun update diretto di `scorta_attuale`;
* messaggi accessibili;
* test manuali movimenti superati;
* commit eseguito.

---

## 9.11 Storico movimenti

Stato:
`[ ] Da fare`
Obiettivo:
consultare lo storico dei movimenti di magazzino.
Funzionalità previste:

* lista movimenti;
* storico per prodotto;
* filtro per prodotto;
* filtro per tipo movimento;
* filtro per data;
* visualizzazione scorta prima;
* visualizzazione scorta dopo;
* visualizzazione note;
* visualizzazione fornitore nei carichi.
  Per l'MVP 1 il nome operatore non viene mostrato in forma amichevole.
  Documenti previsti:
* `docs/4-flutter/1-design/010-DESIGN_MOVEMENT_HISTORY_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/010-CODING_PLAN_MOVEMENT_HISTORY_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/010-TODO_MOVEMENT_HISTORY_mvp1_v1.0.0.md`
  Criterio di completamento:
* storico leggibile;
* filtri principali funzionanti;
* movimenti ordinati correttamente;
* dati importanti letti bene da screen reader;
* commit eseguito.

---

## 9.12 Revisione accessibilità

Stato:
`[ ] Da fare`
Obiettivo:
verificare che il flusso principale sia utilizzabile tramite screen reader.
Controlli previsti:

* login;
* registrazione account;
* onboarding;
* home;
* categorie;
* fornitori;
* prodotti;
* movimenti;
* storico;
* messaggi errore;
* messaggi successo;
* navigazione;
* ordine del focus;
* chiarezza dei pulsanti;
* assenza di informazioni solo visive.
  Documenti previsti:
* `docs/4-flutter/1-design/011-DESIGN_ACCESSIBILITY_REVIEW_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/011-CODING_PLAN_ACCESSIBILITY_REVIEW_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/011-TODO_ACCESSIBILITY_REVIEW_mvp1_v1.0.0.md`
  Criterio di completamento:
* flusso principale usabile con screen reader;
* errori principali leggibili;
* messaggi persistenti funzionanti;
* nessuna funzione critica solo visiva;
* commit eseguito.

---

## 9.13 Stabilizzazione MVP 1

Stato:
`[ ] Da fare`
Obiettivo:
stabilizzare l'app prima di considerare chiuso l'MVP 1.
Attività previste:

* revisione bug;
* pulizia codice;
* controllo documentazione;
* controllo changelog;
* controllo versioni;
* test manuale completo;
* verifica repository;
* preparazione eventuale tag di versione.
  Documenti previsti:
* `docs/4-flutter/1-design/012-DESIGN_STABILIZATION_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/012-CODING_PLAN_STABILIZATION_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/012-TODO_STABILIZATION_mvp1_v1.0.0.md`
  Criterio di completamento:
* flusso MVP 1 completo;
* test principali superati;
* documentazione aggiornata;
* changelog aggiornato;
* commit finale eseguito;
* MVP 1 pronto per uso reale iniziale.

---

# 10. Riepilogo macro-fasi

Stato attuale:

* `[x]` Preparazione operativa Flutter
* `[x]` Core Dart minimo
* `[x]` Login, logout e sessione
* `[ ]` Registrazione account
* `[ ]` Onboarding azienda/profilo
* `[ ]` Home
* `[ ]` Categorie
* `[ ]` Fornitori
* `[ ]` Prodotti
* `[ ]` Movimenti di magazzino
* `[ ]` Storico movimenti
* `[ ]` Revisione accessibilità
* `[ ]` Stabilizzazione MVP 1

---

# 11. Prossimo passo operativo

Il prossimo passo non è ancora codificare.
Il prossimo passo è aggiornare la documentazione generale per riflettere la nuova decisione:

```text
registrazione account separata dall'onboarding azienda/profilo
```

Documenti da valutare o aggiornare:

* `docs/4-flutter/001-FLUTTER_PLAN_mvp1_v1.0.0.md`
* eventuale `README.md`, se contiene stato o sequenza dei blocchi non più aggiornata;
* eventuale `docs/README.md`, se contiene stato o sequenza dei blocchi non più aggiornata;
* `CHANGELOG.md`, dopo aver completato l'aggiornamento documentale.
  Dopo questo aggiornamento documentale, il prossimo blocco da progettare sarà:

```text
Blocco 003 — Registrazione account
```

Documenti previsti per il blocco 003:

* `docs/4-flutter/1-design/003-DESIGN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/003-CODING_PLAN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/003-TODO_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md`
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
  Il blocco 003 dovrà concentrarsi solo su:
* registrazione account Supabase Auth;
* validazione form;
* feedback persistente;
* accessibilità;
* test automatici;
* test manuali reali.

---

# 12. Regole per aggiornare questo file

Questo file deve essere aggiornato quando:

* una macro-fase entra in corso;
* una macro-fase viene completata;
* una macro-fase viene bloccata;
* viene creata o modificata una decisione organizzativa importante;
* viene creato un nuovo design;
* viene creato un nuovo coding plan;
* viene creato un nuovo todo specifico;
* viene completato un blocco di codice importante;
* cambia il prossimo passo operativo;
* cambia la struttura della documentazione Flutter.

---

# 13. Cosa non deve contenere questo file

Questo file non deve contenere:

* codice Dart;
* istruzioni lunghe passo passo;
* micro-task troppo dettagliati;
* bug temporanei piccoli;
* test completi dei singoli blocchi;
* prompt per coding agent;
* bozze di schermate;
* dettagli tecnici che appartengono ai coding plan.
  Questi contenuti devono stare nei documenti specifici.

---

# 14. Regole per i todo specifici

Ogni todo specifico deve essere collegato a una sola macro-fase.
Esempio:
`001-TODO_CORE_mvp1_v1.0.0.md`
deve riguardare solo il core Dart minimo.
Esempio:
`002-TODO_AUTH_SESSION_mvp1_v1.0.0.md`
deve riguardare solo login, logout e sessione.
Esempio:
`003-TODO_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md`
deve riguardare solo registrazione account.
Esempio:
`004-TODO_ONBOARDING_mvp1_v1.0.0.md`
deve riguardare solo onboarding azienda/profilo.
Un todo specifico deve contenere:

* obiettivo del blocco;
* documenti di riferimento;
* file da creare;
* file da modificare;
* task piccoli;
* test automatici obbligatori, quando previsti;
* test manuali, quando previsti;
* criterio di completamento;
* commit consigliato.
  Un todo specifico non deve mischiare fasi diverse.
  Esempio da evitare:
* registrazione account;
* onboarding;
* home;
* prodotti;
  tutti nello stesso todo.

---

# 15. Regola dei piccoli passi

Il progetto deve procedere con piccoli blocchi.
Regola:
**un blocco, un obiettivo, un test, un commit.**
Questo significa:

1. scrivere il design del blocco;
2. scrivere il coding plan;
3. scrivere il todo specifico;
4. implementare solo quel blocco;
5. testare;
6. correggere;
7. committare.
   Questa regola serve a evitare confusione e regressioni.
   Applicazione pratica:

* blocco 003 = registrazione account;
* blocco 004 = onboarding azienda/profilo;
* blocco 005 = home.

---

# 16. Regola sui commit

Ogni blocco completato deve avere un commit chiaro.
Esempi:

* `Aggiunge todo master Flutter`
* `Aggiunge design core Flutter`
* `Aggiunge coding plan core Flutter`
* `Aggiunge TODO core Flutter`
* `Aggiunge core Dart minimo`
* `Aggiunge design auth session Flutter`
* `Aggiunge coding plan auth session Flutter`
* `Aggiunge TODO auth session Flutter`
* `Aggiunge login logout e gestione sessione`
* `Aggiorna piano Flutter con registrazione separata`
* `Aggiunge design registrazione account`
* `Aggiunge registrazione account`
* `Aggiunge design onboarding azienda profilo`
* `Aggiunge onboarding azienda profilo`
  Il commit deve descrivere cosa è stato fatto, non essere generico.
  Da evitare:
* `modifiche`
* `fix`
* `varie`
* `aggiornamento`

---

# 17. Regola sul changelog

Quando viene completato un blocco importante, aggiornare:
`CHANGELOG.md`
Il changelog deve raccontare l'evoluzione del progetto.
Il todo master dice cosa resta da fare.
Il changelog dice cosa è stato fatto.
Il changelog deve distinguere:

* completamento documentale di un blocco;
* completamento della codifica di un blocco;
* eventuali correzioni successive;
* decisioni organizzative importanti, quando cambiano la sequenza di lavoro.
  Per questa fase, il changelog dovrà registrare l'aggiornamento documentale che separa:
* registrazione account;
* onboarding azienda/profilo.

---

# 18. Regola sui consiglieri AI

Questo aggiornamento del todo master introduce una decisione organizzativa importante, ma non modifica backend, database, RLS o RPC.
La revisione con consiglieri AI è consigliata per:

* design complessi;
* coding plan critici;
* modifiche backend;
* nuove RPC;
* modifiche RLS;
* modifiche alla logica di scorta;
* scelte architetturali importanti.
  La revisione non è normalmente necessaria per:
* todo master;
* README;
* changelog;
* piccoli aggiornamenti organizzativi;
* correzioni editoriali.
  Per il nuovo blocco 003 Registrazione account, la revisione con consiglieri AI sarà consigliata dopo la prima bozza del design, perché il blocco riguarda Supabase Auth e il flusso iniziale dell'utente.

---

# 19. Regola di accessibilità permanente

L'accessibilità non è una fase finale separata.
Ogni macro-fase deve rispettare fin dall'inizio questi principi:

* messaggi testuali;
* feedback persistente;
* pulsanti chiari;
* campi con etichette leggibili;
* ordine logico;
* nessuna informazione solo visiva;
* nessun errore comunicato solo tramite colore;
* compatibilità con screen reader.
  La revisione accessibilità finale serve a verificare il risultato complessivo, non a introdurre l'accessibilità per la prima volta.
  La registrazione account dovrà essere progettata con gli stessi criteri già usati per login e feedback:
* campi leggibili;
* errori annunciati;
* messaggi persistenti;
* niente affidamento esclusivo al colore;
* test manuale con NVDA.

---

# 20. Regola backend fonte della verità

Durante tutta la fase Flutter resta valida questa regola:
**il backend è la fonte della verità.**
Flutter non deve:

* modificare direttamente `prodotti.scorta_attuale`;
* inserire direttamente in `movimenti_magazzino`;
* modificare movimenti;
* eliminare movimenti;
* usare service role key;
* bypassare le RLS;
* fidarsi dei dati locali come se fossero definitivi.
  Flutter deve:
* usare Supabase Auth per login, logout e registrazione account;
* usare `crea_azienda_e_profilo` per onboarding azienda/profilo;
* usare `registra_movimento` per carico, vendita, reso e rettifica;
* leggere i dati consentiti dalle RLS;
* tradurre gli errori tecnici in messaggi comprensibili;
* mostrare feedback persistente.
  Nel blocco 003 Registrazione account, Flutter non deve ancora chiamare:

```text
crea_azienda_e_profilo
```

Questa RPC appartiene al blocco 004 Onboarding azienda/profilo.
Nel blocco 003 Registrazione account, Flutter deve solo:

* creare l'utente Supabase Auth;
* gestire validazioni e messaggi;
* mantenere accessibilità;
* preparare il passaggio logico verso onboarding, senza creare ancora azienda e profilo.

---

# 21. Stato del documento

Stato:
`APPROVATO`
Versione:
`1.0.0`
Nome file:
`docs/4-flutter/3-todos/000-todo-master.md`
Prossimo passo:
`Aggiornare il Flutter plan con la decisione Registrazione account separata da onboarding azienda/profilo`
Documenti guida:

* `docs/4-flutter/001-FLUTTER_PLAN_mvp1_v1.0.0.md`
* `docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md`
* `docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md`
* `docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md`

---

# 22. Conclusione

Questo todo master definisce la mappa generale della fase Flutter dell'MVP 1.
Il documento non deve diventare un elenco enorme di dettagli.
Deve restare una bussola.
I dettagli saranno scritti nei design, nei coding plan e nei todo specifici.
La preparazione documentale del core Dart minimo è completata.
La codifica del core Dart minimo è completata.
La preparazione documentale del blocco Login, logout e sessione è completata.
La codifica del blocco Login, logout e sessione è completata.
Il blocco 002 ha creato la porta d'ingresso dell'app:

* controllo sessione;
* login;
* logout;
* lettura profilo;
* lettura azienda;
* placeholder onboarding;
* placeholder home;
* feedback persistente;
* test automatici obbligatori;
* test manuali principali;
* verifica NVDA dei feedback principali.
  La prossima decisione operativa è già fissata:
* il blocco 003 sarà dedicato alla registrazione account;
* il blocco 004 sarà dedicato all'onboarding azienda/profilo;
* il blocco 005 sarà dedicato alla home.
  Il prossimo passo concreto è aggiornare la documentazione generale, a partire dal Flutter plan, per rendere ufficiale questa nuova sequenza prima di scrivere il design del blocco 003.
