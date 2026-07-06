# FLUTTER PLAN MVP 1.0

## Gestionale Magazzino Universale

Versione: 1.0.0
Stato: APPROVATO
Data: 6 luglio 2026
-------------------

# 1. Scopo del documento

Questo documento definisce il piano ufficiale della fase Flutter per l'MVP 1 del progetto Gestionale Magazzino Universale.
La fase backend Supabase è già stata progettata, implementata e validata tramite test.
Lo scopo di questo documento è stabilire come sviluppare l'app Flutter in modo ordinato, accessibile e coerente con le regole già approvate.
Il documento definisce:

* obiettivo della fase Flutter;
* ordine di sviluppo;
* struttura iniziale delle cartelle;
* separazione tra UI, servizi e core applicativo;
* regole per messaggi utente;
* regole per accessibilità e screen reader;
* regole di collegamento a Supabase;
* gestione sessione e stato iniziale dell'app;
* registrazione account;
* onboarding azienda/profilo;
* gestione semplice della navigazione;
* gestione degli errori di rete;
* test manuali minimi per ogni blocco.
  Questo documento non contiene codice Dart definitivo.
  Serve come guida prima dell'implementazione dei singoli blocchi.

---

# 2. Stato di partenza

Il progetto ha già completato la fase backend MVP 1.0.
Sono già stati approvati:

* documento architettura MVP 1.0;
* documento schema database MVP 1.0;
* documento flussi applicativi MVP 1.0;
* documento regole backend MVP 1.0;
* API Contracts MVP 1.0;
* script SQL Supabase;
* piano test backend;
* piano Flutter MVP 1.0;
* todo master Flutter;
* design, coding plan e TODO del blocco 001 Core Dart minimo;
* design, coding plan e TODO del blocco 002 Auth/Session.
  Sono già stati eseguiti su Supabase:
* `001_schema.sql`;
* `002_rpc.sql`;
* `003_rls.sql`;
* `004_onboarding_rpc.sql`.
  Il backend è stato validato tramite test.
  Il blocco 001 Core Dart minimo è stato codificato, testato, committato, pushato e mergiato in `main`.
  Il blocco 002 Login, logout e sessione è stato codificato, testato, corretto per accessibilità NVDA, committato, pushato e mergiato in `main`.
  Dopo il merge del blocco 002:

```text
flutter analyze
flutter test
```

risultano puliti su `main`.
La fase successiva non è più onboarding diretto.
La prossima fase è la progettazione del blocco 003:

```text
Registrazione account
```

---

# 3. Obiettivo della fase Flutter MVP 1.0

L'obiettivo della fase Flutter è costruire una prima applicazione utilizzabile che permetta a un utente di:

1. registrare un nuovo account dall'app;
2. accedere con email e password;
3. uscire dall'app tramite logout;
4. completare l'onboarding iniziale se non ha ancora un profilo;
5. creare azienda e profilo applicativo tramite flusso guidato;
6. visualizzare la home aziendale;
7. gestire categorie;
8. gestire fornitori;
9. gestire prodotti;
10. registrare movimenti di magazzino;
11. visualizzare la scorta aggiornata;
12. consultare lo storico dei movimenti;
13. usare l'app tramite screen reader.
    L'obiettivo non è costruire subito un'app completa e rifinita.
    L'obiettivo è costruire un MVP solido, ordinato, accessibile e coerente con il backend già validato.

---

# 4. Principio guida

La fase Flutter deve seguire questo principio:

> Prima si costruisce una base ordinata, poi si costruiscono le schermate.
> Non si parte direttamente creando schermate piene di logica.
> Prima bisogna definire:

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

L'ordine aggiornato della fase Flutter è:

```text
1. Piano Flutter
2. Core Dart minimo
3. Sistema messaggi centralizzato
4. Sistema errori centralizzato
5. Sistema feedback accessibile
6. Gestione sessione minima
7. Servizi Supabase di base
8. Login / logout / sessione
9. Registrazione account
10. Onboarding azienda/profilo
11. Home
12. Categorie
13. Fornitori
14. Prodotti
15. Movimenti
16. Storico movimenti
17. Verifica accessibilità complessiva
18. Stabilizzazione MVP 1
```

