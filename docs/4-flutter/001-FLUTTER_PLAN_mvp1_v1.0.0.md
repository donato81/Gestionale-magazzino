# FLUTTER PLAN MVP 1.0

## Gestionale Magazzino Universale

Versione: 1.0.0
Stato: APPROVATO
Data: 4 luglio 2026

---

# 1. Scopo del documento

Questo documento definisce il piano ufficiale di avvio della fase Flutter per l'MVP 1 del progetto Gestionale Magazzino Universale.

La fase backend Supabase è già stata progettata, implementata e validata tramite test.

Lo scopo di questo documento è stabilire come iniziare lo sviluppo Flutter in modo ordinato, accessibile e coerente con le regole già approvate.

Il documento definisce:

* obiettivo della fase Flutter;
* ordine di sviluppo;
* struttura iniziale delle cartelle;
* separazione tra UI, servizi e core applicativo;
* regole per messaggi utente;
* regole per accessibilità e screen reader;
* regole di collegamento a Supabase;
* gestione sessione e stato iniziale dell'app;
* gestione semplice della navigazione;
* gestione degli errori di rete;
* test manuali minimi per ogni blocco.

Questo documento non contiene ancora codice Dart definitivo.

Serve come guida prima dell'implementazione.

---

# 2. Stato di partenza

Il progetto ha già completato la fase backend MVP 1.0.

Sono già stati approvati:

* documento architettura MVP 1.0;
* documento schema database MVP 1.0;
* documento flussi applicativi MVP 1.0;
* documento regole backend MVP 1.0;
* script SQL Supabase;
* piano test backend.

Sono già stati eseguiti su Supabase:

* `001_schema.sql`;
* `002_rpc.sql`;
* `003_rls.sql`;
* `004_onboarding_rpc.sql`.

Il backend è stato validato tramite test.

La fase Flutter può quindi iniziare senza riprogettare il database di base.

---

# 3. Obiettivo della fase Flutter MVP 1.0

L'obiettivo della fase Flutter è costruire una prima applicazione utilizzabile che permetta a un utente di:

1. accedere con email e password;
2. uscire dall'app tramite logout;
3. completare l'onboarding iniziale se non ha ancora un profilo;
4. visualizzare la home aziendale;
5. gestire categorie;
6. gestire fornitori;
7. gestire prodotti;
8. registrare movimenti di magazzino;
9. visualizzare la scorta aggiornata;
10. consultare lo storico dei movimenti;
11. usare l'app tramite screen reader.

L'obiettivo non è costruire subito un'app completa e rifinita.

L'obiettivo è costruire un MVP solido, ordinato, accessibile e coerente con il backend già validato.

---

# 4. Principio guida

La fase Flutter deve seguire questo principio:

> Prima si costruisce una base ordinata, poi si costruiscono le schermate.

Non si parte direttamente creando schermate piene di logica.

Prima bisogna definire:

* messaggi centralizzati;
* gestione errori;
* feedback accessibile;
* gestione sessione;
* servizi Supabase;
* modelli dati essenziali;
* struttura cartelle;
* regole di navigazione.

Solo dopo si costruiscono le schermate vere.

---

# 5. Ordine generale di lavoro

L'ordine consigliato è:

```text
1. Piano Flutter
2. Core Dart minimo
3. Sistema messaggi centralizzato
4. Sistema errori centralizzato
5. Sistema feedback accessibile
6. Gestione sessione minima
7. Servizi Supabase
8. Login / logout / sessione
9. Onboarding
10. Home
11. Categorie
12. Fornitori
13. Prodotti
14. Movimenti
15. Storico movimenti
16. Verifica accessibilità complessiva
```

Questo ordine evita di creare codice disordinato e difficile da modificare.

---

# 6. Decisione D01 — Prima core, poi UI

Decisione:

```text
SÌ
```

Prima di costruire le schermate definitive, verrà creato un core Dart minimo.

Il core Dart conterrà le parti comuni dell'applicazione:

* messaggi;
* errori;
* feedback;
* accessibilità;
* sessione;
* servizi condivisi;
* modelli base;
* utilità comuni.

Motivazione:

se si parte subito dalle schermate, il rischio è avere:

* testi sparsi nei pulsanti;
* errori gestiti in modi diversi;
* query Supabase dentro la UI;
* logica duplicata;
* accessibilità aggiunta dopo, in modo fragile.

Il core serve per evitare questo problema.

---

# 7. Decisione D02 — Nessuna stringa utente hardcoded sparsa

