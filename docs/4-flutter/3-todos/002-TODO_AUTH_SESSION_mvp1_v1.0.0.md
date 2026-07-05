# TODO AUTH SESSION MVP 1.0

## Gestionale Magazzino Universale

Versione: 1.0.0
Stato: APPROVATO
Data: 6 luglio 2026
-------------------

# 1. Scopo del documento

Questo documento definisce il TODO operativo del blocco:

```text id="i5er53"
Login, logout e sessione
```

Il TODO traduce in attività concrete il coding plan approvato:

```text id="3l17aj"
docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
```

Questo documento serve a guidare l'implementazione pratica del blocco Flutter 002.
Il TODO deve essere usato durante la codifica per spuntare una attività alla volta.
Il documento è in stato:

```text id="a7mq5u"
APPROVATO
```

## e può essere usato come base per preparare il prompt operativo destinato ad Antigravity.

# 2. Nome del file

Il file deve essere salvato come:

```text id="240aud"
docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md
```

---

# 3. Obiettivo del blocco

L'obiettivo del blocco 002 è implementare la prima gestione reale di autenticazione e sessione dell'app Flutter.
Il blocco deve permettere di:

* controllare la sessione Supabase all'avvio;
* mostrare login se non c'è utente autenticato;
* eseguire login con email e password;
* eseguire logout;
* ascoltare i cambi sessione Supabase in un solo punto centrale;
* recuperare correttamente la sessione persistente;
* leggere il profilo applicativo dell'utente autenticato;
* leggere l'azienda collegata al profilo;
* distinguere profilo assente da errore lettura profilo;
* distinguere profilo incompleto da errore tecnico;
* mostrare placeholder onboarding se l'utente non ha profilo completo;
* mostrare placeholder home se l'utente ha profilo e azienda;
* mostrare feedback persistente;
* mantenere accessibilità minima;
* aggiungere test automatici;
* preparare test manuali con Supabase reale.

---

# 4. Cosa NON deve fare questo blocco

Il blocco 002 non deve:

* implementare registrazione nuovo utente;
* implementare recupero password;
* implementare onboarding reale;
* chiamare la RPC `crea_azienda_e_profilo`;
* creare azienda;
* creare profilo;
* implementare home reale;
* creare dashboard;
* creare menu gestionale definitivo;
* creare categorie;
* creare fornitori;
* creare prodotti;
* creare movimenti;
* creare storico movimenti;
* modificare SQL;
* modificare RLS;
* modificare RPC;
* usare service role key;
* bypassare le RLS;
* modificare direttamente `prodotti.scorta_attuale`;
* inserire direttamente in `movimenti_magazzino`;
* introdurre BLoC;
* introdurre Riverpod;
* introdurre GetIt;
* introdurre service locator;
* introdurre routing complesso;
* introdurre dipendenze nuove non necessarie.
  Regola sintetica:

```text id="t5e8un"
questo blocco apre la porta dell'app,
ma non costruisce ancora il gestionale.
```

---

# 5. Documenti di riferimento

Prima di iniziare il blocco, considerare questi documenti:

```text id="vdvps0"
docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/1-design/001-DESIGN_CORE_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/001-CODING_PLAN_CORE_mvp1_v1.0.0.md
docs/4-flutter/3-todos/001-TODO_CORE_mvp1_v1.0.0.md
docs/4-flutter/001-FLUTTER_PLAN_mvp1_v1.0.0.md
docs/3-backend/002-API_CONTRACTS_mvp1_v1.0.0.md
docs/3-backend/001-BACKEND_RULES_mvp1_v1.0.0.md
docs/1-database/001-DATABASE_SCHEMA_mvp1_v1.0.0.md
docs/1-database/supabase/003_rls.sql
docs/4-flutter/3-todos/000-todo-master.md
```

In caso di dubbio, prevalgono:

1. coding plan auth/session approvato;
2. design auth/session approvato;
3. API Contracts;
4. Backend Rules;
5. Flutter Plan;
6. Design Core;
7. TODO Core;
8. questo TODO operativo.

---

# 6. Stato iniziale previsto

Il blocco 001 core è già completato.
Devono essere già presenti:

```text id="g8vy96"
app/lib/core/messages/app_messages.dart
app/lib/core/errors/app_exception.dart
app/lib/core/errors/supabase_error_mapper.dart
app/lib/core/feedback/app_feedback_message.dart
app/lib/core/feedback/app_feedback_controller.dart
app/lib/core/accessibility/accessibility_service.dart
app/lib/core/session/app_session_state.dart
app/lib/core/session/app_session_controller.dart
```

Devono essere già presenti i test core:

```text id="f03xah"
app/test/core/errors/supabase_error_mapper_test.dart
app/test/core/feedback/app_feedback_controller_test.dart
app/test/core/session/app_session_controller_test.dart
app/test/core/accessibility/accessibility_service_test.dart
```

Il progetto deve partire da:

```text id="7jsifj"
flutter analyze
No issues found!
```

```text id="nv78am"
flutter test
All tests passed!
```

## Il blocco 002 deve costruire sopra questa base senza riscriverla.

# 7. Regole generali del blocco

## 7.1 Regola principale

```text id="785vdb"
un solo punto centrale decide lo stato auth/sessione
```

## 7.2 Test obbligatori

```text id="euxjmj"
senza test automatici minimi superati,
il blocco auth/session non è completato
```

## 7.3 Nessuna logica auth sparsa

Non devono esistere chiamate Supabase Auth sparse in:

* login page;
* session gate;
* placeholder onboarding;
* placeholder home;
* main.dart.

## 7.4 Nessun listener duplicato

Il listener a `onAuthStateChange` deve essere uno solo.
Deve stare nel coordinator.

## 7.5 Nessuna UI definitiva oltre login

Il login deve essere una schermata reale minima.
Onboarding e home devono restare placeholder.

## 7.6 Feedback persistente obbligatorio

Gli errori non devono essere comunicati solo tramite snackbar o messaggi temporanei.

## 7.7 Accessibilità non rimandata

Campi, pulsanti, caricamenti e messaggi devono essere leggibili anche da screen reader.

## 7.8 Protezione del core già completato

Il blocco 002 deve importare e usare i file core già completati, ma non deve riscriverli per adattarli al nuovo blocco.
File core da proteggere:

```text id="x3w0sy"
app/lib/core/errors/app_exception.dart
app/lib/core/errors/supabase_error_mapper.dart
app/lib/core/feedback/app_feedback_message.dart
app/lib/core/feedback/app_feedback_controller.dart
app/lib/core/accessibility/accessibility_service.dart
app/lib/core/session/app_session_state.dart
app/lib/core/session/app_session_controller.dart
```

Eccezioni ammesse:

* `app/lib/core/messages/app_messages.dart` può essere modificato solo per aggiungere messaggi mancanti;
* `app/lib/core/feedback/app_feedback_view.dart` può essere creato perché è un nuovo widget previsto da questo blocco.
  Regola:

```text id="no3j16"
usare il core, non riscriverlo
```

---

# 8. Checklist generale iniziale

## 8.1 Preparazione repository

