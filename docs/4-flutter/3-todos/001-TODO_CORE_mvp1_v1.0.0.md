\# TODO CORE MVP 1.0



\## Gestionale Magazzino Universale



Versione: 1.0.0

Stato: APPROVATO

Data: 5 luglio 2026



\---



\# 1. Scopo del documento



Questo documento definisce il TODO operativo del blocco:



```text

Core Dart minimo

```



Il TODO traduce in attività concrete il coding plan approvato:



```text

docs/4-flutter/2-coding-plans/001-CODING\_PLAN\_CORE\_mvp1\_v1.0.0.md

```



Questo documento serve a guidare l'implementazione pratica del primo blocco core Flutter.



Il TODO deve essere usato durante la codifica per spuntare una attività alla volta.



\---



\# 2. Obiettivo del blocco



L'obiettivo del blocco core è creare la base minima comune dell'app Flutter.



Il core deve preparare:



\* messaggi centralizzati;

\* errori centralizzati;

\* mapper errori Supabase;

\* feedback persistente;

\* controller feedback;

\* servizio accessibilità minimo;

\* stato sessione minimo;

\* controller sessione minimo;

\* test automatici minimi obbligatori.



Il blocco non deve creare schermate complete.



Il blocco non deve implementare login reale.



Il blocco non deve implementare onboarding reale.



Il blocco non deve implementare prodotti, fornitori, categorie o movimenti.



\---



\# 3. Documenti di riferimento



Prima di iniziare il blocco, i documenti di riferimento sono:



```text

docs/4-flutter/1-design/001-DESIGN\_CORE\_mvp1\_v1.0.0.md

docs/4-flutter/2-coding-plans/001-CODING\_PLAN\_CORE\_mvp1\_v1.0.0.md

docs/4-flutter/001-FLUTTER\_PLAN\_mvp1\_v1.0.0.md

docs/3-backend/002-API\_CONTRACTS\_mvp1\_v1.0.0.md

docs/3-backend/001-BACKEND\_RULES\_mvp1\_v1.0.0.md

docs/4-flutter/3-todos/000-todo-master.md

```



\---



\# 4. Regole generali del blocco



\## 4.1 Regola principale



```text

pochi file iniziali, ma ben scelti

```



\## 4.2 Test obbligatori



```text

senza test automatici minimi superati,

il blocco core non è completato

```



I test non sono facoltativi.



I test non devono essere rimandati alla fine dell'MVP.



Ogni blocco importante deve nascere con i propri test minimi.



\## 4.3 Nessun file inutile



Non creare file futuri solo perché previsti teoricamente.



Creare solo i file indicati in questo TODO.



\## 4.4 Nessuna UI reale



Non costruire login, onboarding, home o schermate gestionali.



\## 4.5 Nessuna logica Supabase completa



Non implementare login, logout, ascolto sessione, lettura profilo o lettura azienda.



Queste attività appartengono al blocco successivo:



```text

auth/session

```



\---



\# 5. Stato iniziale previsto



Il progetto Flutter si trova in:



```text

app/

```



Sono già presenti o previsti:



```text

lib/main.dart

lib/config/supabase\_config.dart

```



Potrebbero essere presenti file provvisori:



```text

lib/pages/test\_console\_page.dart

lib/services/test\_backend\_service.dart

```



Non eliminarli in questo blocco se non interferiscono con compilazione, analisi o test.



\---



\# 6. Checklist generale



\## 6.1 Preparazione



\* \[ ] Aprire il progetto in VS Code.

\* \[ ] Verificare di essere nella repository corretta.

\* \[ ] Verificare che il documento di design core sia salvato.

\* \[ ] Verificare che il coding plan core sia salvato.

\* \[ ] Verificare che il coding plan core sia committato.

\* \[ ] Aprire il terminale nella cartella Flutter:



```text

app/

```



\* \[ ] Eseguire controllo iniziale:



```text

flutter analyze

```



\* \[ ] Annotare eventuali errori già presenti prima del blocco core.

\* \[ ] Non iniziare modifiche se il progetto ha errori non compresi.



\---



\# 7. Cartelle da creare



Creare le seguenti cartelle:



```text

lib/core/messages/

lib/core/errors/

lib/core/feedback/

lib/core/accessibility/

lib/core/session/

```



Checklist:



\* \[ ] Creare `lib/core/`.

\* \[ ] Creare `lib/core/messages/`.

\* \[ ] Creare `lib/core/errors/`.

\* \[ ] Creare `lib/core/feedback/`.

\* \[ ] Creare `lib/core/accessibility/`.

\* \[ ] Creare `lib/core/session/`.



Non creare:



```text

lib/core/services/

```



Motivo:



i servizi Supabase concreti verranno creati nei blocchi futuri.