Decisione:

```text
SÌ
```

Nessun testo visibile all'utente deve essere scritto direttamente dentro:

* pulsanti;
* metodi;
* servizi Supabase;
* repository;
* funzioni di salvataggio;
* funzioni di errore;
* callback dei widget.

I testi devono essere centralizzati.

Esempi di testi da centralizzare:

* "Accesso eseguito correttamente";
* "Uscita eseguita correttamente";
* "Email obbligatoria";
* "Password obbligatoria";
* "Prodotto creato correttamente";
* "Scorta insufficiente";
* "Categoria salvata";
* "Errore durante il caricamento dei dati";
* "Connessione assente. Controlla Internet e riprova.";
* "Attenzione: scorta inferiore al livello minimo".

Motivazione:

le stringhe sparse rendono l'app difficile da mantenere.

Un sistema centralizzato permette di:

* correggere un testo in un solo punto;
* mantenere coerenza tra schermate;
* preparare una futura localizzazione;
* gestire meglio i messaggi per screen reader;
* evitare messaggi diversi per lo stesso errore.

---

# 8. Sistema messaggi centralizzato

Verrà creato un sistema centrale per i messaggi utente.

Cartella proposta:

```text
lib/core/messages/
```

File iniziali proposti:

```text
app_messages.dart
app_error_messages.dart
app_accessibility_messages.dart
```

## 8.1 app_messages.dart

Contiene i messaggi normali dell'app.

Esempi:

* login riuscito;
* logout riuscito;
* categoria creata;
* fornitore creato;
* prodotto creato;
* movimento registrato;
* dati salvati;
* nessun risultato trovato.

## 8.2 app_error_messages.dart

Contiene i messaggi di errore mostrati all'utente.

Esempi:

* email obbligatoria;
* password obbligatoria;
* nome obbligatorio;
* scorta insufficiente;
* prodotto non trovato;
* fornitore non valido;
* errore di connessione;
* sessione scaduta;
* operazione non autorizzata.

## 8.3 app_accessibility_messages.dart

Contiene messaggi pensati per gli screen reader.

Esempi:

* accesso completato;
* uscita completata;
* salvataggio completato;
* errore nel modulo;
* prodotto selezionato;
* movimento registrato;
* attenzione scorta minima superata.

Questi messaggi possono essere uguali o leggermente diversi dai messaggi visivi.

L'importante è che siano chiari quando vengono ascoltati.

---

# 9. Decisione D03 — Feedback persistente

Decisione:

```text
SÌ
```

I messaggi importanti non devono essere solo temporanei.

L'app deve prevedere un'area di feedback stabile nella schermata.

Questa area deve poter mostrare:

* messaggi di successo;
* messaggi di errore;
* avvisi;
* informazioni importanti.

Esempi:

```text
Prodotto salvato correttamente.
Errore: il nome prodotto è obbligatorio.
Attenzione: scorta inferiore al livello minimo.
Movimento registrato correttamente.
```

Motivazione:

un messaggio temporaneo può non essere letto dallo screen reader.

Un messaggio stabile può invece essere riletto dall'utente.

Questa decisione nasce anche dai problemi emersi nella console Flutter provvisoria, dove alcuni messaggi non venivano intercettati chiaramente da NVDA.

---

# 10. Sistema feedback applicativo

Cartella proposta:

```text
lib/core/feedback/
```

File iniziali proposti:

```text
app_feedback_message.dart
app_feedback_controller.dart
```

## 10.1 app_feedback_message.dart

Definisce il tipo di messaggio.

Tipi previsti:

```text
successo
errore
avviso
informazione
```

Ogni messaggio dovrebbe contenere:

* testo visibile;
* eventuale testo per screen reader;
* tipo del messaggio;
* eventuale indicazione se deve essere annunciato.

## 10.2 app_feedback_controller.dart

Gestisce il messaggio corrente mostrato nella schermata.

Responsabilità:

* impostare un nuovo messaggio;
* cancellare il messaggio;
* indicare se il messaggio è errore, successo, avviso o informazione;
* collaborare con il sistema accessibilità.

---

# 11. Decisione D04 — Accessibilità non rimandata

Decisione:

```text
SÌ
```

L'accessibilità non deve essere aggiunta alla fine.

Ogni schermata deve nascere già accessibile.

Regole minime:

* pulsanti con testo chiaro;
* campi modulo con etichetta chiara;
* messaggi leggibili da screen reader;
* ordine logico degli elementi;
* nessuna informazione affidata solo al colore;
* nessuna informazione affidata solo alle icone;
* feedback sempre testuale;
* errori spiegati in modo comprensibile;
* schermate utilizzabili da tastiera e screen reader dove applicabile.

---

# 12. Sistema accessibilità

Cartella proposta:

```text
lib/core/accessibility/
```

File iniziali proposti:

```text
accessibility_service.dart
accessible_feedback.dart
focus_helpers.dart
```

## 12.1 accessibility_service.dart

Responsabilità:

* centralizzare eventuali annunci per screen reader;
* evitare annunci sparsi nei widget;
* fornire metodi semplici da usare nelle schermate.

Esempi logici:

```text
annuncia successo
annuncia errore
annuncia avviso
annuncia cambio schermata
```

## 12.2 accessible_feedback.dart

Responsabilità:

* collegare il messaggio visivo al messaggio accessibile;
* garantire che un messaggio importante sia sia mostrato sia leggibile.

## 12.3 focus_helpers.dart

Responsabilità:

* supportare lo spostamento del focus nei punti importanti;
* aiutare nei form;
* aiutare dopo salvataggi o errori.

Nota:

questo sistema non sostituisce la corretta costruzione delle schermate.

Serve come supporto centrale.

La vera accessibilità dipende anche da come vengono scritti i widget.

---

# 13. Decisione D05 — Non basarsi solo sugli annunci vocali

Decisione:

```text
SÌ
```

Gli annunci vocali sono utili, ma non devono essere l'unico modo per comunicare un risultato.

Regola:

```text
Prima il messaggio deve essere presente nella schermata.
Poi, se utile, può anche essere annunciato.
```

Motivazione:

se lo screen reader non intercetta un annuncio, l'utente deve comunque poter ritrovare il messaggio nella schermata.

Questa regola è fondamentale per l'accessibilità.

---

# 14. Decisione D06 — Backend fonte della verità

Decisione:

```text
SÌ
```

Flutter non deve duplicare le regole critiche del backend come se fosse lui la fonte della verità.

Flutter deve:

* raccogliere dati;
* validare i form in modo utile all'utente;
* mostrare errori;
* invocare Supabase;
* invocare le RPC;
* leggere i risultati;
* aggiornare la UI.

Flutter non deve:

* modificare direttamente `prodotti.scorta_attuale`;
* inserire direttamente record in `movimenti_magazzino`;
* aggirare le RPC;
* applicare da solo regole critiche senza conferma backend;
* fidarsi dei dati locali come fonte definitiva.

---

# 15. Collegamento a Supabase

Supabase è già configurato nel progetto Flutter tramite:

```text
lib/config/supabase_config.dart
```

Il client Flutter deve usare solo:

```text
anon public key
```

Non deve mai usare:

```text
service role key
```

La service role key non deve mai essere inserita nell'app Flutter.

---

# 16. Regole Supabase per Flutter

Flutter può eseguire query consentite dalle RLS su:

* aziende;
* profili;
* categorie;
* fornitori;
* prodotti;
* movimenti_magazzino in sola lettura.

Flutter può inserire e aggiornare:

* categorie;
* fornitori;
* prodotti;
* profilo, dove consentito.

Flutter non può:

* eliminare fisicamente categorie;
* eliminare fisicamente fornitori;
* eliminare fisicamente prodotti;
* eliminare o modificare movimenti;
* inserire movimenti direttamente;
* aggiornare direttamente la scorta.

Per i movimenti Flutter deve usare:

```text
registra_movimento
```

Per l'onboarding Flutter deve usare:

```text
crea_azienda_e_profilo
```

---

# 17. Gestione errori Supabase

Gli errori tecnici di Supabase non devono essere mostrati direttamente all'utente finale se sono troppo tecnici.

Serve un livello di traduzione.

Cartella proposta:

```text
lib/core/errors/
```

File iniziali proposti:

```text
app_exception.dart
supabase_error_mapper.dart
```

## 17.1 app_exception.dart

Definisce un errore applicativo comprensibile.

Deve contenere:

* messaggio utente;
* tipo errore;
* eventuale dettaglio tecnico per debug;
* eventuale messaggio accessibile.

## 17.2 supabase_error_mapper.dart

Converte errori Supabase in messaggi comprensibili.

Esempi:

```text
Errore tecnico: duplicate key
Messaggio utente: Esiste già un elemento con questo nome.

Errore tecnico: invalid login credentials
Messaggio utente: Email o password non corrette.

Errore tecnico: JWT expired
Messaggio utente: Sessione scaduta. Accedi di nuovo.
```

