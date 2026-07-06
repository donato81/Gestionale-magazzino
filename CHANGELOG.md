# CHANGELOG

## Gestionale Magazzino Universale

Questo file tiene traccia delle modifiche importanti del progetto.
Il changelog documenta l'evoluzione del progetto, mentre la versione tecnica dell'app Flutter viene mantenuta nel file:

```text
app/pubspec.yaml
```

Formato consigliato:

```text
MAJOR.MINOR.PATCH
```

Regola generale:

* MAJOR: cambiamenti grandi o incompatibili.
* MINOR: nuove funzionalità o nuove fasi completate.
* PATCH: correzioni, rifiniture, piccoli miglioramenti.

---

## [0.5.1] - 2026-07-06

### Aggiunto

* Documentata la decisione organizzativa di separare la registrazione account dall'onboarding azienda/profilo.
* Aggiunta la nuova sequenza ufficiale dei blocchi Flutter:

  * blocco 002: Login, logout e sessione;
  * blocco 003: Registrazione account;
  * blocco 004: Onboarding azienda/profilo;
  * blocco 005: Home;
  * blocchi successivi scalati di conseguenza.
* Aggiunta nei documenti la regola secondo cui la registrazione account crea solo l'utente Supabase Auth.
* Aggiunta nei documenti la regola secondo cui l'onboarding crea azienda e profilo applicativo tramite RPC `crea_azienda_e_profilo`.
* Aggiunta nei documenti la regola secondo cui il blocco 003 non deve creare azienda, profilo, onboarding reale o home reale.
* Aggiunta nei documenti la regola secondo cui il blocco 004 non deve creare l'account Supabase Auth.
* Aggiunta la previsione dei documenti del nuovo blocco 003:

  * `docs/4-flutter/1-design/003-DESIGN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md`;
  * `docs/4-flutter/2-coding-plans/003-CODING_PLAN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md`;
  * `docs/4-flutter/3-todos/003-TODO_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md`.

### Modificato

* Aggiornato `docs/4-flutter/3-todos/000-todo-master.md` con lo stato reale del progetto dopo il completamento del blocco 002.
* Aggiornato `docs/4-flutter/3-todos/000-todo-master.md` per segnare il blocco 002 Auth/Session come completato, testato, committato, pushato e mergiato in `main`.
* Aggiornato `docs/4-flutter/3-todos/000-todo-master.md` per inserire il nuovo blocco 003 Registrazione account e spostare l'onboarding al blocco 004.
* Aggiornato `docs/4-flutter/001-FLUTTER_PLAN_mvp1_v1.0.0.md` con la decisione D07: Registrazione account separata da onboarding.
* Aggiornato `README.md` principale del repository con lo stato reale del progetto, il completamento del blocco 002 e il nuovo prossimo passo sul blocco 003.
* Aggiornato `docs/README.md` con la nuova sequenza Flutter e con il nuovo ordine dei documenti futuri.
* Aggiornati i riferimenti al prossimo passo operativo, sostituendo il vecchio riferimento al blocco 002 con il nuovo riferimento al design del blocco 003 Registrazione account.

### Note

* Questa versione non introduce codice Dart nuovo.
* Questa versione non modifica SQL, RLS o RPC.
* Questa versione non modifica il backend.
* Questa versione serve a rendere coerente la documentazione ufficiale dopo il completamento del blocco 002.
* La scelta di separare registrazione account e onboarding riduce il rischio di blocchi troppo grandi e rende più semplice isolare eventuali problemi futuri.
* Il prossimo passo operativo sarà scrivere il design del blocco 003 Registrazione account.

---

## [0.5.0] - 2026-07-06

### Aggiunto

* Implementata la codifica del blocco 002 Auth/Session.
* Creata la logica di controllo della sessione Supabase all'avvio e del recupero della sessione persistente.
* Creata la classe `AuthProfileCheckResult` per rappresentare gli stati di verifica del profilo applicativo e dell'azienda.
* Creato `AuthService` e `SupabaseAuthService` per incapsulare le chiamate di login e logout di Supabase Auth.
* Creato `ProfileService` e `SupabaseProfileService` per verificare l'esistenza del profilo utente e la leggibilità dell'azienda associata.
* Creato `AuthSessionCoordinator` per centralizzare la gestione della sessione, gestire race condition, doppi invii e deduplicazione degli eventi auth.
* Creato il widget `AppFeedbackView` per mostrare in UI feedback persistenti e accessibili.
* Creato il widget `SessionGate` per osservare lo stato della sessione applicativa e del feedback, e caricare la schermata corretta.
* Creata la pagina `LoginPage` per l'accesso utente tramite email e password, comprensiva di validazioni dei campi e feedback di caricamento.
* Creata la pagina `AuthPlaceholderPage` per gestire in modo temporaneo e minimale le schermate di onboarding e home.
* Creato il widget `AppRoot` per contenere il `MaterialApp` principale in modo da mantenere pulito `main.dart`.
* Aggiunti test unitari completi e integrati per tutti i moduli logici e widget del blocco 002.