* [ ] Aprire il repository corretto in VS Code.
* [ ] Verificare di essere nel progetto `Gestionale-magazzino`.
* [ ] Verificare che il coding plan 002 approvato sia salvato.
* [ ] Verificare che il TODO master sia aggiornato.
* [ ] Verificare che il blocco 001 sia completato.
* [ ] Verificare il riferimento a:

```text id="8u390r"
docs/1-database/supabase/003_rls.sql
```

* [ ] Ricordare che `profili_select_own` consente la lettura del proprio profilo.
* [ ] Ricordare che `aziende_select_membri` consente la lettura delle aziende collegate tramite profilo.
* [ ] Ricordare che una query bloccata da RLS può anche restituire zero righe invece di lanciare eccezione.
* [ ] Aprire il terminale nella cartella:

```text id="qdowj9"
app/
```

* [ ] Eseguire:

```text id="2andkx"
flutter analyze
```

* [ ] Eseguire:

```text id="906b9d"
flutter test
```

* [ ] Annotare eventuali errori preesistenti.
* [ ] Non iniziare il blocco se ci sono errori non compresi.

## 8.2 Preparazione branch

* [ ] Creare un nuovo branch per il blocco 002.
  Nome branch consigliato:

```text id="ewwxdd"
feature/auth-session
```

oppure:

```text id="3bii3g"
feature/blocco-002-auth-session
```

* [ ] Verificare il branch attivo.
* [ ] Non lavorare direttamente su `main`.

---

# 9. Cartelle da creare

Creare le seguenti cartelle:

```text id="grmnkn"
app/lib/features/auth/
app/lib/features/auth/application/
app/lib/features/auth/data/
app/lib/features/auth/domain/
app/lib/features/auth/presentation/
```

Creare le cartelle test:

```text id="b0cf3i"
app/test/features/auth/application/
app/test/features/auth/data/
app/test/features/auth/domain/
app/test/features/auth/presentation/
```

Verifica:

* [ ] Creata `app/lib/features/auth/`.
* [ ] Creata `app/lib/features/auth/application/`.
* [ ] Creata `app/lib/features/auth/data/`.
* [ ] Creata `app/lib/features/auth/domain/`.
* [ ] Creata `app/lib/features/auth/presentation/`.
* [ ] Creata `app/test/features/auth/application/`.
* [ ] Creata `app/test/features/auth/data/`.
* [ ] Creata `app/test/features/auth/domain/`.
* [ ] Creata `app/test/features/auth/presentation/`.
* [ ] Nessuna cartella vuota inutile creata.

---

# 10. File di produzione da creare

Creare questi file:

```text id="y9sd3o"
app/lib/features/auth/domain/auth_profile_check_result.dart
app/lib/features/auth/data/auth_service.dart
app/lib/features/auth/data/profile_service.dart
app/lib/features/auth/application/auth_session_coordinator.dart
app/lib/features/auth/presentation/session_gate.dart
app/lib/features/auth/presentation/login_page.dart
app/lib/features/auth/presentation/auth_placeholder_page.dart
app/lib/core/feedback/app_feedback_view.dart
```

File eventuale:

```text id="oasljy"
app/lib/app/app_root.dart
```

Checklist:

* [ ] Creare `auth_profile_check_result.dart`.
* [ ] Creare `auth_service.dart`.
* [ ] Creare `profile_service.dart`.
* [ ] Creare `auth_session_coordinator.dart`.
* [ ] Creare `session_gate.dart`.
* [ ] Creare `login_page.dart`.
* [ ] Creare `auth_placeholder_page.dart`.
* [ ] Creare `app_feedback_view.dart`.
* [ ] Valutare se creare `app_root.dart`.
* [ ] Non creare altri file senza motivazione.

---

# 11. File esistenti da modificare

Modificare:

```text id="guksb9"
app/lib/main.dart
app/lib/core/messages/app_messages.dart
```

Modificare eventualmente:

```text id="v97hse"
CHANGELOG.md
```

Non modificare salvo reale necessità:

```text id="pc9ng7"
app/lib/core/session/app_session_state.dart
app/lib/core/session/app_session_controller.dart
```

Checklist:

* [ ] Modificare `app_messages.dart` solo per aggiungere messaggi mancanti.
* [ ] Modificare `main.dart` per collegare il nuovo flusso.
* [ ] Non modificare `AppSessionStatus` se non indispensabile.
* [ ] Non introdurre nuovi stati sessione.
* [ ] Non rompere i test core esistenti.
* [ ] Non modificare `SupabaseErrorMapper` salvo errore già esistente e documentato.
* [ ] Non modificare `AppSessionController` salvo reale necessità compatibile con i test esistenti.
* [ ] Aggiornare `CHANGELOG.md` solo dopo implementazione e test.

---

# 12. File provvisori da gestire

Potrebbero esistere:

```text id="0p01ve"
app/lib/services/test_backend_service.dart
app/lib/pages/test_console_page.dart
```

Checklist:

* [ ] Verificare se esistono file provvisori di test backend.
* [ ] Non eliminarli se non serve.
* [ ] Scollegarli dal flusso principale se `main.dart` passa a `SessionGate`.
* [ ] Eliminarli solo se causano conflitti, errori o confusione.
* [ ] Se eliminati, rimuovere import e riferimenti.
* [ ] Verificare che `flutter analyze` non segnali problemi.

---

# 13. Aggiornamento AppMessages

Percorso:

```text id="9efpr1"
app/lib/core/messages/app_messages.dart
```

## 13.1 Obiettivo

Aggiungere i messaggi mancanti necessari al blocco 002.

## 13.2 Checklist

* [ ] Aprire `app_messages.dart`.
* [ ] Verificare i messaggi già presenti.
* [ ] Non duplicare messaggi esistenti.
* [ ] Aggiungere solo messaggi mancanti.
* [ ] Mantenere stringhe Dart pure.
* [ ] Non importare UI.
* [ ] Non usare `BuildContext`.
* [ ] Non creare file paralleli di messaggi.
* [ ] Non scrivere messaggi importanti direttamente nei widget.

## 13.3 Messaggi da verificare o aggiungere

```text id="64iezr"
Controllo sessione in corso.
Caricamento in corso.
Accedi
Esci
Email
Password
Login
Accesso eseguito correttamente.
Uscita eseguita correttamente.
Email obbligatoria.
Password obbligatoria.
Email o password non corrette.
Sessione scaduta. Accedi di nuovo.
Sessione non valida. Accedi di nuovo.
Connessione assente. Controlla Internet e riprova.
Operazione non autorizzata.
Si è verificato un errore. Riprova.
Profilo non ancora creato.
Il flusso onboarding sarà implementato nel blocco successivo.
Accesso completato.
La home sarà implementata nel blocco 004.
Riprova
Riprova controllo sessione
Riprova caricamento profilo
```

## 13.4 Verifica

* [ ] I messaggi sono chiari se letti da screen reader.
* [ ] I messaggi non sono troppo tecnici.
* [ ] I messaggi di retry sono abbastanza comprensibili.
* [ ] Nessuna stringa utente importante è stata lasciata hardcoded nei nuovi file.

---

# 14. Implementazione AuthProfileCheckResult

Percorso:

```text id="pea0sr"
app/lib/features/auth/domain/auth_profile_check_result.dart
```

## 14.1 Obiettivo

Rappresentare il risultato della verifica profilo/azienda.

## 14.2 Checklist implementazione