---

# 18. Gestione assenza rete

L'offline completo non fa parte dell'MVP 1.

L'app non deve implementare sincronizzazione offline in questa fase.

Tuttavia deve gestire in modo chiaro gli errori di connessione.

Se una chiamata Supabase fallisce per assenza di rete, timeout o problema simile, l'utente deve ricevere un messaggio comprensibile.

Esempi:

```text
Connessione assente. Controlla Internet e riprova.
Impossibile completare l'operazione. Verifica la connessione.
```

Questi messaggi devono passare dal sistema centralizzato degli errori.

Non devono essere scritti direttamente nelle schermate.

La gestione degli errori di rete deve quindi essere integrata in:

```text
supabase_error_mapper.dart
```

oppure nel sistema equivalente di mappatura errori.

---

# 19. Gestione stato e dipendenze

Per l'MVP 1 si userà una gestione dello stato semplice.

Non verranno introdotti subito pattern complessi come BLoC.

La sessione utente, il profilo corrente e l'azienda corrente saranno gestiti da un controller centrale, ad esempio:

```text
AppSessionController
```

Questo controller avrà il compito di sapere:

* se l'utente è autenticato;
* se esiste una sessione Supabase;
* se esiste un profilo applicativo;
* quale azienda è collegata all'utente;
* quale schermata iniziale deve essere mostrata.

Il client Supabase sarà centralizzato.

Le schermate non devono inizializzare direttamente Supabase e non devono contenere query sparse.

Le schermate dovranno chiamare servizi o controller dedicati.

Per l'MVP 1 non si introduce obbligatoriamente un service locator come `get_it`.

Se il numero di servizi crescerà, l'introduzione di un service locator potrà essere valutata in una fase successiva.

## 19.1 Scelta consigliata per lo stato

Per partire in modo semplice si potranno usare:

* controller Dart semplice;
* `ValueNotifier`;
* `ChangeNotifier`.

Da evitare in questa fase:

* BLoC completo per ogni schermata;
* architetture di stato complesse premature;
* service locator introdotti prima che siano realmente necessari.

## 19.2 Regola sulle dipendenze

Regola:

```text
Le schermate non devono creare direttamente il client Supabase.
```

Le schermate devono parlare con servizi o controller.

I servizi useranno il client Supabase già configurato.

---

# 20. Struttura cartelle proposta

Struttura iniziale consigliata:

```text
lib/
  main.dart

  config/
    supabase_config.dart

  core/
    accessibility/
      accessibility_service.dart
      accessible_feedback.dart
      focus_helpers.dart

    errors/
      app_exception.dart
      supabase_error_mapper.dart

    feedback/
      app_feedback_controller.dart
      app_feedback_message.dart

    messages/
      app_messages.dart
      app_error_messages.dart
      app_accessibility_messages.dart

    session/
      app_session_controller.dart

  features/
    auth/
      data/
      domain/
      presentation/

    onboarding/
      data/
      domain/
      presentation/

    home/
      presentation/

    categorie/
      data/
      domain/
      presentation/

    fornitori/
      data/
      domain/
      presentation/

    prodotti/
      data/
      domain/
      presentation/

    movimenti/
      data/
      domain/
      presentation/
```

Questa struttura separa:

* dati;
* logica;
* schermate;
* core condiviso.

## 20.1 data

Contiene il collegamento concreto a Supabase.

Esempi:

* query;
* insert;
* update;
* RPC.

## 20.2 domain

Contiene modelli e regole applicative semplici.

Esempi:

* modello categoria;
* modello prodotto;
* modello movimento;
* validazioni non critiche per form.

## 20.3 presentation

Contiene schermate e widget.

Esempi:

* pagina login;
* pagina lista prodotti;
* form prodotto;
* pagina movimento.

## 20.4 core

Contiene elementi condivisi da tutta l'app.

Esempi:

* messaggi;
* errori;
* accessibilità;
* feedback;
* sessione;
* utilità comuni.

---

# 21. Nota sulla semplicità

La struttura proposta non deve diventare troppo pesante.

Se in una fase iniziale una cartella resta vuota, non è un problema.

L'obiettivo è avere una direzione ordinata, non creare complessità inutile.

Regola pratica:

```text
Creare solo i file che servono davvero nel passo corrente.
```

Questa regola è fondamentale.

La struttura cartelle indica la direzione del progetto, ma non obbliga a creare immediatamente tutti i file previsti.

