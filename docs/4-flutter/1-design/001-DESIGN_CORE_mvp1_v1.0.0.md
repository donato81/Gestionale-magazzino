# DESIGN CORE MVP 1.0

## Gestionale Magazzino Universale

Versione: 1.0.0
Stato: APPROVATO
Data: 5 luglio 2026

---

# 1. Scopo del documento

Questo documento definisce il design del core Dart minimo dell'app Flutter del Gestionale Magazzino Universale.

Il core Dart minimo è la base comune dell'applicazione.

Non è ancora una schermata completa.

Non è ancora il login completo.

Non è ancora l'onboarding.

Non è ancora la gestione prodotti.

Non è ancora la gestione movimenti.

Il core serve a preparare le fondamenta comuni che verranno usate da tutte le funzionalità successive.

Lo scopo di questo documento è spiegare:

* perché serve un core iniziale;
* quali responsabilità deve avere;
* quali responsabilità non deve avere;
* quali parti comuni devono essere centralizzate;
* come evitare disordine futuro;
* come rispettare fin dall'inizio accessibilità e leggibilità;
* come preparare il terreno per i coding plan e per il primo blocco di codice.

Questo documento non contiene codice Dart definitivo.

Questo documento non sostituisce il coding plan.

Questo documento non sostituisce il todo specifico.

---

# 2. Documenti di riferimento

Questo documento dipende dai documenti già approvati:

```text
docs/0-architettura/001-ARCHITETTURA_mvp1_v1.0.0.md
docs/1-database/001-DATABASE_SCHEMA_mvp1_v1.0.0.md
docs/2-flussi-applicativi/001-FLOWS_mvp1_v1.0.0.md
docs/3-backend/001-BACKEND_RULES_mvp1_v1.0.0.md
docs/3-backend/002-API_CONTRACTS_mvp1_v1.0.0.md
docs/4-flutter/001-FLUTTER_PLAN_mvp1_v1.0.0.md
docs/4-flutter/3-todos/000-todo-master.md
```

Il design core deve rispettare in particolare:

* backend come fonte della verità;
* nessuna modifica diretta della scorta da Flutter;
* nessun inserimento diretto dei movimenti da Flutter;
* messaggi utente centralizzati;
* errori tecnici tradotti in messaggi comprensibili;
* feedback persistente;
* accessibilità non rimandata;
* sviluppo incrementale;
* semplicità dell'MVP 1.

---

# 3. Idea generale del core

Il core è la base interna dell'app.

Una metafora utile:

```text
Prima di costruire le stanze di una casa,
si preparano fondamenta, impianto elettrico e tubature.
```

Nel nostro progetto:

```text
fondamenta = core Dart
impianto elettrico = sessione e collegamento ai servizi
tubature = messaggi, errori e feedback
accessibilità = percorsi chiari e porte larghe fin dall'inizio
```

Il core deve impedire che ogni schermata venga costruita in modo diverso.

Senza core, rischieremmo di avere:

* testi scritti direttamente dentro i widget;
* messaggi duplicati;
* errori tecnici mostrati all'utente;
* query Supabase sparse nelle schermate;
* gestione sessione duplicata;
* feedback non leggibile;
* accessibilità aggiunta tardi;
* codice difficile da correggere.

Con il core, invece, ogni parte dell'app usa una base comune.

---

# 4. Obiettivo del core Dart minimo

L'obiettivo del core Dart minimo è creare una base semplice e ordinata per:

* messaggi;
* errori;
* feedback;
* accessibilità;
* sessione;
* base dei servizi Supabase.

Il core non deve essere grande.

Il core non deve anticipare tutta l'app.

Il core deve contenere solo ciò che serve per evitare disordine nei blocchi successivi.

Regola:

```text
Creare una base sufficiente, non una struttura enorme.
```

---

# 5. Principio guida

Il principio guida è:

```text
Prima una base comune, poi le schermate.
```

Questo significa:

1. prima centralizziamo messaggi, errori, feedback, accessibilità e sessione;
2. poi costruiamo login, onboarding, home, categorie, fornitori, prodotti e movimenti;
3. ogni nuova schermata userà il core invece di inventare regole proprie.