### Modificato

* Aggiornato `main.dart` per inizializzare il flusso corretto con il coordinator auth e caricare `AppRoot`.
* Aggiornato `app_messages.dart` con i messaggi mancanti necessari al blocco 002.
* Aggiornato il blocco 002 dopo test manuali con NVDA per migliorare gli annunci accessibili dei feedback principali.
* Aggiornato il comportamento dei feedback di validazione locale nella pagina login.
* Aggiornato il comportamento dei feedback di successo e transizione nel coordinator auth/session.

### Verificato

* Verificato `flutter analyze` con esito positivo.
* Verificato `flutter test` con tutti i test superati.
* Verificato login reale con utenti Supabase di test.
* Verificato logout reale.
* Verificato recupero sessione e ritorno alla schermata login dopo logout.
* Verificati messaggi di errore per credenziali errate.
* Verificati messaggi di validazione per campi vuoti.
* Verificati annunci NVDA dei feedback principali.
* Verificato merge del blocco 002 in `main`.
* Verificati `flutter analyze` e `flutter test` puliti anche dopo il merge in `main`.

### Note

* Il blocco 002 implementa login, logout, sessione, lettura profilo, lettura azienda e scelta tra login, placeholder onboarding e placeholder home.
* Il blocco 002 non implementa registrazione nuovo utente.
* Il blocco 002 non implementa onboarding reale.
* Il blocco 002 non implementa home reale.
* Il blocco 002 non implementa categorie, fornitori, prodotti, movimenti o storico.

---

## [0.4.0] - 2026-07-06

### Aggiunto

* Aggiunta documentazione approvata del blocco Flutter 002 dedicato a login, logout e sessione.
* Aggiunto design auth/session Flutter approvato in `docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md`.
* Aggiunto coding plan auth/session Flutter approvato in `docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md`.
* Aggiunto TODO auth/session Flutter approvato in `docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md`.
* Definito il perimetro operativo del blocco 002:

  * controllo sessione Supabase all'avvio;
  * login con email e password;
  * logout;
  * recupero sessione persistente;
  * ascolto centrale degli eventi auth Supabase;
  * lettura profilo applicativo;
  * lettura azienda collegata al profilo;
  * gestione utente senza profilo;
  * gestione utente con profilo e azienda;
  * placeholder onboarding;
  * placeholder home;
  * feedback persistente;
  * accessibilità minima;
  * test automatici obbligatori;
  * test manuali con Supabase reale.
* Definiti i file di produzione previsti per il blocco auth/session:

  * `app/lib/features/auth/domain/auth_profile_check_result.dart`;
  * `app/lib/features/auth/data/auth_service.dart`;
  * `app/lib/features/auth/data/profile_service.dart`;
  * `app/lib/features/auth/application/auth_session_coordinator.dart`;
  * `app/lib/features/auth/presentation/session_gate.dart`;
  * `app/lib/features/auth/presentation/login_page.dart`;
  * `app/lib/features/auth/presentation/auth_placeholder_page.dart`;
  * `app/lib/core/feedback/app_feedback_view.dart`.
* Definito il file eventuale `app/lib/app/app_root.dart`, da creare solo se utile per mantenere pulito `main.dart`.
* Definiti i file di test automatici obbligatori previsti per il blocco auth/session:

  * `app/test/features/auth/domain/auth_profile_check_result_test.dart`;
  * `app/test/features/auth/data/profile_service_test.dart`;
  * `app/test/features/auth/application/auth_session_coordinator_test.dart`;
  * `app/test/features/auth/presentation/session_gate_test.dart`;
  * `app/test/features/auth/presentation/login_page_test.dart`;
  * `app/test/features/auth/presentation/auth_placeholder_page_test.dart`;
  * `app/test/core/feedback/app_feedback_view_test.dart`.
* Definita la regola secondo cui il blocco auth/session deve avere un solo punto centrale di gestione della sessione applicativa.
* Definita la regola secondo cui il listener Supabase Auth deve essere unico e deve stare nel coordinator.
* Definita la gestione degli eventi auth principali:

  * `initialSession`;
  * `signedIn`;
  * `signedOut`;
  * `tokenRefreshed`.