* [ ] Creare enum `AuthProfileCheckStatus`.
* [ ] Prevedere valore `missing`.
* [ ] Prevedere valore `incomplete`.
* [ ] Prevedere valore `complete`.
* [ ] Creare classe `AuthProfileCheckResult`.
* [ ] Prevedere campo `status`.
* [ ] Prevedere campo `profileId`, se necessario.
* [ ] Prevedere campo `companyId`, se necessario.
* [ ] Prevedere campo `companyName`, se necessario.
* [ ] Creare costruttori o factory chiare.
* [ ] Non dipendere da Flutter UI.
* [ ] Non dipendere da Supabase reale.
* [ ] Non rappresentare errori tecnici come stato normale.

## 14.3 Regole logiche

Implementare o documentare chiaramente:

```text id="p3ws70"
profilo assente → missing
profilo presente senza azienda_id → incomplete
profilo presente con azienda_id e azienda leggibile → complete
profilo presente con azienda_id ma azienda non trovata/non leggibile → errore tecnico
errore query/rete/RLS → errore tecnico
```

Regole aggiuntive:

```text id="7d1tmp"
azienda_id assente/null → incomplete
azienda_id presente ma vuoto, malformato o non utilizzabile → errore tecnico
complete richiede companyId valido e companyName non vuoto
companyName mancante o vuoto → errore tecnico
```

## 14.4 Test obbligatorio

Creare:

```text id="lqb4bo"
app/test/features/auth/domain/auth_profile_check_result_test.dart
```

Casi:

* [ ] `missing` non contiene azienda.
* [ ] `incomplete` rappresenta profilo senza azienda valida.
* [ ] `complete` contiene profilo e azienda.
* [ ] `complete` richiede `companyId` valido.
* [ ] `complete` richiede `companyName` non vuoto.
* [ ] `missing` e `incomplete` non sono confusi.
* [ ] Errori tecnici non sono modellati come risultato normale.

---

# 15. Implementazione AuthService

Percorso:

```text id="545d6x"
app/lib/features/auth/data/auth_service.dart
```

## 15.1 Obiettivo

Incapsulare Supabase Auth e impedire chiamate Auth sparse nella UI.

## 15.2 Checklist struttura

* [ ] Creare contratto `AuthService` o classe astratta equivalente.
* [ ] Creare implementazione `SupabaseAuthService` o equivalente.
* [ ] Prevedere accesso a `currentUser`.
* [ ] Prevedere stream `authStateChanges`.
* [ ] Prevedere `signInWithPassword`.
* [ ] Prevedere `signOut`.
* [ ] Permettere fake manuali nei test.

## 15.3 Metodi minimi

Contratto logico:

```text id="wu48kn"
User? get currentUser
Stream<AuthState> get authStateChanges
Future<User> signInWithPassword({
  required String email,
  required String password,
})
Future<void> signOut()
```

Il nome preciso dei tipi deve rispettare il pacchetto Supabase realmente installato.

## 15.4 Regola signInWithPassword

```text id="0nsrli"
successo → restituisce User
fallimento → propaga eccezione tecnica
```

Checklist:

* [ ] Non usare `null` per rappresentare credenziali errate.
* [ ] Non tradurre errori in messaggi utente dentro `AuthService`.
* [ ] Non mostrare feedback dentro `AuthService`.
* [ ] Non salvare password.
* [ ] Non usare service role key.
* [ ] Se Supabase restituisce response, estrarre solo l'utente necessario.
* [ ] Se il login sembra riuscito ma non c'è utente valido, trattare come errore tecnico/sessione non valida.

---

# 16. Implementazione ProfileService

Percorso:

```text id="7tiu03"
app/lib/features/auth/data/profile_service.dart
```

## 16.1 Obiettivo

Leggere profilo applicativo e azienda corrente senza spargere query nella UI.

## 16.2 Checklist struttura

* [ ] Creare contratto `ProfileService` o classe astratta equivalente.
* [ ] Creare implementazione `SupabaseProfileService` o equivalente.
* [ ] Prevedere metodo `checkProfileForUser`.
* [ ] Usare Supabase client solo nell'implementazione concreta.
* [ ] Rendere possibile fake manuale nei test.

## 16.3 Metodo minimo

```text id="8iphnj"
Future<AuthProfileCheckResult> checkProfileForUser(User user)
```

## 16.4 Query profilo

* [ ] Leggere tabella `profili`.
* [ ] Filtrare per `user_id` dell'utente autenticato.
* [ ] Usare `maybeSingle()` o equivalente per gestire profilo assente.
* [ ] Se la query riesce e non trova profilo, restituire `missing`.
* [ ] Se la query fallisce, propagare errore tecnico.

## 16.5 Query azienda

* [ ] Se profilo esiste ma non contiene azienda valida, restituire `incomplete`.
* [ ] Se profilo contiene `azienda_id`, leggere tabella `aziende`.
* [ ] Se azienda è trovata e leggibile, restituire `complete`.
* [ ] Se `azienda_id` è presente ma azienda non è trovata, propagare errore tecnico.
* [ ] Se `azienda_id` è presente ma azienda non è leggibile per RLS, propagare errore tecnico.
* [ ] Se query azienda fallisce, propagare errore tecnico.
* [ ] Se `azienda_id` è presente ma la query su `aziende` con `maybeSingle()` restituisce `null`, lanciare manualmente un errore tecnico.
  Attenzione:

```text id="f621uc"
Supabase non sempre lancia eccezione quando una SELECT è bloccata da RLS.
In alcuni casi la query può restituire zero righe.
```

Regola obbligatoria:

```text id="8h2c9v"
azienda_id presente + query aziende restituisce null → errore tecnico manuale
```

Non deve diventare:

```text id="o9hukd"
incomplete
```

## 16.6 Regole obbligatorie

```text id="p8kmxd"
query riuscita senza profilo → missing
query fallita → errore tecnico
profilo senza azienda_id → incomplete
profilo con azienda_id ma azienda non leggibile → errore tecnico
azienda_id presente ma azienda null → errore tecnico manuale
azienda_id vuoto/malformato → errore tecnico
companyName vuoto/mancante → errore tecnico
```

## 16.7 Cose vietate

* [ ] Non chiamare `crea_azienda_e_profilo`.
* [ ] Non creare azienda.
* [ ] Non creare profilo.
* [ ] Non modificare dati.
* [ ] Non usare service role key.
* [ ] Non trasformare eccezioni in `missing`.
* [ ] Non trasformare azienda non leggibile in `incomplete`.
* [ ] Non trasformare `azienda_id` presente ma azienda `null` in `incomplete`.

## 16.8 Test ProfileService

Creare:

```text id="n6cvmo"
app/test/features/auth/data/profile_service_test.dart
```

Casi:

* [ ] nessun profilo trovato → `missing`;
* [ ] profilo senza azienda_id → `incomplete`;
* [ ] profilo con azienda_id e azienda leggibile → `complete`;
* [ ] profilo con azienda_id ma azienda non trovata → errore tecnico;
* [ ] profilo con azienda_id ma azienda non leggibile → errore tecnico;
* [ ] profilo con azienda_id ma query azienda restituisce `null` → errore tecnico manuale;
* [ ] azienda_id vuoto/malformato nei fake → errore tecnico;
* [ ] azienda letta ma companyName vuoto/mancante → errore tecnico;
* [ ] errore query profilo → eccezione propagata;
* [ ] errore query azienda → eccezione propagata;
* [ ] errore rete/RLS simulato → non diventa `missing`.
  Nota:
  se testare il servizio concreto è troppo complesso, coprire i casi tramite fake nel test del coordinator, ma il comportamento deve essere esplicito.