---

# 6. Cosa fa parte del core

Fanno parte del core MVP 1:

```text
messaggi
errori
feedback
accessibilità
sessione
base servizi Supabase
```

Queste parti sono condivise da tutta l'app.

Non appartengono a una singola funzionalità.

Per esempio:

* il messaggio “Connessione assente” può servire in login, prodotti e movimenti;
* l'errore “Sessione scaduta” può servire ovunque;
* il feedback “Operazione completata” può servire in molte schermate;
* la sessione serve per capire se mostrare login, onboarding o home;
* l'accessibilità deve valere per tutta l'app.

---

# 7. Cosa NON fa parte del core

Il core non deve contenere:

* schermata login completa;
* schermata onboarding completa;
* schermata home completa;
* lista categorie;
* lista fornitori;
* lista prodotti;
* form prodotto;
* form movimento;
* storico movimenti;
* logica completa delle singole funzionalità;
* grafica definitiva;
* gestione avanzata dello stato;
* router complesso;
* service locator obbligatorio;
* sincronizzazione offline;
* scanner barcode;
* immagini prodotto;
* report;
* ruoli avanzati.

Queste parti verranno progettate nei documenti successivi.

Il core prepara la base.

Non costruisce tutta la casa.

---

# 8. Sistema messaggi centralizzato

## 8.1 Scopo

Il sistema messaggi serve a evitare testi sparsi nel codice.

Un testo visibile all'utente non deve essere scritto direttamente dentro una schermata, un pulsante, un metodo o un servizio.

Esempio da evitare:

```text
Dentro una pagina scrivo direttamente:
"Prodotto salvato correttamente."
```

Esempio corretto:

```text
La pagina usa un messaggio centrale:
messaggio prodotto salvato correttamente
```

In questo modo, se un giorno vogliamo modificare una frase, lo facciamo in un solo punto.

---

## 8.2 Messaggi Dart puri

Per l'MVP 1 i messaggi del core devono essere stringhe Dart pure o valori equivalenti.

Devono poter essere usati anche da servizi e controller.

Il sistema messaggi non deve dipendere da:

```text
BuildContext
```

Motivazione:

un servizio o un controller deve poter restituire un messaggio comprensibile senza dipendere dalla schermata attiva.

Eventuali sistemi di localizzazione più avanzati potranno essere valutati in futuro.

Per l'MVP 1 la priorità è avere messaggi semplici, centralizzati e riutilizzabili.

---

## 8.3 Tipi di messaggi

Il core dovrà prevedere almeno questi gruppi logici:

* messaggi generali;
* messaggi di successo;
* messaggi di errore;
* messaggi di avviso;
* messaggi di accessibilità.

Esempi di messaggi generali:

```text
Caricamento in corso.
Nessun risultato trovato.
Operazione completata.
```

Esempi di messaggi di successo:

```text
Accesso eseguito correttamente.
Uscita eseguita correttamente.
Categoria salvata correttamente.
Fornitore salvato correttamente.
Prodotto salvato correttamente.
Movimento registrato correttamente.
```

Esempi di messaggi di errore:

```text
Email o password non corrette.
Nome obbligatorio.
Scorta insufficiente.
Operazione non autorizzata.
Connessione assente. Controlla Internet e riprova.
```

Esempi di messaggi di avviso:

```text
Attenzione: scorta inferiore al livello minimo.
Il prodotto selezionato è disattivato.
```

---

## 8.4 Regola sui testi utente

Regola:

```text
Nessun testo utente importante deve essere hardcoded dentro le schermate.
```

Sono testi utente importanti:

* titoli;
* pulsanti;
* errori;
* conferme;
* avvisi;
* messaggi vuoto lista;
* messaggi di caricamento;
* messaggi di accessibilità.

Il coding plan stabilirà quali file creare.

Questo design stabilisce il principio.

---

# 9. Relazione tra messaggi ed errori

Il sistema messaggi e il sistema errori non devono duplicarsi.

Il sistema messaggi contiene le frasi centralizzate.

