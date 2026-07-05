\# TODO MASTER MVP 1.0



\## Gestionale Magazzino Universale



Versione: 1.0.0

Stato: APPROVATO

Data: 5 luglio 2026



\---



\# 1. Scopo del documento



Questo documento è il todo master della fase Flutter dell'MVP 1.



Serve a tenere traccia delle macro-fasi di lavoro necessarie per costruire l'app Flutter del Gestionale Magazzino Universale.



Questo file non contiene codice.



Questo file non sostituisce:



\* i documenti di design;

\* i coding plan;

\* i todo specifici;

\* il changelog;

\* i test manuali.



Il suo scopo è rispondere sempre a questa domanda:



\*\*A che punto siamo e qual è il prossimo blocco logico da fare?\*\*



\---



\# 2. Ruolo del todo master



Il todo master è la bussola generale del lavoro Flutter.



Deve aiutare a:



\* riprendere il progetto dopo una pausa;

\* capire quali fasi sono già completate;

\* capire quale fase è in corso;

\* capire quale fase viene dopo;

\* collegare ogni macro-fase ai suoi documenti specifici;

\* evitare di saltare passaggi importanti;

\* mantenere il lavoro ordinato e verificabile.



Il todo master deve restare semplice.



I dettagli operativi devono stare nei todo specifici.



\---



\# 3. Differenza tra todo master e todo specifici



\## Todo master



Il file:



`000-todo-master.md`



contiene la visione generale.



Esempio:



\* Core Dart minimo;

\* login e sessione;

\* onboarding;

\* home;

\* categorie;

\* fornitori;

\* prodotti;

\* movimenti;

\* accessibilità;

\* stabilizzazione.



\## Todo specifici



I file specifici, come:



`001-TODO\_CORE\_mvp1\_v1.0.0.md`



contengono i passi piccoli e concreti di una singola fase.



Esempio:



\* creare cartella `core/messages`;

\* creare `app\_messages.dart`;

\* creare `app\_error\_messages.dart`;

\* eseguire `flutter analyze`;

\* aggiornare changelog;

\* fare commit.



Regola:



\*\*Il todo master dice dove andare.

Il todo specifico dice come fare quel pezzo.\*\*



\---



\# 4. Legenda stati



Per mantenere il file semplice e leggibile anche con screen reader, si usano questi stati:



\* `\[ ]` Da fare

\* `\[\~]` In corso

\* `\[x]` Completato

\* `\[!]` Bloccato



Significato:



\## `\[ ]` Da fare



La fase è prevista ma non ancora iniziata.



\## `\[\~]` In corso



La fase è stata iniziata ma non ancora completata.



\## `\[x]` Completato



La fase è stata completata, verificata e committata.



\## `\[!]` Bloccato



La fase non può proseguire finché non viene risolto un problema.



\---



\# 5. Stato generale del progetto



Alla data di questo documento, il progetto si trova in questa situazione:



\* backend Supabase progettato;

\* database approvato;

\* script SQL eseguiti;

\* RLS approvate;

\* RPC movimenti approvata;

\* RPC onboarding approvata;

\* test backend completati;

\* repository GitHub creato;

\* documentazione principale salvata;

\* Flutter plan approvato;

\* API Contracts approvato;

\* README documentazione creato;

\* fase Flutter pronta per essere organizzata operativamente.



La prossima fase riguarda la preparazione dei primi documenti operativi Flutter.



\---



\# 6. Documenti già approvati



\## Architettura



Documento:



`docs/0-architettura/001-ARCHITETTURA\_mvp1\_v1.0.0.md`



Stato:



`APPROVATO`



\## Database schema



Documento:



`docs/1-database/001-DATABASE\_SCHEMA\_mvp1\_v1.0.0.md`



Stato:



`APPROVATO`



\## Script Supabase



Documenti:



\* `docs/1-database/supabase/001\_schema.sql`

\* `docs/1-database/supabase/002\_rpc.sql`

\* `docs/1-database/supabase/003\_rls.sql`

\* `docs/1-database/supabase/004\_onboarding\_rpc.sql`