\---



\# 8. File da creare



Creare questi otto file di produzione:



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



Checklist:



\* \[ ] Creare `lib/core/messages/app\_messages.dart`.

\* \[ ] Creare `lib/core/errors/app\_exception.dart`.

\* \[ ] Creare `lib/core/errors/supabase\_error\_mapper.dart`.

\* \[ ] Creare `lib/core/feedback/app\_feedback\_message.dart`.

\* \[ ] Creare `lib/core/feedback/app\_feedback\_controller.dart`.

\* \[ ] Creare `lib/core/accessibility/accessibility\_service.dart`.

\* \[ ] Creare `lib/core/session/app\_session\_state.dart`.

\* \[ ] Creare `lib/core/session/app\_session\_controller.dart`.



\---



\# 9. File da NON creare



Non creare in questo blocco:



```text

lib/core/messages/app\_error\_messages.dart

lib/core/messages/app\_accessibility\_messages.dart

lib/core/services/supabase\_service.dart

lib/core/accessibility/focus\_helpers.dart

lib/core/accessibility/accessible\_feedback.dart

```



Checklist:



\* \[ ] Verificare di non aver creato `app\_error\_messages.dart`.

\* \[ ] Verificare di non aver creato `app\_accessibility\_messages.dart`.

\* \[ ] Verificare di non aver creato `supabase\_service.dart`.

\* \[ ] Verificare di non aver creato `focus\_helpers.dart`.

\* \[ ] Verificare di non aver creato `accessible\_feedback.dart`.



\---



\# 10. Implementazione app\_messages.dart



Percorso:



```text

lib/core/messages/app\_messages.dart

```



\## 10.1 Obiettivo



Centralizzare i messaggi utente principali del core.



\## 10.2 Checklist



\* \[ ] Creare una classe non istanziabile chiamata `AppMessages`.

\* \[ ] Non importare `package:flutter/material.dart`.

\* \[ ] Non usare `BuildContext`.

\* \[ ] Inserire messaggi generali.

\* \[ ] Inserire messaggi auth/sessione.

\* \[ ] Inserire messaggi validazione.

\* \[ ] Inserire messaggi successo.

\* \[ ] Inserire messaggi errore.

\* \[ ] Inserire messaggi avviso.

\* \[ ] Inserire messaggi informativi o di stato.

\* \[ ] Verificare che i messaggi siano stringhe Dart pure.

\* \[ ] Verificare che non ci siano messaggi tecnici grezzi.

\* \[ ] Verificare che i messaggi siano chiari anche se letti da screen reader.

\* \[ ] Prevedere, se necessario in futuro, messaggi parametrici tramite metodi statici che restituiscono stringhe.



\## 10.3 Messaggi minimi richiesti



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

Sessione non valida. Accedi di nuovo.

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

Il prodotto selezionato è disattivato.

```



Messaggi informativi o di stato:



```text

Il profilo risulta già creato. Ricarico i dati.

```



Messaggi avviso:



```text

Attenzione: scorta inferiore al livello minimo.

Il prodotto selezionato è disattivato.

```



\## 10.4 Messaggi parametrici



Per il core iniziale la maggior parte dei messaggi può essere statica.



Se in futuro serviranno messaggi con valori dinamici, non creare stringhe sparse nei widget.



Usare invece metodi statici dentro `AppMessages`.



Esempio concettuale:



```text

static String scortaInsufficienteDettaglio(int richiesta, int disponibile)

```



Regola:



```text

i messaggi dinamici restano centralizzati

```



Non introdurre ora un sistema complesso di localizzazione o interpolazione.



\---



\# 11. Implementazione app\_exception.dart



Percorso:



```text

lib/core/errors/app\_exception.dart

```



\## 11.1 Obiettivo



Rappresentare un errore applicativo comprensibile.



\## 11.2 Checklist



\* \[ ] Creare classe `AppException`.

\* \[ ] Far implementare o estendere `Exception` se utile.

\* \[ ] Inserire campo `message`.

\* \[ ] Inserire campo facoltativo `technicalMessage`.

\* \[ ] Mantenere il file indipendente dalla UI.

\* \[ ] Non importare `material.dart`.

\* \[ ] Non usare `BuildContext`.

\* \[ ] Non creare gerarchie complesse di eccezioni.

\* \[ ] Verificare che il messaggio utente sia separato dal dettaglio tecnico.



\---



\# 12. Implementazione supabase\_error\_mapper.dart



Percorso:



```text

lib/core/errors/supabase\_error\_mapper.dart