* Definita la regola per cui gli eventi auth non previsti devono essere gestiti come no-op esplicito.
* Definita la regola per cui `tokenRefreshed` deve confrontare l'utente tramite `user.id` e non tramite uguaglianza dell'istanza `User`.
* Definita la distinzione obbligatoria tra:

  * profilo assente;
  * profilo incompleto;
  * profilo completo;
  * errore tecnico di lettura profilo;
  * errore tecnico di lettura azienda.
* Definita la regola per cui un profilo con `azienda_id` presente ma azienda non trovata o non leggibile deve essere trattato come errore tecnico.
* Definita la regola per cui una query Supabase bloccata silenziosamente dalle RLS e conclusa con `null` tramite `maybeSingle()` non deve essere interpretata automaticamente come profilo incompleto.
* Definita la regola per cui `azienda_id` presente ma azienda `null` deve generare errore tecnico manuale.
* Definita la regola per cui `companyName` vuoto o mancante non consente lo stato `complete`.
* Definita la protezione contro doppi login, doppi logout, doppi retry e race condition tra `currentUser` e `initialSession`.
* Definita la regola per cui il blocco 002 deve usare i file core già completati senza riscriverli.
* Definita la regola per cui `LoginPage`, `AuthPlaceholderPage` e `SessionGate` devono ricevere azioni tramite callback esplicite.
* Definita la gestione minima degli errori dello stream auth: feedback persistente e stato sicuro, senza retry automatici complessi nel blocco 002.

### Modificato

* Aggiornato il todo master Flutter in `docs/4-flutter/3-todos/000-todo-master.md`.
* Aggiornato il todo master per segnare il blocco 001 Core Dart minimo come completato.
* Aggiornato il todo master per registrare che il blocco 001 Core Dart minimo è stato codificato, testato, committato, pushato e mergiato in `main`.
* Aggiornato il todo master per registrare che, dopo il merge del blocco 001, `flutter analyze` e `flutter test` risultano superati su `main`.
* Aggiornato il todo master per aggiungere i documenti approvati del blocco 002 Auth/Session.
* Aggiornato il todo master per segnare la macro-fase “Login, logout e sessione” come `[~] In corso`.
* Aggiornato il todo master per indicare che la documentazione del blocco 002 è completata, mentre la codifica è ancora da fare.
* Aggiornato il prossimo passo operativo del todo master: preparare il prompt operativo rigido per Antigravity sul blocco 002 Auth/Session.
* Rafforzata la regola di lavoro Flutter per il blocco 002: design, coding plan, TODO, codice, test automatici, test manuali, changelog, commit e push.
* Rafforzata la regola di accessibilità permanente per il blocco auth/session.
* Rafforzata la regola backend fonte della verità: il blocco auth/session non deve chiamare `crea_azienda_e_profilo`, non deve creare profilo, non deve creare azienda e non deve anticipare onboarding reale.
* Aggiornata la lista dei commit esemplificativi nel todo master con i blocchi auth/session.

### Note

* La preparazione documentale del blocco 002 Auth/Session è completata.
* Il blocco 002 non implementa ancora codice.
* Il blocco 002 non implementa onboarding reale.
* Il blocco 002 non implementa home reale.
* Il blocco 002 non implementa categorie, fornitori, prodotti, movimenti o storico.
* Il blocco 002 prepara la porta d'ingresso dell'app:

  * controllo sessione;
  * login;
  * logout;
  * lettura profilo;
  * lettura azienda;
  * decisione login / placeholder onboarding / placeholder home.
* Il prossimo passo tecnico sarà preparare il prompt operativo rigido per Antigravity.
* La codifica dovrà seguire i documenti approvati:

  * `docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md`;
  * `docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md`;
  * `docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md`.
* Il blocco auth/session non potrà essere considerato completato senza `flutter analyze` e `flutter test` entrambi con esito positivo.
* Prima del commit finale della codifica auth/session dovrà essere aggiornato nuovamente questo changelog con il risultato effettivo dell'implementazione.

---

## [0.3.0] - 2026-07-05

### Aggiunto

* Aggiunto core Dart minimo con messaggi centralizzati, errori applicativi, mapper errori Supabase, feedback, accessibilità e sessione iniziale.
* Aggiunti test automatici obbligatori per mapper errori, feedback controller, session controller e accessibility service.

### Modificato

* Aggiornata inizializzazione Supabase usando `publishableKey` al posto di `anonKey`.
* Puliti avvisi di analisi relativi a interpolazioni stringa non necessarie nel servizio provvisorio di test backend.

### Note

* Il blocco core non introduce schermate complete.
* Il blocco core non implementa login, onboarding, prodotti o movimenti.
* Il blocco core è completabile solo con `flutter analyze` e `flutter test` entrambi con esito positivo.