Stato:



`APPROVATI ED ESEGUITI`



\## Test backend



Documento:



`docs/1-database/TEST\_PLAN\_MVP1\_v1.0.0.md`



Stato:



`APPROVATO`



Esito:



`TEST BACKEND SUPERATI`



\## Flussi applicativi



Documento:



`docs/2-flussi-applicativi/001-FLOWS\_mvp1\_v1.0.0.md`



Stato:



`APPROVATO`



\## Backend rules



Documento:



`docs/3-backend/001-BACKEND\_RULES\_mvp1\_v1.0.0.md`



Stato:



`APPROVATO`



\## API Contracts



Documento:



`docs/3-backend/002-API\_CONTRACTS\_mvp1\_v1.0.0.md`



Stato:



`APPROVATO`



\## Flutter plan



Documento:



`docs/4-flutter/001-FLUTTER\_PLAN\_mvp1\_v1.0.0.md`



Stato:



`APPROVATO`



\## README documentazione



Documento:



`docs/README.md`



Stato:



`APPROVATO`



\---



\# 7. Regola di lavoro per la fase Flutter



Ogni blocco Flutter importante deve seguire questo ordine:



1\. design;

2\. coding plan;

3\. todo specifico;

4\. codice;

5\. test manuale;

6\. eventuali correzioni;

7\. aggiornamento changelog;

8\. commit;

9\. push.



Questa regola evita di scrivere codice senza una direzione chiara.



\---



\# 8. Macro-fasi Flutter MVP 1.0



\## 8.1 Preparazione operativa Flutter



Stato:



`\[\~] In corso`



Obiettivo:



preparare i documenti operativi necessari prima di scrivere il core Dart minimo.



Documenti collegati:



\* `docs/4-flutter/3-todos/000-todo-master.md`



Prossimi documenti:



\* `docs/4-flutter/1-design/001-DESIGN\_CORE\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/2-coding-plans/001-CODING\_PLAN\_CORE\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/3-todos/001-TODO\_CORE\_mvp1\_v1.0.0.md`



Criterio di completamento:



questa fase è completata quando esistono e sono approvati:



\* design core;

\* coding plan core;

\* todo core.



\---



\## 8.2 Core Dart minimo



Stato:



`\[ ] Da fare`



Obiettivo:



creare la base comune dell'app Flutter prima delle schermate complete.



Il core dovrà contenere, in forma minima:



\* messaggi centralizzati;

\* errori centralizzati;

\* feedback persistente;

\* supporto accessibilità;

\* gestione sessione;

\* base per servizi Supabase.



Documenti previsti:



\* `docs/4-flutter/1-design/001-DESIGN\_CORE\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/2-coding-plans/001-CODING\_PLAN\_CORE\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/3-todos/001-TODO\_CORE\_mvp1\_v1.0.0.md`



Criterio di completamento:



\* cartelle core create;

\* file core minimi creati;

\* nessuna stringa utente sparsa nel codice iniziale;

\* sistema messaggi base presente;

\* sistema errori base presente;

\* feedback applicativo base presente;

\* accessibilità minima predisposta;

\* sessione minima predisposta;

\* `flutter analyze` senza errori nuovi;

\* commit eseguito.



\---



\## 8.3 Login, logout e sessione



Stato:



`\[ ] Da fare`



Obiettivo:



gestire l'accesso dell'utente e lo stato iniziale dell'app.



Funzionalità previste:



\* login con email e password;

\* logout;

\* controllo sessione all'avvio;

\* gestione utente non autenticato;

\* gestione utente autenticato senza profilo;

\* gestione utente autenticato con profilo;

\* messaggi accessibili di successo ed errore.



Documenti previsti:



\* `docs/4-flutter/1-design/002-DESIGN\_AUTH\_SESSION\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/2-coding-plans/002-CODING\_PLAN\_AUTH\_SESSION\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/3-todos/002-TODO\_AUTH\_SESSION\_mvp1\_v1.0.0.md`



Criterio di completamento:



\* login funzionante;