```



\## 12.1 Obiettivo



Convertire errori tecnici in `AppException`.



\## 12.2 Checklist generale



\* \[ ] Creare classe o modulo `SupabaseErrorMapper`.

\* \[ ] Prevedere un metodo principale di mappatura.

\* \[ ] Il metodo deve accettare un errore generico, per esempio `Object error`.

\* \[ ] Il metodo deve gestire in sicurezza errori sconosciuti senza causare crash.

\* \[ ] Il metodo deve restituire `AppException`.

\* \[ ] Usare sempre messaggi centralizzati da `AppMessages`.

\* \[ ] Non duplicare stringhe utente dentro il mapper.

\* \[ ] Conservare il dettaglio tecnico in `technicalMessage` quando utile.

\* \[ ] Non mostrare errori tecnici grezzi all'utente.

\* \[ ] Non inizializzare o usare un client Supabase reale nei test di questo mapper.



\## 12.3 Gerarchia obbligatoria di riconoscimento



Il mapper deve riconoscere gli errori in questo ordine:



```text

1\. tipo nativo dell'eccezione

2\. codice errore disponibile nell'eccezione

3\. codice PostgreSQL

4\. messaggio backend previsto dagli API Contracts

5\. nome vincolo database

6\. testo libero solo come fallback

```



Checklist:



\* \[ ] Gestire prima i tipi nativi di eccezione.

\* \[ ] Gestire i codici errore quando disponibili.

\* \[ ] Gestire codice PostgreSQL `23505` per unique violation.

\* \[ ] Gestire i messaggi backend previsti dagli API Contracts.

\* \[ ] Gestire il nome vincolo barcode quando disponibile.

\* \[ ] Usare string matching libero solo come fallback.

\* \[ ] Non basare il mapper solo su testo libero.



Nota importante:



i messaggi backend previsti dagli API Contracts non sono da trattare come testo libero casuale.



Quando possibile, devono essere riconosciuti tramite corrispondenza esatta del campo strutturato, per esempio:



```text

PostgrestException.message

PostgrestException.details

```



o campo equivalente disponibile.



Il controllo `contains()` generico deve restare fallback, non regola principale.



\## 12.4 Errori Auth



Checklist:



\* \[ ] Riconoscere errori di tipo `AuthException`, se disponibile.

\* \[ ] Mappare credenziali errate.

\* \[ ] Mappare sessione scaduta.

\* \[ ] Mappare utente non autenticato.

\* \[ ] Usare fallback testuale solo se necessario.



Messaggi attesi:



```text

Email o password non corrette.

Sessione scaduta. Accedi di nuovo.

Sessione non valida. Accedi di nuovo.

```



\## 12.5 Errori PostgREST e PostgreSQL



Checklist:



\* \[ ] Riconoscere errori di tipo `PostgrestException`, se disponibile.

\* \[ ] Leggere `code`, se disponibile.

\* \[ ] Leggere `message`, se disponibile.

\* \[ ] Leggere `details`, se disponibile.

\* \[ ] Leggere `hint`, se disponibile.

\* \[ ] Gestire codice PostgreSQL `23505`.

\* \[ ] Gestire vincoli specifici quando disponibili.

\* \[ ] Gestire messaggi backend approvati dagli API Contracts come casi strutturati, non come stringhe libere generiche.



\## 12.6 Barcode duplicato



Vincolo da riconoscere:



```text

prodotti\_barcode\_unique\_per\_azienda

```



Checklist:



\* \[ ] Se errore PostgREST con codice `23505`, controllare il vincolo.

\* \[ ] Se il vincolo è `prodotti\_barcode\_unique\_per\_azienda`, restituire messaggio barcode duplicato.

\* \[ ] Se il vincolo non è disponibile, usare fallback testuale solo se il messaggio indica chiaramente barcode duplicato.

\* \[ ] Il fallback testuale deve essere ultima opzione.

\* \[ ] Aggiungere test automatico obbligatorio per barcode duplicato con vincolo riconosciuto.

\* \[ ] Aggiungere test automatico obbligatorio per unique violation con vincolo sconosciuto.



Messaggio atteso per barcode duplicato:



```text

Esiste già un prodotto con questo barcode.

```



Messaggio atteso per unique violation generica o vincolo sconosciuto:



```text

Esiste già un elemento con questo nome.

```



\## 12.7 Duplicato generico



Checklist:



\* \[ ] Gestire unique violation generica.

\* \[ ] Restituire messaggio duplicato generico se non si riconosce il vincolo specifico.



Messaggio atteso:



```text

Esiste già un elemento con questo nome.