---

# 17. Implementazione AuthSessionCoordinator

Percorso:

```text id="ss45wa"
app/lib/features/auth/application/auth_session_coordinator.dart
```

## 17.1 Obiettivo

Centralizzare tutta la logica auth/sessione/profilo/azienda.

## 17.2 Dipendenze previste

Il coordinator deve ricevere tramite costruttore:

* [ ] `AuthService`;
* [ ] `ProfileService`;
* [ ] `AppSessionController`;
* [ ] `AppFeedbackController`;
* [ ] eventuale `AccessibilityService`, se usato in questo blocco.
  Non deve creare da solo Supabase client.

## 17.3 Metodi principali

Creare:

```text id="6139nj"
initialize()
signIn(email, password)
signOut()
retryProfileCheck()
dispose()
```

## 17.4 initialize

Checklist:

* [ ] Impostare o mantenere stato `unknown`.
* [ ] Registrare un solo listener centrale auth.
* [ ] Gestire evento iniziale dello stream, se presente.
* [ ] Leggere sessione o utente corrente dopo `Supabase.initialize`.
* [ ] Se nessun utente → `unauthenticated`.
* [ ] Se utente presente → controllo profilo/azienda.
* [ ] Usare un unico metodo interno per risolvere sessione.
* [ ] Evitare doppia elaborazione tra currentUser e evento iniziale.
* [ ] Non creare listener multipli.
* [ ] Non creare listener in UI.
  Regola obbligatoria:

```text id="5cak1z"
currentUser e initialSession non devono risolvere due volte lo stesso user.id
```

Soluzioni ammesse:

* [ ] leggere `currentUser`, risolvere la sessione e poi registrare il listener ignorando l'eventuale `initialSession` duplicato;
* [ ] registrare il listener prima e usare metodo idempotente che ignora la risoluzione duplicata;
* [ ] usare operation token;
* [ ] usare flag di risoluzione;
* [ ] usare confronto con `lastResolvedUserId`.
  Il TODO non impone una singola tecnica.
  Impone il risultato:

```text id="nsmcxg"
nessuna doppia elaborazione della stessa sessione iniziale
```

## 17.5 Metodo interno di risoluzione sessione

Creare metodo privato con nome simile:

```text id="ylqqlc"
resolveSessionFromUser(user)
```

oppure:

```text id="zepxqf"
resolveCurrentSession()
```

Checklist:

* [ ] Gestisce utente null.
* [ ] Gestisce utente presente.
* [ ] Chiama `ProfileService`.
* [ ] Imposta `authenticatedWithoutProfile` se profilo assente.
* [ ] Imposta `authenticatedWithoutProfile` se profilo incompleto.
* [ ] Imposta `authenticatedWithProfile` se profilo e azienda sono completi.
* [ ] Non manda a onboarding in caso di errore tecnico.
* [ ] In caso di errore tecnico mantiene stato sicuro.
* [ ] Mostra feedback persistente.

## 17.6 Eventi auth da gestire

Gestire almeno, con i nomi reali del pacchetto Supabase:

```text id="773vyk"
initialSession
signedIn
signedOut
tokenRefreshed
```

Checklist:

* [ ] `signedOut` → `unauthenticated`.
* [ ] sessione nulla → `unauthenticated`.
* [ ] `signedIn` nuovo utente → controllo profilo/azienda.
* [ ] sessione iniziale con utente → controllo profilo/azienda.
* [ ] `tokenRefreshed` stesso utente già risolto → non rileggere profilo.
* [ ] errore stream → `SupabaseErrorMapper` + feedback persistente.
* [ ] listener con gestione `onError`.
  Regola per `tokenRefreshed`:

```text id="hs7ere"
il confronto deve essere fatto tramite user.id,
non tramite uguaglianza dell'istanza User
```

Regola pratica:

```text id="bdbssm"
se event.user.id == lastResolvedUserId
e lo stato applicativo è già coerente,
tokenRefreshed deve essere no-op
```

Regola per eventi auth non previsti:

```text id="bcqppk"
qualsiasi evento auth diverso da quelli gestiti esplicitamente
non deve modificare lo stato sessione corrente
```

Comportamento richiesto:

```text id="3k43u9"
evento auth non previsto → no-op esplicito
```

Gli eventi auth non previsti possono essere eventualmente loggati in debug, ma:

* [ ] non devono cambiare stato applicativo;
* [ ] non devono far ripartire controllo profilo;
* [ ] non devono generare feedback utente;
* [ ] non devono causare crash.

## 17.7 Protezione duplicati e race condition

Implementare una protezione semplice:

* [ ] flag di caricamento;
* [ ] oppure operation token;
* [ ] oppure confronto user id già risolto;
* [ ] oppure combinazione delle soluzioni.
  Regola:

```text id="wbhl1d"
una risposta vecchia non deve sovrascrivere uno stato più nuovo
```

Casi da proteggere:

* [ ] login riuscito + evento auth quasi simultaneo;
* [ ] initialize + evento initialSession;
* [ ] currentUser + initialSession dello stesso utente;
* [ ] token refresh;
* [ ] doppio retry;
* [ ] doppio logout.
  Regola specifica:

```text id="922l28"
la protezione da duplicati deve coprire esplicitamente
la sovrapposizione tra lettura manuale currentUser
e evento initialSession dello stream
```

## 17.8 signIn

Checklist:

* [ ] Validare email obbligatoria.
* [ ] Validare password obbligatoria.
* [ ] Usare messaggi da `AppMessages`.
* [ ] Evitare doppi invii.
* [ ] Durante un `signIn` in corso, una seconda chiamata deve essere ignorata prima di arrivare ad `AuthService`.
* [ ] Chiamare `AuthService.signInWithPassword`.
* [ ] Aspettarsi `User` in caso di successo.
* [ ] Aspettarsi eccezione in caso di errore.
* [ ] Mappare errori tramite `SupabaseErrorMapper`.
* [ ] Mostrare feedback persistente.
* [ ] Dopo successo, controllare profilo/azienda.
* [ ] Non andare direttamente alla home.
  Regola testabile:

```text id="2v3s0i"
doppio signIn ravvicinato → AuthService.signInWithPassword chiamato una sola volta
```

## 17.9 signOut

Checklist:

* [ ] Evitare doppi logout.
* [ ] Durante un `signOut` in corso, una seconda chiamata deve essere ignorata o resa no-op.
* [ ] Chiamare `AuthService.signOut`.
* [ ] Impostare `unauthenticated`.
* [ ] Pulire dati sessione in memoria se presenti.
* [ ] Mostrare feedback uscita riuscita.
* [ ] Gestire errori tramite mapper.
* [ ] Gestire in modo idempotente eventuale evento `signedOut` successivo.

## 17.10 retryProfileCheck

Checklist:

* [ ] Recuperare utente corrente.
* [ ] Se nessun utente → `unauthenticated`.
* [ ] Se utente presente → ripetere controllo profilo/azienda.
* [ ] Evitare doppi retry ravvicinati.
* [ ] Durante un retry in corso, una seconda chiamata deve essere ignorata o resa no-op.
* [ ] Mantenere stato sicuro in caso di errore.
* [ ] Mostrare feedback persistente in caso di errore.
* [ ] Non chiamare onboarding.

## 17.11 Stato unknown

Implementare la logica coerente:

```text id="gsgh6j"
unknown senza feedback errore → controllo in corso
unknown con feedback errore → errore recuperabile, mostra Riprova
```

Checklist:

* [ ] Non aggiungere nuovo stato `sessionError`.
* [ ] Non modificare `AppSessionStatus`.
* [ ] Non mandare a login durante controllo iniziale.
* [ ] Non mandare a onboarding durante errore tecnico.

## 17.12 Errore dello stream auth

In caso di errore dello stream auth:

* [ ] usare `SupabaseErrorMapper`;
* [ ] mostrare feedback persistente;
* [ ] mantenere stato sicuro;
* [ ] non implementare retry automatici complessi dello stream in questo blocco;
* [ ] non creare più listener per tentare recuperi automatici.
  Regola MVP 1:

```text id="8yfa80"
errore stream auth → feedback persistente + stato sicuro
```

## Non introdurre meccanismi complessi di risottoscrizione automatica.

# 18. Test AuthSessionCoordinator

Creare:

```text id="36ostd"
app/test/features/auth/application/auth_session_coordinator_test.dart
```

Usare fake manuali.
Non usare Supabase reale.

## 18.1 Test initialize

* [ ] `initialize` senza utente → `unauthenticated`.
* [ ] `initialize` con utente e profilo assente → `authenticatedWithoutProfile`.
* [ ] `initialize` con utente, profilo e azienda → `authenticatedWithProfile`.
* [ ] `initialize` con profilo presente ma senza azienda_id → `authenticatedWithoutProfile`.
* [ ] `initialize` con profilo presente, azienda_id valorizzato ma azienda non leggibile → feedback errore e nessun onboarding.
* [ ] `initialize` con currentUser e initialSession dello stesso `user.id` → una sola risoluzione profilo effettiva.

## 18.2 Test login

* [ ] login con email vuota → feedback `Email obbligatoria.`;
* [ ] login con password vuota → feedback `Password obbligatoria.`;
* [ ] login fallito → feedback errore mappato;
* [ ] login riuscito con profilo assente → `authenticatedWithoutProfile`;
* [ ] login riuscito con profilo completo → `authenticatedWithProfile`;
* [ ] doppio `signIn` ravvicinato → `AuthService.signInWithPassword` chiamato una sola volta;
* [ ] login riuscito ma senza User valido → feedback errore/sessione non valida.

## 18.3 Test logout

* [ ] logout riuscito → `unauthenticated`;
* [ ] doppio logout ravvicinato → stato finale coerente;
* [ ] doppio logout ravvicinato → seconda chiamata ignorata o resa no-op;
* [ ] errore logout → feedback errore mappato.

## 18.4 Test stream auth

* [ ] evento auth logout/sessione nulla → `unauthenticated`;
* [ ] evento `signedIn` con nuovo utente → controllo profilo;
* [ ] evento iniziale + controllo manuale non creano stati incoerenti;
* [ ] `tokenRefreshed` stesso `user.id` già risolto → non rilegge profilo inutilmente;
* [ ] evento auth non previsto → no-op esplicito;
* [ ] errore stream auth → feedback errore mappato;
* [ ] errore stream auth non crea listener multipli o retry automatici complessi.

## 18.5 Test retry

* [ ] `retryProfileCheck` senza utente corrente → `unauthenticated`;
* [ ] `retryProfileCheck` con utente e profilo completo → `authenticatedWithProfile`;
* [ ] `retryProfileCheck` con utente e profilo assente → `authenticatedWithoutProfile`;
* [ ] `retryProfileCheck` con errore profilo → resta in stato sicuro e mostra feedback;
* [ ] doppio `retryProfileCheck` ravvicinato → non produce query concorrenti inutili o stati incoerenti.

## 18.6 Test dispose

* [ ] `dispose` chiude stream/listener se previsto.
* [ ] Dopo `dispose`, eventi successivi non devono aggiornare stato se questo è gestito dalla struttura scelta.

---

# 19. Implementazione AppFeedbackView

Percorso:

```text id="6zbum8"
app/lib/core/feedback/app_feedback_view.dart
```

## 19.1 Obiettivo

Mostrare in UI il feedback persistente gestito da `AppFeedbackController`.

## 19.2 Checklist

* [ ] Creare widget `AppFeedbackView`.
* [ ] Ricevere `AppFeedbackController`.
* [ ] Osservare il controller.
* [ ] Se non c'è messaggio, non mostrare nulla o mostrare spazio neutro.
* [ ] Se c'è messaggio, mostrare testo persistente.
* [ ] Distinguere errore/successo/avviso/info senza usare solo colore.
* [ ] Rendere il testo disponibile per screen reader.
* [ ] Valutare `Semantics(liveRegion: true)` se opportuno.
* [ ] Non usare Supabase.
* [ ] Non contenere logica business.
* [ ] Non decidere stato sessione.

## 19.3 Test AppFeedbackView

Creare:

```text id="8crzk1"
app/test/core/feedback/app_feedback_view_test.dart
```

Casi:

* [ ] nessun feedback → widget vuoto o non visibile;
* [ ] feedback errore → testo visibile;
* [ ] feedback successo → testo visibile;
* [ ] feedback warning → testo visibile;
* [ ] feedback info → testo visibile;
* [ ] testo presente nella tree del widget;
* [ ] testo disponibile per screen reader tramite testo o Semantics;
* [ ] se usato `Semantics(liveRegion: true)`, verificarlo.

---

# 20. Implementazione SessionGate

Percorso:

```text id="hkenyd"
app/lib/features/auth/presentation/session_gate.dart
```

## 20.1 Obiettivo

Osservare lo stato sessione e mostrare il ramo corretto.

## 20.2 Dipendenze

`SessionGate` deve ricevere:

* [ ] `AppSessionController`;
* [ ] `AppFeedbackController`;
* [ ] callback `onRetryProfileCheck`;
* [ ] callback o riferimento necessario per login/logout tramite pagine figlie.
  Soluzione consigliata:

```text id="q10zi7"
SessionGate(
  sessionController: ...,
  feedbackController: ...,
  onRetryProfileCheck: coordinator.retryProfileCheck,
  onSignIn: coordinator.signIn,
  onSignOut: coordinator.signOut,
)
```

Regola:

```text id="bdjwmu"
i widget figli devono ricevere le azioni tramite callback passate da costruttore
```

Esempi:

```text id="a17tvo"
LoginPage(onSignIn: coordinator.signIn, ...)
AuthPlaceholderPage(onSignOut: coordinator.signOut, ...)
SessionGate(onRetryProfileCheck: coordinator.retryProfileCheck, ...)
```

## 20.3 Stati da mostrare

```text id="zbt5dc"
unknown → caricamento o errore recuperabile con Riprova
unauthenticated → LoginPage
authenticatedWithoutProfile → AuthPlaceholderPage onboarding
authenticatedWithProfile → AuthPlaceholderPage home
```