Il sistema errori non deve creare un secondo archivio parallelo di frasi duplicate.

Il mapper errori deve trasformare un errore tecnico in un errore applicativo che usa un messaggio centralizzato.

Schema logico:

```text
errore tecnico
↓
mapper errori
↓
errore applicativo
↓
messaggio centralizzato
↓
feedback persistente
```

Esempio:

```text
PostgrestException duplicate key
↓
errore applicativo duplicato
↓
"Esiste già un elemento con questo nome."
```

Questa regola serve a evitare che lo stesso messaggio venga scritto in più punti.

---

# 10. Sistema errori centralizzato

## 10.1 Scopo

Il sistema errori serve a trasformare errori tecnici in messaggi comprensibili.

L'utente non deve leggere errori grezzi di Supabase, PostgreSQL o Flutter.

Esempio tecnico da non mostrare:

```text
PostgrestException duplicate key value violates unique constraint
```

Messaggio utente corretto:

```text
Esiste già un elemento con questo nome.
```

Esempio tecnico da non mostrare:

```text
Invalid login credentials
```

Messaggio utente corretto:

```text
Email o password non corrette.
```

---

## 10.2 Responsabilità del sistema errori

Il sistema errori deve:

* ricevere un errore tecnico;
* riconoscere i casi più comuni;
* restituire un messaggio comprensibile;
* evitare messaggi troppo tecnici;
* conservare, se utile, il dettaglio tecnico per debug;
* lavorare insieme al sistema messaggi;
* lavorare insieme al sistema feedback.

Il mapper errori non deve mostrare direttamente nulla nella UI.

Il mapper prepara un errore comprensibile.

La UI o il controller di feedback deciderà come mostrarlo.

---

## 10.3 Errori da gestire nella prima fase

Il core deve preparare una gestione base per:

* credenziali errate;
* sessione scaduta;
* utente non autorizzato;
* connessione assente;
* timeout;
* duplicati;
* scorta insufficiente;
* prodotto non trovato;
* fornitore non valido;
* errore generico.

Non serve gestire subito ogni possibile errore esistente.

Serve però una struttura che permetta di aggiungere nuovi casi senza riscrivere tutto.

---

## 10.4 Errori Supabase ed errori di rete

Il mapper errori deve gestire sia errori Supabase sia errori di rete.

Categorie minime:

* errori Auth;
* errori PostgREST;
* errori RPC;
* assenza rete;
* timeout;
* errore generico non riconosciuto.

Questa distinzione è importante perché non tutti gli errori arrivano dal database.

Alcuni errori possono avvenire prima ancora che Supabase risponda.

Esempi:

```text
assenza connessione
timeout
errore HTTP
errore generico del client
```

In questi casi l'utente deve ricevere un messaggio chiaro, non un errore tecnico.

---

## 10.5 Collegamento con API Contracts

Quando possibile, il mapper errori deve basarsi sui casi previsti dagli API Contracts.

Gli errori restituiti dalle RPC e dal backend devono essere tradotti nei messaggi utente già definiti nei contratti.

Il mapper deve preferire, quando disponibili:

* tipo dell'eccezione;
* codice errore;
* codice PostgreSQL;
* messaggi backend previsti dagli API Contracts;
* categoria dell'errore.

Il riconoscimento tramite testo libero può essere usato come fallback.

Non deve però diventare l'unico criterio fragile.

Regola:

```text
Preferire errori riconoscibili per tipo o codice.
Usare il testo libero solo come ultima difesa.
```

---

## 10.6 Errore generico

Quando l'errore non è riconosciuto, l'app deve mostrare un messaggio semplice.

Esempio:

```text
Impossibile completare l'operazione. Riprova più tardi.
```

Non deve mostrare una frase tecnica incomprensibile.

---

# 11. Sistema feedback persistente

## 11.1 Scopo

Il sistema feedback serve a comunicare all'utente il risultato di un'azione.

Esempi:

```text
Categoria salvata correttamente.
Scorta insufficiente per completare l'operazione.
Connessione assente. Controlla Internet e riprova.
```

Il punto fondamentale è che il feedback deve essere persistente.