```



\## 12.8 Errori RPC previsti



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



Checklist:



\* \[ ] Mappare `Scorta insufficiente`.

\* \[ ] Mappare `Prodotto non trovato`.

\* \[ ] Mappare `Prodotto disattivato`.

\* \[ ] Mappare `Fornitore non valido`.

\* \[ ] Mappare `Profilo già esistente`.

\* \[ ] Mappare `Nome azienda obbligatorio`.

\* \[ ] Mappare `Quantità non valida`.

\* \[ ] Mappare `La nuova scorta coincide con quella attuale`.

\* \[ ] Usare messaggi centralizzati.

\* \[ ] Riconoscere questi messaggi come messaggi backend approvati dagli API Contracts.

\* \[ ] Preferire corrispondenza esatta su campo `message` o `details` quando disponibile.

\* \[ ] Non trattare questi casi come semplice string matching libero generico.



\## 12.9 Errori autorizzazione e RLS



Checklist:



\* \[ ] Riconoscere `permission denied`.

\* \[ ] Riconoscere `violates row-level security`.

\* \[ ] Riconoscere `Operazione non autorizzata`.

\* \[ ] Restituire messaggio operazione non autorizzata.

\* \[ ] Aggiungere test automatico obbligatorio per questo caso.



Messaggio atteso:



```text

Operazione non autorizzata.

```



\## 12.10 Errori rete e timeout



Checklist:



\* \[ ] Gestire assenza rete.

\* \[ ] Gestire timeout.

\* \[ ] Gestire failed host lookup.

\* \[ ] Gestire connection failed.

\* \[ ] Gestire network error.

\* \[ ] Usare fallback testuale quando il tipo errore varia per piattaforma.

\* \[ ] Aggiungere test automatico obbligatorio per questo caso.



Messaggio atteso:



```text

Connessione assente. Controlla Internet e riprova.

```



\## 12.11 Errore generico



Checklist:



\* \[ ] Qualsiasi errore non riconosciuto deve restituire errore generico.

\* \[ ] Il dettaglio tecnico deve restare in `technicalMessage`.

\* \[ ] Il dettaglio tecnico non deve essere mostrato all'utente.

\* \[ ] Aggiungere test automatico obbligatorio per errore non riconosciuto.

\* \[ ] Aggiungere test automatico obbligatorio per `technicalMessage` popolato quando disponibile.



Messaggio atteso:



```text

Si è verificato un errore. Riprova.

```



\---



\# 13. Implementazione app\_feedback\_message.dart



Percorso:



```text

lib/core/feedback/app\_feedback\_message.dart

```



\## 13.1 Obiettivo



Rappresentare un messaggio di feedback persistente.



\## 13.2 Checklist



\* \[ ] Creare enum `AppFeedbackType`.

\* \[ ] Prevedere valori `success`, `error`, `warning`, `info`.

\* \[ ] Creare classe `AppFeedbackMessage`.

\* \[ ] Inserire campo `text`.

\* \[ ] Inserire campo `type`.

\* \[ ] Inserire campo facoltativo `accessibilityText`.

\* \[ ] Inserire campo `shouldAnnounce`.

\* \[ ] Prevedere che `accessibilityText` ricada su `text` se non specificato.

\* \[ ] Non importare `material.dart`.

\* \[ ] Non dipendere da widget Flutter.

\* \[ ] Aggiungere copertura nei test del feedback controller o in test dedicato.



\---



\# 14. Implementazione app\_feedback\_controller.dart



Percorso:



```text

lib/core/feedback/app\_feedback\_controller.dart

```



\## 14.1 Obiettivo



Gestire il feedback corrente.



\## 14.2 Checklist



\* \[ ] Creare classe `AppFeedbackController`.

\* \[ ] Usare `ValueNotifier<AppFeedbackMessage?>` o equivalente semplice.

\* \[ ] Importare `package:flutter/foundation.dart` se si usa `ValueNotifier`.

\* \[ ] Prevedere metodo per successo.

\* \[ ] Prevedere metodo per errore.

\* \[ ] Prevedere metodo per avviso.

\* \[ ] Prevedere metodo per informazione.

\* \[ ] Prevedere metodo `clear()` o equivalente.

\* \[ ] Non disegnare UI.

\* \[ ] Non mostrare snackbar.

\* \[ ] Non creare overlay.

\* \[ ] Non dipendere da Supabase.

\* \[ ] Aggiungere test automatico obbligatorio.



Metodi possibili:



```text

showSuccess(...)

showError(...)

showWarning(...)

showInfo(...)

clear()

```



\---



\# 15. Implementazione accessibility\_service.dart



Percorso:



```text

lib/core/accessibility/accessibility\_service.dart

