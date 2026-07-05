\# CODING PLAN CORE MVP 1.0



\## Gestionale Magazzino Universale



Versione: 1.0.0

Stato: APPROVATO

Data: 5 luglio 2026



\---



\# 1. Scopo del documento



Questo documento definisce il piano di codifica del core Dart minimo dell'app Flutter del Gestionale Magazzino Universale.



Il documento traduce in passi operativi il design approvato:



`docs/4-flutter/1-design/001-DESIGN\_CORE\_mvp1\_v1.0.0.md`



Questo coding plan non contiene ancora il codice Dart completo.



Serve a stabilire:



\* quali file creare;

\* quali file non creare;

\* in quale ordine lavorare;

\* quale responsabilità avrà ogni file;

\* quali regole devono essere rispettate durante la codifica;

\* quali controlli eseguire dopo il blocco;

\* quali rischi evitare.



Questo documento precede il todo specifico:



`docs/4-flutter/3-todos/001-TODO\_CORE\_mvp1\_v1.0.0.md`



\---



\# 2. Documenti di riferimento



Questo coding plan dipende dai documenti già approvati:



```text

docs/0-architettura/001-ARCHITETTURA\_mvp1\_v1.0.0.md

docs/1-database/001-DATABASE\_SCHEMA\_mvp1\_v1.0.0.md

docs/2-flussi-applicativi/001-FLOWS\_mvp1\_v1.0.0.md

docs/3-backend/001-BACKEND\_RULES\_mvp1\_v1.0.0.md

docs/3-backend/002-API\_CONTRACTS\_mvp1\_v1.0.0.md

docs/4-flutter/001-FLUTTER\_PLAN\_mvp1\_v1.0.0.md

docs/4-flutter/1-design/001-DESIGN\_CORE\_mvp1\_v1.0.0.md

docs/4-flutter/3-todos/000-todo-master.md

```



In caso di dubbio, prevalgono:



1\. regole backend approvate;

2\. API Contracts;

3\. design core approvato;

4\. Flutter plan;

5\. questo coding plan.



\---



\# 3. Obiettivo del blocco core



L'obiettivo del blocco core è creare una base minima, semplice e riutilizzabile per tutta l'app Flutter.



Il core deve preparare:



\* messaggi centralizzati;

\* errori centralizzati;

\* feedback persistente;

\* accessibilità minima;

\* stato sessione minimo;

\* base concettuale per futuri servizi Supabase.



Il core non deve ancora costruire schermate complete.



Il core non deve ancora implementare login, onboarding, prodotti o movimenti.



\---



\# 4. Principio guida del coding plan



Il principio guida è:



```text

pochi file iniziali, ma ben scelti

```



Questo significa:



\* creare solo i file realmente utili al primo blocco;

\* non creare cartelle vuote inutili;

\* non creare file futuri solo perché previsti teoricamente;

\* non introdurre architettura pesante;

\* non introdurre subito BLoC, service locator o router complesso;

\* lasciare le funzionalità verticali ai blocchi successivi.



\---



\# 5. Stato di partenza



Il progetto Flutter esiste già nella cartella:



```text

app/

```



Sono già presenti o previsti:



```text

lib/main.dart

lib/config/supabase\_config.dart

```



Potrebbero essere ancora presenti file provvisori usati per i test backend, come:



```text

lib/pages/test\_console\_page.dart

lib/services/test\_backend\_service.dart

```



Questi file provvisori non sono l'obiettivo di questo blocco.



In questa fase non è obbligatorio rimuoverli, salvo che interferiscano con la compilazione.



La pulizia della console di test potrà essere fatta in un blocco successivo, quando verrà costruito il flusso reale dell'app.



\---



\# 6. Risultato atteso del blocco



Alla fine del blocco core dovranno esistere i file minimi per:



\* centralizzare i messaggi;

\* rappresentare errori applicativi;

\* tradurre errori tecnici in errori comprensibili;

\* rappresentare un feedback persistente;

\* gestire un feedback corrente;

\* annunciare messaggi accessibili quando necessario;

\* rappresentare lo stato sessione;

\* aggiornare lo stato sessione tramite controller semplice.



Dovrà essere possibile eseguire:



```text

flutter analyze

```



senza errori nuovi introdotti dal core.



Dovrà inoltre essere possibile eseguire:



```text

flutter test

```



con esito positivo sui test automatici minimi obbligatori di questo blocco.



I test automatici minimi non sono facoltativi.



Questo blocco non può essere considerato completato se i test minimi non esistono o non passano.



\---



\# 7. File da creare



Il primo blocco core creerà questi file di produzione:



```text

lib/core/messages/app\_messages.dart



lib/core/errors/app\_exception.dart

lib/core/errors/supabase\_error\_mapper.dart



lib/core/feedback/app\_feedback\_message.dart

lib/core/feedback/app\_feedback\_controller.dart



lib/core/accessibility/accessibility\_service.dart



lib/core/session/app\_session\_state.dart

lib/core/session/app\_session\_controller.dart

```



Questi file sono sufficienti per il primo core minimo.



Non bisogna aggiungere altri file core in questo blocco.



\---



\# 8. Cartelle da creare



Creare queste cartelle:



```text

lib/core/messages/

lib/core/errors/

lib/core/feedback/

lib/core/accessibility/

lib/core/session/

```



Non creare per ora:



```text

lib/core/services/

```



Motivazione:



il design prevede una base servizi Supabase, ma in questo primo blocco non serve ancora creare un servizio Supabase generico.