Persistente significa:

```text
il messaggio resta nella schermata
finché viene sostituito o cancellato in modo controllato
```

Non deve essere solo un messaggio temporaneo che sparisce subito.

---

## 11.2 Perché serve feedback persistente

Un messaggio temporaneo può non essere intercettato da uno screen reader.

Un messaggio stabile può essere riletto.

Questa regola è particolarmente importante per utenti che usano NVDA, TalkBack, VoiceOver o altri screen reader.

Il feedback persistente serve anche agli utenti vedenti, perché rende chiaro cosa è appena successo.

---

## 11.3 Oggetto feedback minimo

Il feedback persistente sarà rappresentato da una struttura semplice.

Informazioni minime:

* testo visibile;
* tipo feedback;
* eventuale testo accessibile;
* eventuale indicazione se annunciare il messaggio.

Il design non impone ancora il codice Dart definitivo.

Stabilisce però che il feedback non deve essere solo una stringa sciolta.

Deve avere almeno un significato.

Esempio concettuale:

```text
testo visibile = "Prodotto salvato correttamente."
tipo = successo
testo accessibile = opzionale
annuncia = sì oppure no
```

---

## 11.4 Tipi di feedback

Il core deve prevedere almeno quattro tipi di feedback:

```text
successo
errore
avviso
informazione
```

Esempi:

```text
successo → Prodotto salvato correttamente.
errore → Scorta insufficiente.
avviso → Attenzione: scorta inferiore al livello minimo.
informazione → Nessun prodotto trovato.
```

---

## 11.5 Relazione tra feedback e accessibilità

Regola:

```text
Prima il messaggio esiste nella schermata.
Poi, se utile, viene anche annunciato allo screen reader.
```

L'annuncio vocale non deve sostituire il messaggio visibile.

L'annuncio vocale è un aiuto.

Il messaggio stabile è la base.

---

# 12. Pipeline evento, errore, feedback e accessibilità

Messaggi, errori, feedback e accessibilità non sono quattro sistemi isolati.

Devono lavorare come una catena unica.

Flusso logico:

```text
evento o errore tecnico
↓
mapper o servizio applicativo
↓
messaggio utente centralizzato
↓
oggetto feedback
↓
messaggio persistente nella schermata
↓
eventuale annuncio accessibile
```

Esempio con errore:

```text
Supabase restituisce errore credenziali errate
↓
il mapper errori riconosce il caso
↓
viene scelto il messaggio:
"Email o password non corrette."
↓
viene creato un feedback di tipo errore
↓
la schermata mostra il messaggio in modo persistente
↓
il messaggio può essere annunciato allo screen reader
```

Esempio con successo:

```text
categoria salvata
↓
servizio categoria restituisce esito positivo
↓
viene scelto il messaggio:
"Categoria salvata correttamente."
↓
viene creato un feedback di tipo successo
↓
la schermata mostra il messaggio
↓
il messaggio può essere annunciato
```

Questa catena deve guidare il coding plan.

---

# 13. Sistema accessibilità

## 13.1 Scopo

Il core deve aiutare l'app a essere accessibile fin dall'inizio.

L'accessibilità non deve essere aggiunta alla fine.

Il core non può rendere automaticamente accessibile ogni schermata, ma può fornire regole e strumenti comuni.

---

## 13.2 Regole accessibilità del core

Il core deve rispettare queste regole:

* ogni messaggio importante deve essere testuale;
* nessun errore deve essere comunicato solo tramite colore;
* nessun avviso deve essere comunicato solo tramite icona;
* un feedback importante deve essere persistente;
* gli annunci vocali devono essere centralizzati;
* i messaggi per screen reader devono essere chiari;
* le schermate future devono poter usare il sistema feedback in modo coerente.

---

## 13.3 Semantics ed etichette accessibili

Il servizio di annunci accessibili non sostituisce la corretta costruzione semantica delle schermate.

Le schermate future dovranno usare:

* etichette chiare;
* controlli descrittivi;
* testo leggibile;
* ordine logico;
* `Semantics` o strumenti equivalenti Flutter quando necessario.