Questo ordine evita di creare codice disordinato e difficile da modificare.
La registrazione account è stata separata dall'onboarding azienda/profilo per mantenere piccoli i blocchi di lavoro.
--------------------------------------------------------------------------------------------------------------------

# 6. Decisione D01 — Prima core, poi UI

Decisione:

```text
SÌ
```

Prima di costruire le schermate definitive, è stato creato un core Dart minimo.
Il core Dart contiene le parti comuni dell'applicazione:

* messaggi;
* errori;
* feedback;
* accessibilità;
* sessione;
* servizi condivisi minimi;
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
  Stato:

```text
COMPLETATO
```

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

È stato creato un sistema centrale per i messaggi utente.
Cartella:

```text
lib/core/messages/
```

File operativo attuale:

```text
app_messages.dart
```

Scelta aggiornata:
per l'MVP 1 iniziale si usa un solo file principale `app_messages.dart`, semplice e controllabile.
File separati come:

```text
app_error_messages.dart
app_accessibility_messages.dart
```

potranno essere valutati in futuro solo se `app_messages.dart` diventerà troppo grande.

## 8.1 app_messages.dart

Contiene i messaggi principali dell'app.
Esempi:

* login riuscito;
* logout riuscito;
* email obbligatoria;
* password obbligatoria;
* registrazione riuscita;
* categoria creata;
* fornitore creato;
* prodotto creato;
* movimento registrato;
* dati salvati;
* nessun risultato trovato;
* errore generico;
* errore connessione.
  Regola:

```text
i messaggi importanti restano centralizzati
```

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
Questa decisione nasce anche dai problemi emersi nella console Flutter provvisoria e nei test manuali con NVDA.
---------------------------------------------------------------------------------------------------------------

# 10. Sistema feedback applicativo

Cartella:

```text
lib/core/feedback/
```

File creati:

```text
app_feedback_message.dart
app_feedback_controller.dart
app_feedback_view.dart
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

Ogni messaggio può contenere:

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

## 10.3 app_feedback_view.dart

Mostra il feedback persistente nella UI.
Responsabilità:

* rendere il messaggio visibile;
* renderlo leggibile da screen reader;
* non affidare il significato solo al colore;
* usare semantica accessibile;
* collaborare con gli annunci vocali quando necessario.

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
  Questa regola è stata applicata nei blocchi 001 e 002.
  Nel blocco 002 sono stati verificati anche gli annunci NVDA dei feedback principali.

---

# 12. Sistema accessibilità

Cartella:

```text
lib/core/accessibility/
```

File operativo attuale:

```text
accessibility_service.dart
```

Scelta aggiornata:
per l'MVP 1 iniziale si mantiene un sistema accessibilità minimo.
File separati come:

```text
accessible_feedback.dart
focus_helpers.dart
```

non vengono creati in anticipo.
Potranno essere introdotti solo quando un blocco concreto li renderà necessari.

## 12.1 accessibility_service.dart

Responsabilità:

* centralizzare eventuali annunci per screen reader;
* evitare annunci sparsi senza criterio;
* fornire metodi semplici da usare nelle schermate.
  Esempi logici:

```text
annuncia successo
annuncia errore
annuncia avviso
annuncia cambio schermata
```

Nota:
questo sistema non sostituisce la corretta costruzione delle schermate.
La vera accessibilità dipende anche da come vengono scritti i widget.
---------------------------------------------------------------------

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
-------------------------------------------------

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

# 15. Decisione D07 — Registrazione account separata da onboarding

Decisione:

```text
SÌ
```

La registrazione account viene separata dall'onboarding azienda/profilo.
Significato:

```text
Registrazione account = crea l'utente Supabase Auth.
Onboarding = crea azienda e profilo applicativo tramite RPC crea_azienda_e_profilo.
```

Motivazione:

* un utente finale non deve usare Supabase Dashboard;
* un utente finale non deve lanciare query SQL;
* la registrazione deve essere disponibile dall'app;
* ogni blocco deve avere una sola missione;
* Antigravity deve ricevere istruzioni più piccole e meno ambigue;
* se un problema nasce nella registrazione, resta nel blocco 003;
* se un problema nasce nell'onboarding, resta nel blocco 004.
  Nuova sequenza:

```text
002 Login, logout e sessione
003 Registrazione account
004 Onboarding azienda/profilo
005 Home
```

Regola:

```text
il blocco 003 non crea azienda e profilo
il blocco 004 non crea l'account Supabase Auth
```

---

# 16. Collegamento a Supabase

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
Flutter userà Supabase per:

* login;
* logout;
* recupero sessione;
* registrazione account;
* lettura dati consentiti dalle RLS;
* chiamata alle RPC previste.

---

# 17. Regole Supabase per Flutter

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
* profilo, dove consentito e quando previsto dal blocco specifico.
  Flutter non può:
* eliminare fisicamente categorie;
* eliminare fisicamente fornitori;
* eliminare fisicamente prodotti;
* eliminare o modificare movimenti;
* inserire movimenti direttamente;
* aggiornare direttamente la scorta;
* usare la service role key;
* bypassare le RLS.
  Per i movimenti Flutter deve usare:

```text
registra_movimento
```

Per l'onboarding Flutter deve usare:

```text
crea_azienda_e_profilo
```

## Per la registrazione account Flutter deve usare Supabase Auth.

# 18. Gestione errori Supabase

Gli errori tecnici di Supabase non devono essere mostrati direttamente all'utente finale se sono troppo tecnici.
Serve un livello di traduzione tra:

```text
errore tecnico
↓
errore applicativo
↓
messaggio utente comprensibile
```

Cartella:

```text
lib/core/errors/
```

File creati:

```text
app_exception.dart
supabase_error_mapper.dart
```

## 18.1 app_exception.dart

Rappresenta un errore applicativo.
Deve contenere:

* messaggio utente;
* eventuale messaggio tecnico per debug;
* tipo o categoria dell'errore, se utile.

## 18.2 supabase_error_mapper.dart

Traduce errori Supabase o errori tecnici in messaggi comprensibili.
Esempi:

```text
Invalid login credentials
↓
Email o password non corrette.
```

```text
violates row-level security policy
↓
Operazione non autorizzata.
```

```text
duplicate key value
↓
Esiste già un elemento con questo nome.
```

Regola:
gli errori tecnici non devono comparire nella UI.
-------------------------------------------------

# 19. Gestione assenza rete

L'app deve gestire l'assenza di connessione.
Quando possibile, il messaggio deve essere:

```text
Connessione assente. Controlla Internet e riprova.
```

Per l'MVP 1 non è previsto un sistema offline completo.
Non si deve implementare sincronizzazione offline.
Si deve però evitare che l'utente riceva errori tecnici incomprensibili.
------------------------------------------------------------------------

# 20. Gestione stato e dipendenze

## 20.1 Scelta consigliata per lo stato

Per l'MVP 1 si usa una gestione semplice dello stato.
Non introdurre framework complessi se non necessari.
Sono da evitare nella fase iniziale:

* BLoC;
* Riverpod;
* GetIt;
* service locator obbligatorio;
* architetture troppo astratte.
  Il progetto deve restare comprensibile.
  La gestione sessione è stata centralizzata nel blocco 002 tramite coordinator dedicato.

## 20.2 Regola sulle dipendenze

Aggiungere una dipendenza solo se serve davvero.
Ogni nuova dipendenza deve avere una motivazione chiara.
Da evitare:

* pacchetti usati solo per comodità momentanea;
* pacchetti pesanti per problemi semplici;
* pacchetti non necessari al blocco corrente.

---

# 21. Struttura cartelle proposta

La struttura deve restare semplice.
Struttura logica:

```text
lib/
  app/
  config/
  core/
  features/