I servizi concreti verranno creati nei blocchi futuri:



\* auth/session;

\* onboarding;

\* categorie;

\* fornitori;

\* prodotti;

\* movimenti;

\* storico.



Il client Supabase è già configurato nella configurazione esistente.



\---



\# 9. File da NON creare in questo blocco



Non creare per ora:



```text

lib/core/messages/app\_error\_messages.dart

lib/core/messages/app\_accessibility\_messages.dart

lib/core/services/supabase\_service.dart

lib/core/accessibility/focus\_helpers.dart

lib/core/accessibility/accessible\_feedback.dart

```



Motivazione:



questi file potrebbero essere utili in futuro, ma non sono necessari nel primo blocco.



Per ora è meglio evitare frammentazione prematura.



Regola:



```text

se un file avrebbe solo poche righe e nessun uso reale immediato,

non crearlo ancora

```



\---



\# 10. File 1 — app\_messages.dart



Percorso:



```text

lib/core/messages/app\_messages.dart

```



\## 10.1 Scopo



Questo file contiene i messaggi utente centralizzati del core.



I messaggi devono essere:



\* semplici;

\* chiari;

\* riutilizzabili;

\* Dart puri;

\* indipendenti da `BuildContext`.



\---



\## 10.2 Regola fondamentale



Il file non deve dipendere da Flutter UI.



Non deve importare:



```text

package:flutter/material.dart

```



Non deve usare:



```text

BuildContext

```



I messaggi devono poter essere usati da:



\* controller;

\* servizi;

\* mapper errori;

\* schermate future.



\---



\## 10.3 Struttura consigliata



Usare una classe non istanziabile.



Nome consigliato:



```text

AppMessages

```



Categorie minime di messaggi:



\* generali;

\* autenticazione;

\* sessione;

\* validazione;

\* successo;

\* errori;

\* accessibilità;

\* magazzino.



\---



\## 10.4 Messaggi minimi da includere



Messaggi generali:



```text

Caricamento in corso.

Operazione completata correttamente.

Nessun risultato trovato.

```



Messaggi autenticazione/sessione:



```text

Accesso eseguito correttamente.

Uscita eseguita correttamente.

Sessione scaduta. Accedi di nuovo.

Email o password non corrette.

```



Messaggi validazione:



```text

Email obbligatoria.

Password obbligatoria.

Nome obbligatorio.

Nome azienda obbligatorio.

Quantità obbligatoria.

La quantità deve essere maggiore di zero.

```



Messaggi successo:



```text

Categoria salvata correttamente.

Fornitore salvato correttamente.

Prodotto salvato correttamente.

Movimento registrato correttamente.

```



Messaggi errore:



```text

Si è verificato un errore. Riprova.

Connessione assente. Controlla Internet e riprova.

Operazione non autorizzata.

Scorta insufficiente.

Prodotto non trovato.

Fornitore non valido.

Esiste già un elemento con questo nome.

Esiste già un prodotto con questo barcode.

```



Messaggi avviso:



```text

Attenzione: scorta inferiore al livello minimo.

Il prodotto selezionato è disattivato.

```



\---



\## 10.5 Nota sulla crescita futura



Per il core iniziale i messaggi restano in un unico file:



```text

app\_messages.dart

```



Non creare ora:



```text

app\_error\_messages.dart

app\_accessibility\_messages.dart

```



Se in futuro `app\_messages.dart` crescerà troppo, sarà possibile separare i messaggi in file dedicati.



La separazione futura dovrà avvenire solo quando diventerà realmente utile.



\---



\## 10.6 Cosa evitare



Evitare:



\* testi duplicati in altri file;

\* messaggi troppo tecnici;

\* frasi legate a una singola schermata non ancora esistente;

\* dipendenza da localizzazione avanzata;

\* dipendenza da `BuildContext`.



\---



\# 11. File 2 — app\_exception.dart



Percorso:



```text

lib/core/errors/app\_exception.dart

```



\## 11.1 Scopo



Questo file definisce un errore applicativo comprensibile.



Serve a rappresentare un errore dopo che è stato tradotto dal sistema errori.



L'utente non deve vedere errori tecnici grezzi.



\---



\## 11.2 Informazioni minime



L'errore applicativo deve contenere almeno:



\* messaggio utente;

\* dettaglio tecnico facoltativo.



\---



\## 11.3 Struttura consigliata



Nome consigliato:



```text

AppException

```



Campi minimi:



```text

message

technicalMessage

```



Dove:



\* `message` è il testo da mostrare all'utente;

\* `technicalMessage` è facoltativo e serve solo per debug o analisi.



\---



\## 11.4 Cosa evitare



Evitare:



\* gerarchie complesse di eccezioni;

\* troppi tipi di errore iniziali;

\* dipendenza da UI;

\* errori che mostrano direttamente messaggi tecnici all'utente.



\---



\# 12. File 3 — supabase\_error\_mapper.dart



Percorso:



```text

lib/core/errors/supabase\_error\_mapper.dart

```



\## 12.1 Scopo



Questo file converte errori tecnici in `AppException`.



Deve gestire:



\* errori Supabase Auth;

\* errori PostgREST;

\* errori RPC;

\* errori di rete;

\* timeout;

\* errori generici.



\---



\## 12.2 Input



Il mapper riceve un errore generico.



Esempio concettuale:



```text

Object error

```



\---



\## 12.3 Output



Il mapper restituisce:



```text

AppException

```



\---