Icone funzionali e controlli non ovvi dovranno avere un testo accessibile.

Esempio da evitare:

```text
pulsante con sola icona non descritta
```

Esempio corretto:

```text
pulsante "Salva prodotto"
oppure icona con label accessibile "Salva prodotto"
```

Regola:

```text
accessibilità = struttura leggibile + feedback persistente + eventuali annunci
```

Non solo annunci vocali.

---

## 13.4 Annunci screen reader

Il core può prevedere un servizio per annunciare messaggi importanti allo screen reader.

Esempi di annunci:

```text
Accesso eseguito correttamente.
Errore: email obbligatoria.
Movimento registrato correttamente.
Attenzione: scorta inferiore al livello minimo.
```

Gli annunci non devono essere sparsi dentro tutte le schermate.

Devono passare da un punto centrale.

---

## 13.5 Limite degli annunci

Gli annunci non sono sempre affidabili.

Per questo motivo:

```text
un annuncio non deve mai essere l'unico feedback
```

Ogni messaggio importante deve anche essere presente nella schermata.

---

# 14. Gestione sessione

## 14.1 Scopo

La gestione sessione serve a sapere in quale stato si trova l'utente.

Quando l'app si apre, deve capire cosa mostrare.

I casi principali sono tre:

```text
utente non autenticato
→ mostra login
```

```text
utente autenticato senza profilo
→ mostra onboarding
```

```text
utente autenticato con profilo
→ mostra home
```

---

## 14.2 Perché la sessione deve essere centralizzata

Questa decisione non deve essere duplicata in tante schermate.

Se ogni schermata controlla da sola la sessione, il progetto diventa fragile.

La sessione deve essere gestita in un punto centrale.

Esempio mentale:

```text
La sessione è il semaforo iniziale dell'app.
Dice all'app quale strada prendere.
```

---

## 14.3 Sessione come consumatore di Supabase

Il controller sessione sarà il primo punto che usa Supabase Auth per capire se esiste un utente autenticato.

Dopo l'autenticazione, dovrà recuperare il profilo applicativo e l'azienda corrente tramite servizi dedicati o logica definita nel coding plan.

Questa logica deve restare centralizzata.

Schema logico:

```text
Supabase Auth
↓
utente autenticato o non autenticato
↓
lettura profilo applicativo
↓
lettura azienda corrente
↓
stato app
```

---

## 14.4 Informazioni minime della sessione

La sessione dovrà conoscere almeno:

* se l'utente è autenticato;
* se esiste un profilo applicativo;
* quale profilo è collegato all'utente;
* quale azienda è collegata all'utente;
* quale stato iniziale deve essere mostrato.

---

## 14.5 Stati logici minimi

Il design prevede questi stati logici:

```text
sconosciuto
non autenticato
autenticato senza profilo
autenticato con profilo
```

Significato:

## sconosciuto

L'app sta ancora controllando la sessione.

## non autenticato

L'utente deve fare login.

## autenticato senza profilo

L'utente ha una sessione Supabase, ma non ha ancora completato l'onboarding applicativo.

## autenticato con profilo

L'utente può entrare nella home.

---

## 14.6 Dipendenza aperta profilo e azienda

Il modo preciso in cui profilo e azienda verranno letti sarà definito nel coding plan core o nel successivo design auth/session.

Questo documento stabilisce il principio:

```text
la decisione login / onboarding / home non deve essere duplicata nelle schermate
```

Il coding plan dovrà decidere se questa logica iniziale resterà in un controller sessione minimo o se verrà poi completata nel blocco auth/session.

---

## 14.7 Reazione della UI allo stato sessione

La UI dovrà osservare lo stato sessione in un punto unico e scegliere la schermata corretta.

Questa logica non deve essere ripetuta in login, onboarding e home.

Schema logico:

```text
stato sessione sconosciuto
→ schermata o messaggio di caricamento

non autenticato
→ login

autenticato senza profilo
→ onboarding

autenticato con profilo
→ home
```

Il design non impone ancora il widget esatto.

Il coding plan dovrà scegliere una soluzione semplice e leggibile.