Per il primo blocco di codice è sufficiente creare solo il core minimo davvero necessario.

Esempio di partenza minima:

```text
messaggi base
mapper errori semplice
feedback persistente semplice
accessibility_service minimo
app_session_controller minimo
```

File più specifici, come `focus_helpers.dart`, possono essere creati solo quando serviranno davvero.

---

# 22. Schermate MVP previste

Le schermate previste per l'MVP 1 sono:

```text
Login
Onboarding
Home
Lista categorie
Form categoria
Lista fornitori
Form fornitore
Lista prodotti
Dettaglio prodotto
Form prodotto
Registrazione carico
Registrazione vendita
Registrazione rettifica
Storico movimenti
```

Il reso è previsto dalla logica backend, ma può essere inserito dopo carico, vendita e rettifica se si vuole ridurre la complessità iniziale dell'interfaccia.

---

# 23. Ordine di sviluppo delle schermate

Ordine consigliato:

## Fase 1 — Login, logout e sessione

Obiettivo:

* login;
* logout;
* controllo sessione;
* gestione utente autenticato;
* ritorno corretto alla login dopo logout.

## Fase 2 — Onboarding

Obiettivo:

* se l'utente non ha profilo, mostrare onboarding;
* creare azienda e profilo tramite RPC;
* impedire doppio onboarding.

## Fase 3 — Home

Obiettivo:

* mostrare nome azienda;
* mostrare utente corrente;
* collegamenti alle sezioni principali.

## Fase 4 — Categorie

Obiettivo:

* lista categorie;
* creazione categoria;
* modifica categoria;
* disattivazione logica tramite `attiva = false` in una fase successiva.

## Fase 5 — Fornitori

Obiettivo:

* lista fornitori;
* creazione fornitore;
* modifica fornitore;
* disattivazione logica tramite `attivo = false` in una fase successiva.

## Fase 6 — Prodotti

Obiettivo:

* lista prodotti;
* dettaglio prodotto;
* creazione prodotto;
* modifica prodotto;
* visualizzazione scorta;
* collegamento a categoria e fornitore.

## Fase 7 — Movimenti

Obiettivo:

* carico;
* vendita;
* rettifica;
* storico movimenti.

## Fase 8 — Revisione accessibilità

Obiettivo:

* testare l'intero flusso con screen reader;
* correggere etichette;
* correggere ordine focus;
* correggere messaggi poco chiari;
* verificare che nessuna informazione sia solo visiva.

---

# 24. Regole per i form

Ogni form deve rispettare queste regole:

* ogni campo ha una label chiara;
* ogni campo obbligatorio viene indicato in modo testuale;
* gli errori vengono mostrati vicino al campo o in area messaggi;
* il primo errore importante deve essere facilmente raggiungibile;
* il salvataggio deve produrre un messaggio di conferma;
* il fallimento deve produrre un messaggio di errore comprensibile;
* i pulsanti devono avere testo esplicito.

Esempi di pulsanti corretti:

```text
Salva categoria
Annulla modifica
Crea prodotto
Registra carico
Registra vendita
```

Esempi da evitare:

```text
OK
Vai
Conferma
Icona senza testo
```

---

# 25. Regole per le liste

Ogni lista deve essere leggibile anche con screen reader.

Una riga di lista deve comunicare le informazioni essenziali.

Esempio per prodotto:

```text
Concime Universale Modificato, scorta 5 pezzi, prezzo vendita 12 euro.
```

Non deve essere letta solo come:

```text
Concime Universale Modificato
```

se le altre informazioni sono importanti per decidere cosa fare.

---

# 26. Regole per i movimenti

I movimenti di magazzino devono sempre passare dalla RPC:

```text
registra_movimento
```

## 26.1 Carico

Flutter deve inviare:

* prodotto;
* tipo movimento `carico`;
* quantità;
* fornitore;
* prezzo unitario;
* note facoltative.

Il fornitore è obbligatorio.

## 26.2 Vendita

Flutter deve inviare:

* prodotto;
* tipo movimento `vendita`;
* quantità;
* prezzo unitario facoltativo;
* note facoltative.

Il fornitore non deve essere inviato.

## 26.3 Rettifica

Flutter deve inviare:

* prodotto;
* tipo movimento `rettifica`;
* nuova scorta;
* motivazione.

La quantità non deve essere inviata.

La motivazione deve essere obbligatoria lato UI, anche se tecnicamente nel backend il campo note è nullable.