\* logout funzionante;

\* sessione letta all'avvio;

\* errori login tradotti in messaggi comprensibili;

\* feedback persistente presente;

\* schermata corretta mostrata in base allo stato utente;

\* test manuali login superati;

\* commit eseguito.



\---



\## 8.4 Onboarding



Stato:



`\[ ] Da fare`



Obiettivo:



permettere a un utente autenticato senza profilo di creare azienda e profilo.



Funzionalità previste:



\* rilevamento profilo assente;

\* schermata onboarding;

\* inserimento nome azienda;

\* eventuale nome profilo;

\* chiamata RPC `crea\_azienda\_e\_profilo`;

\* gestione onboarding duplicato;

\* passaggio alla home dopo onboarding riuscito.



Documenti previsti:



\* `docs/4-flutter/1-design/003-DESIGN\_ONBOARDING\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/2-coding-plans/003-CODING\_PLAN\_ONBOARDING\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/3-todos/003-TODO\_ONBOARDING\_mvp1\_v1.0.0.md`



Criterio di completamento:



\* onboarding funzionante;

\* azienda creata;

\* profilo creato;

\* doppio onboarding gestito;

\* messaggi chiari;

\* test manuali onboarding superati;

\* commit eseguito.



\---



\## 8.5 Home



Stato:



`\[ ] Da fare`



Obiettivo:



creare la schermata iniziale dopo login e onboarding.



Funzionalità previste:



\* mostrare nome azienda;

\* mostrare utente o profilo corrente;

\* collegamenti principali;

\* accesso a categorie;

\* accesso a fornitori;

\* accesso a prodotti;

\* accesso a movimenti;

\* logout raggiungibile.



Documenti previsti:



\* `docs/4-flutter/1-design/004-DESIGN\_HOME\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/2-coding-plans/004-CODING\_PLAN\_HOME\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/3-todos/004-TODO\_HOME\_mvp1\_v1.0.0.md`



Criterio di completamento:



\* home leggibile;

\* navigazione principale funzionante;

\* elementi letti correttamente da screen reader;

\* test home superati;

\* commit eseguito.



\---



\## 8.6 Categorie



Stato:



`\[ ] Da fare`



Obiettivo:



gestire le categorie prodotto.



Funzionalità previste:



\* lista categorie;

\* creazione categoria;

\* modifica categoria;

\* disattivazione categoria;

\* gestione nome obbligatorio;

\* gestione nome duplicato;

\* visualizzazione stato attiva/inattiva.



Documenti previsti:



\* `docs/4-flutter/1-design/005-DESIGN\_CATEGORIES\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/2-coding-plans/005-CODING\_PLAN\_CATEGORIES\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/3-todos/005-TODO\_CATEGORIES\_mvp1\_v1.0.0.md`



Criterio di completamento:



\* lista categorie funzionante;

\* creazione funzionante;

\* modifica funzionante;

\* disattivazione funzionante;

\* errori tradotti;

\* feedback accessibile;

\* commit eseguito.



\---



\## 8.7 Fornitori



Stato:



`\[ ] Da fare`



Obiettivo:



gestire l'anagrafica fornitori.



Funzionalità previste:



\* lista fornitori;

\* creazione fornitore;

\* modifica fornitore;

\* disattivazione fornitore;

\* gestione nome obbligatorio;

\* gestione nome duplicato;

\* gestione campi facoltativi;

\* visualizzazione stato attivo/inattivo.



Documenti previsti:



\* `docs/4-flutter/1-design/006-DESIGN\_SUPPLIERS\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/2-coding-plans/006-CODING\_PLAN\_SUPPLIERS\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/3-todos/006-TODO\_SUPPLIERS\_mvp1\_v1.0.0.md`



Criterio di completamento:



\* lista fornitori funzionante;

\* creazione funzionante;

\* modifica funzionante;

\* disattivazione funzionante;

\* errori tradotti;

\* feedback accessibile;

\* commit eseguito.



\---



\## 8.8 Prodotti



Stato:



`\[ ] Da fare`



Obiettivo:



gestire l'anagrafica prodotti.



Funzionalità previste:



\* lista prodotti;

\* dettaglio prodotto;

\* creazione prodotto;

\* modifica prodotto;

\* disattivazione prodotto;

\* gestione barcode;

\* gestione categoria;

\* gestione fornitore preferito;

\* gestione prezzi;

\* gestione scorta minima;

\* visualizzazione scorta attuale;

\* blocco modifica diretta scorta.



Documenti previsti:



\* `docs/4-flutter/1-design/007-DESIGN\_PRODUCTS\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/2-coding-plans/007-CODING\_PLAN\_PRODUCTS\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/3-todos/007-TODO\_PRODUCTS\_mvp1\_v1.0.0.md`



Criterio di completamento:



\* lista prodotti funzionante;

\* dettaglio prodotto funzionante;

\* creazione funzionante;

\* modifica funzionante;

\* disattivazione funzionante;

\* barcode vuoto salvato come `NULL`;

\* scorta attuale non modificata direttamente;

\* errori tradotti;

\* feedback accessibile;

\* commit eseguito.



\---



\## 8.9 Movimenti di magazzino



Stato:



`\[ ] Da fare`



Obiettivo:



registrare le variazioni di scorta tramite RPC.



Funzionalità previste:



\* carico;

\* vendita;

\* rettifica;

\* eventuale reso cliente dopo carico/vendita/rettifica;

\* chiamata RPC `registra\_movimento`;

\* blocco movimenti su prodotti inattivi;

\* gestione scorta insufficiente;

\* gestione scorta minima;

\* motivazione obbligatoria per rettifica.



Documenti previsti:



\* `docs/4-flutter/1-design/008-DESIGN\_MOVEMENTS\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/2-coding-plans/008-CODING\_PLAN\_MOVEMENTS\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/3-todos/008-TODO\_MOVEMENTS\_mvp1\_v1.0.0.md`



Criterio di completamento:



\* carico funzionante;

\* vendita funzionante;

\* rettifica funzionante;

\* RPC usata correttamente;

\* nessun inserimento diretto in `movimenti\_magazzino`;

\* nessun update diretto di `scorta\_attuale`;

\* messaggi accessibili;

\* test manuali movimenti superati;

\* commit eseguito.



\---



\## 8.10 Storico movimenti



Stato:



`\[ ] Da fare`



Obiettivo:



consultare lo storico dei movimenti di magazzino.



Funzionalità previste:



\* lista movimenti;

\* storico per prodotto;

\* filtro per prodotto;

\* filtro per tipo movimento;

\* filtro per data;

\* visualizzazione scorta prima;

\* visualizzazione scorta dopo;

\* visualizzazione note;

\* visualizzazione fornitore nei carichi.



Per l'MVP 1 il nome operatore non viene mostrato in forma amichevole.



Documenti previsti:



\* `docs/4-flutter/1-design/009-DESIGN\_MOVEMENT\_HISTORY\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/2-coding-plans/009-CODING\_PLAN\_MOVEMENT\_HISTORY\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/3-todos/009-TODO\_MOVEMENT\_HISTORY\_mvp1\_v1.0.0.md`



Criterio di completamento:



\* storico leggibile;

\* filtri principali funzionanti;

\* movimenti ordinati correttamente;

\* dati importanti letti bene da screen reader;

\* commit eseguito.



\---



\## 8.11 Revisione accessibilità



Stato:



`\[ ] Da fare`



Obiettivo:



verificare che il flusso principale sia utilizzabile tramite screen reader.



Controlli previsti:



\* login;

\* onboarding;

\* home;

\* categorie;

\* fornitori;

\* prodotti;

\* movimenti;

\* storico;

\* messaggi errore;

\* messaggi successo;

\* navigazione;

\* ordine del focus;

\* chiarezza dei pulsanti;

\* assenza di informazioni solo visive.



Documenti previsti:



\* `docs/4-flutter/1-design/010-DESIGN\_ACCESSIBILITY\_REVIEW\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/2-coding-plans/010-CODING\_PLAN\_ACCESSIBILITY\_REVIEW\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/3-todos/010-TODO\_ACCESSIBILITY\_REVIEW\_mvp1\_v1.0.0.md`



Criterio di completamento:



\* flusso principale usabile con screen reader;

\* errori principali leggibili;

\* messaggi persistenti funzionanti;

\* nessuna funzione critica solo visiva;

\* commit eseguito.



\---



\## 8.12 Stabilizzazione MVP 1



Stato:



`\[ ] Da fare`



Obiettivo:



stabilizzare l'app prima di considerare chiuso l'MVP 1.



Attività previste:



\* revisione bug;

\* pulizia codice;

\* controllo documentazione;

\* controllo changelog;

\* controllo versioni;

\* test manuale completo;

\* verifica repository;

\* preparazione eventuale tag di versione.



Documenti previsti:



\* `docs/4-flutter/1-design/011-DESIGN\_STABILIZATION\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/2-coding-plans/011-CODING\_PLAN\_STABILIZATION\_mvp1\_v1.0.0.md`

\* `docs/4-flutter/3-todos/011-TODO\_STABILIZATION\_mvp1\_v1.0.0.md`



Criterio di completamento:



\* flusso MVP 1 completo;

\* test principali superati;

\* documentazione aggiornata;

\* changelog aggiornato;

\* commit finale eseguito;

\* MVP 1 pronto per uso reale iniziale.



\---



\# 9. Riepilogo macro-fasi



Stato attuale:



\* `\[\~]` Preparazione operativa Flutter

\* `\[ ]` Core Dart minimo

\* `\[ ]` Login, logout e sessione

\* `\[ ]` Onboarding

\* `\[ ]` Home

\* `\[ ]` Categorie

\* `\[ ]` Fornitori

\* `\[ ]` Prodotti

\* `\[ ]` Movimenti di magazzino

\* `\[ ]` Storico movimenti

\* `\[ ]` Revisione accessibilità

\* `\[ ]` Stabilizzazione MVP 1



\---



\# 10. Prossimo passo operativo



Il prossimo passo è scrivere il documento:



`docs/4-flutter/1-design/001-DESIGN\_CORE\_mvp1\_v1.0.0.md`



Questo documento dovrà definire il design del core Dart minimo.



Il core Dart minimo dovrà preparare:



\* messaggi;

\* errori;

\* feedback;

\* accessibilità;

\* sessione;

\* base servizi.



Non si deve ancora partire dalle schermate complete.



\---



\# 11. Regole per aggiornare questo file



Questo file deve essere aggiornato quando:



\* una macro-fase entra in corso;

\* una macro-fase viene completata;

\* una macro-fase viene bloccata;

\* viene creato un nuovo design;

\* viene creato un nuovo coding plan;

\* viene creato un nuovo todo specifico;

\* viene completato un blocco di codice importante;

\* cambia il prossimo passo operativo;

\* cambia la struttura della documentazione Flutter.



\---



\# 12. Cosa non deve contenere questo file



Questo file non deve contenere:



\* codice Dart;

\* istruzioni lunghe passo passo;

\* micro-task troppo dettagliati;

\* bug temporanei piccoli;

\* test completi dei singoli blocchi;

\* prompt per coding agent;

\* bozze di schermate;

\* dettagli tecnici che appartengono ai coding plan.



Questi contenuti devono stare nei documenti specifici.



\---



\# 13. Regole per i todo specifici



Ogni todo specifico deve essere collegato a una sola macro-fase.



Esempio:



`001-TODO\_CORE\_mvp1\_v1.0.0.md`



deve riguardare solo il core Dart minimo.



Un todo specifico deve contenere:



\* obiettivo del blocco;

\* documenti di riferimento;

\* file da creare;

\* file da modificare;

\* task piccoli;

\* test manuali;

\* criterio di completamento;

\* commit consigliato.



Un todo specifico non deve mischiare fasi diverse.



Esempio da evitare:



\* core;

\* login;

\* onboarding;

\* prodotti;



tutti nello stesso todo.