```



\## 15.1 Obiettivo



Centralizzare gli annunci screen reader.



\## 15.2 Checklist



\* \[ ] Creare classe o modulo `AccessibilityService`.

\* \[ ] Prevedere metodo `announce`.

\* \[ ] Usare `SemanticsService.announce` o API equivalente Flutter.

\* \[ ] Ricevere almeno messaggio e `TextDirection`, se necessario.

\* \[ ] Non richiedere `BuildContext` se non serve.

\* \[ ] Non gestire focus avanzato.

\* \[ ] Non contenere logica di business.

\* \[ ] Non sostituire il feedback persistente.

\* \[ ] Verificare che il metodo ignori messaggi vuoti o solo spazi.

\* \[ ] Non introdurre annunci sparsi in altri file.

\* \[ ] Aggiungere test automatico obbligatorio leggero per messaggi vuoti o composti da soli spazi.



Regola:



```text

prima messaggio visibile,

poi eventuale annuncio

```



\---



\# 16. Implementazione app\_session\_state.dart



Percorso:



```text

lib/core/session/app\_session\_state.dart

```



\## 16.1 Obiettivo



Rappresentare lo stato logico della sessione.



\## 16.2 Checklist



\* \[ ] Creare enum `AppSessionStatus`.

\* \[ ] Inserire stato `unknown`.

\* \[ ] Inserire stato `unauthenticated`.

\* \[ ] Inserire stato `authenticatedWithoutProfile`.

\* \[ ] Inserire stato `authenticatedWithProfile`.

\* \[ ] Creare classe `AppSessionState`.

\* \[ ] Inserire campo `status`.

\* \[ ] Inserire campo `user`.

\* \[ ] Inserire campo `profileId`.

\* \[ ] Inserire campo `companyId`.

\* \[ ] Inserire campo `companyName`.

\* \[ ] Usare il tipo `User` di Supabase per MVP 1.

\* \[ ] Documentare nel codice o nel commento che l'uso di `User` è scelta consapevole per MVP 1.

\* \[ ] Evitare modelli utente duplicati.

\* \[ ] Evitare ruoli avanzati.

\* \[ ] Evitare multi-azienda per singolo utente.



\---



\# 17. Implementazione app\_session\_controller.dart



Percorso:



```text

lib/core/session/app\_session\_controller.dart

```



\## 17.1 Obiettivo



Gestire in modo semplice lo stato sessione corrente.



\## 17.2 Checklist



\* \[ ] Creare classe `AppSessionController`.

\* \[ ] Usare `ValueNotifier<AppSessionState>` o equivalente semplice.

\* \[ ] Importare `package:flutter/foundation.dart` se si usa `ValueNotifier`.

\* \[ ] Stato iniziale: `unknown`.

\* \[ ] Creare metodo `setUnknown()` o equivalente.

\* \[ ] Creare metodo `setUnauthenticated()` o equivalente.

\* \[ ] Creare metodo `setAuthenticatedWithoutProfile(...)` o equivalente.

\* \[ ] Creare metodo `setAuthenticatedWithProfile(...)` o equivalente.

\* \[ ] Non leggere Supabase Auth.

\* \[ ] Non ascoltare `onAuthStateChange`.

\* \[ ] Non fare login.

\* \[ ] Non fare logout.

\* \[ ] Non leggere profilo.

\* \[ ] Non leggere azienda.

\* \[ ] Aggiungere test automatico obbligatorio.



Schema futuro da supportare:



```text

unknown → caricamento

unauthenticated → login

authenticatedWithoutProfile → onboarding

authenticatedWithProfile → home

```



\---



\# 18. Test automatici minimi obbligatori



Questa sezione è obbligatoria.



Il blocco core non può essere considerato completato senza questi test.



\---



\## 18.1 Cartelle test da creare



Creare le seguenti cartelle:



```text

test/core/errors/

test/core/feedback/

test/core/session/

test/core/accessibility/

```



Checklist:



\* \[ ] Creare `test/core/`.

\* \[ ] Creare `test/core/errors/`.

\* \[ ] Creare `test/core/feedback/`.

\* \[ ] Creare `test/core/session/`.

\* \[ ] Creare `test/core/accessibility/`.



\---



\## 18.2 Test mapper errori



File obbligatorio:



```text

test/core/errors/supabase\_error\_mapper\_test.dart

```



Checklist casi minimi:



\* \[ ] Test errore generico.

\* \[ ] Test errore non riconosciuto → messaggio generico.

\* \[ ] Test `technicalMessage` popolato quando disponibile.

\* \[ ] Test credenziali errate.

\* \[ ] Test scorta insufficiente.

\* \[ ] Test prodotto non trovato.

\* \[ ] Test fornitore non valido.

\* \[ ] Test operazione non autorizzata / RLS.

\* \[ ] Test barcode duplicato con vincolo riconosciuto.

\* \[ ] Test unique violation con vincolo sconosciuto → duplicato generico.

\* \[ ] Test connessione assente.

\* \[ ] Test almeno un errore RPC rappresentativo aggiuntivo.

\* \[ ] Test fallback testuale solo dove necessario.



Casi RPC rappresentativi consigliati:



```text