Motivazione:

una rettifica senza motivo è poco utile nello storico.

## 26.4 Reso

Il reso rappresenta merce restituita dal cliente.

Aumenta la scorta.

Il fornitore non deve essere inviato.

Il reso può essere implementato dopo carico, vendita e rettifica.

---

# 27. Regole per prodotti inattivi

Un prodotto inattivo:

* non deve essere proposto nei form di carico;
* non deve essere proposto nei form di vendita;
* non deve essere proposto nei form di reso;
* non deve essere proposto nei form di rettifica.

Il backend blocca comunque i movimenti su prodotto disattivato.

Flutter deve però evitare di presentare all'utente scelte non valide.

---

# 28. Regole per categorie e fornitori inattivi

Categorie inattive:

* non devono essere proposte come scelta normale nei nuovi prodotti;
* possono restare visibili nello storico o nei prodotti già associati.

Fornitori inattivi:

* non devono essere proposti nei nuovi carichi;
* possono restare visibili nello storico dei movimenti passati.

---

# 29. Navigazione MVP

Per l'MVP 1 si userà una navigazione semplice basata su:

```text
Navigator.push
Navigator.pop
```

Non viene introdotto subito un router esterno come `go_router`.

La scelta è motivata dalla volontà di mantenere il progetto:

* semplice;
* leggibile;
* adatto allo sviluppo manuale;
* facile da seguire con screen reader;
* modificabile passo per passo.

Ogni schermata deve avere:

* titolo chiaro;
* pulsanti di navigazione espliciti;
* ritorno prevedibile alla schermata precedente;
* eventuale messaggio o annuncio accessibile quando il cambio schermata è importante.

La schermata iniziale dell'app deve decidere in modo centralizzato se mostrare:

* login;
* onboarding;
* home.

Questa logica non deve essere duplicata in più pagine.

`go_router` o altri sistemi di routing più strutturati potranno essere valutati in futuro se la navigazione crescerà di complessità.

---

# 30. Stato iniziale dell'app

All'avvio l'app deve verificare:

```text
utente non autenticato
↓
mostra login
```

```text
utente autenticato senza profilo
↓
mostra onboarding
```

```text
utente autenticato con profilo
↓
mostra home
```

Questo controllo deve essere centralizzato, non duplicato in più schermate.

La logica appartiene al controller di sessione o al punto di ingresso dell'app, non alle singole schermate.

---

# 31. Fuori scope MVP 1 — Recupero password

Il recupero password non fa parte dell'MVP 1 Flutter.

Potrà essere progettato in una fase successiva.

In questa fase l'obiettivo è validare:

* login;
* logout;
* onboarding;
* home;
* categorie;
* fornitori;
* prodotti;
* movimenti principali di magazzino.

Il fatto che il recupero password sia fuori scope deve essere esplicito, così da non confonderlo con una dimenticanza.

---

# 32. Test manuali minimi — Login

## Test L001 — Schermata login leggibile

Risultato atteso:

* screen reader legge titolo;
* legge campo email;
* legge campo password;
* legge pulsante accedi.

## Test L002 — Login con campi vuoti

Risultato atteso:

* messaggio errore email obbligatoria;
* messaggio errore password obbligatoria;
* messaggio leggibile da screen reader.

## Test L003 — Login credenziali errate

Risultato atteso:

* messaggio comprensibile;
* nessun dettaglio tecnico inutile.

## Test L004 — Login corretto

Risultato atteso:

* accesso eseguito;
* passaggio alla schermata corretta;
* feedback accessibile.

## Test L005 — Logout

Risultato atteso:

* la sessione viene terminata;
* l'utente torna alla schermata login;
* la home non è più accessibile senza nuovo accesso;
* il messaggio di logout è leggibile da screen reader.

---

# 33. Test manuali minimi — Onboarding

## Test O001 — Utente senza profilo

Risultato atteso:

* app mostra onboarding.

## Test O002 — Nome azienda vuoto

Risultato atteso:

* errore nome azienda obbligatorio.

## Test O003 — Onboarding corretto

Risultato atteso:

* RPC chiamata correttamente;
* azienda creata;
* profilo creato;
* passaggio alla home.

## Test O004 — Onboarding duplicato

Risultato atteso:

* errore gestito in modo comprensibile;
* nessuna seconda azienda creata.

---

# 34. Test manuali minimi — Home

## Test H001 — Home leggibile

Risultato atteso:

* screen reader legge nome azienda;
* legge utente;
* legge collegamenti principali.