Checklist:

* [ ] `unknown` senza feedback errore → mostra caricamento accessibile.
* [ ] `unknown` con feedback errore → mostra feedback e pulsante Riprova.
* [ ] `unauthenticated` → mostra LoginPage.
* [ ] `authenticatedWithoutProfile` → mostra placeholder onboarding.
* [ ] `authenticatedWithProfile` → mostra placeholder home.

## 20.4 Osservazione sessione e feedback

`SessionGate` deve osservare:

* [ ] `AppSessionController`;
* [ ] `AppFeedbackController`.
  Soluzioni accettabili:
* [ ] `ListenableBuilder` con listenable combinato;
* [ ] builder annidati;
* [ ] widget interno dedicato.
  Regola:

```text id="cyc4d7"
sessione e feedback devono aggiornare coerentemente la UI
```

## 20.5 Cose vietate

* [ ] Non leggere Supabase direttamente.
* [ ] Non ascoltare `onAuthStateChange`.
* [ ] Non fare query.
* [ ] Non fare login direttamente.
* [ ] Non fare logout direttamente se non passando da callback/coordinator.
* [ ] Non implementare onboarding reale.
* [ ] Non implementare home reale.
* [ ] Non creare routing complesso.

## 20.6 Test SessionGate

Creare:

```text id="qtshms"
app/test/features/auth/presentation/session_gate_test.dart
```

Casi:

* [ ] stato `unknown` senza feedback errore mostra caricamento accessibile;
* [ ] stato `unknown` con feedback errore mostra messaggio e pulsante Riprova;
* [ ] pulsante Riprova chiama `onRetryProfileCheck`;
* [ ] stato `unauthenticated` mostra login;
* [ ] stato `authenticatedWithoutProfile` mostra placeholder onboarding;
* [ ] stato `authenticatedWithProfile` mostra placeholder home;
* [ ] cambia sessione → UI aggiornata;
* [ ] cambia feedback → UI aggiornata;
* [ ] non legge Supabase direttamente.

---

# 21. Implementazione LoginPage

Percorso:

```text id="57eqsw"
app/lib/features/auth/presentation/login_page.dart
```

## 21.1 Obiettivo

Creare schermata login minima, accessibile e funzionante.

## 21.2 Elementi UI

La pagina deve contenere:

* [ ] titolo chiaro;
* [ ] campo email;
* [ ] campo password;
* [ ] pulsante Accedi;
* [ ] indicatore di caricamento o stato login in corso;
* [ ] area feedback persistente tramite `AppFeedbackView`.

## 21.3 Campo email

* [ ] Etichetta visibile/accessibile `Email`.
* [ ] Non usare solo placeholder.
* [ ] Tipo tastiera email se utile.

## 21.4 Campo password

* [ ] Etichetta visibile/accessibile `Password`.
* [ ] Password oscurata.
* [ ] Non usare solo placeholder.

## 21.5 Pulsante Accedi

* [ ] Testo `Accedi`.
* [ ] Disabilitato o protetto durante login in corso.
* [ ] Non invia due login contemporanei.

## 21.6 Validazione

* [ ] Email vuota → feedback `Email obbligatoria.`;
* [ ] Password vuota → feedback `Password obbligatoria.`;
* [ ] Nessuna validazione email complessa in MVP 1.

## 21.7 Collegamento logica

* [ ] Non chiamare Supabase direttamente.
* [ ] Chiamare callback `onSignIn`.
* [ ] Non cercare il coordinator tramite service locator.
* [ ] Non decidere home/onboarding.
* [ ] Non gestire sessione da sola.
* [ ] Usare `AppFeedbackView`.
  Esempio logico:

```text id="zltmvy"
LoginPage(
  feedbackController: ...,
  onSignIn: coordinator.signIn,
)
```

## 21.8 Test LoginPage

Creare:

```text id="8wd74y"
app/test/features/auth/presentation/login_page_test.dart
```

Casi:

* [ ] campo Email presente;
* [ ] campo Password presente;
* [ ] pulsante Accedi presente;
* [ ] password oscurata;
* [ ] submit con email vuota produce feedback;
* [ ] submit con password vuota produce feedback;
* [ ] doppio submit durante login viene impedito o ignorato;
* [ ] messaggio errore persistente resta visibile;
* [ ] pagina non decide onboarding/home;
* [ ] pagina non chiama Supabase direttamente.

---

# 22. Implementazione AuthPlaceholderPage

Percorso:

```text id="ue8flm"
app/lib/features/auth/presentation/auth_placeholder_page.dart
```

## 22.1 Obiettivo

Mostrare placeholder minimi e temporanei per onboarding e home.

## 22.2 Placeholder onboarding

Testo:

```text id="ybx78d"
Profilo non ancora creato.
Il flusso onboarding sarà implementato nel blocco successivo.
```

Checklist:

* [ ] Mostrare testo chiaro.
* [ ] Non creare form onboarding.
* [ ] Non chiamare `crea_azienda_e_profilo`.
* [ ] Non creare azienda.
* [ ] Non creare profilo.
* [ ] Prevedere pulsante Esci per test logout.

## 22.3 Placeholder home

Testo:

```text id="n6ka1z"
Accesso completato.
La home sarà implementata nel blocco 004.
```

Checklist:

* [ ] Mostrare testo chiaro.
* [ ] Non creare dashboard.
* [ ] Non creare menu definitivo.
* [ ] Non creare navigazione gestionale.
* [ ] Prevedere pulsante Esci per test logout.

## 22.4 Logout dai placeholder

* [ ] Il pulsante Esci chiama callback `onSignOut`.
* [ ] Non chiama Supabase direttamente.
* [ ] Non cerca il coordinator tramite service locator.
* [ ] Il testo del pulsante è leggibile.
* [ ] Il logout torna al login.
  Esempio logico:

```text id="5ltgif"
AuthPlaceholderPage(
  type: onboarding,
  onSignOut: coordinator.signOut,
)
```

oppure:

```text id="biw15u"
AuthPlaceholderPage(
  type: home,
  onSignOut: coordinator.signOut,
)
```

## 22.5 Test AuthPlaceholderPage

Creare:

```text id="2wbfkj"
app/test/features/auth/presentation/auth_placeholder_page_test.dart
```

Casi:

* [ ] placeholder onboarding mostra `Profilo non ancora creato.`;
* [ ] placeholder onboarding mostra `Il flusso onboarding sarà implementato nel blocco successivo.`;
* [ ] placeholder home mostra `Accesso completato.`;
* [ ] placeholder home mostra `La home sarà implementata nel blocco 004.`;
* [ ] pulsante `Esci` presente;
* [ ] pulsante `Esci` chiama callback logout;
* [ ] pulsante `Esci` è leggibile da screen reader;
* [ ] il widget non chiama Supabase direttamente;
* [ ] il widget non implementa onboarding reale;
* [ ] il widget non implementa home reale.

---

# 23. Implementazione AppRoot

Percorso eventuale:

```text id="8tz4vi"
app/lib/app/app_root.dart
```

## 23.1 Obiettivo

Tenere `main.dart` pulito, se utile.

## 23.2 Checklist

