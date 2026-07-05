# DESIGN AUTH SESSION MVP 1.0

## Gestionale Magazzino Universale

Versione: 1.0.0
Stato: APPROVATO
Data: 5 luglio 2026
-------------------

# 1. Scopo del documento

Questo documento definisce il design del blocco 002 della fase Flutter MVP 1.0:

```text
Login, logout e sessione
```

Il blocco 002 viene dopo il blocco 001:

```text
Core Dart minimo
```

Il core Dart minimo ha preparato:

* messaggi centralizzati;
* errori applicativi;
* mapper errori Supabase;
* feedback persistente;
* accessibilità minima;
* stato sessione;
* controller sessione;
* test automatici.
  Il blocco 002 usa questi strumenti per iniziare a rendere l'app realmente utilizzabile.
  Lo scopo del blocco 002 è permettere all'app di:
* capire se l'utente è autenticato;
* mostrare il login se l'utente non è autenticato;
* eseguire il login con email e password;
* eseguire il logout;
* controllare se l'utente autenticato ha già un profilo applicativo;
* controllare se il profilo è collegato a un'azienda valida;
* decidere se l'utente deve andare a login, onboarding o home;
* gestire sessione scaduta o non più valida;
* mostrare messaggi chiari e accessibili;
* non mostrare errori tecnici grezzi.
  Questo documento è un documento di design.
  Non contiene ancora il codice.
  Non è ancora il coding plan.
  Non è ancora il TODO operativo.

---

# 2. Nome del file

Il file deve essere salvato come:

```text
docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
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
docs/4-flutter/3-todos/000-todo-master.md
```

In caso di dubbio, prevalgono:

1. regole backend;
2. API Contracts;
3. Flutter plan;
4. design core;
5. questo documento.

---

# 4. Riassunto logico del blocco

Il blocco 002 costruisce la porta d'ingresso dell'app.
In modo semplice, deve rispondere a queste domande:

```text
Chi sta usando l'app?
È già autenticato?
Ha un profilo nel gestionale?
Ha un'azienda collegata?
Dove deve andare adesso?
```

Le risposte possibili sono:

```text
nessun utente autenticato → login
utente autenticato senza profilo → onboarding
utente autenticato con profilo e azienda → home
```

Il blocco 002 non costruisce ancora tutto il gestionale.
Costruisce il punto in cui l'app capisce chi è l'utente e quale schermata deve essere mostrata.
-----------------------------------------------------------------------------------------------

# 5. Concetti fondamentali

## 5.1 Utente Supabase

L'utente Supabase è l'utente autenticato tramite Supabase Auth.
È l'identità tecnica.
Esempio:

```text
email: utente@example.com
id Supabase: uuid dell'utente
```

Supabase Auth può dire:

```text
questo utente è autenticato
```

oppure:

```text
nessun utente è autenticato
```

## 5.2 Profilo applicativo

Il profilo applicativo è il record del gestionale collegato all'utente Supabase.
Non basta essere autenticati su Supabase.
Per usare il gestionale, l'utente deve avere anche un profilo applicativo.
Esempio:

```text
utente Supabase autenticato
↓
profilo nella tabella profili
↓
azienda collegata
```

## 5.3 Azienda

L'azienda rappresenta il negozio o l'attività che usa il gestionale.
Nel nostro MVP 1 ogni profilo operativo appartiene a una azienda.
Per questo, dopo il login, l'app deve sapere anche:

```text
qual è l'azienda corrente?
```

Se il profilo esiste ma non è collegato a una azienda valida, per l'MVP 1 il profilo non è considerato completo.

## 5.4 Sessione applicativa

La sessione applicativa è lo stato interno dell'app.
Non è solo "utente autenticato sì/no".
È più precisa.
Gli stati già previsti dal core sono:

```text
unknown
unauthenticated
authenticatedWithoutProfile
authenticatedWithProfile
```

Significato:

* `unknown`: l'app sta ancora controllando;
* `unauthenticated`: nessun utente autenticato;
* `authenticatedWithoutProfile`: utente autenticato ma senza profilo applicativo completo;
* `authenticatedWithProfile`: utente autenticato con profilo e azienda.
  Non servono nuovi stati nel core per il blocco 002.
  Il blocco 002 deve usare correttamente gli stati già esistenti.