---

# 15. Base servizi Supabase

## 15.1 Scopo

Il core deve preparare il principio secondo cui le schermate non devono parlare direttamente con Supabase in modo sparso.

Le schermate dovranno usare servizi o controller dedicati.

Esempio:

```text
La schermata prodotti non deve contenere tutte le query Supabase.
La schermata prodotti dovrà chiamare un servizio prodotti.
```

---

## 15.2 Cosa deve fare il core ora

In questa fase il core non deve creare tutti i servizi completi.

Deve solo preparare la direzione.

I servizi specifici verranno creati nei blocchi futuri:

* auth;
* onboarding;
* categorie;
* fornitori;
* prodotti;
* movimenti;
* storico.

La sessione sarà il primo caso in cui il core avrà bisogno di dialogare con Supabase Auth.

---

## 15.3 Regola sul client Supabase

Il client Supabase deve essere centralizzato.

Flutter deve usare solo la chiave pubblica anon dove previsto.

Flutter non deve mai usare la service role key.

---

# 16. Collegamento con il backend

Il core deve rispettare le regole backend già approvate.

In particolare:

* Flutter non modifica direttamente `prodotti.scorta_attuale`;
* Flutter non inserisce direttamente in `movimenti_magazzino`;
* Flutter non modifica movimenti;
* Flutter non elimina movimenti;
* Flutter non usa service role key;
* Flutter non bypassa le RLS;
* Flutter usa `crea_azienda_e_profilo` per onboarding;
* Flutter usa `registra_movimento` per carico, vendita, reso e rettifica;
* Flutter traduce errori tecnici in messaggi utente;
* Flutter produce feedback persistente.

Queste regole non appartengono solo alle schermate future.

Devono essere rispettate fin dalla struttura iniziale del core.

---

# 17. Struttura logica prevista

La struttura logica prevista è:

```text
lib/
  core/
    messages/
    errors/
    feedback/
    accessibility/
    session/
    services/
```

Questa è una struttura logica.

Il coding plan deciderà quali cartelle e file creare subito.

Regola:

```text
Non creare file vuoti solo per completare una struttura teorica.
```

I file devono nascere quando servono davvero.

---

# 18. Possibili file futuri

Questi nomi sono indicativi e saranno confermati nel coding plan.

```text
lib/core/messages/app_messages.dart
lib/core/messages/app_error_messages.dart
lib/core/messages/app_accessibility_messages.dart

lib/core/errors/app_exception.dart
lib/core/errors/supabase_error_mapper.dart

lib/core/feedback/app_feedback_message.dart
lib/core/feedback/app_feedback_controller.dart

lib/core/accessibility/accessibility_service.dart

lib/core/session/app_session_controller.dart
lib/core/session/app_session_state.dart

lib/core/services/supabase_service.dart
```

Nota importante:

questa lista è solo orientativa.

Questo documento non obbliga a creare tutti questi file immediatamente.

Il coding plan non deve creare tutti questi file automaticamente.

La prima iterazione dovrà creare solo i file realmente necessari al primo blocco di codice.

Dove utile, il coding plan potrà accorpare elementi vicini.

La separazione in file diversi dovrà avvenire solo quando il codice cresce o quando la separazione rende il progetto più chiaro.

Regola:

```text
pochi file iniziali, ma ben scelti
```

---

# 19. Regola sulla semplicità

Il core deve restare semplice.

Da evitare in questa fase:

* architettura troppo pesante;
* troppi file prima del necessario;
* cartelle vuote;
* service locator obbligatorio;
* BLoC per ogni cosa;
* router complesso;
* astrazioni premature;
* codice difficile da seguire manualmente.

Scelta consigliata per MVP 1:

```text
controller semplici
ValueNotifier o ChangeNotifier dove utile
servizi dedicati solo quando servono
navigazione semplice
```

Il core deve aiutare il progetto, non appesantirlo.

---

# 20. Regola sulle schermate future

Le schermate future dovranno:

* usare i messaggi centralizzati;
* usare il mapper errori;
* mostrare feedback persistente;
* rispettare l'accessibilità;
* non contenere query Supabase sparse;
* non contenere regole critiche duplicate;
* non modificare direttamente scorta o movimenti;
* non mostrare errori tecnici grezzi.

Il core deve rendere queste regole facili da rispettare.

---

# 21. Esempi pratici di uso futuro

## 21.1 Esempio login

Quando il login fallisce per credenziali errate:

```text
Supabase restituisce un errore tecnico
↓
il mapper errori lo traduce
↓
viene scelto il messaggio centralizzato:
"Email o password non corrette."
↓
il feedback controller mostra il messaggio
↓
eventualmente accessibility service annuncia il messaggio
```

La schermata login non deve inventare il messaggio da sola.

---

## 21.2 Esempio prodotto duplicato

Quando si tenta di salvare un prodotto con barcode già esistente:

```text
Supabase restituisce errore di vincolo
↓
il mapper errori riconosce il caso
↓
viene scelto il messaggio centralizzato:
"Esiste già un prodotto con questo barcode."
↓
l'utente legge il feedback persistente
```

La frase deve essere centralizzata.

---

## 21.3 Esempio scorta insufficiente

Quando una vendita supera la scorta disponibile:

```text
RPC registra_movimento restituisce errore
↓
il mapper errori lo traduce
↓
viene scelto il messaggio centralizzato:
"Scorta insufficiente per completare l'operazione."
↓
il feedback persistente mostra il messaggio
```

La schermata vendita non deve modificare la scorta da sola.

---

## 21.4 Esempio sessione iniziale

All'avvio:

```text
l'app controlla Supabase Auth
↓
controlla se esiste il profilo
↓
decide lo stato:
non autenticato / senza profilo / con profilo
↓
mostra login / onboarding / home
```

Questa logica deve essere centralizzata.

---

# 22. Test logici previsti per il core

Il core non avrà ancora tutti i test funzionali dell'app.

Tuttavia il design deve prevedere verifiche semplici.

---

## 22.1 Messaggi

Verificare che i messaggi principali siano centralizzati.

Risultato atteso:

```text
nessun messaggio utente importante scritto direttamente nei widget del primo blocco
```

---

## 22.2 Messaggi senza BuildContext

Verificare che i messaggi core siano usabili anche fuori dalla UI.

Risultato atteso:

```text
un servizio o un controller può usare un messaggio senza BuildContext
```

---

## 22.3 Errori

Verificare che un errore tecnico venga trasformato in messaggio utente.

Risultato atteso:

```text
errore tecnico dentro
messaggio comprensibile fuori
```

---

## 22.4 Errori di rete

Verificare che gli errori di rete non diventino errori generici incomprensibili.

Risultato atteso:

```text
assenza rete o timeout
↓
messaggio comprensibile
```

---

## 22.5 Feedback

Verificare che un messaggio possa essere mostrato in modo persistente.

Risultato atteso:

```text
il messaggio resta disponibile nella schermata
```

---

## 22.6 Accessibilità

Verificare che un messaggio importante possa essere annunciato, ma non solo annunciato.

Risultato atteso:

```text
messaggio visibile + eventuale annuncio
```

---

## 22.7 Semantics

Verificare che il coding plan tenga conto delle etichette accessibili nelle future schermate.

Risultato atteso:

```text
icone e controlli non ovvi avranno testo accessibile
```

---

## 22.8 Sessione

Verificare che gli stati logici della sessione siano chiari.

Risultato atteso:

```text
non autenticato
autenticato senza profilo
autenticato con profilo
```

---

## 22.9 Reazione UI alla sessione

Verificare che la UI reagisca allo stato sessione in un punto unico.

Risultato atteso:

```text
la scelta login / onboarding / home non viene duplicata in più schermate
```

---

# 23. Criterio di completamento del design

Questo design può essere considerato valido perché chiarisce:

* perché serve il core;
* cosa appartiene al core;
* cosa non appartiene al core;
* come devono essere gestiti i messaggi;
* perché i messaggi non devono dipendere da `BuildContext`;
* come devono essere gestiti gli errori;
* come il mapper errori deve evitare fragilità;
* come devono essere gestiti gli errori di rete;
* come deve funzionare il feedback persistente;
* quale struttura minima deve avere il feedback;
* come messaggi, errori, feedback e accessibilità lavorano in catena;
* come il core supporta l'accessibilità;
* perché gli annunci non bastano;
* perché servono anche `Semantics` ed etichette accessibili;
* come viene pensata la sessione;
* come la sessione si collega a Supabase Auth;
* come si prepara il rapporto con Supabase;
* quali regole backend restano obbligatorie;
* come evitare sovra-architettura;
* quale sarà il passo successivo.

---

# 24. Revisione AI

Questo documento è stato revisionato tramite confronto con:

* ChatGPT;
* DeepSeek;
* Gemini;
* Claude.

Il primo giro di revisione ha prodotto giudizio complessivo:

```text
APPROVATO CON MODIFICHE MINORI
```

Le modifiche integrate hanno riguardato:

* messaggi Dart puri e non dipendenti da `BuildContext`;
* rapporto tra messaggi ed errori;
* pipeline evento, errore, feedback e accessibilità;
* gestione degli errori di rete;
* riduzione del rischio di mapper fragile basato solo su testo libero;
* definizione concettuale dell'oggetto feedback;
* uso di `Semantics` ed etichette accessibili;
* sessione come consumatore di Supabase Auth;
* dipendenza aperta su profilo e azienda;
* creazione prudente dei file iniziali;
* reazione UI centralizzata allo stato sessione.

Dopo l'integrazione di queste modifiche, non è necessario un secondo giro di revisione AI.

Il documento può essere considerato approvato.

---

# 25. Rischi da evitare

## 25.1 Core troppo grande

Il core non deve diventare un progetto dentro il progetto.

Deve essere minimo.

---

## 25.2 Core troppo povero

Il core non deve essere così piccolo da lasciare messaggi, errori e feedback sparsi nelle schermate.

---

## 25.3 Accessibilità rimandata

L'accessibilità non deve essere trattata come revisione finale.

Deve essere presente fin dalla base.

---

## 25.4 Errori tecnici visibili

Gli errori tecnici non devono arrivare grezzi all'utente.

---

## 25.5 Mapper errori fragile

Il mapper errori non deve dipendere solo da controlli casuali su testo libero.

Quando possibile deve usare tipo, codice o casi previsti dai contratti.

---

## 25.6 Duplicazione tra messaggi ed errori

Il sistema errori non deve duplicare frasi già presenti nel sistema messaggi.

---

## 25.7 Sessione duplicata

La logica che decide login, onboarding o home non deve essere copiata in più punti.

---

## 25.8 Query sparse nella UI

Le schermate non devono diventare contenitori di query Supabase.

---

## 25.9 Troppi file iniziali

La prima implementazione del core non deve creare tutti i file possibili solo per riempire la struttura.

Deve creare solo i file realmente utili al primo blocco.

---

# 26. Prossimo passo dopo approvazione

Dopo l'approvazione di questo documento, il passo successivo sarà creare:

```text
docs/4-flutter/2-coding-plans/001-CODING_PLAN_CORE_mvp1_v1.0.0.md
```

Dopo il coding plan verrà creato:

```text
docs/4-flutter/3-todos/001-TODO_CORE_mvp1_v1.0.0.md
```

Solo dopo questi documenti si passerà al primo codice Dart del core.

---

# 27. Stato del documento

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
docs/4-flutter/1-design/001-DESIGN_CORE_mvp1_v1.0.0.md
```

---

# 28. Conclusione

Il core Dart minimo è il primo vero blocco strutturale dell'app Flutter.

Non deve costruire l'app completa.

Deve creare una base ordinata per evitare problemi futuri.

Il core deve permettere alle schermate successive di usare:

* messaggi coerenti;
* errori comprensibili;
* feedback persistente;
* accessibilità integrata;
* sessione centralizzata;
* rapporto pulito con Supabase.

Il principio finale è:

```text
prima una base comune,
poi le funzionalità.
```

Con questo design approvato, il progetto può passare al coding plan core.