* [ ] Creare `app_root.dart` solo se migliora chiarezza.
* [ ] Contenere `MaterialApp`.
* [ ] Usare `SessionGate` come home.
* [ ] Ricevere controller e coordinator dal main.
* [ ] Passare callback necessarie a `SessionGate`.
* [ ] Passare `signIn`, `signOut` e `retryProfileCheck` tramite costruttore/callback.
* [ ] Non contenere query Supabase.
* [ ] Non creare listener auth.
* [ ] Non contenere logica business.
  Se `main.dart` resta leggibile senza `AppRoot`, il file può non essere creato.

---

# 24. Modifica main.dart

Percorso:

```text id="gvx6fv"
app/lib/main.dart
```

## 24.1 Obiettivo

Collegare il nuovo flusso auth/session all'app.

## 24.2 Checklist

* [ ] Chiamare `WidgetsFlutterBinding.ensureInitialized()`.
* [ ] Inizializzare Supabase con configurazione esistente.
* [ ] Attendere il completamento di `Supabase.initialize`.
* [ ] Usare `publishableKey`.
* [ ] Non usare `anonKey` se deprecato.
* [ ] Non usare service role key.
* [ ] Creare `AppSessionController`.
* [ ] Creare `AppFeedbackController`.
* [ ] Creare `AuthService`.
* [ ] Creare `ProfileService`.
* [ ] Creare `AuthSessionCoordinator`.
* [ ] Avviare app con `AppRoot` o `SessionGate`.
* [ ] Chiamare `coordinator.initialize()` una sola volta.
* [ ] Non creare listener auth in `main.dart`.
* [ ] Non mettere query Supabase in `main.dart`.
* [ ] Non lasciare come home definitiva la vecchia console test backend.

## 24.3 Verifica main

* [ ] L'app parte da caricamento/session gate.
* [ ] Se non autenticato, mostra login.
* [ ] Non compare una schermata bianca.
* [ ] Non compare per errore login durante recupero sessione.

---

# 25. Gestione errori

## 25.1 Regola

Tutti gli errori tecnici passano da:

```text id="7k5yn9"
SupabaseErrorMapper
```

## 25.2 Casi da gestire nel blocco

* [ ] credenziali errate;
* [ ] sessione scaduta;
* [ ] sessione non valida;
* [ ] rete assente;
* [ ] timeout;
* [ ] errore lettura profilo;
* [ ] errore lettura azienda;
* [ ] azienda non leggibile;
* [ ] azienda `null` nonostante `azienda_id` presente;
* [ ] `azienda_id` vuoto/malformato;
* [ ] `companyName` vuoto/mancante;
* [ ] errore RLS/autorizzazione;
* [ ] errore stream auth;
* [ ] evento auth non previsto;
* [ ] errore generico.

## 25.3 Regole

* [ ] Non mostrare `AuthException` grezza.
* [ ] Non mostrare `PostgrestException` grezza.
* [ ] Non mostrare dettagli tecnici nella UI.
* [ ] Conservare eventuale dettaglio in `technicalMessage`.
* [ ] Non trasformare errore lettura profilo in profilo assente.
* [ ] Non trasformare azienda non leggibile in profilo incompleto.
* [ ] Non trasformare azienda `null` con `azienda_id` presente in profilo incompleto.

---

# 26. Accessibilità

## 26.1 Checklist generale

* [ ] Campo Email con etichetta chiara.
* [ ] Campo Password con etichetta chiara.
* [ ] Pulsante Accedi leggibile.
* [ ] Pulsante Esci leggibile.
* [ ] Pulsante Riprova leggibile.
* [ ] Caricamento con testo.
* [ ] Feedback persistente visibile.
* [ ] Errori non solo colore.
* [ ] Placeholder con testo chiaro.
* [ ] Ordine logico degli elementi.

## 26.2 Messaggi accessibili

* [ ] Il messaggio di errore resta nella schermata.
* [ ] Il messaggio è consultabile dallo screen reader.
* [ ] Eventuale annuncio vocale non sostituisce il feedback persistente.

## 26.3 Test manuale con screen reader

Da eseguire dopo implementazione:

* [ ] NVDA legge campo Email.
* [ ] NVDA legge campo Password.
* [ ] NVDA legge pulsante Accedi.
* [ ] NVDA legge errore credenziali.
* [ ] NVDA legge caricamento sessione.
* [ ] NVDA legge pulsante Riprova.
* [ ] NVDA legge pulsante Esci.

---

# 27. Test automatici complessivi richiesti

Il blocco deve aggiungere o aggiornare test per:

```text id="57zy8e"
app/test/features/auth/domain/auth_profile_check_result_test.dart
app/test/features/auth/data/profile_service_test.dart
app/test/features/auth/application/auth_session_coordinator_test.dart
app/test/features/auth/presentation/session_gate_test.dart
app/test/features/auth/presentation/login_page_test.dart
app/test/features/auth/presentation/auth_placeholder_page_test.dart
app/test/core/feedback/app_feedback_view_test.dart
```

## Se un test concreto di `ProfileService` risultasse troppo complicato senza Supabase reale, i casi devono essere coperti esplicitamente nel test del coordinator con fake manuali.

# 28. Test automatici da NON fare

Non creare test automatici che:

* [ ] chiamano Supabase reale;
* [ ] richiedono rete;
* [ ] richiedono utenti reali;
* [ ] dipendono da database esterno;
* [ ] richiedono credenziali vere;
* [ ] usano service role key;
* [ ] modificano dati reali.
  Regola:

```text id="biw0u1"
test automatici = fake o simulazioni
test manuali = Supabase reale
```

---

# 29. Test manuali con Supabase reale

Dopo implementazione e test automatici, eseguire test manuali.

## 29.1 Avvio e login

* [ ] Avviare app senza sessione → appare login.
* [ ] Avvio durante controllo sessione → caricamento accessibile.
* [ ] Login con email vuota → `Email obbligatoria.`
* [ ] Login con password vuota → `Password obbligatoria.`
* [ ] Login con credenziali errate → `Email o password non corrette.`

## 29.2 Stati utente

* [ ] Utente valido senza profilo → placeholder onboarding.
* [ ] Utente valido con profilo e azienda → placeholder home.
* [ ] Profilo presente ma senza azienda valida → placeholder onboarding/incomplete.
* [ ] Profilo con azienda_id ma azienda non leggibile → feedback errore, non onboarding.
* [ ] Profilo con azienda_id ma query azienda restituisce zero righe → feedback errore, non onboarding.

## 29.3 Retry

* [ ] Errore rete durante lettura profilo → feedback errore.
* [ ] Pulsante Riprova visibile.
* [ ] Pulsante Riprova ritenta controllo.
* [ ] Doppio click su Riprova non crea stati incoerenti.

## 29.4 Logout

* [ ] Logout da placeholder onboarding → ritorna login.
* [ ] Logout da placeholder home → ritorna login.
* [ ] Doppio click su Esci → stato finale coerente.

## 29.5 Sessione persistente

* [ ] Login riuscito.
* [ ] Chiudere app.
* [ ] Riaprire app.
* [ ] Sessione valida recuperata.
* [ ] Login non lampeggia inutilmente durante recupero sessione.

## 29.6 Accessibilità

* [ ] Screen reader legge Email.
* [ ] Screen reader legge Password.
* [ ] Screen reader legge Accedi.
* [ ] Screen reader legge messaggi errore.
* [ ] Screen reader legge caricamento iniziale.
* [ ] Screen reader legge Riprova.
* [ ] Screen reader legge Esci.