---

# 6. Obiettivi del blocco 002

Il blocco 002 deve:

* controllare la sessione Supabase all'avvio;
* leggere lo stato dell'utente autenticato;
* ascoltare in un punto centrale i cambi di sessione Supabase;
* leggere il profilo applicativo dell'utente autenticato;
* distinguere profilo assente da errore durante la lettura profilo;
* leggere l'azienda collegata al profilo;
* gestire il caso profilo presente ma azienda mancante o non valida;
* aggiornare `AppSessionController`;
* mostrare login se l'utente non è autenticato;
* permettere login con email e password;
* permettere logout;
* gestire sessione scaduta o non più valida;
* tradurre errori tecnici tramite `SupabaseErrorMapper`;
* mostrare feedback persistenti tramite il sistema del core;
* annunciare messaggi importanti allo screen reader quando utile;
* usare messaggi centralizzati da `AppMessages`;
* evitare duplicazioni della logica sessione nelle schermate;
* aggiungere test automatici adeguati;
* prevedere test manuale con utenti Supabase reali.

---

# 7. Cosa NON deve fare il blocco 002

Il blocco 002 non deve:

* creare onboarding completo;
* creare home completa;
* creare categorie;
* creare fornitori;
* creare prodotti;
* creare movimenti;
* creare storico movimenti;
* creare scanner barcode;
* creare gestione immagini;
* creare report;
* modificare SQL;
* modificare RLS;
* modificare RPC;
* modificare la logica di scorta;
* inserire movimenti direttamente;
* modificare direttamente `prodotti.scorta_attuale`;
* chiamare la RPC `crea_azienda_e_profilo`;
* usare service role key;
* bypassare le RLS;
* introdurre router complessi;
* introdurre BLoC;
* introdurre Riverpod;
* introdurre GetIt;
* introdurre service locator;
* creare architettura pesante.
  Il blocco 002 deve restare concentrato su:

```text
login
logout
controllo sessione
controllo profilo
decisione login/onboarding/home
```

---

# 8. Flusso principale all'apertura dell'app

Quando l'app si apre, deve partire da uno stato sicuro.
Schema:

```text
apertura app
↓
stato sessione = unknown
↓
mostra caricamento accessibile
↓
controllo sessione Supabase
↓
se nessun utente → unauthenticated → login
↓
se utente presente → controllo profilo applicativo
↓
se profilo assente → authenticatedWithoutProfile → onboarding o placeholder onboarding
↓
se profilo presente con azienda → authenticatedWithProfile → home o placeholder home
```

Questo controllo deve avvenire in un punto centrale.
Non deve essere duplicato in più schermate.
La UI deve limitarsi a osservare lo stato sessione e mostrare la schermata corretta.

## 8.1 Stato unknown

Durante lo stato:

```text
unknown
```

l'app non deve mostrare per errore il login per un attimo.
L'app non deve mostrare una schermata bianca.
Deve mostrare un caricamento accessibile.
Esempi di testo:

```text
Controllo sessione in corso.
```

oppure:

```text
Caricamento in corso.
```

## Questo evita confusione, soprattutto con screen reader.

# 9. Flusso login

Il flusso login deve essere semplice.
Schema:

```text
utente apre schermata login
↓
inserisce email
↓
inserisce password
↓
preme Accedi
↓
validazione campi
↓
chiamata Supabase Auth
↓
se errore → messaggio persistente
↓
se successo → controllo profilo
↓
decisione onboarding/home
```

## 9.1 Validazione minima

Prima di chiamare Supabase, l'app deve controllare:

* email obbligatoria;
* password obbligatoria.
  Messaggi previsti:

```text
Email obbligatoria.
Password obbligatoria.
```

Per MVP 1 non serve una validazione email complessa.
È sufficiente evitare invii vuoti.

## 9.2 Login riuscito

Se il login riesce, l'app non deve andare direttamente alla home.
Prima deve controllare il profilo.
Schema:

```text
login riuscito
↓
leggi profilo
↓
se manca profilo → onboarding o placeholder onboarding
↓
se esiste profilo con azienda → home o placeholder home
```

## 9.3 Login fallito

Se il login fallisce, l'utente deve ricevere un messaggio comprensibile.
Esempi:

```text
Email o password non corrette.
Connessione assente. Controlla Internet e riprova.
Si è verificato un errore. Riprova.
```

Gli errori tecnici non devono essere mostrati grezzi.
Devono passare da:

```text
SupabaseErrorMapper
```

## 9.4 Doppi invii

Durante il login in corso, evitare doppi invii.
Il pulsante può essere disabilitato oppure la logica può ignorare invii ripetuti.
Il coding plan definirà il modo più semplice.
---------------------------------------------

# 10. Flusso logout

Il logout deve:

* chiamare Supabase Auth per chiudere la sessione;
* aggiornare lo stato applicativo a `unauthenticated`;
* cancellare o rendere non più valido il profilo corrente in memoria;
* mostrare un feedback chiaro;
* tornare alla schermata login.
  Schema:

```text
utente preme Esci
↓
Supabase signOut
↓
AppSessionController → unauthenticated
↓
mostra login
↓
messaggio: Uscita eseguita correttamente.
```

Il logout deve essere raggiungibile almeno dalle visualizzazioni provvisorie usate dopo login.
Se la home completa non esiste ancora, può essere disponibile in un placeholder minimo.
---------------------------------------------------------------------------------------

# 11. Controllo profilo applicativo

Dopo un login riuscito o dopo il recupero di una sessione già esistente, l'app deve controllare il profilo applicativo.
La logica è:

```text
utente Supabase autenticato
↓
cerca profilo collegato all'utente
↓
se non esiste → authenticatedWithoutProfile
↓
se esiste → recupera azienda
↓
se azienda valida → authenticatedWithProfile
```

Il controllo deve rispettare le RLS.
Flutter non deve aggirare le regole del backend.
Il controllo deve usare solo dati accessibili all'utente autenticato.

## 11.1 Profilo assente

Se il profilo non esiste e la lettura profilo è avvenuta correttamente:

```text
stato = authenticatedWithoutProfile
```

Questo non è un errore tecnico.
Significa che l'utente deve completare onboarding.
Il blocco 002 non deve implementare onboarding completo.
Può mostrare un placeholder accessibile che dica:

```text
Profilo non ancora creato.
Il flusso onboarding sarà implementato nel blocco successivo.
```

oppure può predisporre il punto di ingresso che il blocco 003 completerà.
La scelta precisa verrà definita nel coding plan.

## 11.2 Profilo presente

Se il profilo esiste ed è collegato a una azienda valida:

```text
stato = authenticatedWithProfile
```

L'app deve prepararsi a mostrare home.
Il blocco 002 non deve implementare home completa.
Può mostrare un placeholder accessibile che dica:

```text
Accesso completato.
La home sarà implementata nel blocco 004.
```

oppure può predisporre il punto di ingresso che il blocco 004 completerà.
La scelta precisa verrà definita nel coding plan.

## 11.3 Profilo presente ma azienda mancante

Se il profilo esiste ma non è collegato a una azienda valida, per l'MVP 1 il profilo non è completo.
In questo caso l'app deve trattare l'utente come:

```text
authenticatedWithoutProfile
```

oppure come ramo di completamento profilo/onboarding.
Non serve aggiungere un nuovo stato nel core.
Regola:

```text
profilo senza azienda valida → profilo applicativo incompleto
```

Il coding plan definirà la soluzione più semplice.

## 11.4 Errore durante lettura profilo

Il blocco 002 deve distinguere sempre:

```text
profilo assente
```

da:

```text
errore durante la lettura del profilo
```

Sono due casi diversi.
Se la query viene eseguita correttamente e non trova profilo, allora l'utente va verso onboarding.
Se invece la query fallisce per rete, timeout, RLS o errore server, l'app non deve concludere che il profilo manca.
In caso di errore lettura profilo:

* non impostare automaticamente `authenticatedWithoutProfile`;
* mostrare feedback persistente;
* usare `SupabaseErrorMapper`;
* permettere di riprovare;
* non mandare l'utente erroneamente in onboarding.
  Esempi di messaggi:

```text
Connessione assente. Controlla Internet e riprova.
```

oppure:

```text
Si è verificato un errore. Riprova.
```

## Questa distinzione è obbligatoria.

# 12. Punto centrale di decisione schermata