\## 12.4 Regola sui messaggi



Il mapper non deve contenere frasi utente duplicate.



Deve usare i messaggi centralizzati in:



```text

AppMessages

```



Il mapper non è un archivio di frasi.



Il mapper decide quale messaggio centralizzato usare.



\---



\## 12.5 Gerarchia di riconoscimento degli errori



Il mapper deve riconoscere gli errori seguendo questo ordine:



```text

1\. tipo nativo dell'eccezione

2\. codice errore disponibile nell'eccezione

3\. codice PostgreSQL

4\. nome vincolo database

5\. messaggio backend previsto dagli API Contracts

6\. testo libero solo come fallback

```



Questa gerarchia evita che il mapper dipenda solo da frasi testuali fragili.



Il testo libero può essere usato, ma solo come ultima difesa.



\---



\## 12.6 Errori Auth



Per gli errori di autenticazione, il mapper deve riconoscere prima il tipo nativo Supabase, se disponibile.



Tipo atteso:



```text

AuthException

```



Casi minimi:



```text

credenziali errate

sessione scaduta

utente non autenticato

```



Messaggi utente:



```text

Email o password non corrette.

Sessione scaduta. Accedi di nuovo.

Sessione non valida. Accedi di nuovo.

```



Nota:



se l'eccezione Auth non fornisce un codice strutturato sufficiente, il messaggio testuale può essere usato come fallback.



\---



\## 12.7 Errori PostgREST e PostgreSQL



Per gli errori PostgREST, il mapper deve riconoscere prima il tipo nativo.



Tipo atteso:



```text

PostgrestException

```



Quando disponibili, usare:



```text

code

message

details

hint

```



Per violazione di vincolo unique, il codice PostgreSQL tipico è:



```text

23505

```



Questo codice indica una violazione di unicità.



Il mapper deve poi distinguere, quando possibile, il vincolo specifico.



\---



\## 12.8 Errore barcode duplicato



Il barcode duplicato deve essere riconosciuto in modo più robusto possibile.



Il vincolo database da riconoscere è:



```text

prodotti\_barcode\_unique\_per\_azienda

```



Caso logico:



```text

PostgrestException

↓

codice PostgreSQL 23505

↓

vincolo prodotti\_barcode\_unique\_per\_azienda

↓

messaggio utente:

"Esiste già un prodotto con questo barcode."

```



Se il vincolo non è disponibile nell'eccezione, il mapper può usare come fallback il testo libero.



Il fallback può controllare la presenza di parole come:



```text

barcode

unique

duplicate

```



ma solo dopo aver tentato il riconoscimento strutturato.



\---



\## 12.9 Errori duplicato generico



Per altri duplicati non specifici, il mapper può usare il messaggio generico:



```text

Esiste già un elemento con questo nome.

```



Esempi:



\* nome categoria duplicato;

\* nome fornitore duplicato;

\* altro vincolo unique non ancora distinto.



Anche in questo caso, il mapper deve preferire codice e vincolo prima del testo libero.



\---



\## 12.10 Errori RPC previsti dagli API Contracts



Il mapper deve conoscere i principali messaggi backend già previsti dalle RPC e dagli API Contracts.



Casi minimi da mappare:



```text

Utente non autenticato

Profilo non trovato

Profilo già esistente

Nome azienda obbligatorio

Tipo movimento non valido

Quantità obbligatoria

Quantità non valida

Nuova scorta obbligatoria

Nuova scorta non valida

Fornitore obbligatorio per il carico

Fornitore non consentito per questo tipo movimento

Fornitore non valido

Prodotto non trovato

Prodotto disattivato

Prezzo unitario non valido

Scorta insufficiente

La nuova scorta coincide con quella attuale

```



Questi casi devono diventare messaggi utente comprensibili.



Esempi:



```text

Scorta insufficiente

↓

Scorta insufficiente.



Prodotto non trovato

↓

Prodotto non trovato.



Prodotto disattivato

↓

Il prodotto selezionato è disattivato.



Fornitore non valido

↓

Fornitore non valido.



Profilo già esistente

↓

Il profilo risulta già creato. Ricarico i dati.

```



\---



\## 12.11 Errori autorizzazione e RLS



Casi da riconoscere:



```text

permission denied

violates row-level security

Operazione non autorizzata

```



Messaggio utente:



```text

Operazione non autorizzata.

```



Anche qui, il mapper deve preferire codice o tipo eccezione quando disponibili.



Il testo libero resta fallback.



\---



\## 12.12 Errori di rete e timeout



Gli errori di rete possono avvenire prima ancora che Supabase risponda.



Casi minimi:



```text

assenza rete

timeout

errore di connessione

failed host lookup

connection failed

network error

```



Messaggio utente:



```text

Connessione assente. Controlla Internet e riprova.

```



Nota tecnica:



in base alla piattaforma Flutter, il tipo dell'errore può cambiare.



Per questo motivo il mapper deve prevedere sia controlli strutturati, quando disponibili, sia fallback testuale.



Non introdurre però una dipendenza fragile da un solo tipo di eccezione se il progetto dovrà funzionare su più piattaforme.



\---



\## 12.13 Errore non riconosciuto



Per qualsiasi errore non riconosciuto, il mapper deve restituire un errore generico.



Messaggio utente:



```text

Si è verificato un errore. Riprova.

```



Il dettaglio tecnico può essere conservato in:



```text

technicalMessage

```



ma non deve essere mostrato direttamente all'utente finale.



\---



\## 12.14 Import previsti



