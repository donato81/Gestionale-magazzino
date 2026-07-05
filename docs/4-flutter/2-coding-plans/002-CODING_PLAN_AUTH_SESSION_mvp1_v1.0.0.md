# CODING PLAN AUTH SESSION MVP 1.0

## Gestionale Magazzino Universale

Versione: 1.0.0
Stato: APPROVATO
Data: 5 luglio 2026
-------------------

# 1. Scopo del documento

Questo documento definisce il coding plan del blocco 002 della fase Flutter MVP 1.0:

```text
Login, logout e sessione
```

Il documento trasforma il design approvato:

```text
docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
```

in un piano operativo per la futura implementazione Dart/Flutter.
Questo documento non contiene ancora codice definitivo.
Questo documento non è il TODO operativo.
Questo documento serve a chiarire:

* quali file creare;
* quali file modificare;
* quali responsabilità assegnare a ogni file;
* quale ordine seguire durante la codifica;
* quali test automatici preparare;
* quali test manuali eseguire;
* quali rischi evitare;
* quali criteri usare per considerare completato il blocco.
  Il documento è in stato:

```text
APPROVATO
```

## e può essere usato come base per scrivere il TODO operativo del blocco 002.

# 2. Nome del file

Il file deve essere salvato come:

```text
docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
```

---

# 3. Documenti di riferimento

Il blocco 002 dipende dai documenti già approvati:

```text
docs/0-architettura/001-ARCHITETTURA_mvp1_v1.0.0.md
docs/1-database/001-DATABASE_SCHEMA_mvp1_v1.0.0.md
docs/2-flussi-applicativi/001-FLOWS_mvp1_v1.0.0.md
docs/3-backend/001-BACKEND_RULES_mvp1_v1.0.0.md
docs/3-backend/002-API_CONTRACTS_mvp1_v1.0.0.md
docs/4-flutter/001-FLUTTER_PLAN_mvp1_v1.0.0.md
docs/4-flutter/1-design/001-DESIGN_CORE_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/001-CODING_PLAN_CORE_mvp1_v1.0.0.md
docs/4-flutter/3-todos/001-TODO_CORE_mvp1_v1.0.0.md
docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/3-todos/000-todo-master.md
```

In caso di dubbio, prevalgono:

1. regole backend;
2. API Contracts;
3. Flutter plan;
4. design core;
5. design auth/session;
6. questo coding plan.

---

# 4. Stato iniziale del progetto

Il blocco precedente:

```text
Blocco 001 — Core Dart minimo
```

è completato.
Sono già presenti gli strumenti core:

```text
app/lib/core/messages/app_messages.dart
app/lib/core/errors/app_exception.dart
app/lib/core/errors/supabase_error_mapper.dart
app/lib/core/feedback/app_feedback_message.dart
app/lib/core/feedback/app_feedback_controller.dart
app/lib/core/accessibility/accessibility_service.dart
app/lib/core/session/app_session_state.dart
app/lib/core/session/app_session_controller.dart
```

Sono già presenti test automatici del core:

```text
app/test/core/errors/supabase_error_mapper_test.dart
app/test/core/feedback/app_feedback_controller_test.dart
app/test/core/session/app_session_controller_test.dart
app/test/core/accessibility/accessibility_service_test.dart
```

Il risultato finale del blocco core è:

```text
flutter analyze
No issues found!
```

```text
flutter test
+30: All tests passed!
```

Il blocco 002 deve costruire sopra questa base.
Non deve riscrivere il core.
Può solo estenderlo in modo minimo dove serve.
----------------------------------------------

# 5. Obiettivo del blocco 002

Il blocco 002 deve permettere all'app Flutter di:

* controllare la sessione Supabase all'avvio;
* mostrare una schermata di caricamento accessibile durante lo stato `unknown`;
* mostrare login se non esiste un utente autenticato;
* eseguire login con email e password;
* validare email e password obbligatorie;
* evitare doppi invii durante il login;
* eseguire logout;
* ascoltare i cambi sessione Supabase in un solo punto centrale;
* gestire correttamente la sessione persistente ripristinata da Supabase;
* gestire eventi auth iniziali, login, logout e refresh token senza duplicare la logica;
* controllare se l'utente autenticato ha un profilo applicativo;
* controllare se il profilo è collegato a una azienda valida;
* distinguere profilo assente da errore durante la lettura profilo;
* distinguere profilo incompleto da dato incoerente o errore tecnico;
* trattare profilo presente senza azienda come profilo incompleto;
* trattare profilo con azienda non leggibile come errore tecnico;
* aggiornare `AppSessionController`;
* decidere se mostrare login, placeholder onboarding o placeholder home;
* mostrare feedback persistente;
* usare `SupabaseErrorMapper` per tradurre errori tecnici;
* usare `AppMessages` per i messaggi utente importanti;
* mantenere accessibilità base per screen reader;
* aggiungere test automatici del blocco;
* predisporre test manuali con Supabase reale.

---

# 6. Cosa NON deve fare il blocco 002

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
  Il blocco deve restare concentrato su:

```text
login
logout
controllo sessione
controllo profilo
controllo azienda
decisione login/onboarding/home
```

---

# 7. Principio tecnico guida

Il principio tecnico guida è:

```text
un solo punto centrale decide lo stato della sessione applicativa
```

Le schermate non devono controllare ognuna per conto proprio:

* sessione Supabase;
* profilo applicativo;
* azienda corrente;
* cambio sessione;
* scadenza sessione;
* retry lettura profilo;
* eventi dello stream auth.
  La UI deve osservare lo stato del core:

```text
AppSessionController
```

e mostrare il ramo corretto:

```text
unknown → caricamento accessibile oppure errore recuperabile con Riprova
unauthenticated → login
authenticatedWithoutProfile → placeholder onboarding
authenticatedWithProfile → placeholder home
```

Il blocco non introduce nuovi stati in `AppSessionStatus`.
Lo stato `unknown` viene usato consapevolmente in due situazioni:

```text
unknown senza feedback errore → controllo sessione/profilo in corso
unknown con feedback errore → errore recuperabile, mostra pulsante Riprova
```

## Questa scelta evita di riaprire il blocco core e mantiene minimo il modello di sessione.

# 8. Scelta architetturale del blocco

Per il blocco 002 si usa una struttura semplice, senza framework di stato complessi.
La struttura consigliata è:

```text
features/auth/
  application/
  data/
  domain/
  presentation/
```

Motivazione:

* `data` contiene il collegamento concreto a Supabase;
* `domain` contiene piccoli oggetti di risultato e stato logico specifici del blocco auth;
* `application` contiene il coordinamento tra Auth, profilo, sessione e feedback;
* `presentation` contiene schermate e widget.
  Questa struttura non deve diventare una architettura pesante.
  Si crea solo ciò che serve ora.
  Non devono essere create cartelle vuote inutili.
  La struttura viene mantenuta perché:
* rende chiare le responsabilità;
* prepara i blocchi futuri;
* evita query Supabase dentro la UI;
* non introduce framework esterni;
* non introduce service locator.

---

# 9. Cartelle da creare

Creare le seguenti cartelle:

```text
app/lib/features/auth/
app/lib/features/auth/application/
app/lib/features/auth/data/
app/lib/features/auth/domain/
app/lib/features/auth/presentation/
```

Creare le cartelle test corrispondenti:

```text
app/test/features/auth/application/
app/test/features/auth/data/
app/test/features/auth/domain/
app/test/features/auth/presentation/
```

Creare test per core feedback UI:

```text
app/test/core/feedback/
```

Regole:

* non creare cartelle non previste;
* non creare file vuoti;
* creare solo i file indicati nel presente coding plan;
* eventuali file aggiuntivi devono avere una motivazione chiara e documentata nel TODO operativo.

---

# 10. File di produzione da creare

Creare questi file:

```text
app/lib/features/auth/domain/auth_profile_check_result.dart
app/lib/features/auth/data/auth_service.dart
app/lib/features/auth/data/profile_service.dart
app/lib/features/auth/application/auth_session_coordinator.dart
app/lib/features/auth/presentation/session_gate.dart
app/lib/features/auth/presentation/login_page.dart
app/lib/features/auth/presentation/auth_placeholder_page.dart
app/lib/core/feedback/app_feedback_view.dart
```

Creare eventualmente questo file se serve per tenere pulito `main.dart`:

```text
app/lib/app/app_root.dart
```

La creazione di `app_root.dart` è consigliata se `main.dart` diventerebbe troppo carico di inizializzazioni.
Non creare altri file senza motivazione.
----------------------------------------

# 11. File esistenti da modificare

Modificare:

```text
app/lib/main.dart
app/lib/core/messages/app_messages.dart
```

Modificare eventualmente:

```text
CHANGELOG.md
```

Il changelog dovrà essere aggiornato dopo l'implementazione e dopo i test.
Non modificare:

```text
app/lib/core/session/app_session_state.dart
```

salvo reale necessità.
Il design approvato stabilisce che non servono nuovi stati sessione nel core.
Non modificare:

```text
app/lib/core/session/app_session_controller.dart
```

salvo piccole integrazioni strettamente necessarie e compatibili con i test già esistenti.
Se `AppSessionController` viene esteso, i test del blocco core devono continuare a passare.
-------------------------------------------------------------------------------------------

# 12. File provvisori esistenti

Potrebbero esistere file provvisori del primo collegamento Supabase:

```text
app/lib/services/test_backend_service.dart
app/lib/pages/test_console_page.dart
```

Regola:

* non eliminarli se non serve;
* scollegarli dal flusso principale se `main.dart` passerà a `SessionGate`;
* eliminarli solo se causano errori, confusione o conflitti;
* se vengono eliminati, aggiornare eventuali riferimenti e test.
  La priorità è che l'app parta dal nuovo flusso:

```text
Supabase init
↓
AppSessionController
↓
AppFeedbackController
↓
AuthService
↓
ProfileService
↓
AuthSessionCoordinator
↓
SessionGate
```

---

# 13. Modifica di AppMessages

Percorso:

```text
app/lib/core/messages/app_messages.dart
```

Obiettivo:
aggiungere solo i messaggi mancanti necessari al blocco 002.
Non creare un nuovo archivio parallelo di messaggi.
Non scrivere messaggi importanti direttamente nei widget.
Messaggi da verificare o aggiungere se mancanti:

```text
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

Regole:

* usare stringhe Dart pure;
* non usare `BuildContext`;
* non importare UI;
* non duplicare messaggi già presenti;
* mantenere messaggi chiari anche se letti da screen reader;
* il messaggio generico `Riprova` può essere usato dove il contesto visivo è già chiaro;
* per accessibilità, il pulsante può usare un testo più descrittivo come `Riprova controllo sessione` o `Riprova caricamento profilo`.

---

# 14. File auth_profile_check_result.dart

Percorso:

```text
app/lib/features/auth/domain/auth_profile_check_result.dart
```

Responsabilità:
rappresentare il risultato della verifica profilo/azienda.
Questo file serve a distinguere chiaramente:

```text
profilo assente
profilo incompleto
profilo completo
```

senza confondere questi casi con un errore tecnico.
Struttura logica consigliata:

```text
AuthProfileCheckStatus
```

con valori:

```text
missing
incomplete
complete
```

Classe consigliata:

```text
AuthProfileCheckResult
```

Campi indicativi:

```text
status
profileId
companyId
companyName
```

Regole:

* `missing` significa che la query profilo è riuscita ma non ha trovato record;
* `incomplete` significa che il profilo esiste ma non contiene una azienda collegata valida;
* `complete` significa che profilo e azienda sono validi;
* gli errori di rete, RLS o server non devono diventare `missing`;
* gli errori tecnici devono essere lanciati o restituiti separatamente e mappati dal coordinator;
* il modello non deve dipendere da widget Flutter;
* il modello non deve dipendere da Supabase reale nei test automatici.
  Regola finale sui casi:

```text
profilo assente → missing
profilo presente senza azienda_id → incomplete
profilo presente con azienda_id e azienda leggibile → complete
profilo presente con azienda_id ma azienda non trovata/non leggibile → errore tecnico
errore query/rete/RLS → errore tecnico
```

## Il test di questo file è obbligatorio.

# 15. File auth_service.dart

Percorso:

```text
app/lib/features/auth/data/auth_service.dart
```

Responsabilità:
incapsulare Supabase Auth.
Questo file deve evitare che la UI chiami direttamente Supabase Auth.
Contenuto consigliato:

* una interfaccia o classe astratta semplice per i test;
* una implementazione concreta basata su Supabase.
  Nome logico possibile:

```text
AuthService
SupabaseAuthService
```

Metodi minimi:

```text
User? get currentUser
Stream<AuthState> get authStateChanges
Future<User> signInWithPassword({
  required String email,
  required String password,
})
Future<void> signOut()
```

Contratto obbligatorio di `signInWithPassword`:

```text
successo → restituisce User
fallimento → propaga eccezione tecnica
```

Quindi `signInWithPassword` non deve usare `null` per rappresentare credenziali errate.
Le credenziali errate devono arrivare al coordinator come errore tecnico da tradurre tramite:

```text
SupabaseErrorMapper
```

Regole:

* non salvare password;
* non usare service role key;
* non mostrare messaggi utente;
* non gestire UI;
* non aggiornare direttamente widget;
* non aggiornare direttamente feedback visivo;
* lasciare la traduzione degli errori al coordinator tramite `SupabaseErrorMapper`;
* permettere fake manuali nei test automatici;
* non catturare errori Supabase per trasformarli in messaggi utente.
  Note:
* il nome preciso del tipo stream deve rispettare il pacchetto Supabase Dart realmente usato;
* se il metodo Supabase restituisce una response, il servizio deve estrarre e restituire solo l'utente necessario al coordinator;
* se Supabase non restituisce un utente valido dopo un login apparentemente riuscito, il servizio deve lanciare un errore tecnico o permettere al coordinator di trattarlo come sessione non valida.

---

# 16. File profile_service.dart

Percorso:

```text
app/lib/features/auth/data/profile_service.dart
```

Responsabilità:
leggere profilo applicativo e azienda corrente.
Questo file deve evitare query Supabase sparse nelle schermate.
Nome logico possibile:

```text
ProfileService
SupabaseProfileService
```

Metodo minimo:

```text
Future<AuthProfileCheckResult> checkProfileForUser(User user)
```

Strategia obbligatoria:

1. leggere `profili` filtrando per `user_id`;
2. usare una lettura che consenta risultato assente senza eccezione, per esempio `maybeSingle()` o equivalente;
3. se il profilo non esiste, restituire `missing`;
4. se il profilo esiste ma non contiene una azienda valida, restituire `incomplete`;
5. se il profilo esiste e contiene `azienda_id`, leggere l'azienda collegata;
6. se l'azienda è trovata e leggibile, restituire `complete`;
7. se `azienda_id` è presente ma l'azienda non viene trovata o non è leggibile, lanciare errore tecnico;
8. se la query profilo o azienda fallisce per rete, timeout, RLS o server, lanciare errore tecnico.
   Regola fondamentale:

```text
query riuscita senza profilo → missing
query fallita → errore tecnico
```

Regola finale su profilo e azienda:

```text
profilo assente → missing
profilo presente senza azienda_id → incomplete
profilo presente con azienda_id e azienda leggibile → complete
profilo presente con azienda_id ma azienda non trovata/non leggibile → errore tecnico
errore query/rete/RLS → errore tecnico
```

Motivazione:
se il profilo contiene `azienda_id`, per l'MVP 1 quell'azienda dovrebbe esistere ed essere leggibile tramite RLS.
Se non è leggibile, probabilmente c'è:

* dato incoerente;
* azienda mancante;
* RLS errata;
* problema backend;
* problema temporaneo di rete o server.
  Questo non deve mandare l'utente silenziosamente verso onboarding.
  Il servizio deve rispettare le RLS.
  Flutter non deve usare service role key.
  Flutter non deve scegliere manualmente aziende di altri utenti.
  Campi minimi da leggere da `profili`:

```text
id
user_id
azienda_id
```

Campi minimi da leggere da `aziende`:

```text
id
nome
```

Regole:

* non chiamare `crea_azienda_e_profilo`;
* non creare azienda;
* non creare profilo;
* non modificare dati;
* solo lettura;
* errori tecnici devono poter arrivare al coordinator;
* non mostrare messaggi utente;
* non trasformare eccezioni in `missing`;
* non trasformare azienda non leggibile in `incomplete`.

---

# 17. File auth_session_coordinator.dart

Percorso:

```text
app/lib/features/auth/application/auth_session_coordinator.dart
```

Responsabilità:
coordinare:

* Auth Supabase;
* lettura profilo;
* lettura azienda;
* `AppSessionController`;
* `AppFeedbackController`;
* `SupabaseErrorMapper`;
* eventuali annunci accessibili.
  Questo è il cuore del blocco 002.
  Nome consigliato:

```text
AuthSessionCoordinator
```

Responsabilità principali:

```text
initialize()
signIn(email, password)
signOut()
retryProfileCheck()
dispose()
```

## 17.1 initialize()

Deve:

1. impostare o mantenere lo stato `unknown`;
2. registrare un solo listener centrale di `onAuthStateChange` o stream equivalente;
3. gestire l'evento iniziale della sessione, se emesso dallo stream;
4. leggere l'utente o la sessione corrente dopo che `Supabase.initialize` è completato;
5. se non esiste utente, impostare `unauthenticated`;
6. se esiste utente, controllare profilo e azienda;
7. aggiornare `AppSessionController`;
8. usare lo stesso metodo interno sia per la sessione iniziale sia per gli eventi successivi;
9. evitare che un evento iniziale e un controllo manuale elaborino due volte lo stesso utente.
   Regola:

```text
lettura iniziale e stream auth devono convergere nello stesso metodo idempotente
```

Nome possibile del metodo interno:

```text
resolveSessionFromUser(user)
```

oppure:

```text
resolveCurrentSession()
```

Il coordinator deve gestire almeno questi casi dello stream auth, usando i nomi reali previsti dal pacchetto Supabase Dart:

```text
initialSession
signedIn
signedOut
tokenRefreshed
```

Regole sugli eventi:

* `signedOut` o sessione nulla → `unauthenticated`;
* `signedIn` con nuovo utente → controllo profilo/azienda;
* sessione iniziale con utente → controllo profilo/azienda;
* `tokenRefreshed` dello stesso utente già risolto → non rilegge profilo inutilmente;
* errore nello stream → passa da `SupabaseErrorMapper` e feedback persistente.
  Il listener deve prevedere gestione errori:

```text
onError
```

Gli errori dello stream non devono diventare eccezioni non gestite.

## 17.2 signIn()

Deve:

1. validare email obbligatoria;
2. validare password obbligatoria;
3. evitare doppi invii;
4. chiamare `AuthService.signInWithPassword`;
5. aspettarsi `User` in caso di successo;
6. aspettarsi eccezione tecnica in caso di fallimento;
7. in caso di errore usare `SupabaseErrorMapper`;
8. mostrare feedback persistente;
9. in caso di successo controllare profilo e azienda;
10. aggiornare lo stato sessione corretto;
11. mostrare feedback di successo solo se non crea confusione nel passaggio di schermata.
    Regola:

```text
login riuscito non significa automaticamente home
```

Dopo il login bisogna controllare il profilo.
Il login non deve trasformare un risultato `null` in credenziali errate.
Le credenziali errate devono essere trattate come errore tecnico mappato.

## 17.3 signOut()

Deve:

1. evitare doppi logout;
2. chiamare `AuthService.signOut`;
3. impostare `AppSessionController` a `unauthenticated`;
4. cancellare dati sessione applicativa in memoria;
5. mostrare feedback persistente:

```text
Uscita eseguita correttamente.
```

6. gestire eventuali errori tramite `SupabaseErrorMapper`;
7. ignorare o gestire in modo idempotente un eventuale evento auth `signedOut` successivo.

## 17.4 retryProfileCheck()

Serve quando la lettura profilo fallisce.
Deve:

1. controllare se esiste un utente corrente;
2. se non esiste, impostare `unauthenticated`;
3. se esiste, riprovare lettura profilo e azienda;
4. aggiornare lo stato corretto;
5. in caso di errore mantenere una condizione sicura e mostrare feedback;
6. evitare doppi retry ravvicinati.
   Durante il retry:

* il pulsante può essere disabilitato;
* oppure le chiamate ripetute possono essere ignorate;
* oppure si può usare un operation token.
  Regola:

```text
retryProfileCheck non deve avviare query concorrenti inutili
```

## 17.5 Ascolto centrale sessione

Il coordinator deve essere l'unico punto che ascolta i cambi Supabase Auth.
Regole:

* non creare listener nella login page;
* non creare listener in `SessionGate`;
* non creare listener nei placeholder;
* non creare listener in `main.dart`;
* non creare listener multipli;
* il listener deve essere cancellato in `dispose()`;
* il listener deve avere gestione `onError`;
* eventi di logout o sessione non valida devono portare a `unauthenticated`;
* eventi di login o sessione recuperata devono passare dal controllo profilo;
* eventi di refresh token non devono produrre riletture inutili del profilo.
  Tutti i flussi devono usare un metodo privato unico, ad esempio:

```text
resolveSessionFromUser(user)
```

oppure nome equivalente.
Questo evita duplicazione tra:

* avvio app;
* login riuscito;
* sessione persistente;
* cambio sessione;
* evento iniziale dello stream;
* refresh token.

## 17.6 Gestione chiamate ravvicinate

Il coordinator deve evitare stati incoerenti se arrivano eventi ravvicinati.
Esempio:

```text
login riuscito
↓
onAuthStateChange emette evento
↓
controllo profilo parte due volte
```

Altro esempio:

```text
initialize legge currentUser
↓
stream emette initialSession
↓
stesso utente rischia di essere risolto due volte
```

Contromisura semplice:

* usare un flag di caricamento;
* oppure usare un token progressivo dell'ultima operazione;
* oppure centralizzare in un unico metodo e accettare chiamate idempotenti;
* confrontare lo user id già risolto;
* ignorare risposte vecchie se è partita una operazione più recente.
  Non serve una soluzione complessa.
  Serve una difesa semplice e testabile.
  Regola:

```text
una risposta vecchia non deve sovrascrivere uno stato più nuovo
```

## 17.7 Stato in caso di errore lettura profilo

Se il profilo non può essere letto per errore tecnico:

* non impostare `authenticatedWithoutProfile`;
* non mandare automaticamente a onboarding;
* mostrare feedback persistente;
* permettere riprova;
* mantenere uno stato sicuro.
  Dato che il core non prevede uno stato errore dedicato, la soluzione approvata è:

```text
mantenere unknown
mostrare feedback persistente
mostrare pulsante Riprova nella schermata unknown
```

Questa scelta evita di confondere errore tecnico con profilo assente.
È una scelta consapevole per non modificare `AppSessionState`.
Significato pratico:

```text
unknown senza feedback errore → controllo in corso
unknown con feedback errore → errore recuperabile, mostra Riprova
```

Non aggiungere nuovi stati al core in questo blocco.

## 17.8 Ignorare eventi auth non rilevanti

Il coordinator deve evitare lavoro inutile.
Regola:

```text
tokenRefreshed dello stesso utente già risolto non deve far ripartire la lettura profilo
```

Esempio:

```text
utente già authenticatedWithProfile
↓
arriva tokenRefreshed dello stesso user
↓
non rileggo profilo e azienda
```

Diverso il caso:

```text
signedOut oppure session null
↓
imposto unauthenticated
```

Il coordinator deve distinguere tra:

* evento che cambia davvero lo stato logico;
* evento tecnico che aggiorna solo la sessione interna;
* errore dello stream;
* logout reale.

---

# 18. File app_feedback_view.dart

Percorso:

```text
app/lib/core/feedback/app_feedback_view.dart
```

Responsabilità:
mostrare in UI il feedback persistente gestito da `AppFeedbackController`.
Questo widget serve perché il feedback non sia solo snackbar temporaneo.
Nome possibile:

```text
AppFeedbackView
```

Comportamento:

* osserva `AppFeedbackController`;
* se non c'è messaggio, non mostra nulla;
* se c'è messaggio, mostra testo persistente;
* rende il testo leggibile da screen reader;
* non usa solo colore per distinguere errore/successo/avviso;
* può usare testo o etichetta chiara per il tipo di messaggio;
* non deve essere invasivo.
  Regole:
* non deve dipendere da Supabase;
* non deve contenere logica di business;
* non deve decidere la sessione;
* deve essere riutilizzabile in login e schermate future.
  Accessibilità:
* usare testo visibile;
* valutare `Semantics` con `liveRegion` se opportuno;
* non affidare il risultato solo a snackbar;
* il messaggio deve restare consultabile;
* il messaggio deve essere presente nella tree del widget;
* il feedback persistente resta la base;
* l'annuncio vocale è eventuale e non sostituisce il testo visibile.
  Regola:

```text
prima feedback persistente,
poi eventuale annuncio
```

---

# 19. File session_gate.dart

Percorso:

```text
app/lib/features/auth/presentation/session_gate.dart
```

Responsabilità:
osservare `AppSessionController` e mostrare il ramo corretto.
Nome consigliato:

```text
SessionGate
```

Logica:

```text
unknown → loading accessibile con eventuale feedback e pulsante Riprova se serve
unauthenticated → LoginPage
authenticatedWithoutProfile → AuthPlaceholderPage onboarding
authenticatedWithProfile → AuthPlaceholderPage home
```

`SessionGate` deve osservare:

* `AppSessionController`;
* `AppFeedbackController`.
  Deve ricostruire la UI quando cambia:
* lo stato sessione;
* il feedback corrente.
  Soluzioni accettabili:
* `ListenableBuilder` con listenable combinato;
* builder annidati;
* widget interno dedicato che ascolta entrambi.
  Non è obbligatoria una soluzione tecnica specifica.
  È obbligatorio che sessione e feedback siano osservati in modo coerente.
  `SessionGate` deve ricevere un modo esplicito per chiamare il retry.
  Soluzione consigliata:

```text
SessionGate(
  sessionController: ...,
  feedbackController: ...,
  onRetryProfileCheck: coordinator.retryProfileCheck,
)
```

Questa soluzione è preferita rispetto a passare tutto il coordinator, perché il widget conosce solo ciò che gli serve.
Regole:

* non leggere direttamente Supabase;
* non ascoltare direttamente `onAuthStateChange`;
* non fare query;
* non fare login;
* non fare logout se non passando da callback o coordinator;
* non implementare onboarding reale;
* non implementare home reale;
* non creare routing complesso.
  Per lo stato `unknown`, mostrare testo:

```text
Controllo sessione in corso.
```

oppure:

```text
Caricamento in corso.
```

Se lo stato è `unknown` e il feedback corrente è un errore, mostrare anche:

```text
Riprova
```

collegato a:

```text
onRetryProfileCheck
```

Il pulsante Riprova non deve essere mostrato solo perché lo stato è `unknown`.
Deve essere mostrato quando c'è un errore recuperabile.
-------------------------------------------------------

# 20. File login_page.dart

Percorso:

```text
app/lib/features/auth/presentation/login_page.dart
```

Responsabilità:
mostrare una schermata login minima, accessibile e funzionante.
Elementi:

* titolo chiaro;
* campo email;
* campo password;
* pulsante Accedi;
* indicatore di caricamento o stato login in corso;
* area feedback persistente;
* eventuale testo di aiuto minimo.
  Regole campi:
* il campo email deve avere etichetta:

```text
Email
```

* il campo password deve avere etichetta:

```text
Password
```

* la password deve essere oscurata;
* non basta un placeholder visivo;
* il pulsante deve essere leggibile come:

```text
Accedi
```

Validazione:

* email vuota → `Email obbligatoria.`;
* password vuota → `Password obbligatoria.`;
* non serve validazione email complessa in MVP 1.
  Durante login:
* evitare doppi invii;
* disabilitare il pulsante oppure ignorare richieste ripetute;
* mostrare stato comprensibile.
  Regole:
* non chiamare Supabase direttamente;
* chiamare `AuthSessionCoordinator.signIn`;
* non gestire sessione da sola;
* non decidere onboarding/home;
* non usare snackbar come unico feedback;
* usare `AppFeedbackView`.

---

# 21. File auth_placeholder_page.dart

Percorso:

```text
app/lib/features/auth/presentation/auth_placeholder_page.dart
```

Responsabilità:
mostrare placeholder minimi e temporanei per i rami non ancora implementati.
Ramo onboarding:

```text
Profilo non ancora creato.
Il flusso onboarding sarà implementato nel blocco successivo.
```

Ramo home:

```text
Accesso completato.
La home sarà implementata nel blocco 004.
```

Entrambi possono contenere pulsante:

```text
Esci
```

per testare logout.
Il pulsante logout deve chiamare una callback ricevuta dall'esterno oppure un metodo esposto dal coordinator tramite dipendenza esplicita.
Regole:

* non creare form onboarding;
* non chiamare `crea_azienda_e_profilo`;
* non creare home vera;
* non creare dashboard;
* non creare menu gestionale;
* non creare navigazione definitiva;
* i placeholder devono essere chiaramente temporanei;
* il pulsante logout deve passare dal coordinator o da callback collegata al coordinator.

---

# 22. File app_root.dart

Percorso eventuale:

```text
app/lib/app/app_root.dart
```

Responsabilità:
contenere la radice Flutter dell'app.
Questo file è consigliato se aiuta a mantenere `main.dart` pulito.
Può contenere:

* `MaterialApp`;
* configurazione titolo;
* creazione o ricezione dei controller;
* uso di `SessionGate` come home.
  Regole:
* non contenere logica Supabase complessa;
* non contenere query;
* non duplicare il coordinator;
* non creare service locator;
* passare dipendenze tramite costruttori o struttura semplice;
* non creare listener auth.
  Se viene creato `AppRoot`, dovrà ricevere o costruire in modo semplice:

```text
AppSessionController
AppFeedbackController
AuthSessionCoordinator
```

e passare a `SessionGate`:

```text
sessionController
feedbackController
onRetryProfileCheck
```

e alle pagine/placeholder le callback necessarie per:

```text
signIn
signOut
```

---

# 23. Modifica main.dart

Percorso:

```text
app/lib/main.dart
```

Responsabilità:
inizializzare Supabase e avviare l'app.
Il file deve:

1. garantire `WidgetsFlutterBinding.ensureInitialized()`;
2. inizializzare Supabase usando configurazione già presente;
3. attendere il completamento di `Supabase.initialize`;
4. creare il client Supabase con `publishableKey`;
5. creare `AppSessionController`;
6. creare `AppFeedbackController`;
7. creare servizi auth e profilo;
8. creare `AuthSessionCoordinator`;
9. avviare l'app con `AppRoot` o `SessionGate`;
10. chiamare `initialize()` una sola volta nel punto corretto.
    Regole:

* non usare `anonKey` se deprecato;
* non usare service role key;
* non lasciare come home definitiva la vecchia console di test;
* non duplicare inizializzazioni;
* non mettere query Supabase direttamente in `main.dart`;
* non creare listener auth in `main.dart`;
* non chiamare `initialize()` più volte;
* non leggere `currentUser` prima che Supabase sia inizializzato.
  Scelta consigliata:
* `main.dart` inizializza Supabase e crea dipendenze;
* `AppRoot` costruisce la UI;
* `AuthSessionCoordinator` gestisce la sessione.

---

# 24. Gestione dipendenze senza service locator

Per MVP 1 non introdurre GetIt o service locator.
Dipendenze passate in modo semplice:

```text
main.dart
↓
AppRoot
↓
SessionGate
↓
LoginPage / Placeholder
```

Oggetti principali:

```text
AppSessionController
AppFeedbackController
AuthSessionCoordinator
AuthService
ProfileService
```

I servizi concreti vengono creati una sola volta.
I widget ricevono ciò che serve tramite costruttore.
Questa soluzione è esplicita, leggibile e sufficiente per il blocco 002.
Regole:

* niente GetIt;
* niente Riverpod;
* niente BLoC;
* niente dependency injection complessa;
* niente singleton globali non necessari;
* usare costruttori e callback espliciti.

---

# 25. Gestione errori

Tutti gli errori tecnici devono passare da:

```text
SupabaseErrorMapper
```

Casi minimi da coprire:

* credenziali errate;
* sessione scaduta;
* sessione non valida;
* rete assente;
* timeout;
* errore lettura profilo;
* errore lettura azienda;
* azienda non leggibile;
* errore autorizzazione/RLS;
* errore dello stream auth;
* errore generico.
  Messaggi utente:

```text
Email o password non corrette.
Sessione scaduta. Accedi di nuovo.
Sessione non valida. Accedi di nuovo.
Connessione assente. Controlla Internet e riprova.
Operazione non autorizzata.
Si è verificato un errore. Riprova.
```

Regole:

* non mostrare `AuthException` grezza;
* non mostrare `PostgrestException` grezza;
* non mostrare dettagli tecnici nella UI;
* conservare dettagli tecnici solo in `technicalMessage` dove già previsto dal core;
* non trasformare errore lettura profilo in profilo assente;
* non trasformare azienda non leggibile in profilo incompleto;
* errori dello stream auth devono essere mappati e mostrati come feedback persistente quando impattano l'utente.

---

# 26. Gestione profilo assente vs errore profilo

Questa è una regola critica.

## 26.1 Profilo assente reale

Accade solo quando:

* l'utente è autenticato;
* la query profilo viene eseguita correttamente;
* il risultato è vuoto.
  Risultato:

```text
AppSessionStatus.authenticatedWithoutProfile
```

UI:

```text
placeholder onboarding
```

Questo non è un errore tecnico.
Significa che l'utente dovrà completare l'onboarding nel blocco successivo.

## 26.2 Errore lettura profilo

Accade quando:

* la query fallisce;
* c'è rete assente;
* c'è timeout;
* c'è errore Supabase;
* c'è errore RLS;
* c'è errore server.
  Risultato:
* non andare a onboarding;
* mostrare feedback persistente;
* permettere riprova;
* mantenere stato sicuro.
  Soluzione approvata:

```text
stato unknown + feedback errore + pulsante Riprova
```

Significato:

```text
unknown senza feedback errore → controllo in corso
unknown con feedback errore → errore recuperabile, mostra Riprova
```

## 26.3 Profilo presente ma azienda assente

Accade quando:

* il profilo esiste;
* il profilo non contiene una azienda valida.
  Risultato:

```text
AppSessionStatus.authenticatedWithoutProfile
```

Motivazione:
per MVP 1 il profilo senza azienda valida è incompleto.

## 26.4 Profilo presente con azienda_id ma azienda non leggibile

Accade quando:

* il profilo esiste;
* il profilo contiene `azienda_id`;
* la query azienda non trova la riga;
* oppure la riga non è leggibile;
* oppure la lettura azienda fallisce.
  Risultato:

```text
errore tecnico
```

Non deve diventare:

```text
authenticatedWithoutProfile
```

Motivazione:
se un profilo ha `azienda_id`, quell'azienda dovrebbe esistere ed essere leggibile.
Se non lo è, probabilmente c'è un problema backend, RLS o dato incoerente.
Il sistema non deve mascherare questo problema mandando l'utente in onboarding.
-------------------------------------------------------------------------------

# 27. Accessibilità

Il blocco 002 deve rispettare accessibilità fin da subito.
Requisiti minimi:

* campi con etichetta chiara;
* pulsanti con testo chiaro;
* feedback persistente;
* messaggi non solo visivi;
* errori non comunicati solo tramite colore;
* caricamento iniziale con testo;
* placeholder con testo chiaro;
* pulsante logout leggibile;
* pulsante retry leggibile;
* ordine logico degli elementi;
* compatibilità di base con screen reader.
  Ordine logico consigliato nella login page:

```text
titolo Login
campo Email
campo Password
pulsante Accedi
feedback persistente
```

Il feedback può essere posizionato anche prima del pulsante se risulta più leggibile.
La scelta finale dovrà essere testata con screen reader.
Regola:

```text
prima messaggio persistente
poi eventuale annuncio
```

Gli annunci non devono sostituire il testo presente in schermata.
Per il pulsante retry, il testo visibile può essere:

```text
Riprova
```

ma l'etichetta accessibile, se necessaria, può essere più descrittiva:

```text
Riprova controllo sessione
```

oppure:

```text
Riprova caricamento profilo
```

---

# 28. Sicurezza

Regole obbligatorie:

* usare solo chiave pubblica client prevista;
* non usare service role key;
* non salvare password;
* non bypassare RLS;
* non leggere profili di altri utenti;
* non permettere scelta manuale di `azienda_id`;
* non creare profilo in questo blocco;
* non creare azienda in questo blocco;
* non modificare dati di magazzino;
* non chiamare RPC movimenti;
* non chiamare RPC onboarding.
  Il blocco 002 legge solo ciò che serve a decidere:

```text
utente
profilo
azienda
```

Il controllo profilo e azienda deve rispettare le RLS.
La sicurezza non deve dipendere da Flutter.
Flutter deve usare solo il client normale con chiave pubblica.
--------------------------------------------------------------

# 29. Test automatici da creare

Creare i seguenti test automatici.

## 29.1 Test coordinator

Percorso consigliato:

```text
app/test/features/auth/application/auth_session_coordinator_test.dart
```

Casi minimi:

* `initialize` senza utente → `unauthenticated`;
* `initialize` con utente e profilo assente → `authenticatedWithoutProfile`;
* `initialize` con utente, profilo e azienda → `authenticatedWithProfile`;
* `initialize` con profilo presente ma senza azienda_id → `authenticatedWithoutProfile`;
* `initialize` con profilo presente, azienda_id valorizzato ma azienda non leggibile → feedback errore e nessun passaggio automatico a onboarding;
* errore lettura profilo → feedback errore e nessun passaggio automatico a onboarding;
* login con email vuota → feedback `Email obbligatoria.`;
* login con password vuota → feedback `Password obbligatoria.`;
* login fallito → feedback errore mappato;
* login riuscito con profilo assente → `authenticatedWithoutProfile`;
* login riuscito con profilo completo → `authenticatedWithProfile`;
* doppio `signIn` ravvicinato → una sola richiesta effettiva oppure secondo invio ignorato;
* logout riuscito → `unauthenticated`;
* doppio `signOut` ravvicinato → stato finale coerente `unauthenticated`;
* evento auth logout/sessione nulla → `unauthenticated`;
* evento auth `tokenRefreshed` dello stesso utente già risolto → non rilegge profilo inutilmente;
* evento auth iniziale e controllo iniziale manuale non producono stati incoerenti;
* errore nello stream auth → feedback errore mappato;
* `retryProfileCheck` senza utente corrente → `unauthenticated`;
* `retryProfileCheck` con utente e profilo completo → `authenticatedWithProfile`;
* `retryProfileCheck` con utente e profilo assente → `authenticatedWithoutProfile`;
* `retryProfileCheck` con errore profilo → resta in stato sicuro e mostra feedback errore;
* doppio `retryProfileCheck` ravvicinato → non produce query concorrenti inutili o stati incoerenti;
* listener centrale non crea aggiornamenti incoerenti;
* `dispose` chiude lo stream/listener se previsto.
  Usare fake manuali.
  Non usare Supabase reale.

## 29.2 Test AuthProfileCheckResult

Percorso consigliato:

```text
app/test/features/auth/domain/auth_profile_check_result_test.dart
```

Questo test è obbligatorio.
Casi minimi:

* risultato `missing` non contiene azienda;
* risultato `incomplete` gestisce profilo senza azienda valida;
* risultato `complete` contiene profilo e azienda;
* il modello non confonde `missing` e `incomplete`;
* il modello non rappresenta errori tecnici come stato normale.

## 29.3 Test ProfileService

Percorso consigliato:

```text
app/test/features/auth/data/profile_service_test.dart
```

Casi minimi:

* nessun profilo trovato → `missing`;
* profilo senza azienda_id → `incomplete`;
* profilo con azienda_id e azienda leggibile → `complete`;
* profilo con azienda_id ma azienda non trovata/non leggibile → errore tecnico;
* errore rete/query/RLS simulato → eccezione propagata, non `missing`;
* errore lettura azienda → eccezione propagata, non `incomplete`.
  Se testare il servizio concreto con Supabase mockato è troppo complesso, è accettabile testare il comportamento tramite fake nel coordinator, purché tutti i casi siano coperti in modo esplicito.

## 29.4 Test SessionGate

Percorso consigliato:

```text
app/test/features/auth/presentation/session_gate_test.dart
```

Casi minimi:

* stato `unknown` senza feedback errore mostra caricamento accessibile;
* stato `unknown` con feedback errore mostra messaggio e pulsante Riprova;
* stato `unauthenticated` mostra login;
* stato `authenticatedWithoutProfile` mostra placeholder onboarding;
* stato `authenticatedWithProfile` mostra placeholder home;
* il pulsante Riprova chiama `onRetryProfileCheck`;
* `SessionGate` ricostruisce la UI quando cambia sessione;
* `SessionGate` ricostruisce la UI quando cambia feedback;
* `SessionGate` non legge Supabase direttamente.

## 29.5 Test LoginPage

Percorso consigliato:

```text
app/test/features/auth/presentation/login_page_test.dart
```

Casi minimi:

* campo Email presente;
* campo Password presente;
* pulsante Accedi presente;
* password oscurata;
* submit con email vuota produce feedback;
* submit con password vuota produce feedback;
* durante login in corso il doppio invio è impedito o ignorato;
* messaggio errore persistente resta visibile;
* la pagina non decide onboarding/home;
* la pagina non chiama Supabase direttamente.

## 29.6 Test AppFeedbackView

Percorso consigliato:

```text
app/test/core/feedback/app_feedback_view_test.dart
```

Casi minimi:

* nessun feedback → widget vuoto o non visibile;
* feedback errore → testo visibile;
* feedback successo → testo visibile;
* feedback avviso → testo visibile;
* feedback informativo → testo visibile;
* il testo è disponibile nella tree del widget;
* il testo è disponibile per screen reader tramite testo o `Semantics`;
* se viene usato `Semantics(liveRegion: true)`, verificarlo nel test.

---

# 30. Test automatici da NON fare

Non creare test automatici che:

* chiamano Supabase reale;
* richiedono rete;
* richiedono utenti reali;
* dipendono da un database esterno;
* richiedono credenziali vere;
* usano service role key;
* modificano dati reali.
  Regola:

```text
test automatici = fake o simulazioni
test manuali = Supabase reale
```

---

# 31. Test manuali previsti

Dopo implementazione, eseguire test manuali con Supabase reale.
Casi minimi:

1. aprire app senza sessione → appare login;
2. avvio app durante controllo sessione → appare caricamento accessibile;
3. login con email vuota → messaggio `Email obbligatoria.`;
4. login con password vuota → messaggio `Password obbligatoria.`;
5. login con credenziali errate → messaggio `Email o password non corrette.`;
6. login con utente valido senza profilo → placeholder onboarding;
7. login con utente valido con profilo e azienda → placeholder home;
8. profilo presente ma senza azienda valida → ramo profilo incompleto;
9. profilo presente con azienda_id ma azienda non leggibile → feedback errore, non onboarding;
10. errore rete durante lettura profilo → feedback errore e possibilità di riprova;
11. pulsante Riprova dopo errore profilo → ritenta lettura profilo;
12. doppio tocco su Riprova → non crea stati incoerenti;
13. logout dal placeholder onboarding → ritorno al login;
14. logout dal placeholder home → ritorno al login;
15. doppio tocco su Esci → stato finale coerente;
16. chiudere e riaprire app con sessione valida → sessione recuperata;
17. sessione scaduta/non valida → ritorno al login;
18. refresh token o rinnovo sessione non deve far sfarfallare la UI;
19. controllo con screen reader del campo Email;
20. controllo con screen reader del campo Password;
21. controllo con screen reader del pulsante Accedi;
22. controllo con screen reader dei messaggi errore;
23. controllo con screen reader del caricamento iniziale;
24. controllo con screen reader del pulsante Riprova;
25. controllo con screen reader del pulsante Esci.
    Questi test saranno poi trasformati nel TODO operativo o in checklist manuale.

---

# 32. Ordine di implementazione consigliato

Seguire questo ordine:

1. creare cartelle `features/auth`;
2. aggiornare `AppMessages` con i messaggi mancanti;
3. creare `auth_profile_check_result.dart`;
4. creare test obbligatorio `auth_profile_check_result_test.dart`;
5. creare `auth_service.dart`;
6. creare `profile_service.dart`;
7. creare `auth_session_coordinator.dart`;
8. creare test del coordinator con fake manuali;
9. creare test o casi equivalenti per `ProfileService`;
10. creare `app_feedback_view.dart`;
11. creare test `app_feedback_view_test.dart`;
12. creare `session_gate.dart`;
13. creare test `session_gate_test.dart`;
14. creare `auth_placeholder_page.dart`;
15. creare `login_page.dart`;
16. creare test `login_page_test.dart`;
17. creare eventuale `app_root.dart`;
18. collegare tutto in `main.dart`;
19. verificare che `initialize()` sia chiamato una sola volta;
20. verificare che non ci siano listener auth duplicati;
21. eseguire `flutter analyze`;
22. eseguire `flutter test`;
23. correggere eventuali problemi;
24. eseguire test manuali minimi;
25. aggiornare `CHANGELOG.md`;
26. preparare commit.
    Regola:

```text
prima logica testabile
poi UI minima
poi collegamento in main
```

---

# 33. Criteri di completamento

Il blocco 002 è completato quando:

* l'app parte da `SessionGate`;
* lo stato `unknown` mostra caricamento accessibile;
* lo stato `unknown` con errore mostra feedback persistente e pulsante Riprova;
* l'app controlla la sessione Supabase all'avvio;
* la sessione persistente viene recuperata correttamente;
* nessun utente autenticato porta a login;
* login email/password funziona;
* logout funziona;
* doppi invii login/logout/retry sono gestiti;
* esiste un solo punto centrale di ascolto `onAuthStateChange`;
* il listener auth ha gestione `onError`;
* gli eventi auth iniziali non duplicano stati;
* `tokenRefreshed` non causa riletture inutili del profilo;
* dopo login viene letto il profilo;
* dopo login viene letta l'azienda;
* profilo assente reale porta a `authenticatedWithoutProfile`;
* profilo completo porta a `authenticatedWithProfile`;
* profilo presente senza azienda valida porta a `authenticatedWithoutProfile`;
* profilo presente con azienda_id ma azienda non leggibile porta a errore tecnico;
* errore lettura profilo non porta a onboarding;
* errore lettura profilo mostra feedback persistente;
* esiste possibilità di riprovare lettura profilo;
* i placeholder onboarding/home sono minimi e temporanei;
* il blocco non chiama `crea_azienda_e_profilo`;
* il blocco non crea onboarding reale;
* il blocco non crea home reale;
* il blocco non introduce routing complesso;
* il blocco non introduce BLoC/Riverpod/GetIt;
* tutti i messaggi importanti usano `AppMessages`;
* gli errori tecnici passano da `SupabaseErrorMapper`;
* il feedback è persistente;
* login page ha campi etichettati;
* `SessionGate` osserva sessione e feedback;
* `SessionGate` riceve callback di retry;
* i test automatici passano;
* i test manuali principali sono stati eseguiti;
* `flutter analyze` passa;
* `flutter test` passa;
* `CHANGELOG.md` è aggiornato;
* il commit è pronto.

---

# 34. Aggiornamento changelog previsto

Dopo implementazione e test, aggiornare:

```text
CHANGELOG.md
```

Voce indicativa:

```text
Aggiunta gestione login, logout e controllo sessione iniziale.
```

Note possibili:

```text
Aggiunto controllo profilo applicativo per distinguere utenti senza profilo da utenti con profilo e azienda.
```

```text
Aggiunto ascolto centrale dei cambi sessione Supabase.
```

```text
Aggiunta gestione sicura di sessione persistente, eventi auth e retry lettura profilo.
```

```text
Aggiunti placeholder temporanei per onboarding e home.
```

```text
Aggiunta schermata login minima con feedback persistente e campi accessibili.
```

```text
Aggiunti test automatici per coordinator auth, SessionGate, LoginPage e feedback persistente.
```

## Il testo definitivo del changelog verrà scritto solo dopo il codice effettivamente implementato.

# 35. Commit previsto

Commit consigliato dopo completamento del blocco:

```text
feat: aggiunge login logout e gestione sessione
```

Se il commit include anche test:

```text
feat: aggiunge auth session con test
```

Il commit deve essere eseguito solo dopo:

```text
flutter analyze
flutter test
```

## entrambi superati.

# 36. Rischi principali

## 36.1 Duplicare la logica sessione

Rischio:
login page, placeholder, main e SessionGate ascoltano tutti Supabase.
Contromisura:
un solo `AuthSessionCoordinator`.

## 36.2 Confondere profilo assente con errore lettura profilo

Rischio:
un timeout manda l'utente a onboarding.
Contromisura:
`missing` solo se query riuscita senza risultato.

## 36.3 Listener duplicati

Rischio:
`onAuthStateChange` viene ascoltato in più punti.
Contromisura:
un solo listener centrale e `dispose`.

## 36.4 Evento iniziale duplicato

Rischio:
`initialize()` legge currentUser e lo stream auth emette anche evento iniziale.
Contromisura:
metodo unico idempotente e protezione con flag/token/user id già risolto.

## 36.5 Refresh token rumoroso

Rischio:
`tokenRefreshed` fa ripartire la lettura profilo senza motivo.
Contromisura:
ignorare eventi che non cambiano utente o stato logico.

## 36.6 Errori stream non gestiti

Rischio:
errore nello stream auth diventa eccezione non gestita.
Contromisura:
listener con `onError` e mapping tramite `SupabaseErrorMapper`.

## 36.7 Stato unknown infinito

Rischio:
errore profilo lascia schermata bloccata.
Contromisura:
feedback persistente e pulsante Riprova.

## 36.8 Azienda non leggibile mascherata da onboarding

Rischio:
dato incoerente o RLS errata viene trattata come profilo incompleto.
Contromisura:
`azienda_id` presente ma azienda non leggibile → errore tecnico.

## 36.9 Placeholder che crescono troppo

Rischio:
il blocco 002 diventa onboarding/home.
Contromisura:
placeholder minimi, temporanei e senza funzioni gestionali.

## 36.10 Test instabili

Rischio:
test automatici dipendono da Supabase reale.
Contromisura:
fake manuali e nessuna rete nei test automatici.

## 36.11 Accessibilità insufficiente

Rischio:
NVDA/screen reader non leggono errori o campi.
Contromisura:
etichette chiare, feedback persistente, testo visibile.

## 36.12 Architettura troppo pesante

Rischio:
introdurre pattern grandi prima del necessario.
Contromisura:
controller semplici, ValueNotifier già presenti nel core, dipendenze via costruttore.
-------------------------------------------------------------------------------------

# 37. Decisioni finali integrate

Le revisioni dei consiglieri AI hanno confermato l'impianto generale del documento.
Sono state integrate le seguenti decisioni:

1. mantenere `AuthSessionCoordinator` come unico punto centrale;
2. mantenere `AuthService` e `ProfileService`;
3. mantenere `AuthProfileCheckResult`;
4. mantenere `SessionGate`;
5. mantenere `AppFeedbackView`;
6. mantenere la struttura `application/data/domain/presentation`;
7. non aggiungere nuovi stati ad `AppSessionStatus`;
8. documentare il doppio uso dello stato `unknown`;
9. chiarire gestione inizializzazione Supabase e stream auth;
10. aggiungere gestione `onError` al listener auth;
11. ignorare `tokenRefreshed` quando non cambia lo stato logico;
12. rendere esplicito il collegamento `SessionGate → retryProfileCheck`;
13. chiarire osservazione congiunta di sessione e feedback;
14. rendere `signInWithPassword` un contratto successo/errore, non successo/null;
15. chiarire che `azienda_id` presente ma azienda non leggibile è errore tecnico;
16. rendere obbligatorio il test `AuthProfileCheckResult`;
17. aggiungere test `ProfileService` o test equivalenti nel coordinator;
18. aggiungere test esplicito di `retryProfileCheck`;
19. aggiungere test doppi invii;
20. rafforzare test `AppFeedbackView` e Semantics;
21. non introdurre GetIt, Riverpod, BLoC o router complessi;
22. non creare onboarding reale;
23. non creare home reale;
24. non chiamare `crea_azienda_e_profilo`.
    Le domande aperte della bozza iniziale risultano risolte.
    Il documento può essere considerato approvato.

---

# 38. Stato del documento

Stato:

```text
APPROVATO
```

Questo documento è pronto per essere salvato come:

```text
docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
```

Il prossimo documento da preparare sarà:

```text
docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md
```

Solo dopo il TODO operativo approvato verrà preparato il prompt rigido per Antigravity.