Profilo già esistente

Quantità non valida

```



Risultato atteso:



```text

ogni errore tecnico testato viene trasformato nel messaggio utente corretto

```



Note:



\* \[ ] I test devono verificare il valore di `AppException.message`.

\* \[ ] I test devono verificare `technicalMessage` quando il dettaglio tecnico è disponibile.

\* \[ ] I test non devono dipendere da schermate.

\* \[ ] I test non devono chiamare Supabase reale.

\* \[ ] I test non devono inizializzare `SupabaseClient`.

\* \[ ] I test devono usare errori simulati o oggetti errore costruiti localmente.

\* \[ ] I messaggi RPC approvati dagli API Contracts devono essere testati come casi noti, non come string matching libero generico.



\---



\## 18.3 Test feedback controller



File obbligatorio:



```text

test/core/feedback/app\_feedback\_controller\_test.dart

```



Checklist casi minimi:



\* \[ ] Test impostazione messaggio successo.

\* \[ ] Test impostazione messaggio errore.

\* \[ ] Test impostazione messaggio avviso.

\* \[ ] Test impostazione messaggio informativo.

\* \[ ] Test cancellazione messaggio.

\* \[ ] Test `accessibilityText` uguale a `text` quando non specificato.



Risultato atteso:



```text

il controller imposta, conserva e cancella correttamente il feedback corrente

```



\---



\## 18.4 Test session controller



File obbligatorio:



```text

test/core/session/app\_session\_controller\_test.dart

```



Checklist casi minimi:



\* \[ ] Test stato iniziale `unknown`.

\* \[ ] Test passaggio a `unauthenticated`.

\* \[ ] Test passaggio a `authenticatedWithoutProfile`.

\* \[ ] Test passaggio a `authenticatedWithProfile`.

\* \[ ] Test presenza dei dati minimi quando lo stato è `authenticatedWithProfile`.



Risultato atteso:



```text

il controller rappresenta correttamente gli stati sessione minimi

```



\---



\## 18.5 Test accessibility service



File obbligatorio:



```text

test/core/accessibility/accessibility\_service\_test.dart

```



Checklist casi minimi:



\* \[ ] Test messaggio vuoto.

\* \[ ] Test messaggio composto solo da spazi.

\* \[ ] Verificare che il metodo non generi errori con messaggi non validi.

\* \[ ] Non testare internamente il comportamento di Flutter `SemanticsService`.

\* \[ ] Testare solo la logica nostra di protezione dai messaggi vuoti.



Risultato atteso:



```text

AccessibilityService ignora in modo sicuro messaggi vuoti o non validi

```



\---



\## 18.6 Test Flutter predefiniti



Se esiste un file Flutter di test predefinito, per esempio:



```text

test/widget\_test.dart

```



Checklist:



\* \[ ] Verificare se `test/widget\_test.dart` esiste.

\* \[ ] Verificare se è ancora coerente con il progetto.

\* \[ ] Se è coerente, mantenerlo.

\* \[ ] Se non è coerente e fallisce, aggiornarlo in modo minimo oppure rinominarlo temporaneamente in:



```text

test/widget\_test.dart.disabled

```



\* \[ ] Non eliminare il file senza motivo.

\* \[ ] Non lasciare test predefiniti falliti.

\* \[ ] Non ignorare test falliti solo perché non appartengono al core.

\* \[ ] Riattivare o riscrivere il widget test quando esisterà una home reale o una struttura UI stabile.



\---



\# 19. Ordine di implementazione



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

10\. creare cartelle test

11\. creare supabase\_error\_mapper\_test.dart

12\. creare app\_feedback\_controller\_test.dart

13\. creare app\_session\_controller\_test.dart

14\. creare accessibility\_service\_test.dart

15\. gestire eventuale widget\_test.dart predefinito

16\. eseguire flutter analyze

17\. eseguire flutter test

18\. correggere eventuali errori

19\. rieseguire flutter analyze

20\. rieseguire flutter test

21\. aggiornare CHANGELOG.md

22\. commit

```



Regola:



```text

prima si scrive il blocco,

poi si scrivono subito i suoi test,

poi si passa oltre

```



\---



\# 20. Regole sugli import



\## 20.1 File che non devono importare Flutter UI



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



\## 20.2 Eccezione per foundation.dart



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



\## 20.3 File che può importare servizi Flutter



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



\# 21. Regole su BuildContext



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



\# 22. Regole su Supabase



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



\# 23. Modifiche a main.dart



In questo blocco non è necessario modificare pesantemente:



```text

lib/main.dart

```



\## Scelta consigliata