---

# 30. Ordine di implementazione consigliato

Seguire questo ordine:

1. [ ] Preparare branch `feature/auth-session`.
2. [ ] Eseguire `flutter analyze`.
3. [ ] Eseguire `flutter test`.
4. [ ] Creare cartelle `features/auth`.
5. [ ] Aggiornare `AppMessages`.
6. [ ] Creare `auth_profile_check_result.dart`.
7. [ ] Creare `auth_profile_check_result_test.dart`.
8. [ ] Creare `auth_service.dart`.
9. [ ] Creare `profile_service.dart`.
10. [ ] Creare `auth_session_coordinator.dart`.
11. [ ] Creare test coordinator.
12. [ ] Creare o coprire test ProfileService.
13. [ ] Creare `app_feedback_view.dart`.
14. [ ] Creare `app_feedback_view_test.dart`.
15. [ ] Creare `session_gate.dart`.
16. [ ] Creare `session_gate_test.dart`.
17. [ ] Creare `auth_placeholder_page.dart`.
18. [ ] Creare `auth_placeholder_page_test.dart`.
19. [ ] Creare `login_page.dart`.
20. [ ] Creare `login_page_test.dart`.
21. [ ] Creare eventuale `app_root.dart`.
22. [ ] Collegare tutto in `main.dart`.
23. [ ] Eseguire `flutter analyze`.
24. [ ] Eseguire `flutter test`.
25. [ ] Correggere eventuali problemi.
26. [ ] Eseguire test manuali minimi.
27. [ ] Aggiornare `CHANGELOG.md`.
28. [ ] Verificare `git status`.
29. [ ] Preparare commit.
    Regola:

```text id="3cd3av"
prima logica testabile,
poi UI minima,
poi collegamento in main.
```

---

# 31. Comandi di verifica

Da eseguire nella cartella:

```text id="cp3sur"
app/
```

Comando analisi:

```text id="chpalq"
flutter analyze
```

Comando test:

```text id="47ltz7"
flutter test
```

Dalla root del repository:

```text id="vt7hb8"
git status
```

Criterio:

* [ ] `flutter analyze` senza errori;
* [ ] `flutter test` senza test falliti;
* [ ] `git status` mostra solo file attesi;
* [ ] nessun file temporaneo inutile;
* [ ] nessuna chiave segreta committata.

---

# 32. Aggiornamento CHANGELOG

Dopo implementazione e test, aggiornare:

```text id="s1dpje"
CHANGELOG.md
```

Voce indicativa:

```text id="q75oym"
Aggiunta gestione login, logout e controllo sessione iniziale.
```

Possibili dettagli:

```text id="nb22du"
Aggiunto controllo profilo applicativo per distinguere utenti senza profilo da utenti con profilo e azienda.
Aggiunto ascolto centrale dei cambi sessione Supabase.
Aggiunta gestione sicura di sessione persistente, eventi auth e retry lettura profilo.
Aggiunti placeholder temporanei per onboarding e home.
Aggiunta schermata login minima con feedback persistente e campi accessibili.
Aggiunti test automatici per coordinator auth, SessionGate, LoginPage, AuthPlaceholderPage e feedback persistente.
```

Checklist:

* [ ] Aggiornare changelog solo dopo codice e test.
* [ ] Non dichiarare funzionalità non implementate.
* [ ] Non indicare onboarding/home come completi.

---

# 33. Criteri di completamento

Il blocco 002 è completato quando:

* [ ] l'app parte da `SessionGate`;
* [ ] lo stato `unknown` mostra caricamento accessibile;
* [ ] lo stato `unknown` con errore mostra feedback e Riprova;
* [ ] la sessione Supabase viene controllata all'avvio;
* [ ] la sessione persistente viene recuperata correttamente;
* [ ] nessun utente autenticato porta a login;
* [ ] login email/password funziona;
* [ ] logout funziona;
* [ ] doppi invii login/logout/retry sono gestiti;
* [ ] doppio signIn ravvicinato non chiama due volte `AuthService.signInWithPassword`;
* [ ] esiste un solo listener auth centrale;
* [ ] il listener auth ha gestione errore;
* [ ] eventi auth iniziali non duplicano stati;
* [ ] eventi auth non previsti sono no-op esplicito;
* [ ] `tokenRefreshed` non causa riletture inutili profilo;
* [ ] `tokenRefreshed` confronta l'utente tramite `user.id`;
* [ ] dopo login viene letto profilo;
* [ ] dopo login viene letta azienda;
* [ ] profilo assente reale porta a `authenticatedWithoutProfile`;
* [ ] profilo completo porta a `authenticatedWithProfile`;
* [ ] profilo senza azienda valida porta a `authenticatedWithoutProfile`;
* [ ] profilo con azienda_id ma azienda non leggibile porta a errore tecnico;
* [ ] profilo con azienda_id ma query azienda restituisce `null` porta a errore tecnico manuale;
* [ ] azienda_id vuoto/malformato porta a errore tecnico;
* [ ] companyName vuoto/mancante porta a errore tecnico;
* [ ] errore lettura profilo non porta a onboarding;
* [ ] errore lettura profilo mostra feedback persistente;
* [ ] esiste possibilità di riprovare lettura profilo;
* [ ] placeholder onboarding/home sono minimi e temporanei;
* [ ] `AuthPlaceholderPage` è coperto da test;
* [ ] il blocco non chiama `crea_azienda_e_profilo`;
* [ ] il blocco non crea onboarding reale;
* [ ] il blocco non crea home reale;
* [ ] il blocco non introduce routing complesso;
* [ ] il blocco non introduce BLoC/Riverpod/GetIt;
* [ ] tutti i messaggi importanti usano `AppMessages`;
* [ ] gli errori tecnici passano da `SupabaseErrorMapper`;
* [ ] il feedback è persistente;
* [ ] login page ha campi etichettati;
* [ ] `SessionGate` osserva sessione e feedback;
* [ ] `SessionGate` riceve callback retry;
* [ ] `LoginPage` riceve callback `onSignIn`;
* [ ] `AuthPlaceholderPage` riceve callback `onSignOut`;
* [ ] i file core completati nel blocco 001 non sono stati riscritti;
* [ ] i test automatici passano;
* [ ] i test manuali principali sono stati eseguiti;
* [ ] `flutter analyze` passa;
* [ ] `flutter test` passa;
* [ ] `CHANGELOG.md` è aggiornato;
* [ ] il commit è pronto.

---

# 34. Commit previsto

Commit consigliato:

```text id="krsbsi"
feat: aggiunge login logout e gestione sessione
```

Commit alternativo:

```text id="epz6ti"
feat: aggiunge auth session con test
```

Il commit deve essere eseguito solo dopo:

```text id="tl0xdw"
flutter analyze
flutter test
```

## entrambi superati.

# 35. Stato del documento

Stato:

```text id="6gw7ow"
APPROVATO
```

Questo documento è pronto per essere salvato come:

```text id="1qf25d"
docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md
```

Il prossimo passo sarà preparare il prompt operativo rigido per Antigravity.
Il prompt dovrà basarsi su:

```text id="859imc"
docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md
```