Il file potrà importare:



```text

package:supabase\_flutter/supabase\_flutter.dart

```



e i file core necessari:



```text

app\_messages.dart

app\_exception.dart

```



Se servirà riconoscere timeout o errori base Dart, si potranno usare import standard Dart compatibili con la piattaforma target.



Evitare import non compatibili con tutti i target Flutter previsti, salvo necessità reale.



\---



\## 12.15 Cosa evitare



Evitare:



\* mostrare errori tecnici grezzi;

\* duplicare stringhe già presenti in `AppMessages`;

\* creare eccezioni complesse non necessarie;

\* basarsi solo su string matching;

\* introdurre logging avanzato in questo blocco.



\---



\# 13. File 4 — app\_feedback\_message.dart



Percorso:



```text

lib/core/feedback/app\_feedback\_message.dart

```



\## 13.1 Scopo



Questo file definisce la struttura del feedback persistente.



Il feedback non deve essere solo una stringa.



Deve avere almeno un significato.



\---



\## 13.2 Tipi di feedback



Creare un tipo semplice per distinguere:



```text

successo

errore

avviso

informazione

```



Nome consigliato:



```text

AppFeedbackType

```



Valori consigliati:



```text

success

error

warning

info

```



\---



\## 13.3 Struttura del messaggio



Nome consigliato:



```text

AppFeedbackMessage

```



Campi minimi:



```text

text

type

accessibilityText

shouldAnnounce

```



Dove:



\* `text` è il messaggio visibile;

\* `type` indica successo, errore, avviso o informazione;

\* `accessibilityText` è facoltativo;

\* `shouldAnnounce` indica se il messaggio dovrebbe essere annunciato allo screen reader.



\---



\## 13.4 Regola accessibilità



Se `accessibilityText` non è presente, il testo accessibile coincide con il testo visibile.



\---



\## 13.5 Cosa evitare



Evitare:



\* feedback solo temporaneo;

\* feedback privo di tipo;

\* feedback solo visivo;

\* dipendenza da widget Flutter.



\---



\# 14. File 5 — app\_feedback\_controller.dart



Percorso:



```text

lib/core/feedback/app\_feedback\_controller.dart

```



\## 14.1 Scopo



Questo file gestisce il feedback corrente.



Serve a permettere alle schermate future di mostrare un messaggio persistente.



\---



\## 14.2 Struttura consigliata



Usare una soluzione semplice.



Nome consigliato:



```text

AppFeedbackController

```



Può estendere:



```text

ValueNotifier<AppFeedbackMessage?>

```



oppure usare una struttura equivalente semplice.



\---



\## 14.3 Responsabilità



Il controller deve permettere di:



\* impostare un messaggio;

\* cancellare un messaggio;

\* impostare messaggi di successo;

\* impostare messaggi di errore;

\* impostare messaggi di avviso;

\* impostare messaggi informativi.



Esempi di metodi possibili:



```text

showSuccess(...)

showError(...)

showWarning(...)

showInfo(...)

clear()

```



Il coding effettivo potrà scegliere nomi equivalenti, purché chiari.



\---



\## 14.4 Cosa non deve fare



Non deve:



\* disegnare UI;

\* mostrare snackbar;

\* creare overlay;

\* gestire code complesse di messaggi;

\* decidere layout;

\* dipendere da Supabase.



Il controller gestisce lo stato del feedback.



La schermata futura deciderà come mostrarlo.



\---



\# 15. File 6 — accessibility\_service.dart



Percorso:



```text

lib/core/accessibility/accessibility\_service.dart

```



\## 15.1 Scopo



Questo file centralizza eventuali annunci accessibili.



Serve a evitare chiamate sparse a strumenti di annuncio dentro le schermate.



\---



\## 15.2 Regola fondamentale



L'annuncio vocale non sostituisce il messaggio persistente.



Regola:



```text

prima messaggio visibile

poi eventuale annuncio

```



\---



\## 15.3 Struttura consigliata



Nome consigliato:



```text

AccessibilityService

```



Metodo minimo consigliato:



```text

announce

```



Il metodo deve ricevere almeno:



\* messaggio da annunciare;

\* direzione del testo, se necessaria per l'API Flutter.



Per il primo blocco è preferibile usare una firma concettuale basata su:



```text

message

TextDirection

```



Non richiedere `BuildContext` se non è strettamente necessario.



\---



\## 15.4 Dipendenza da Flutter



A differenza dei messaggi, questo file può dipendere da Flutter.



Motivazione:



gli annunci accessibili richiedono strumenti Flutter come:



```text

SemanticsService.announce

```



Questa dipendenza deve restare confinata qui.



\---



\## 15.5 BuildContext



`AccessibilityService` non deve introdurre `BuildContext` come dipendenza obbligatoria se basta usare `TextDirection`.



Il design core ha stabilito che `BuildContext` non deve entrare nei messaggi, negli errori o nella sessione.



Per coerenza, anche nel servizio accessibilità bisogna usare il contesto solo se realmente necessario.



\---



\## 15.6 Cosa evitare



Evitare:



\* annunci sparsi nei widget;

\* annunci come unico feedback;

\* logica di business dentro il servizio accessibilità;

\* gestione focus avanzata in questo blocco.



La gestione focus verrà affrontata quando esisteranno schermate reali.



\---



\# 16. File 7 — app\_session\_state.dart



Percorso:



```text

lib/core/session/app\_session\_state.dart

```



\## 16.1 Scopo