Non modificare `main.dart`, salvo correzioni necessarie per mantenere il progetto compilabile.



Motivazione:



il core deve nascere prima delle schermate reali.



La modifica del punto di ingresso dell'app sarà più adatta nel blocco auth/session.



\## Eccezione



Se `main.dart` contiene codice provvisorio che impedisce `flutter analyze` o `flutter test`, può essere corretto in modo minimo.



Non introdurre ancora il flusso completo:



```text

login / onboarding / home

```



Questo flusso verrà gestito nel blocco successivo.



\---



\# 24. Modifiche ai file provvisori



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



Se però uno di questi file impedisce:



```text

flutter analyze

flutter test

```



allora va corretto in modo minimo o isolato, senza anticipare il blocco auth/session.



\---



\# 25. Controlli dopo la codifica



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



\# 26. Test logici del blocco



I test logici non sostituiscono i test automatici.



Servono come ulteriore controllo umano.



\---



\## 26.1 Messaggi



Controllo:



```text

i messaggi utente principali sono in app\_messages.dart

```



Risultato atteso:



```text

nessun messaggio importante duplicato nei file core

```



\---



\## 26.2 Messaggi senza BuildContext



Controllo:



```text

app\_messages.dart non usa BuildContext

```



Risultato atteso:



```text

messaggi usabili da servizi e controller

```



\---



\## 26.3 Messaggi parametrici



Controllo:



```text

eventuali messaggi dinamici futuri sono previsti come metodi statici centralizzati

```



Risultato atteso:



```text

nessuna interpolazione utente importante sparsa nei widget

```



\---



\## 26.4 Errori



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



\## 26.5 Errori di rete



Controllo:



```text

il mapper prevede assenza rete e timeout

```



Risultato atteso:



```text

errore rete → messaggio connessione assente

```



\---



\## 26.6 Errori RLS



Controllo:



```text

il mapper prevede errori di autorizzazione e RLS

```



Risultato atteso:



```text

errore autorizzazione / RLS → Operazione non autorizzata.

```



\---



\## 26.7 Feedback



Controllo:



```text

AppFeedbackMessage contiene testo, tipo, testo accessibile opzionale e shouldAnnounce

```



Risultato atteso:



```text

feedback persistente rappresentabile

```



\---



\## 26.8 Feedback controller



Controllo:



```text

AppFeedbackController può impostare e cancellare il feedback corrente

```



Risultato atteso:



```text

le schermate future potranno mostrare un messaggio stabile

```



\---



\## 26.9 Accessibilità



Controllo:



```text

AccessibilityService centralizza gli annunci

```



Risultato atteso:



```text

nessun annuncio sparso necessario nei widget futuri

```



\---



\## 26.10 Sessione



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



\## 26.11 Controller sessione sincrono



Controllo:



```text

AppSessionController non legge Supabase Auth in questo blocco

```



Risultato atteso:



```text

il controller espone solo metodi di transizione stato

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

\* eventuali messaggi dinamici futuri hanno una regola centralizzata;

\* gli errori tecnici possono essere mappati in `AppException`;

\* il mapper errori segue la gerarchia di riconoscimento stabilita;

\* il mapper riconosce errori RLS/autorizzazione;

\* il mapper conserva `technicalMessage` quando disponibile;

\* il feedback persistente è rappresentabile;

\* esiste un controller feedback semplice;

\* esiste un servizio accessibilità minimo;

\* esiste uno stato sessione minimo;

\* esiste un controller sessione minimo e sincrono;

\* non sono stati creati file inutili;

\* i quattro file di test obbligatori sono stati creati;

\* i casi minimi obbligatori sono coperti;

\* eventuale `widget\_test.dart` predefinito è coerente, aggiornato o disabilitato motivatamente;

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

Aggiunti test automatici minimi obbligatori per mapper errori, feedback, sessione e accessibilità.

```



\---



\# 30. Commit consigliato



Messaggio commit consigliato per il codice:



```text

Aggiunge core Dart minimo

```



Se il commit riguarda solo questo documento TODO, usare:



```text

Aggiunge TODO core Flutter

```



\---



\# 31. Rischi da evitare



\## 31.1 Troppi file



Rischio:



creare tutti i file futuri elencati nel design.



Contromisura:



creare solo gli otto file previsti da questo TODO.



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



\## 31.4 Messaggi dinamici sparsi



Rischio:



inserire in futuro stringhe interpolate direttamente nei widget o nei servizi.



Contromisura:



eventuali messaggi parametrici devono essere metodi centralizzati in `AppMessages`.



\---



\## 31.5 Error mapper fragile



Rischio:



basarsi solo su testo libero.



Contromisura:



preferire tipo eccezione, codice errore, codice PostgreSQL, API Contracts, vincoli database.