---

## [0.2.0] - 2026-07-05

### Aggiunto

* Aggiunto README principale del repository.
* Aggiunto README della cartella `docs/`.
* Aggiunto todo master Flutter in `docs/4-flutter/3-todos/000-todo-master.md`.
* Aggiunto design core Flutter approvato in `docs/4-flutter/1-design/001-DESIGN_CORE_mvp1_v1.0.0.md`.
* Aggiunto coding plan core Flutter approvato in `docs/4-flutter/2-coding-plans/001-CODING_PLAN_CORE_mvp1_v1.0.0.md`.
* Aggiunto TODO core Flutter approvato in `docs/4-flutter/3-todos/001-TODO_CORE_mvp1_v1.0.0.md`.
* Definiti gli otto file di produzione previsti per il core Dart minimo:

  * `lib/core/messages/app_messages.dart`;
  * `lib/core/errors/app_exception.dart`;
  * `lib/core/errors/supabase_error_mapper.dart`;
  * `lib/core/feedback/app_feedback_message.dart`;
  * `lib/core/feedback/app_feedback_controller.dart`;
  * `lib/core/accessibility/accessibility_service.dart`;
  * `lib/core/session/app_session_state.dart`;
  * `lib/core/session/app_session_controller.dart`.
* Definiti i quattro file di test automatici obbligatori previsti per il core Dart minimo:

  * `test/core/errors/supabase_error_mapper_test.dart`;
  * `test/core/feedback/app_feedback_controller_test.dart`;
  * `test/core/session/app_session_controller_test.dart`;
  * `test/core/accessibility/accessibility_service_test.dart`.
* Definita la regola secondo cui il blocco core non può essere considerato completato senza `flutter analyze` e `flutter test` entrambi con esito positivo.
* Definita la strategia dei test automatici minimi obbligatori per evitare debito di test nelle fasi successive.
* Definita la regola per cui il core Dart minimo non deve anticipare schermate complete, login reale, onboarding reale o servizi Supabase verticali.

### Modificato

* Aggiornato il todo master Flutter per segnare come completata la preparazione operativa del blocco 001 Core Flutter.
* Aggiornato il todo master Flutter per segnare il blocco Core Dart minimo come fase in corso.
* Aggiornata la regola generale di lavoro Flutter: design, coding plan, todo specifico, codice, test automatici, test manuali quando previsti, correzioni, changelog, commit e push.
* Rafforzata la regola di accessibilità permanente: l'accessibilità deve essere integrata fin dall'inizio e non rimandata alla fine.
* Rafforzata la regola backend fonte della verità: Flutter non modifica direttamente la scorta, non inserisce movimenti direttamente e non bypassa le RLS.
* Pulita e aggiornata la documentazione di orientamento prima della codifica del core.

### Note

* La preparazione documentale del blocco 001 Core Flutter è completata.
* Il prossimo passo tecnico sarà la codifica del core Dart minimo.
* La codifica dovrà seguire i documenti approvati:

  * `docs/4-flutter/1-design/001-DESIGN_CORE_mvp1_v1.0.0.md`;
  * `docs/4-flutter/2-coding-plans/001-CODING_PLAN_CORE_mvp1_v1.0.0.md`;
  * `docs/4-flutter/3-todos/001-TODO_CORE_mvp1_v1.0.0.md`.
* Il blocco core dovrà creare otto file di produzione e quattro file di test automatici obbligatori.
* Il blocco core non dovrà creare schermate complete.

---

## [0.1.0] - 2026-07-04

### Aggiunto

* Creato repository GitHub del progetto.
* Spostate le cartelle ufficiali `app/` e `docs/` dentro la root del repository.
* Aggiunta documentazione progettuale MVP 1.0.
* Salvato documento Flutter Plan approvato in `docs/4-flutter/001-FLUTTER_PLAN_mvp1_v1.0.0.md`.
* Definita strategia Flutter: prima core Dart minimo, poi schermate.
* Confermate regole fondamentali:

  * nessuna stringa utente hardcoded sparsa;
  * sistema centralizzato messaggi;
  * sistema centralizzato errori;
  * feedback persistente;
  * accessibilità non rimandata;
  * backend Supabase come fonte della verità;
  * movimenti sempre tramite RPC;
  * nessuna modifica diretta della scorta.

### Modificato

* Riorganizzata la struttura locale del progetto per allinearla al repository GitHub.

### Note

* La cartella personale `lavoro-consiglio-ai/` non fa parte del repository.
* Il primo commit è stato eseguito dopo lo spostamento di `app/` e `docs/`.
* Il prossimo passo tecnico sarà la creazione del core Dart minimo.