```

## 21.1 app

Contiene l'avvio applicativo e il widget root.
Esempio:

```text
lib/app/app_root.dart
```

## 21.2 config

Contiene configurazioni.
Esempio:

```text
lib/config/supabase_config.dart
```

## 21.3 core

Contiene parti condivise.
Esempi:

```text
lib/core/messages/
lib/core/errors/
lib/core/feedback/
lib/core/accessibility/
lib/core/session/
```

## 21.4 features

Contiene le funzionalità applicative.
Esempi:

```text
lib/features/auth/
lib/features/account_registration/
lib/features/onboarding/
lib/features/home/
lib/features/categories/
lib/features/suppliers/
lib/features/products/
lib/features/movements/
```

## 21.5 data

Contiene servizi o classi che parlano con Supabase.
Non deve mostrare UI.

## 21.6 domain

Contiene modelli o risultati logici.
Non deve dipendere dai widget.

## 21.7 presentation

Contiene schermate e widget.
Non deve contenere query Supabase dirette.
------------------------------------------

# 22. Nota sulla semplicità

La struttura proposta non deve diventare una gabbia.
Regola:

```text
creare solo ciò che serve al blocco corrente
```

Non creare cartelle vuote solo perché previste in teoria.
Non creare file futuri in anticipo.
Non costruire architettura pesante.
Il progetto deve rimanere:

* leggibile;
* testabile;
* accessibile;
* facile da correggere.

---

# 23. Schermate MVP previste

Le schermate previste per l'MVP 1 sono:

* Login;
* Registrazione account;
* Onboarding azienda/profilo;
* Home;
* Lista categorie;
* Form categoria;
* Lista fornitori;
* Form fornitore;
* Lista prodotti;
* Dettaglio prodotto;
* Form prodotto;
* Registrazione carico;
* Registrazione vendita;
* Registrazione rettifica;
* Registrazione reso;
* Storico movimenti.
  Ogni schermata deve avere:
* titolo chiaro;
* contenuto leggibile;
* pulsanti con testo;
* feedback persistente;
* errori accessibili;
* ordine logico del focus.

---

# 24. Ordine di sviluppo delle schermate

## Fase 1 — Login, logout e sessione

Stato:

```text
COMPLETATO
```

Obiettivo:

* login;
* logout;
* controllo sessione;
* lettura profilo;
* lettura azienda;
* placeholder onboarding;
* placeholder home.

## Fase 2 — Registrazione account

Stato:

```text
DA FARE
```

Obiettivo:

* accesso alla registrazione dalla login;
* form email;
* form password;
* conferma password;
* creazione utente Supabase Auth;
* gestione email già usata;
* gestione password non valida;
* feedback persistente;
* accessibilità NVDA.

## Fase 3 — Onboarding azienda/profilo

Stato:

```text
DA FARE
```

Obiettivo:

* sostituire il placeholder onboarding;
* inserimento nome azienda;
* eventuale nome profilo;
* chiamata RPC `crea_azienda_e_profilo`;
* creazione azienda;
* creazione profilo;
* passaggio alla home.

## Fase 4 — Home

Stato:

```text
DA FARE
```

Obiettivo:

* sostituire il placeholder home;
* mostrare nome azienda;
* mostrare collegamenti principali;
* mantenere logout raggiungibile.

## Fase 5 — Categorie

Stato:

```text
DA FARE
```

Obiettivo:

* lista categorie;
* creazione;
* modifica;
* disattivazione.

## Fase 6 — Fornitori

Stato:

```text
DA FARE
```

Obiettivo:

* lista fornitori;
* creazione;
* modifica;
* disattivazione.

## Fase 7 — Prodotti

Stato:

```text
DA FARE
```

Obiettivo:

* lista prodotti;
* dettaglio;
* creazione;
* modifica;
* disattivazione;
* blocco modifica diretta scorta.

## Fase 8 — Movimenti

Stato:

```text
DA FARE
```

Obiettivo:

* carico;
* vendita;
* reso;
* rettifica;
* uso RPC `registra_movimento`;
* storico movimenti.

## Fase 9 — Revisione accessibilità

Stato:

```text
DA FARE
```

Obiettivo:

* verifica completa con screen reader;
* ordine focus;
* messaggi;
* errori;
* navigazione.

---

# 25. Regole per i form

Ogni form deve avere:

* titolo chiaro;
* campi con label leggibili;
* pulsanti con testo esplicito;
* validazioni prima dell'invio;
* messaggi di errore persistenti;
* feedback di successo persistente;
* stato di caricamento quando serve;
* protezione da doppi invii.
  Regole generali:
* stringhe vuote facoltative devono diventare `NULL` quando il backend lo richiede;
* numeri negativi devono essere bloccati quando non consentiti;
* quantità devono essere maggiori di zero quando richiesto;
* errori tecnici devono essere tradotti.

---

# 26. Regole per le liste

Ogni lista deve avere:

* titolo chiaro;
* messaggio quando è vuota;
* elementi leggibili;
* azioni chiare;
* stato caricamento;
* stato errore;
* retry quando utile.
  Nessuna informazione importante deve essere comunicata solo con:
* colore;
* icona;
* posizione visiva.

---

# 27. Regole per i movimenti

I movimenti sono la parte più delicata del gestionale.
Flutter non deve mai inserire direttamente record in:

```text
movimenti_magazzino
```

Flutter non deve mai aggiornare direttamente:

```text
prodotti.scorta_attuale
```

Deve sempre usare:

```text
registra_movimento
```

## 27.1 Carico

Richiede:

* prodotto;
* fornitore;
* quantità;
* prezzo unitario facoltativo;
* note facoltative.
  Risultato:
* scorta aumenta;
* movimento registrato.

## 27.2 Vendita

Richiede:

* prodotto;
* quantità;
* prezzo unitario facoltativo;
* note facoltative.
  Risultato:
* scorta diminuisce;
* movimento registrato.
  Se la scorta è insufficiente:
* nessun movimento;
* scorta invariata;
* messaggio accessibile.

## 27.3 Rettifica

Richiede:

* prodotto;
* nuova scorta;
* motivazione o nota.
  Risultato:
* scorta portata al valore indicato;
* movimento registrato.

## 27.4 Reso

Richiede:

* prodotto;
* quantità;
* note facoltative.
  Risultato:
* scorta aumenta;
* movimento registrato.

---

# 28. Regole per prodotti inattivi

I prodotti inattivi:

* non devono essere proposti per nuovi movimenti;
* possono restare visibili nello storico;
* possono essere visibili nelle liste se serve;
* devono essere indicati come inattivi con testo chiaro.
  Non usare solo colore o icona.

---

# 29. Regole per categorie e fornitori inattivi

Categorie inattive:

* non devono essere proposte nei nuovi prodotti;
* possono restare visibili sui prodotti già collegati;
* devono essere indicate come inattive con testo.
  Fornitori inattivi:
* non devono essere proposti nei nuovi carichi;
* non devono essere proposti come fornitore preferito per nuovi prodotti;
* possono restare visibili nello storico.

---

# 30. Navigazione MVP

La navigazione deve essere semplice.
Per l'MVP 1 non serve un router complesso.
Flusso generale:

```text
avvio app
↓
controllo sessione
↓
login
↓
registrazione account, se utente nuovo
↓
onboarding, se utente autenticato senza profilo
↓
home, se utente con profilo e azienda
↓
sezioni gestionali
```

Regola:

```text
la navigazione deve seguire lo stato applicativo
```

Non devono esserci schermate raggiungibili senza i prerequisiti corretti.
Esempio:

* la home non deve essere accessibile senza login;
* le sezioni gestionali non devono essere accessibili senza profilo e azienda;
* l'onboarding non deve creare un secondo profilo se il profilo esiste già.

---

# 31. Stato iniziale dell'app

All'avvio l'app deve:

1. inizializzare Supabase;
2. controllare la sessione corrente;
3. mostrare caricamento accessibile;
4. decidere lo stato:

```text
nessuna sessione → login
sessione presente senza profilo → onboarding
sessione presente con profilo e azienda → home
```

Questa logica è stata implementata nel blocco 002 con un coordinator centrale.
Il blocco 003 aggiungerà il ramo:

```text
utente senza account → registrazione account
```

## Il blocco 004 sostituirà il placeholder onboarding con onboarding reale.

# 32. Fuori scope MVP 1 — Recupero password

Il recupero password non fa parte dell'MVP 1.
Non verrà implementato nei primi blocchi Flutter.
Potrà essere valutato in una fase successiva.
Motivazione:

* riduce complessità iniziale;
* evita di introdurre flussi email aggiuntivi;
* permette di concentrarsi su registrazione, onboarding e gestione magazzino.
  Questa è una scelta di scope, non una dimenticanza.

---

# 33. Test manuali minimi — Login

## Test L001 — Schermata login leggibile

Risultato atteso:

* campo email leggibile;
* campo password leggibile;
* pulsante Accedi leggibile;
* pulsante o link Crea account leggibile quando sarà implementato.

## Test L002 — Login con campi vuoti

Risultato atteso:

* messaggio email obbligatoria;
* messaggio password obbligatoria quando applicabile;
* messaggio persistente;
* messaggio annunciato da NVDA.

## Test L003 — Login credenziali errate

Risultato atteso:

* errore comprensibile;
* nessun accesso;
* feedback persistente;
* annuncio NVDA.

## Test L004 — Login corretto

Risultato atteso:

* accesso riuscito;
* controllo profilo;
* passaggio a onboarding o home in base allo stato utente.

## Test L005 — Logout

Risultato atteso:

* sessione chiusa;
* ritorno a login;
* sessione non recuperata dopo riavvio;
* feedback accessibile.

---

# 34. Test manuali minimi — Registrazione account

## Test R001 — Schermata registrazione raggiungibile

Risultato atteso:

* dalla login è possibile raggiungere la registrazione;
* il ritorno alla login è possibile;
* i pulsanti sono leggibili da screen reader.

## Test R002 — Campi vuoti

Risultato atteso:

* email obbligatoria;
* password obbligatoria;
* conferma password obbligatoria;
* feedback persistente;
* annuncio NVDA.

## Test R003 — Conferma password errata

Risultato atteso:

* registrazione bloccata;
* messaggio comprensibile;
* nessun account creato.

## Test R004 — Email già registrata

Risultato atteso:

* registrazione bloccata;
* messaggio comprensibile;
* nessun crash;
* l'utente resta nella registrazione o può tornare al login.

## Test R005 — Registrazione corretta

Risultato atteso:

* account Supabase Auth creato;
* feedback chiaro;
* comportamento successivo coerente con configurazione Supabase Auth;
* nessuna azienda creata in questo blocco;
* nessun profilo creato in questo blocco.

---

# 35. Test manuali minimi — Onboarding

## Test O001 — Utente senza profilo

Risultato atteso:

* dopo login o registrazione, se l'utente è autenticato ma senza profilo, viene mostrato onboarding reale.

## Test O002 — Nome azienda vuoto

Risultato atteso:

* onboarding bloccato;
* messaggio nome azienda obbligatorio;
* feedback persistente;
* annuncio NVDA.

## Test O003 — Onboarding corretto

Risultato atteso:

* RPC `crea_azienda_e_profilo` chiamata;
* azienda creata;
* profilo creato;
* passaggio alla home.

## Test O004 — Onboarding duplicato

Risultato atteso:

* nessuna seconda azienda;
* nessun secondo profilo;
* messaggio comprensibile.

---

# 36. Test manuali minimi — Home

## Test H001 — Home leggibile

Risultato atteso:

* titolo leggibile;
* nome azienda leggibile;
* azioni principali leggibili.

## Test H002 — Navigazione sezioni

Risultato atteso:

* accesso a categorie;
* accesso a fornitori;
* accesso a prodotti;
* accesso a movimenti;
* logout raggiungibile.

---

# 37. Test manuali minimi — Categorie

## Test C001 — Lista categorie

Risultato atteso:

* lista leggibile;
* stato vuoto gestito.

## Test C002 — Creazione categoria

Risultato atteso:

* categoria creata;
* feedback successo.

## Test C003 — Nome categoria vuoto

Risultato atteso:

* errore nome obbligatorio.

## Test C004 — Nome duplicato

Risultato atteso:

* errore duplicato comprensibile.

---

# 38. Test manuali minimi — Fornitori

## Test F001 — Lista fornitori

Risultato atteso:

* lista leggibile;
* stato vuoto gestito.

## Test F002 — Creazione fornitore

Risultato atteso:

* fornitore creato;
* feedback successo.

## Test F003 — Nome fornitore vuoto

Risultato atteso:

* errore nome obbligatorio.

## Test F004 — Nome duplicato

Risultato atteso:

* errore duplicato comprensibile.

---

# 39. Test manuali minimi — Prodotti

## Test P001 — Lista prodotti

Risultato atteso:

* lista leggibile;
* stato vuoto gestito.

## Test P002 — Creazione prodotto

Risultato atteso:

* prodotto creato con scorta iniziale 0.

## Test P003 — Barcode vuoto

Risultato atteso:

* barcode vuoto salvato come `NULL`.

## Test P004 — Barcode duplicato

Risultato atteso:

* errore comprensibile.

## Test P005 — Modifica prodotto

Risultato atteso:

* dati aggiornati;
* scorta non modificata direttamente.

## Test P006 — Prodotto inattivo in lista

Risultato atteso:

* prodotto indicato come inattivo con testo chiaro.

---

# 40. Test manuali minimi — Movimenti

## Test M001 — Carico valido

Risultato atteso:

* movimento carico registrato;
* scorta aumentata.

## Test M002 — Carico senza fornitore

Risultato atteso:

* errore fornitore obbligatorio.

## Test M003 — Vendita valida

Risultato atteso:

* movimento vendita registrato;
* scorta diminuita.

## Test M004 — Vendita con scorta insufficiente

Risultato atteso:

* errore scorta insufficiente;
* scorta invariata.

## Test M005 — Rettifica valida

Risultato atteso:

* scorta impostata al nuovo valore;
* movimento registrato.

## Test M006 — Rettifica senza motivazione

Risultato atteso:

* errore o avviso secondo design del blocco movimenti.

## Test M007 — Storico movimenti

Risultato atteso:

* movimento visibile nello storico.

## Test M008 — Prodotto inattivo non selezionabile

Risultato atteso:

* prodotto inattivo non selezionabile per nuovo movimento.

---

# 41. Test manuali minimi — Connessione

## Test N001 — Assenza rete durante caricamento dati

Risultato atteso:

* errore comprensibile;
* possibilità di riprovare quando utile.

## Test N002 — Assenza rete durante salvataggio

Risultato atteso:

* operazione non completata;
* messaggio chiaro;
* nessun dato locale trattato come definitivo.

---

# 42. Regole di sviluppo operative

Regole obbligatorie:

* un blocco alla volta;
* un obiettivo per blocco;
* niente funzioni future anticipate senza motivo;
* niente service role key;
* niente query Supabase dentro widget se evitabile;
* niente stringhe utente importanti hardcoded;
* feedback persistente;
* test automatici quando previsti dal blocco;
* test manuale quando il blocco coinvolge UI reale;
* verifica NVDA quando il blocco mostra messaggi o form;
* `flutter analyze` pulito;
* `flutter test` pulito;
* changelog aggiornato prima del commit del blocco.

---

# 43. Metodo di lavoro consigliato

Per ogni blocco:

1. scrivere design;
2. farlo eventualmente revisionare dai consiglieri AI;
3. integrare correzioni;
4. scrivere coding plan;
5. scrivere TODO operativo;
6. preparare prompt rigido per Antigravity;
7. codificare;
8. eseguire test automatici;
9. eseguire test manuali;
10. correggere;
11. aggiornare changelog;
12. commit;
13. push;
14. merge in `main` dopo validazione;
15. verificare `flutter analyze` e `flutter test` su `main`.

---

# 44. Primo blocco dopo questo aggiornamento

Il primo blocco da progettare dopo questo aggiornamento documentale è:

```text
Blocco 003 — Registrazione account
```

Documenti previsti:

```text
docs/4-flutter/1-design/003-DESIGN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/003-CODING_PLAN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
docs/4-flutter/3-todos/003-TODO_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
```

Il blocco 003 deve creare:

* schermata o vista registrazione;
* accesso alla registrazione dalla login;
* servizio o metodo di registrazione tramite Supabase Auth;
* validazioni email/password/conferma password;
* messaggi centralizzati;
* feedback persistente;
* annunci accessibili;
* test automatici;
* test manuali.
  Il blocco 003 non deve creare:
* azienda;
* profilo applicativo;
* onboarding reale;
* home reale;
* categorie;
* fornitori;
* prodotti;
* movimenti.

---

# 45. Criterio di successo della fase Flutter MVP 1.0

La fase Flutter MVP 1.0 sarà considerata riuscita quando:

* un nuovo utente può registrarsi dall'app;
* un utente può accedere;
* un utente può completare onboarding;
* l'utente entra nella home;
* può creare categorie;
* può creare fornitori;
* può creare prodotti;
* può registrare carichi;
* può registrare vendite;
* può registrare rettifiche;
* può consultare storico movimenti;
* la scorta viene aggiornata solo tramite backend;
* gli errori principali sono comprensibili;
* i feedback sono persistenti;
* il flusso principale è utilizzabile con screen reader;
* `flutter analyze` è pulito;
* `flutter test` è pulito per i test previsti.

---

# 46. Decisioni confermate

Decisioni confermate:

* core prima delle UI;
* messaggi centralizzati;
* feedback persistente;
* accessibilità non rimandata;
* backend fonte della verità;
* Supabase anon key soltanto;
* service role key vietata in Flutter;
* nessuna modifica diretta della scorta;
* movimenti solo tramite RPC `registra_movimento`;
* onboarding solo tramite RPC `crea_azienda_e_profilo`;
* registrazione account separata da onboarding azienda/profilo;
* niente recupero password nell'MVP 1;
* niente architettura pesante non necessaria;
* sviluppo per piccoli blocchi;
* test e commit per ogni blocco importante.

---

# 47. Revisione AI

La revisione con consiglieri AI è consigliata per:

* design complessi;
* coding plan critici;
* modifiche backend;
* nuove RPC;
* modifiche RLS;
* modifiche alla logica di scorta;
* decisioni importanti su Supabase Auth.
  La revisione non è normalmente necessaria per:
* piccoli aggiornamenti organizzativi;
* README;
* changelog;
* correzioni editoriali;
* todo master semplici.
  Per il blocco 003 Registrazione account, la revisione con consiglieri AI sarà consigliata dopo la prima bozza del design, perché il blocco riguarda Supabase Auth e il flusso iniziale dell'utente.

---

# 48. Stato del documento

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
progettazione del blocco 003 Registrazione account
```

Documenti da creare dopo questo aggiornamento:

```text
docs/4-flutter/1-design/003-DESIGN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/003-CODING_PLAN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
docs/4-flutter/3-todos/003-TODO_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
```

---

# 49. Conclusione

La fase Flutter è avviata e procede in modo progressivo.
Il backend rimane la fonte della verità.
Flutter deve essere costruito in modo ordinato, progressivo e accessibile.
Il blocco 001 Core Dart minimo è completato.
Il blocco 002 Login, logout e sessione è completato.
La decisione aggiornata stabilisce che:

* il blocco 003 sarà dedicato alla registrazione account;
* il blocco 004 sarà dedicato all'onboarding azienda/profilo;
* il blocco 005 sarà dedicato alla home.
  Questa separazione serve a mantenere piccoli i blocchi, ridurre il rischio di errori e rendere più semplice il lavoro di implementazione e verifica.
  La priorità ora non è correre verso le schermate gestionali, ma completare correttamente il flusso iniziale dell'utente:

```text
registrazione
↓
login
↓
onboarding
↓
home
```

Solo dopo questo flusso sarà stabile, si passerà alle funzioni gestionali:

* categorie;
* fornitori;
* prodotti;
* movimenti;
* storico movimenti.