\---



\# 14. Regola dei piccoli passi



Il progetto deve procedere con piccoli blocchi.



Regola:



\*\*un blocco, un obiettivo, un test, un commit.\*\*



Questo significa:



1\. scrivere il design del blocco;

2\. scrivere il coding plan;

3\. scrivere il todo specifico;

4\. implementare solo quel blocco;

5\. testare;

6\. correggere;

7\. committare.



Questa regola serve a evitare confusione e regressioni.



\---



\# 15. Regola sui commit



Ogni blocco completato deve avere un commit chiaro.



Esempi:



\* `Aggiunge todo master Flutter`

\* `Aggiunge design core Flutter`

\* `Aggiunge coding plan core Flutter`

\* `Aggiunge core messaggi ed errori`

\* `Aggiunge gestione feedback applicativo`

\* `Aggiunge gestione sessione iniziale`



Il commit deve descrivere cosa è stato fatto, non essere generico.



Da evitare:



\* `modifiche`

\* `fix`

\* `varie`

\* `aggiornamento`



\---



\# 16. Regola sul changelog



Quando viene completato un blocco importante, aggiornare:



`CHANGELOG.md`



Il changelog deve raccontare l'evoluzione del progetto.



Il todo master dice cosa resta da fare.



Il changelog dice cosa è stato fatto.



\---



\# 17. Regola sui consiglieri AI



Questo todo master non richiede revisione esterna con consiglieri AI perché non introduce nuove decisioni tecniche.



La revisione con consiglieri AI è consigliata per:



\* design complessi;

\* coding plan critici;

\* modifiche backend;

\* nuove RPC;

\* modifiche RLS;

\* modifiche alla logica di scorta;

\* scelte architetturali importanti.



La revisione non è normalmente necessaria per:



\* todo master;

\* README;

\* changelog;

\* piccoli aggiornamenti organizzativi;

\* correzioni editoriali.



\---



\# 18. Regola di accessibilità permanente



L'accessibilità non è una fase finale separata.



Ogni macro-fase deve rispettare fin dall'inizio questi principi:



\* messaggi testuali;

\* feedback persistente;

\* pulsanti chiari;

\* campi con etichette leggibili;

\* ordine logico;

\* nessuna informazione solo visiva;

\* nessun errore comunicato solo tramite colore;

\* compatibilità con screen reader.



La revisione accessibilità finale serve a verificare il risultato complessivo, non a introdurre l'accessibilità per la prima volta.



\---



\# 19. Regola backend fonte della verità



Durante tutta la fase Flutter resta valida questa regola:



\*\*il backend è la fonte della verità.\*\*



Flutter non deve:



\* modificare direttamente `prodotti.scorta\_attuale`;

\* inserire direttamente in `movimenti\_magazzino`;

\* modificare movimenti;

\* eliminare movimenti;

\* usare service role key;

\* bypassare le RLS;

\* fidarsi dei dati locali come se fossero definitivi.



Flutter deve:



\* usare `crea\_azienda\_e\_profilo` per onboarding;

\* usare `registra\_movimento` per carico, vendita, reso e rettifica;

\* leggere i dati consentiti dalle RLS;

\* tradurre gli errori tecnici in messaggi comprensibili;

\* mostrare feedback persistente.



\---



\# 20. Stato del documento



Stato:



`APPROVATO`



Versione:



`1.0.0`



Nome file:



`docs/4-flutter/3-todos/000-todo-master.md`



Prossimo documento:



`docs/4-flutter/1-design/001-DESIGN\_CORE\_mvp1\_v1.0.0.md`



\---



\# 21. Conclusione



Questo todo master definisce la mappa generale della fase Flutter dell'MVP 1.



Il documento non deve diventare un elenco enorme di dettagli.



Deve restare una bussola.



I dettagli saranno scritti nei design, nei coding plan e nei todo specifici.



Il prossimo passo è progettare il core Dart minimo.



Il primo blocco di codice non dovrà creare schermate complete.



Dovrà creare la base ordinata su cui costruire il resto dell'app.