Serve un punto centrale che osservi `AppSessionController` e decida cosa mostrare.
Lo schema logico è:

```text
unknown → caricamento accessibile
unauthenticated → login
authenticatedWithoutProfile → onboarding placeholder o punto di ingresso onboarding
authenticatedWithProfile → home placeholder o punto di ingresso home
```

Questo punto centrale è importante perché evita duplicazioni.
Non vogliamo che ogni schermata decida da sola cosa fare con la sessione.
La decisione deve essere unica e leggibile.
Il nome del file e la forma precisa saranno decisi nel coding plan.
Possibili nomi concettuali:

```text
AppSessionGate
SessionGate
AuthGate
```

La cosa importante non è il nome.
La cosa importante è il ruolo:

```text
guardare lo stato sessione e mostrare il ramo corretto
```

## 12.1 Placeholder gestiti dal punto centrale

I placeholder onboarding/home devono essere minimi e temporanei.
Non devono diventare schermate definitive.
La soluzione preferita è che siano gestiti dal punto centrale di decisione, senza creare una struttura grande.
Il blocco 002 deve permettere di verificare i tre rami:

```text
login
onboarding non ancora implementato
home non ancora implementata
```

## ma non deve costruire onboarding reale né home reale.

# 13. Schermata login

Nel blocco 002 deve esistere una schermata login minima e accessibile.
Deve contenere:

* campo email;
* campo password;
* pulsante Accedi;
* eventuale indicatore di caricamento;
* area feedback persistente;
* testo chiaro per errori e successi.

## 13.1 Campo email

Il campo email deve avere etichetta chiara:

```text
Email
```

Non basta un placeholder visivo.

## 13.2 Campo password

Il campo password deve avere etichetta chiara:

```text
Password
```

La password deve essere oscurata.

## 13.3 Pulsante Accedi

Il pulsante deve essere leggibile dallo screen reader come:

```text
Accedi
```

Durante il caricamento, evitare doppi invii.
Il pulsante può essere disabilitato oppure la logica può ignorare invii ripetuti.

## 13.4 Feedback persistente

Gli errori non devono essere mostrati solo con snackbar temporaneo.
Deve esserci un feedback persistente leggibile.
Esempio:

```text
Email o password non corrette.
```

## Questo feedback deve essere visibile e leggibile dallo screen reader.

# 14. Schermate provvisorie per onboarding e home

Il blocco 002 non deve creare onboarding reale e home reale.
Però, per verificare il flusso sessione, può servire una visualizzazione minima dopo il login.
Sono ammessi placeholder solo se:

* sono semplici;
* sono chiaramente temporanei;
* sono gestiti dal punto centrale di decisione o da struttura minima equivalente;
* non contengono funzionalità gestionali;
* non anticipano il blocco onboarding;
* non anticipano il blocco home;
* permettono eventualmente logout per testare il flusso.
  Esempio placeholder onboarding:

```text
Profilo non ancora creato.
Il flusso onboarding sarà implementato nel blocco successivo.
```

Esempio placeholder home:

```text
Accesso completato.
La home sarà implementata nel blocco 004.
```

Questi placeholder non devono diventare schermate definitive.
Il coding plan deciderà se crearli come widget minimi o se usare una struttura ancora più semplice.
Regole:

```text
non creare form onboarding
non creare dashboard
non creare menu gestionale
non creare navigazione definitiva
```

---

# 15. Uso del core 001

Il blocco 002 deve usare il core già creato.

## 15.1 AppMessages

Tutti i messaggi utente importanti devono venire da:

```text
AppMessages
```

Esempi:

```text
Email obbligatoria.
Password obbligatoria.
Email o password non corrette.
Accesso eseguito correttamente.
Uscita eseguita correttamente.
Connessione assente. Controlla Internet e riprova.
Sessione scaduta. Accedi di nuovo.
```

Non scrivere messaggi importanti sparsi nelle schermate.

## 15.2 SupabaseErrorMapper

Gli errori tecnici devono passare da:

```text
SupabaseErrorMapper
```

Esempio:

```text
AuthException tecnico
↓
Email o password non corrette.
```

## 15.3 AppFeedbackController

La schermata login e il flusso sessione devono usare feedback persistente.
Esempio:

```text
showError(...)
showSuccess(...)
clear()
```

## 15.4 AccessibilityService

I messaggi importanti possono essere annunciati allo screen reader.
Regola:

```text
prima feedback persistente
poi eventuale annuncio
```

L'annuncio non sostituisce il messaggio visibile.

## 15.5 AppSessionController

Il blocco 002 deve aggiornare:

```text
AppSessionController
```

Esempi:

```text
setUnauthenticated()
setAuthenticatedWithoutProfile(...)
setAuthenticatedWithProfile(...)
```

## Il controller deve essere aggiornato da un punto centrale, non da logiche duplicate in più schermate.

# 16. Gestione degli errori

Gli errori devono essere semplici per l'utente.

## 16.1 Credenziali errate

Messaggio:

```text
Email o password non corrette.
```

## 16.2 Connessione assente

Messaggio:

```text
Connessione assente. Controlla Internet e riprova.
```

## 16.3 Sessione scaduta

Messaggio:

```text
Sessione scaduta. Accedi di nuovo.
```

Se Supabase segnala che l'utente non è più autenticato durante l'uso, l'app deve:

* aggiornare `AppSessionController` a `unauthenticated`;
* mostrare login;
* mostrare messaggio persistente;
* non lasciare l'utente in una schermata protetta.

## 16.4 Profilo non trovato

Profilo non trovato non è automaticamente un errore tecnico.
Può significare:

```text
utente autenticato ma onboarding non ancora completato
```

Quindi lo stato corretto è:

```text
authenticatedWithoutProfile
```

Questa regola vale solo se la lettura profilo è riuscita.

## 16.5 Errore lettura profilo

Errore lettura profilo significa che l'app non è riuscita a controllare correttamente.
Non deve essere trattato come profilo assente.
In questo caso:

* mostrare feedback persistente;
* usare `SupabaseErrorMapper`;
* permettere riprova;
* non mandare automaticamente a onboarding.

## 16.6 Profilo senza azienda valida

Profilo presente ma azienda mancante o non valida significa profilo applicativo incompleto per MVP 1.
Lo stato può restare:

```text
authenticatedWithoutProfile
```

oppure ramo equivalente di completamento profilo/onboarding.
Non serve creare un nuovo stato nel core.

## 16.7 Errore non riconosciuto

Messaggio:

```text
Si è verificato un errore. Riprova.
```

---

# 17. Accessibilità

L'accessibilità resta obbligatoria.
Il blocco 002 deve rispettare:

* campi con etichette chiare;
* pulsanti con testo chiaro;
* feedback persistente;
* messaggi non solo visivi;
* niente errori comunicati solo tramite colore;
* ordine logico del focus;
* testi comprensibili;
* schermata usabile con screen reader;
* caricamento iniziale non muto;
* pulsante logout chiaramente leggibile nei placeholder, se presente.

## 17.1 Login accessibile

Lo screen reader deve permettere di capire:

* dove inserire email;
* dove inserire password;
* quale pulsante premere;
* se c'è un errore;
* se il login è riuscito;
* se l'app sta caricando.

## 17.2 Feedback accessibile

Quando avviene un errore:

```text
Email o password non corrette.
```

il messaggio deve rimanere in schermata.
Può anche essere annunciato.
Non deve sparire subito.

## 17.3 Caricamento accessibile

Durante il controllo iniziale, evitare schermate mute.
Una schermata di caricamento deve avere un testo comprensibile:

```text
Controllo sessione in corso.
```

oppure:

```text
Caricamento in corso.
```

## 17.4 Focus e ordine logico

La schermata login deve essere percorribile in modo naturale:

```text
titolo
campo email
campo password
pulsante Accedi
feedback persistente
```

## L'ordine preciso sarà definito nel coding plan, ma non deve risultare confuso con screen reader.

# 18. Sicurezza

Il blocco 002 deve rispettare le regole di sicurezza del progetto.
Flutter deve usare solo la chiave pubblica prevista per il client.
Flutter non deve usare:

```text
service role key
```

Flutter non deve bypassare:

```text
RLS
```

Flutter non deve fidarsi di dati locali come verità definitiva.
La verità resta il backend.
Il controllo profilo e azienda deve leggere dati tramite le policy consentite.
La password non deve essere salvata localmente dal nostro codice.
I test automatici non devono usare Supabase reale.
--------------------------------------------------