Questo file definisce lo stato logico della sessione applicativa.



Serve a distinguere i casi principali all'avvio dell'app.



\---



\## 16.2 Stati minimi



Nome consigliato:



```text

AppSessionStatus

```



Valori consigliati:



```text

unknown

unauthenticated

authenticatedWithoutProfile

authenticatedWithProfile

```



Significato:



\## unknown



L'app sta ancora controllando lo stato.



\## unauthenticated



L'utente non è autenticato.



\## authenticatedWithoutProfile



L'utente è autenticato su Supabase, ma non ha profilo applicativo.



\## authenticatedWithProfile



L'utente è autenticato e ha profilo e azienda.



\---



\## 16.3 Stato sessione



Nome consigliato:



```text

AppSessionState

```



Informazioni minime:



```text

status

user

profileId

companyId

companyName

```



Dove:



\* `status` indica lo stato logico;

\* `user` rappresenta l'utente Supabase, se disponibile;

\* `profileId` è l'id del profilo applicativo;

\* `companyId` è l'id dell'azienda;

\* `companyName` è il nome azienda, utile per home futura.



\---



\## 16.4 Dipendenza da Supabase



Per l'MVP 1 è accettabile usare direttamente il tipo `User` di Supabase.



Motivazione:



\* il backend MVP 1 è già basato su Supabase;

\* il progetto non prevede cambio backend in questa fase;

\* creare subito un modello `AppUser` duplicato sarebbe una complessità non necessaria;

\* il core deve restare semplice;

\* una separazione più astratta potrà essere valutata in futuro se diventerà utile.



Questa è una scelta consapevole e controllata.



Non è una svista.



\---



\## 16.5 Cosa evitare



Evitare:



\* ruoli avanzati;

\* multi-azienda per singolo utente;

\* permessi complessi;

\* dati non necessari all'MVP 1;

\* modelli utente duplicati senza necessità reale.



\---



\# 17. File 8 — app\_session\_controller.dart



Percorso:



```text

lib/core/session/app\_session\_controller.dart

```



\## 17.1 Scopo



Questo file gestisce lo stato sessione corrente.



Serve a mantenere centralizzata la decisione:



```text

login / onboarding / home

```



\---



\## 17.2 Struttura consigliata



Nome consigliato:



```text

AppSessionController

```



Può estendere:



```text

ValueNotifier<AppSessionState>

```



oppure usare una struttura equivalente semplice.



\---



\## 17.3 Natura del controller nel primo blocco



Nel primo blocco core, `AppSessionController` deve essere un controller sincrono e manuale.



Non deve ancora:



\* ascoltare Supabase Auth;

\* ascoltare `onAuthStateChange`;

\* eseguire query;

\* leggere profilo;

\* leggere azienda;

\* fare login;

\* fare logout.



Il suo compito è rappresentare e aggiornare uno stato già noto.



\---



\## 17.4 Responsabilità del primo blocco



Nel primo blocco core il controller deve almeno permettere di:



\* impostare stato sconosciuto;

\* impostare stato non autenticato;

\* impostare stato autenticato senza profilo;

\* impostare stato autenticato con profilo;

\* esporre lo stato corrente.



Metodi consigliati:



```text

setUnknown()

setUnauthenticated()

setAuthenticatedWithoutProfile(...)

setAuthenticatedWithProfile(...)

```



I nomi potranno essere leggermente diversi, ma devono restare chiari.



\---



\## 17.5 Responsabilità rimandate



Non è obbligatorio in questo blocco implementare tutto il controllo reale di Supabase Auth.



Il controllo completo di:



\* login;

\* logout;

\* lettura sessione;

\* ascolto cambi auth;

\* lettura profilo;

\* lettura azienda;



verrà completato nel blocco successivo:



```text

auth/session

```



Questo blocco core prepara lo stato e il controller.



Il blocco auth/session userà questi elementi.



\---



\## 17.6 Rapporto futuro con auth/session



Nel blocco `auth/session`, un servizio o controller dedicato:



\* leggerà Supabase Auth;

\* ascolterà eventuali cambi sessione;

\* controllerà se esiste un profilo applicativo;

\* recupererà azienda corrente;

\* aggiornerà `AppSessionController`.



Quindi:



```text

core

↓

prepara AppSessionController



auth/session

↓

alimenta AppSessionController con dati reali

```



Questa separazione evita di trasformare il core in un blocco auth completo.



\---



\## 17.7 Reazione UI



La UI dovrà osservare lo stato sessione in un punto unico.



Questa logica non deve essere duplicata in login, onboarding e home.



Schema futuro:



```text

unknown → caricamento

unauthenticated → login

authenticatedWithoutProfile → onboarding

authenticatedWithProfile → home

```



\---



\## 17.8 Cosa evitare



Evitare:



\* router complesso;

\* service locator;

\* logica auth completa prima del blocco auth/session;

\* letture Supabase duplicate nelle schermate.



\---



\# 18. Ordine di implementazione



L'ordine di lavoro consigliato è:



```text

1\. creare cartelle core

2\. creare app\_messages.dart

3\. creare app\_exception.dart

4\. creare supabase\_error\_mapper.dart

5\. creare app\_feedback\_message.dart

6\. creare app\_feedback\_controller.dart

7\. creare accessibility\_service.dart

8\. creare app\_session\_state.dart

9\. creare app\_session\_controller.dart

10\. creare i test automatici minimi obbligatori

11\. eseguire flutter analyze

12\. eseguire flutter test

13\. correggere eventuali errori

14\. aggiornare CHANGELOG.md

15\. commit

```