## Test H002 — Navigazione sezioni

Risultato atteso:

* categorie raggiungibile;
* fornitori raggiungibile;
* prodotti raggiungibile;
* movimenti raggiungibile.

---

# 35. Test manuali minimi — Categorie

## Test C001 — Lista categorie

Risultato atteso:

* categorie caricate;
* ogni riga leggibile.

## Test C002 — Creazione categoria

Risultato atteso:

* categoria salvata;
* messaggio successo;
* lista aggiornata.

## Test C003 — Nome categoria vuoto

Risultato atteso:

* errore leggibile.

## Test C004 — Nome duplicato

Risultato atteso:

* errore comprensibile.

---

# 36. Test manuali minimi — Fornitori

## Test F001 — Lista fornitori

Risultato atteso:

* fornitori caricati;
* ogni riga leggibile.

## Test F002 — Creazione fornitore

Risultato atteso:

* fornitore salvato;
* messaggio successo;
* lista aggiornata.

## Test F003 — Nome fornitore vuoto

Risultato atteso:

* errore leggibile.

## Test F004 — Nome duplicato

Risultato atteso:

* errore comprensibile.

---

# 37. Test manuali minimi — Prodotti

## Test P001 — Lista prodotti

Risultato atteso:

* prodotti caricati;
* nome e scorta leggibili.

## Test P002 — Creazione prodotto

Risultato atteso:

* prodotto salvato;
* scorta iniziale 0;
* messaggio successo.

## Test P003 — Barcode vuoto

Risultato atteso:

* barcode salvato come NULL;
* nessuna stringa vuota.

## Test P004 — Barcode duplicato

Risultato atteso:

* errore comprensibile.

## Test P005 — Modifica prodotto

Risultato atteso:

* dati aggiornati;
* scorta non modificata direttamente.

## Test P006 — Prodotto inattivo in lista

Risultato atteso:

* il prodotto inattivo resta gestibile dove previsto;
* il suo stato inattivo è comunicato in modo testuale;
* lo stato non è comunicato solo tramite colore o icona.

---

# 38. Test manuali minimi — Movimenti

## Test M001 — Carico valido

Risultato atteso:

* RPC `registra_movimento` chiamata;
* scorta aumentata;
* movimento creato;
* messaggio successo.

## Test M002 — Carico senza fornitore

Risultato atteso:

* errore prima dell'invio oppure errore backend tradotto;
* messaggio chiaro.

## Test M003 — Vendita valida

Risultato atteso:

* scorta diminuita;
* movimento creato.

## Test M004 — Vendita con scorta insufficiente

Risultato atteso:

* errore chiaro;
* scorta invariata;
* nessun movimento creato.

## Test M005 — Rettifica valida

Risultato atteso:

* scorta impostata correttamente;
* movimento creato;
* motivazione presente nelle note.

## Test M006 — Rettifica senza motivazione

Risultato atteso:

* errore UI;
* RPC non chiamata.

## Test M007 — Storico movimenti

Risultato atteso:

* movimenti leggibili;
* tipo movimento leggibile;
* quantità leggibile;
* scorta prima e dopo leggibili;
* fornitore leggibile nei carichi.

## Test M008 — Prodotto inattivo non selezionabile

Risultato atteso:

* un prodotto con `attivo = false` non compare nei form di carico;
* un prodotto con `attivo = false` non compare nei form di vendita;
* un prodotto con `attivo = false` non compare nei form di rettifica;
* se si tenta comunque una chiamata non valida, il backend blocca l'operazione;
* il messaggio mostrato all'utente è chiaro.

---

# 39. Test manuali minimi — Connessione

## Test N001 — Assenza rete durante caricamento dati

Risultato atteso:

* l'errore tecnico non viene mostrato grezzo;
* l'utente riceve un messaggio comprensibile;
* il messaggio è persistente;
* il messaggio è leggibile da screen reader.

## Test N002 — Assenza rete durante salvataggio

Risultato atteso:

* il salvataggio non viene considerato riuscito;
* l'utente riceve un messaggio di errore chiaro;
* nessun messaggio falso di successo viene mostrato;
* l'utente può riprovare.

---

# 40. Regole di sviluppo operative

Durante lo sviluppo Flutter:

* modificare pochi file per volta;
* testare ogni blocco prima di passare al successivo;
* non creare file enormi;
* non duplicare logica;
* non inserire testi utente dentro i metodi;
* non usare service role key;
* non bypassare RLS;
* non chiamare direttamente insert su movimenti;
* non aggiornare direttamente scorta;
* non creare tutto il core in una volta sola;
* documentare le decisioni importanti;
* mantenere il codice leggibile anche per revisione manuale.