# 19. Stato e caricamento

Durante login, logout e controllo sessione, devono essere gestiti gli stati di caricamento.
Obiettivo:

* evitare doppi click;
* evitare schermate confuse;
* evitare stato bloccato su caricamento;
* dare feedback all'utente;
* evitare schermata bianca;
* evitare flash del login mentre la sessione è ancora in controllo.
  Possibili stati interni:

```text
controllo iniziale in corso
login in corso
logout in corso
lettura profilo in corso
```

Il design non impone ancora una classe specifica per questi stati.
Il coding plan definirà il modo più semplice per gestirli.
----------------------------------------------------------

# 20. Persistenza sessione

Supabase Auth gestisce la persistenza della sessione.
Il nostro codice deve:

* leggere la sessione corrente all'avvio;
* reagire in modo coerente se la sessione esiste;
* tornare al login se la sessione non esiste o non è valida;
* non salvare manualmente password;
* non creare un sistema parallelo di autenticazione.

---

# 21. Ascolto cambi sessione

Il blocco 002 deve prevedere un ascolto centrale dei cambi Auth di Supabase.
Esempio:

```text
utente fa logout
↓
sessione Supabase cambia
↓
AppSessionController viene aggiornato
```

La regola è:

```text
un solo punto centrale deve occuparsi dei cambi sessione
```

Non vogliamo listener sparsi in più schermate.
L'ascolto centrale deve aggiornare:

```text
AppSessionController
```

Deve gestire almeno:

```text
utente entrato
utente uscito
sessione non più valida
```

Il coding plan definirà il file e la forma più semplice.
Non deve diventare:

* sistema complesso di routing;
* service locator;
* framework di stato globale;
* listener duplicato in ogni pagina.

---

# 22. Registrazione nuovo utente

La registrazione di nuovi utenti non fa parte del blocco 002, salvo decisione diversa successiva.
Per MVP 1, il blocco 002 si concentra su:

```text
login con utente già esistente
logout
controllo sessione
controllo profilo
```

La creazione utente potrà essere decisa in un blocco futuro se necessaria.
L'onboarding invece riguarda un utente già autenticato che deve creare azienda e profilo applicativo.
-----------------------------------------------------------------------------------------------------

# 23. Rapporto con onboarding

Il blocco 003 sarà onboarding.
Il blocco 002 deve solo riconoscere questo caso:

```text
utente autenticato senza profilo completo
```

e portare lo stato a:

```text
authenticatedWithoutProfile
```

Non deve chiamare la RPC:

```text
crea_azienda_e_profilo
```

Quella RPC appartiene al blocco onboarding.
Il blocco 002 può solo mostrare un placeholder o un punto di ingresso temporaneo.
---------------------------------------------------------------------------------

# 24. Rapporto con home

Il blocco 004 sarà home.
Il blocco 002 deve solo riconoscere questo caso:

```text
utente autenticato con profilo e azienda
```

e portare lo stato a:

```text
authenticatedWithProfile
```

Non deve costruire dashboard, menu completo o funzioni gestionali.
Il blocco 002 può solo mostrare un placeholder o un punto di ingresso temporaneo.
---------------------------------------------------------------------------------

# 25. Possibile struttura logica

Questo documento non blocca ancora i nomi dei file.
Tuttavia il blocco avrà probabilmente bisogno di alcuni pezzi logici:

* servizio o controller per Auth Supabase;
* servizio o funzione per lettura profilo e azienda;
* controller o stato per login;
* schermata login;
* punto centrale di decisione sessione;
* ascolto centrale di `onAuthStateChange`;
* placeholder minimi onboarding/home;
* test automatici.
  Il coding plan dovrà trasformare questi concetti in file precisi.
  La struttura deve restare semplice.
  Non creare architettura più grande del necessario.

---

# 26. Test automatici previsti

Anche il blocco 002 deve nascere con test.
I test automatici devono coprire soprattutto la logica.
Esempi di test:

* email vuota → messaggio email obbligatoria;
* password vuota → messaggio password obbligatoria;
* login fallito → feedback errore;
* errore Supabase Auth → messaggio tradotto;
* nessuna sessione → stato `unauthenticated`;
* sessione con utente ma profilo assente → stato `authenticatedWithoutProfile`;
* sessione con utente, profilo e azienda → stato `authenticatedWithProfile`;
* profilo esistente ma azienda mancante → stato `authenticatedWithoutProfile`;
* errore rete durante lettura profilo → feedback errore e nessun passaggio automatico a onboarding;
* logout riuscito → stato `unauthenticated`;
* `onAuthStateChange` segnala logout/sessione non valida → stato `unauthenticated`;
* errore rete → messaggio connessione assente;
* `AppSessionController` aggiornato correttamente dopo login, logout e controllo profilo;
* campo email etichettato;
* campo password etichettato;
* pulsante Accedi presente e leggibile;
* messaggio errore persistente.
  I test automatici non devono chiamare Supabase reale.
  Dove serve, usare fake, mock o simulazioni controllate.
  Regola:

```text
unit test = simulati
test manuali = Supabase reale
```

---

# 27. Test manuali previsti

Oltre ai test automatici, serviranno test manuali con Supabase reale.
Esempi:

* aprire app senza sessione → appare login;
* avvio app durante controllo sessione → appare caricamento accessibile;
* login con credenziali errate → messaggio corretto;
* login con utente valido senza profilo → onboarding o placeholder onboarding;
* login con utente valido con profilo e azienda → home o placeholder home;
* profilo presente ma azienda mancante → ramo onboarding/completamento profilo;
* errore rete durante lettura profilo → messaggio errore e possibilità di riprova;
* logout → ritorno al login;
* sessione scaduta o non più valida → ritorno al login con messaggio;
* chiudere e riaprire app con sessione valida → stato recuperato;
* controllo con screen reader dei campi login;
* controllo con screen reader dei messaggi di errore;
* controllo con screen reader del caricamento iniziale;
* controllo con screen reader del pulsante logout nei placeholder, se presente.
  I test manuali devono essere guidati da un test plan o da un TODO specifico.

---

# 28. Rischi da evitare

## 28.1 Duplicare la logica sessione

Rischio:
ogni schermata controlla da sola login/profilo/azienda.
Contromisura:
un solo punto centrale decide lo stato sessione.

## 28.2 Anticipare onboarding

Rischio:
il blocco 002 inizia a creare azienda e profilo.
Contromisura:
onboarding reale appartiene al blocco 003.

## 28.3 Anticipare home

Rischio:
il blocco 002 costruisce dashboard e menu definitivi.
Contromisura:
home reale appartiene al blocco 004.

## 28.4 Mostrare errori tecnici

Rischio:
l'utente vede errori Supabase grezzi.
Contromisura:
usare sempre `SupabaseErrorMapper`.

## 28.5 Feedback solo temporaneo

Rischio:
errore mostrato solo con snackbar che sparisce.
Contromisura:
feedback persistente in schermata.

## 28.6 Accessibilità rimandata

Rischio:
i campi login non sono letti bene dallo screen reader.
Contromisura:
etichette chiare e feedback leggibile subito.

## 28.7 Test con Supabase reale

Rischio:
test automatici instabili e dipendenti da rete/backend.
Contromisura:
test automatici con fake o simulazioni; test manuali separati con Supabase reale.

## 28.8 Architettura troppo grande

Rischio:
introdurre framework o pattern pesanti troppo presto.
Contromisura:
soluzione semplice e coerente con MVP 1.

## 28.9 Confondere profilo assente con errore lettura profilo

Rischio:
un errore di rete o server viene interpretato come profilo mancante.
Contromisura:
distinguere sempre query riuscita senza risultato da query fallita.
Solo il profilo assente reale porta a `authenticatedWithoutProfile`.

## 28.10 Listener sessione duplicati

Rischio:
più schermate ascoltano Supabase Auth e aggiornano lo stato in modi diversi.
Contromisura:
un solo ascolto centrale di `onAuthStateChange`.

## 28.11 Placeholder che diventano schermate permanenti

Rischio:
i placeholder onboarding/home crescono e diventano schermate definitive non progettate.
Contromisura:
placeholder minimi, temporanei e chiaramente limitati.

## 28.12 Stato unknown gestito male