Questo ordine parte dalle dipendenze più semplici, arriva ai controller e chiude il blocco con analisi e test.



I test automatici minimi devono essere scritti nello stesso blocco del codice.



Non devono essere rimandati a una fase finale del progetto.



\---



\# 19. Regole sugli import



\## 19.1 File che non devono importare Flutter UI



Questi file non devono importare `material.dart`:



```text

app\_messages.dart

app\_exception.dart

supabase\_error\_mapper.dart

app\_feedback\_message.dart

app\_feedback\_controller.dart

app\_session\_state.dart

app\_session\_controller.dart

```



Questa regola significa:



```text

niente dipendenza da widget o UI Flutter

```



\---



\## 19.2 Eccezione per foundation.dart



Questi file possono importare:



```text

package:flutter/foundation.dart

```



se usano `ValueNotifier` o strumenti equivalenti:



```text

app\_feedback\_controller.dart

app\_session\_controller.dart

```



Questa non è considerata dipendenza da UI.



È una dipendenza leggera e accettabile per l'MVP 1.



\---



\## 19.3 File che può importare servizi Flutter



Questo file può importare servizi Flutter legati alla semantica/accessibilità:



```text

accessibility\_service.dart

```



Motivazione:



serve a centralizzare gli annunci screen reader.



Esempio di API utilizzabile:



```text

SemanticsService.announce

```



\---



\# 20. Regole su BuildContext



Il core deve rispettare questa regola:



```text

BuildContext non deve entrare nei messaggi, negli errori o nella sessione.

```



`BuildContext` può essere accettato solo dove serve davvero per interagire con Flutter UI.



Nel primo blocco, anche per:



```text

accessibility\_service.dart

```



è preferibile evitare `BuildContext` se basta usare:



```text

TextDirection

```



Regola pratica:



```text

non richiedere BuildContext se non è necessario

```



\---



\# 21. Regole su Supabase



In questo blocco non si devono creare servizi Supabase completi.



Il core deve però essere coerente con queste regole:



\* Flutter usa solo anon public key;

\* Flutter non usa service role key;

\* Flutter non modifica direttamente `prodotti.scorta\_attuale`;

\* Flutter non inserisce direttamente in `movimenti\_magazzino`;

\* Flutter non bypassa le RLS;

\* Flutter usa RPC nei blocchi futuri;

\* errori Supabase vengono tradotti dal mapper.



Il file che potrà importare Supabase in questo blocco è:



```text

supabase\_error\_mapper.dart

```



Il file session state può importare il tipo `User` di Supabase.



Questa scelta è accettata per l'MVP 1 perché evita modelli duplicati inutili.



\---



\# 22. Modifiche a main.dart



In questo blocco non è necessario modificare pesantemente:



```text

lib/main.dart

```



Possibili scelte:



\## Scelta consigliata



Non modificare `main.dart`, salvo correzioni necessarie per mantenere il progetto compilabile.



Motivazione:



il core deve nascere prima delle schermate reali.



La modifica del punto di ingresso dell'app sarà più adatta nel blocco auth/session.



\## Eccezione



Se `main.dart` contiene codice provvisorio che impedisce `flutter analyze`, può essere corretto in modo minimo.



Non introdurre ancora il flusso completo:



```text

login / onboarding / home

```



Questo flusso verrà gestito nel blocco successivo.



\---



\# 23. Modifiche ai file provvisori



Se esistono file provvisori come:



```text

test\_console\_page.dart

test\_backend\_service.dart

```



non eliminarli automaticamente in questo blocco.



Regola:



```text

non pulire file provvisori se non interferiscono

```



La loro rimozione o sostituzione avverrà quando verrà introdotta la struttura reale dell'app.



\---



\# 24. Controlli dopo la codifica



Dopo aver creato i file core, eseguire:



```text

flutter analyze

```



Il risultato atteso è:



```text

nessun errore nuovo introdotto dal core

```



Dopo l'analisi statica, eseguire:



```text

flutter test

```



Il risultato atteso è:



```text

tutti i test automatici minimi del blocco core passano

```



Se emergono warning non bloccanti, valutarli uno alla volta.



Non ignorare errori reali.



Non considerare completato il blocco se `flutter analyze` o `flutter test` falliscono.



\---



\# 25. Test logici del blocco



Questo blocco non ha ancora test funzionali completi.



Tuttavia devono essere verificati questi punti.



\---



\## 25.1 Messaggi



Controllo:



```text

i messaggi utente principali sono in app\_messages.dart

```



Risultato atteso:



```text

nessun messaggio importante duplicato nei file core

```



\---



\## 25.2 Messaggi senza BuildContext



Controllo:



```text

app\_messages.dart non usa BuildContext

```



Risultato atteso:



```text

messaggi usabili da servizi e controller

```



\---



\## 25.3 Errori



Controllo:



```text

supabase\_error\_mapper.dart restituisce AppException

```



Risultato atteso:



```text

errore tecnico dentro

messaggio utente fuori

```



\---



\## 25.4 Errori di rete



Controllo:



```text

il mapper prevede assenza rete e timeout

```



Risultato atteso:



```text

errore rete → messaggio connessione assente

```



\---



\## 25.5 Feedback



Controllo:



```text

AppFeedbackMessage contiene testo, tipo, testo accessibile opzionale e shouldAnnounce

```



Risultato atteso:



```text

feedback persistente rappresentabile

```



\---