Il testo libero resta solo fallback.



\---



\## 31.6 Barcode duplicato non riconosciuto



Rischio:



non intercettare correttamente il duplicato barcode.



Contromisura:



riconoscere il vincolo:



```text

prodotti\_barcode\_unique\_per\_azienda

```



quando disponibile.



Testare anche il caso unique violation con vincolo sconosciuto.



\---



\## 31.7 Errori RLS non testati



Rischio:



mostrare errori tecnici o generici quando l’operazione non è autorizzata.



Contromisura:



aggiungere test obbligatorio per operazione non autorizzata / RLS.



\---



\## 31.8 Feedback solo vocale



Rischio:



trattare l'annuncio screen reader come feedback principale.



Contromisura:



il feedback persistente resta il messaggio principale; l'annuncio è facoltativo.



\---



\## 31.9 Sessione troppo completa



Rischio:



implementare già login, logout e lettura profilo completa.



Contromisura:



in questo blocco si prepara lo stato sessione; il blocco auth/session completerà la logica reale.



\---



\## 31.10 Sessione troppo vuota



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



\## 31.11 Modificare main.dart troppo presto



Rischio:



anticipare login/onboarding/home prima del blocco dedicato.



Contromisura:



non modificare `main.dart`, salvo necessità di compilazione.



\---



\## 31.12 BuildContext non necessario



Rischio:



introdurre `BuildContext` nel core senza reale necessità.



Contromisura:



usare `BuildContext` solo se indispensabile.



Per gli annunci accessibili preferire `TextDirection` quando basta.



\---



\## 31.13 Rimandare i test



Rischio:



considerare i test come attività finale del progetto.



Contromisura:



ogni blocco deve nascere con i suoi test minimi.



Per questo blocco, i test automatici minimi sono obbligatori e fanno parte del criterio di completamento.



\---



\## 31.14 Accumulare debito di test



Rischio:



procedere con login, onboarding, prodotti e movimenti sopra un core non testato.



Contromisura:



non passare al blocco successivo se il core non ha test minimi superati.



\---



\## 31.15 Test che usano Supabase reale



Rischio:



trasformare unit test del core in test di integrazione instabili.



Contromisura:



i test del core devono usare errori simulati o oggetti costruiti localmente.



Non devono inizializzare `SupabaseClient`.



\---



\# 32. Revisione AI



Questo documento è stato revisionato tramite confronto con:



\* ChatGPT;

\* Gemini;

\* DeepSeek;

\* Claude.



Il giro di revisione ha prodotto giudizio complessivo:



```text

APPROVATO CON MODIFICHE MIRATE

```



Le modifiche integrate hanno riguardato:



\* rafforzamento dei test del mapper errori;

\* aggiunta del test per operazione non autorizzata / RLS;

\* aggiunta del test per errore non riconosciuto;

\* aggiunta del test per `technicalMessage`;

\* aggiunta di test RPC rappresentativi;

\* distinzione tra messaggi backend approvati dagli API Contracts e testo libero;

\* correzione dell'ordine della gerarchia del mapper;

\* test del barcode duplicato con vincolo riconosciuto;

\* test di unique violation con vincolo sconosciuto;

\* aggiunta del test leggero per `AccessibilityService`;

\* aggiunta della cartella test accessibilità;

\* gestione più chiara di `test/widget\_test.dart`;

\* regola per messaggi parametrici centralizzati;

\* spostamento del messaggio “Profilo già esistente” tra i messaggi informativi o di stato;

\* conferma dei file di produzione da creare e dei file da non creare.



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

docs/4-flutter/3-todos/001-TODO\_CORE\_mvp1\_v1.0.0.md

```



Documento revisionato tramite:



\* ChatGPT;

\* DeepSeek;

\* Gemini;

\* Claude.



\---



\# 34. Prossimo passo



Dopo l'approvazione di questo TODO si passerà al primo codice Dart del core.



Il codice dovrà seguire questo TODO.



Prima di passare al blocco successivo, dovranno essere completati:



```text

flutter analyze

flutter test

```



entrambi con esito positivo.



\---



\# 35. Conclusione



Questo TODO rende operativo il blocco core Dart minimo.



Il blocco dovrà creare:



\* otto file di produzione;

\* quattro file di test obbligatori;

\* messaggi centralizzati;

\* errori centralizzati;

\* mapper errori;

\* feedback persistente;

\* accessibilità minima;

\* sessione minima.



Il blocco non sarà completato senza:



```text

flutter analyze

flutter test

```



entrambi con esito positivo.



Il principio finale è:



```text

preparare una base semplice,

testarla subito,

poi costruire le funzionalità.

```



Con questo TODO approvato, il progetto può passare alla codifica del core Dart minimo.