---

# 41. Metodo di lavoro consigliato

Per ogni blocco Flutter si userà questo metodo:

```text
1. Mini obiettivo
2. File da creare o modificare
3. Codice minimo
4. Test manuale
5. Esito PASS/FAIL
6. Eventuale correzione
7. Approvazione del blocco
```

Questo metodo è adatto allo sviluppo manuale con VS Code e screen reader.

---

# 42. Primo blocco di codice dopo questo documento

Dopo l'approvazione di questo documento, il primo blocco di codice non sarà una schermata completa.

Il primo blocco sarà il core minimo.

Ordine consigliato:

```text
1. verificare struttura attuale lib/
2. creare cartelle core minime
3. creare messaggi base
4. creare errori base
5. creare feedback persistente semplice
6. creare accessibilità minima
7. creare gestione sessione minima
```

Il primo obiettivo non è costruire subito tutte le funzionalità.

Il primo obiettivo è evitare disordine futuro.

---

# 43. Criterio di successo della fase Flutter MVP 1.0

La fase Flutter MVP 1.0 sarà considerata completata quando un utente potrà:

1. aprire l'app;
2. accedere;
3. uscire tramite logout;
4. completare onboarding se necessario;
5. entrare nella home;
6. creare e modificare categorie;
7. creare e modificare fornitori;
8. creare e modificare prodotti;
9. registrare carichi;
10. registrare vendite;
11. registrare rettifiche;
12. visualizzare la scorta aggiornata;
13. consultare lo storico movimenti;
14. ricevere messaggi chiari;
15. ricevere errori comprensibili;
16. gestire errori di connessione senza messaggi tecnici grezzi;
17. usare il flusso principale con screen reader.

---

# 44. Decisioni confermate

1. Prima core Dart, poi UI.
2. Nessuna stringa utente hardcoded sparsa.
3. Sistema centralizzato messaggi.
4. Sistema centralizzato errori.
5. Sistema feedback persistente.
6. Sistema supporto accessibilità.
7. Non basarsi solo su annunci vocali.
8. Backend fonte della verità.
9. Movimenti sempre tramite RPC.
10. Onboarding tramite RPC.
11. Nessuna modifica diretta della scorta.
12. Nessun inserimento diretto dei movimenti.
13. Sviluppo incrementale.
14. Accessibilità non rimandata.
15. Gestione sessione centralizzata.
16. Navigazione semplice con `Navigator.push` e `Navigator.pop`.
17. Nessun router esterno obbligatorio nell'MVP 1.
18. Nessun service locator obbligatorio nell'MVP 1.
19. Nessun BLoC completo per ogni schermata nell'MVP 1.
20. Gestione degli errori di rete tramite sistema centralizzato.
21. Recupero password fuori scope per MVP 1.
22. Reso implementabile dopo carico, vendita e rettifica.

---

# 45. Revisione AI

Questo documento è stato preparato da ChatGPT e revisionato concettualmente tramite confronto con:

* DeepSeek;
* Gemini.

Le osservazioni dei revisori sono state integrate.

In particolare sono state aggiunte o rafforzate le sezioni relative a:

* gestione stato e sessione;
* dipendenze;
* navigazione;
* assenza rete;
* logout;
* prodotto inattivo nei movimenti;
* recupero password fuori scope;
* rischio di sovra-architettura;
* creazione progressiva del core.

---

# 46. Stato del documento

Stato:

```text
APPROVATO
```

Versione:

```text
1.0.0
```

Nome file consigliato:

```text
docs/4-flutter/001-FLUTTER_PLAN_mvp1_v1.0.0.md
```

Passo successivo:

```text
creazione del core Dart minimo:
messaggi, errori, feedback, accessibilità, sessione e servizi Supabase di base.
```

---

# 47. Conclusione

La fase Flutter può iniziare.

Il backend rimane la fonte della verità.

Flutter deve essere costruito in modo ordinato, progressivo e accessibile.

La priorità iniziale non è creare rapidamente schermate complete, ma costruire una base pulita che impedisca:

* stringhe sparse;
* errori tecnici mostrati all'utente;
* logica Supabase dentro la UI;
* feedback non leggibile;
* accessibilità aggiunta solo alla fine;
* file troppo grandi e difficili da mantenere.