\## 25.6 Feedback controller



Controllo:



```text

AppFeedbackController può impostare e cancellare il feedback corrente

```



Risultato atteso:



```text

le schermate future potranno mostrare un messaggio stabile

```



\---



\## 25.7 Accessibilità



Controllo:



```text

AccessibilityService centralizza gli annunci

```



Risultato atteso:



```text

nessun annuncio sparso necessario nei widget futuri

```



\---



\## 25.8 Sessione



Controllo:



```text

AppSessionState e AppSessionController rappresentano gli stati minimi

```



Risultato atteso:



```text

unknown

unauthenticated

authenticatedWithoutProfile

authenticatedWithProfile

```



\---



\## 25.9 Controller sessione sincrono



Controllo:



```text

AppSessionController non legge Supabase Auth in questo blocco

```



Risultato atteso:



```text

il controller espone solo metodi di transizione stato

```



\---



\# 26. Test automatici minimi obbligatori



I test automatici minimi sono obbligatori per questo blocco.



Non sono una fase facoltativa.



Non sono un'attività da rimandare alla fine dell'MVP.



Il blocco core deve essere sviluppato insieme ai suoi test.



Regola fondamentale:



```text

senza test automatici minimi superati,

il blocco core non è completato

```



I test devono essere creati almeno per:



\* mapper errori;

\* feedback controller;

\* session controller.



Questi elementi sono logica centrale e riutilizzabile.



Proprio per questo devono essere protetti subito.



\---



\## 26.1 Test mapper errori



File obbligatorio:



```text

test/core/errors/supabase\_error\_mapper\_test.dart

```



Casi minimi obbligatori:



\* errore generico;

\* errore credenziali errate;

\* errore scorta insufficiente;

\* errore prodotto non trovato;

\* errore fornitore non valido;

\* errore barcode duplicato;

\* errore connessione assente.



Risultato atteso:



```text

ogni errore tecnico testato viene trasformato nel messaggio utente corretto

```



\---



\## 26.2 Test feedback controller



File obbligatorio:



```text

test/core/feedback/app\_feedback\_controller\_test.dart

```



Casi minimi obbligatori:



\* impostazione messaggio successo;

\* impostazione messaggio errore;

\* impostazione messaggio avviso;

\* impostazione messaggio informativo;

\* cancellazione messaggio;

\* testo accessibile uguale al testo visibile quando non specificato.



Risultato atteso:



```text

il controller imposta, conserva e cancella correttamente il feedback corrente

```



\---



\## 26.3 Test session controller



File obbligatorio:



```text

test/core/session/app\_session\_controller\_test.dart

```



Casi minimi obbligatori:



\* stato iniziale sconosciuto;

\* passaggio a non autenticato;

\* passaggio ad autenticato senza profilo;

\* passaggio ad autenticato con profilo;

\* verifica dei dati minimi quando lo stato è autenticato con profilo.



Risultato atteso:



```text

il controller rappresenta correttamente gli stati sessione minimi

```



\---



\## 26.4 Comando test



Dopo aver creato i test, eseguire:



```text

flutter test

```



Risultato atteso:



```text

tutti i test passano

```



\---



\## 26.5 Regola in caso di problema tecnico



I test automatici minimi devono essere creati e devono passare.



Possono essere temporaneamente bloccati solo se emerge un problema tecnico concreto nella configurazione dei test Flutter/Dart.



In quel caso:



\* il problema deve essere scritto chiaramente nel TODO core;

\* il blocco deve essere segnato come bloccato;

\* non si deve considerare completato il core;

\* non si deve fare commit del blocco come completato;

\* prima di proseguire con il blocco successivo, il problema dei test deve essere risolto.



Regola sintetica:



```text

i test non si accumulano alla fine del progetto

```



\---



\# 27. Cosa non deve essere implementato ora



Non implementare in questo blocco:



\* schermata login;

\* schermata onboarding;

\* schermata home;

\* query reali profilo/azienda;

\* ascolto reale di Supabase Auth;

\* `onAuthStateChange`;

\* servizi categorie;

\* servizi fornitori;

\* servizi prodotti;

\* servizi movimenti;

\* form;

\* liste;

\* routing complesso;

\* `go\_router`;

\* BLoC;

\* service locator;

\* sincronizzazione offline;

\* barcode scanner;

\* gestione immagini;

\* report.



\---



\# 28. Criterio di completamento



Il blocco core sarà considerato completato quando:



\* le cartelle core minime esistono;

\* gli otto file di produzione indicati sono stati creati;

\* i messaggi principali sono centralizzati;

\* gli errori tecnici possono essere mappati in `AppException`;

\* il mapper errori segue la gerarchia di riconoscimento stabilita;

\* il feedback persistente è rappresentabile;

\* esiste un controller feedback semplice;

\* esiste un servizio accessibilità minimo;

\* esiste uno stato sessione minimo;

\* esiste un controller sessione minimo e sincrono;

\* non sono stati creati file inutili;

\* i test automatici minimi obbligatori sono stati creati;

\* `flutter analyze` non segnala errori nuovi;

\* `flutter test` passa con esito positivo;

\* `CHANGELOG.md` è aggiornato;

\* il commit è eseguito.



Il blocco core non può essere considerato completato se i test automatici minimi non esistono o non passano.



\---



\# 29. Aggiornamento changelog



Dopo la codifica del core, aggiornare:



```text

CHANGELOG.md

```



Voce consigliata:



```text

Aggiunto core Dart minimo con messaggi, errori, feedback, accessibilità e sessione iniziale.

```



Aggiungere anche:



```text

Aggiunti test automatici minimi obbligatori per mapper errori, feedback e sessione.

```



\---



\# 30. Commit consigliato



Messaggio commit consigliato per il codice:



```text

Aggiunge core Dart minimo

```



Se il commit riguarda solo questo documento coding plan, usare:



```text

Aggiunge coding plan core Flutter

```



\---



\# 31. Rischi da evitare



\## 31.1 Troppi file



Rischio:



creare tutti i file futuri elencati nel design.



Contromisura:



creare solo gli otto file previsti da questo coding plan.



\---



\## 31.2 Core troppo astratto



Rischio:



creare classi generiche difficili da capire.



Contromisura:



nomi semplici, responsabilità chiare, niente astrazioni premature.



\---



\## 31.3 Messaggi duplicati



Rischio:



scrivere messaggi sia in `AppMessages` sia negli errori.



Contromisura:



il mapper usa sempre `AppMessages`.



\---



\## 31.4 Error mapper fragile



Rischio:



basarsi solo su testo libero.



Contromisura:



preferire tipo eccezione, codice errore, codice PostgreSQL, vincoli database e API Contracts.



Il testo libero resta solo fallback.



\---



\## 31.5 Barcode duplicato non riconosciuto



Rischio:



non intercettare correttamente il duplicato barcode.



Contromisura:



riconoscere il vincolo:



```text

prodotti\_barcode\_unique\_per\_azienda

```



quando disponibile.



\---



\## 31.6 Feedback solo vocale



Rischio:



trattare l'annuncio screen reader come feedback principale.



Contromisura:



il feedback persistente resta il messaggio principale; l'annuncio è facoltativo.



\---



\## 31.7 Sessione troppo completa



Rischio:



implementare già login, logout e lettura profilo completa.



Contromisura:



in questo blocco si prepara lo stato sessione; il blocco auth/session completerà la logica reale.



\---



\## 31.8 Sessione troppo vuota



Rischio:



creare un controller senza metodi utili per i blocchi futuri.



Contromisura:



prevedere metodi chiari di transizione stato:



```text

setUnknown()

setUnauthenticated()

setAuthenticatedWithoutProfile(...)

setAuthenticatedWithProfile(...)

```



\---



\## 31.9 Modificare main.dart troppo presto



Rischio:



anticipare login/onboarding/home prima del blocco dedicato.



Contromisura:



non modificare `main.dart`, salvo necessità di compilazione.



\---



\## 31.10 BuildContext non necessario



Rischio:



introdurre `BuildContext` nel core senza reale necessità.



Contromisura:



usare `BuildContext` solo se indispensabile.



Per gli annunci accessibili preferire `TextDirection` quando basta.



\---



\## 31.11 Rimandare i test



Rischio:



considerare i test come attività finale del progetto.



Contromisura:



ogni blocco deve nascere con i suoi test minimi.



Per questo blocco, i test automatici minimi sono obbligatori e fanno parte del criterio di completamento.



\---



\## 31.12 Accumulare debito di test



Rischio:



procedere con login, onboarding, prodotti e movimenti sopra un core non testato.



Contromisura:



non passare al blocco successivo se il core non ha test minimi superati.



\---



\# 32. Revisione AI



Questo documento è stato revisionato tramite confronto con:



\* ChatGPT;

\* Gemini;

\* DeepSeek;

\* Claude.



Il primo giro di revisione ha prodotto giudizio complessivo:



```text

APPROVATO CON MODIFICHE PUNTUALI

```



Le modifiche integrate hanno riguardato:



\* rafforzamento del mapper errori;

\* gerarchia di riconoscimento errori;

\* riconoscimento del vincolo barcode;

\* chiarimento sul controller sessione sincrono;

\* chiarimento sul rapporto futuro con auth/session;

\* correzione delle regole sugli import;

\* chiarimento dell'uso di `TextDirection` in `AccessibilityService`;

\* motivazione dell'uso diretto di `User` Supabase;

\* aggiunta e rafforzamento dei test automatici minimi obbligatori;

\* conferma dei file da creare e da rimandare.



Dopo l'integrazione di queste modifiche, non è necessario un secondo giro di revisione AI.



Il documento può essere considerato approvato.



\---



\# 33. Stato del documento



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

docs/4-flutter/2-coding-plans/001-CODING\_PLAN\_CORE\_mvp1\_v1.0.0.md

```



\---



\# 34. Prossimo passo



Dopo l'approvazione di questo documento, il passo successivo sarà creare:



```text

docs/4-flutter/3-todos/001-TODO\_CORE\_mvp1\_v1.0.0.md

```



Solo dopo il todo specifico si passerà al primo codice Dart del core.



Il TODO core dovrà riportare in modo esplicito i test automatici minimi obbligatori.



\---



\# 35. Conclusione



Questo coding plan definisce un core Dart minimo, coerente con il design approvato.



Il blocco crea solo ciò che serve per iniziare:



\* messaggi;

\* errori;

\* feedback;

\* accessibilità;

\* sessione.



Non crea schermate.



Non crea servizi verticali.



Non modifica la logica di magazzino.



Non sostituisce il backend.



Il blocco core deve nascere insieme ai suoi test automatici minimi.



Il principio finale è:



```text

preparare una base semplice,

testarla subito,

poi costruire le funzionalità.

```



Con questo coding plan approvato, il progetto può passare al TODO operativo del core.