Rischio:
l'app mostra login per un attimo anche se l'utente ha una sessione valida, oppure mostra schermata bianca.
Contromisura:
durante `unknown`, mostrare caricamento accessibile.
----------------------------------------------------

# 29. Criterio di completamento del blocco 002

Il blocco 002 sarà completato quando:

* l'app controlla la sessione all'avvio;
* durante `unknown` viene mostrato caricamento accessibile;
* l'app mostra login se non c'è utente autenticato;
* il login con email/password funziona;
* il logout funziona;
* esiste un ascolto centrale dei cambi sessione Supabase;
* dopo login viene controllato il profilo applicativo;
* profilo assente viene distinto da errore lettura profilo;
* errore lettura profilo mostra feedback persistente e permette riprova;
* profilo presente ma azienda mancante viene trattato come profilo incompleto;
* utente senza profilo completo porta a stato `authenticatedWithoutProfile`;
* utente con profilo e azienda porta a stato `authenticatedWithProfile`;
* sessione scaduta o non valida porta a `unauthenticated`;
* errori tecnici vengono tradotti in messaggi utente;
* feedback persistente è presente;
* accessibilità base del login è rispettata;
* i placeholder onboarding/home, se creati, restano minimi e temporanei;
* non sono state create funzioni gestionali fuori scope;
* non è stato implementato onboarding reale;
* non è stata implementata home reale;
* test automatici del blocco passano;
* test manuali principali sono eseguibili;
* `flutter analyze` passa;
* `flutter test` passa;
* changelog aggiornato;
* commit eseguito.

---

# 30. Aggiornamento changelog previsto

Quando il blocco 002 sarà implementato, aggiornare:

```text
CHANGELOG.md
```

Voce futura indicativa:

```text
Aggiunta gestione login, logout e controllo sessione iniziale.
```

Possibile nota:

```text
Aggiunto controllo profilo applicativo per distinguere utenti senza profilo da utenti con profilo e azienda.
```

Possibile nota aggiuntiva:

```text
Aggiunto ascolto centrale dei cambi sessione Supabase e gestione sessione non più valida.
```

## Il changelog definitivo verrà scritto dopo il codice, non in questo documento di design.

# 31. Revisione AI

Questo documento è stato revisionato tramite confronto con:

* ChatGPT;
* Gemini;
* DeepSeek;
* Claude.
  Il giro di revisione ha prodotto giudizio complessivo:

```text
APPROVATO CON MODIFICHE MIRATE
```

Le modifiche integrate hanno riguardato:

* distinzione tra profilo assente ed errore lettura profilo;
* decisione di usare `onAuthStateChange` in un solo punto centrale;
* gestione della sessione scaduta o non più valida;
* gestione del caso profilo presente ma azienda mancante;
* rafforzamento dello stato `unknown` con caricamento accessibile;
* chiarimento sui placeholder onboarding/home minimi e temporanei;
* rafforzamento dei criteri di accessibilità;
* rafforzamento dei test automatici;
* aggiunta dei rischi su lettura profilo, listener duplicati, placeholder e stato unknown.
  Dopo l'integrazione di queste modifiche, non è necessario un secondo giro di revisione AI.
  Il documento può essere considerato approvato.

---

# 32. Stato del documento

Stato:

```text
APPROVATO
```

Versione:

```text
1.0.0
```

Nome file:

```text
docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
```

Documento revisionato tramite:

* ChatGPT;
* DeepSeek;
* Gemini;
* Claude.

---

# 33. Prossimo passo

Dopo l'approvazione del design, si passerà al coding plan:

```text
docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
```

Il coding plan dovrà trasformare questo design in:

* file da creare;
* file da modificare;
* responsabilità dei singoli file;
* ordine di implementazione;
* test automatici obbligatori;
* test manuali;
* criteri di completamento.

---

# 34. Conclusione

Il blocco 002 costruisce la porta d'ingresso dell'app.
Il blocco deve far capire all'app:

```text
chi è l'utente
se è autenticato
se ha un profilo
se ha un'azienda
dove deve andare
```

Il blocco non deve costruire tutto il gestionale.
Deve costruire il passaggio ordinato tra:

```text
login
onboarding
home
```

Il principio finale è:

```text
prima far entrare correttamente l'utente,
poi costruire le funzionalità gestionali.
```