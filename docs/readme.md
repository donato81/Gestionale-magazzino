\# DOCUMENTAZIONE PROGETTO



\## Gestionale Magazzino Universale



Versione: 1.0.0

Stato: APPROVATO

Data: 5 luglio 2026



\---



\# 1. Scopo del documento



Questo file è l'indice generale della cartella `docs`.



Serve a spiegare dove si trova la documentazione ufficiale del progetto e in quale ordine deve essere letta.



Non sostituisce i singoli documenti tecnici.



Non contiene codice.



Non introduce nuove regole architetturali.



Il suo scopo è rendere la documentazione:



\* ordinata;

\* facile da consultare;

\* utile per il lavoro manuale;

\* utile per la revisione con AI;

\* utile per futuri coding agent;

\* stabile nel tempo.



\---



\# 2. Progetto



Nome progetto:



```text

Gestionale Magazzino Universale

```



Obiettivo dell'MVP 1:



```text

costruire un gestionale magazzino accessibile, sicuro e multi-tenant,

basato su Flutter e Supabase.

```



Il cuore dell'MVP 1 è:



\* autenticazione utente;

\* creazione azienda e profilo;

\* gestione categorie;

\* gestione fornitori;

\* gestione prodotti;

\* registrazione movimenti di magazzino;

\* aggiornamento scorte;

\* consultazione storico movimenti;

\* utilizzo tramite screen reader.



\---



\# 3. Principio guida della documentazione



La documentazione segue questo principio:



```text

prima si definiscono le regole,

poi si scrive il codice.

```



Il progetto non deve procedere con codice improvvisato.



Ogni blocco importante deve avere:



1\. una regola chiara;

2\. un piano comprensibile;

3\. un todo operativo;

4\. codice scritto in modo progressivo;

5\. test;

6\. aggiornamento del changelog;

7\. commit.



\---



\# 4. Struttura generale della cartella docs



La cartella `docs` è organizzata così:



```text

docs/

&#x20; README.md



&#x20; 0-architettura/

&#x20; 1-database/

&#x20; 2-flussi-applicativi/

&#x20; 3-backend/

&#x20; 4-flutter/

```



Ogni cartella ha una responsabilità specifica.



\---



\# 5. Cartella 0-architettura



Percorso:



```text

docs/0-architettura/

```



Contiene la visione architetturale generale del progetto.



Documento principale:



```text

001-ARCHITETTURA\_mvp1\_v1.0.0.md

```



Questo documento definisce:



\* obiettivo dell'MVP 1;

\* visione futura del gestionale;

\* principio della scorta;

\* ruolo dei movimenti di magazzino;

\* architettura multi-tenant;

\* entità principali;

\* scelta Supabase;

\* scelta Flutter;

\* accessibilità come requisito architetturale;

\* evoluzioni future.



Questo è il primo documento da leggere per capire il senso generale del progetto.



\---



\# 6. Cartella 1-database



Percorso:



```text

docs/1-database/

```



Contiene la documentazione e gli script relativi alla base dati Supabase.



Documento principale:



```text

001-DATABASE\_SCHEMA\_mvp1\_v1.0.0.md

```



Questo documento definisce:



\* tabelle;

\* campi;

\* vincoli;

\* relazioni;

\* UUID;

\* multi-tenant;

\* scorta;

\* movimenti;

\* barcode;

\* soft delete;

\* indici;

\* trigger previsti.



\---



\## 6.1 Script Supabase



Gli script SQL si trovano nella sottocartella dedicata a Supabase.



Percorso consigliato:



```text

docs/1-database/supabase/

```



Script principali:



```text

001\_schema.sql

002\_rpc.sql

003\_rls.sql

004\_onboarding\_rpc.sql

```



\### 001\_schema.sql



Contiene:



\* estensioni;

\* tabelle;

\* vincoli;

\* indici;

\* trigger `updated\_at`;

\* protezione di `prodotti.scorta\_attuale`;

\* immutabilità dei movimenti.



\### 002\_rpc.sql



Contiene la RPC:



```text

registra\_movimento

```



Questa RPC è il punto unico per modificare la scorta.



Supporta:



\* carico;

\* vendita;

\* reso;

\* rettifica.



\### 003\_rls.sql



Contiene:



\* abilitazione Row Level Security;

\* policy multi-tenant;

\* permessi base per utenti autenticati;

\* protezione delle tabelle applicative.



\### 004\_onboarding\_rpc.sql



Contiene la RPC:



```text

crea\_azienda\_e\_profilo

```



Questa RPC gestisce l'onboarding iniziale creando azienda e profilo in una singola operazione.



\---



\## 6.2 Piano test backend



Documento:



```text

TEST\_PLAN\_MVP1\_v1.0.0.md

```



Questo documento contiene il piano di test del backend Supabase.



È stato usato per validare:



\* database;

\* RLS;

\* RPC;

\* onboarding;

\* movimenti;

\* isolamento multi-tenant;

\* protezione della scorta;

\* immutabilità dello storico.



Il backend MVP 1.0 è stato approvato dopo l'esecuzione dei test.



\---



\# 7. Cartella 2-flussi-applicativi



Percorso:



```text

docs/2-flussi-applicativi/

```



Documento principale:



```text

001-FLOWS\_mvp1\_v1.0.0.md

```



Questo documento descrive i flussi funzionali dell'applicazione.



Contiene cosa deve succedere quando l'utente esegue operazioni come:



\* registrazione;

\* onboarding;

\* creazione categoria;

\* creazione fornitore;

\* creazione prodotto;

\* carico magazzino;

\* vendita;

\* reso cliente;

\* rettifica inventario;

\* consultazione prodotto;

\* storico movimenti;

\* disattivazione categoria;

\* disattivazione fornitore;

\* disattivazione prodotto.



Questo documento non descrive i widget Flutter.



Descrive il comportamento applicativo.



\---



\# 8. Cartella 3-backend



Percorso:



```text

docs/3-backend/

```



Contiene le regole backend e il contratto tra Flutter e Supabase.



Documenti principali:



```text

001-BACKEND\_RULES\_mvp1\_v1.0.0.md

002-API\_CONTRACTS\_mvp1\_v1.0.0.md

```



\---



\## 8.1 Backend Rules



Documento:



```text

001-BACKEND\_RULES\_mvp1\_v1.0.0.md

```



Definisce le regole operative del backend.



Stabilisce:



\* backend come fonte della verità;

\* RLS obbligatorie;

\* nessuna fiducia nel client;

\* movimenti immutabili;

\* nessuna modifica diretta della scorta;

\* nessun inserimento diretto dei movimenti;

\* soft delete per categorie, fornitori e prodotti;

\* RPC obbligatoria per modificare la scorta.



\---



\## 8.2 API Contracts



Documento:



```text

002-API\_CONTRACTS\_mvp1\_v1.0.0.md

```



Definisce il contratto operativo tra Flutter e Supabase.



Spiega:



\* cosa Flutter può leggere;

\* cosa Flutter può creare;

\* cosa Flutter può modificare;

\* cosa Flutter non deve mai fare;

\* quali RPC deve chiamare;

\* quali parametri deve usare;

\* quali errori deve tradurre;

\* quali messaggi deve mostrare;

\* quali regole di sicurezza deve rispettare.



Questo documento è fondamentale prima di scrivere i servizi Flutter.



\---



\# 9. Cartella 4-flutter



Percorso:



```text

docs/4-flutter/

```



Contiene la documentazione della fase Flutter.



Documento principale già approvato:



```text

001-FLUTTER\_PLAN\_mvp1\_v1.0.0.md

```



Questo documento definisce:



\* ordine di sviluppo Flutter;

\* core Dart minimo;

\* sistema messaggi centralizzato;

\* sistema errori centralizzato;

\* feedback persistente;

\* accessibilità;

\* sessione;

\* navigazione semplice;

\* gestione assenza rete;

\* test manuali minimi;

\* regole operative di sviluppo.



\---



\## 9.1 Sottocartelle Flutter



La cartella Flutter contiene tre sottocartelle operative:



```text

docs/4-flutter/1-design/

docs/4-flutter/2-coding-plans/

docs/4-flutter/3-todos/

```



\---



\## 9.2 Cartella 1-design



Percorso:



```text

docs/4-flutter/1-design/

```



Conterrà i documenti di design dei blocchi Flutter.



I design spiegano:



\* cosa deve fare un blocco;

\* quali responsabilità ha;

\* quali regole deve rispettare;

\* quali messaggi deve mostrare;

\* quali aspetti di accessibilità sono obbligatori;

\* quali errori deve gestire.



Esempi futuri:



```text

001-DESIGN\_CORE\_mvp1\_v1.0.0.md

002-DESIGN\_AUTH\_SESSION\_mvp1\_v1.0.0.md

003-DESIGN\_ONBOARDING\_mvp1\_v1.0.0.md

```



\---



\## 9.3 Cartella 2-coding-plans



Percorso:



```text

docs/4-flutter/2-coding-plans/

```



Conterrà i piani di codifica.



I coding plan spiegano:



\* quali file creare;

\* quali file modificare;

\* in che ordine lavorare;

\* quali responsabilità ha ogni file;

\* quali test eseguire dopo il blocco;

\* cosa non deve essere fatto in quel blocco.



Esempi futuri:



```text

001-CODING\_PLAN\_CORE\_mvp1\_v1.0.0.md

002-CODING\_PLAN\_AUTH\_SESSION\_mvp1\_v1.0.0.md

```



\---



\## 9.4 Cartella 3-todos



Percorso:



```text

docs/4-flutter/3-todos/

```



Conterrà il todo master e i todo operativi dei singoli blocchi.



File già previsto:



```text

000-todo-master.md

```



Il todo master deve contenere le macro-fasi del lavoro Flutter.



I todo specifici devono contenere task più piccoli e verificabili.



Esempi futuri:



```text

001-TODO\_CORE\_mvp1\_v1.0.0.md

002-TODO\_AUTH\_SESSION\_mvp1\_v1.0.0.md

```



\---



\# 10. Ordine consigliato di lettura



Per capire il progetto da zero, leggere in questo ordine:



```text

1\. docs/0-architettura/001-ARCHITETTURA\_mvp1\_v1.0.0.md

2\. docs/1-database/001-DATABASE\_SCHEMA\_mvp1\_v1.0.0.md

3\. docs/2-flussi-applicativi/001-FLOWS\_mvp1\_v1.0.0.md

4\. docs/3-backend/001-BACKEND\_RULES\_mvp1\_v1.0.0.md

5\. docs/1-database/supabase/001\_schema.sql

6\. docs/1-database/supabase/002\_rpc.sql

7\. docs/1-database/supabase/003\_rls.sql

8\. docs/1-database/supabase/004\_onboarding\_rpc.sql

9\. docs/1-database/TEST\_PLAN\_MVP1\_v1.0.0.md

10\. docs/3-backend/002-API\_CONTRACTS\_mvp1\_v1.0.0.md

11\. docs/4-flutter/001-FLUTTER\_PLAN\_mvp1\_v1.0.0.md

```



\---



\# 11. Ordine consigliato per riprendere il lavoro



Quando si riprende il progetto dopo una pausa, leggere prima:



```text

CHANGELOG.md

```



poi:



```text

docs/README.md

```



poi il documento relativo alla fase in corso.



Per la fase attuale, i documenti più importanti sono:



```text

docs/3-backend/002-API\_CONTRACTS\_mvp1\_v1.0.0.md

docs/4-flutter/001-FLUTTER\_PLAN\_mvp1\_v1.0.0.md

docs/4-flutter/3-todos/000-todo-master.md

```



\---



\# 12. Stato attuale del progetto



Alla data di questo documento risultano approvati:



```text

001-ARCHITETTURA\_mvp1\_v1.0.0.md

001-DATABASE\_SCHEMA\_mvp1\_v1.0.0.md

001-FLOWS\_mvp1\_v1.0.0.md

001-BACKEND\_RULES\_mvp1\_v1.0.0.md

001-FLUTTER\_PLAN\_mvp1\_v1.0.0.md

002-API\_CONTRACTS\_mvp1\_v1.0.0.md

```



Risultano inoltre eseguiti e validati:



```text

001\_schema.sql

002\_rpc.sql

003\_rls.sql

004\_onboarding\_rpc.sql

TEST\_PLAN\_MVP1\_v1.0.0.md

```



Il backend MVP 1.0 è considerato validato.



La fase successiva riguarda la preparazione operativa Flutter.



\---



\# 13. Prossimi documenti da creare



I prossimi documenti consigliati sono:



```text

docs/4-flutter/3-todos/000-todo-master.md

docs/4-flutter/1-design/001-DESIGN\_CORE\_mvp1\_v1.0.0.md

docs/4-flutter/2-coding-plans/001-CODING\_PLAN\_CORE\_mvp1\_v1.0.0.md

docs/4-flutter/3-todos/001-TODO\_CORE\_mvp1\_v1.0.0.md

```



Il primo blocco di codice dovrà riguardare:



```text

core Dart minimo

```



e non ancora le schermate complete.



\---



\# 14. Regole per aggiornare la documentazione



Ogni modifica strutturale deve essere documentata.



Quando viene completato un blocco importante, aggiornare:



```text

CHANGELOG.md

```



Se la modifica riguarda la documentazione, aggiornare anche questo file quando necessario.



Esempi di casi in cui aggiornare `docs/README.md`:



\* nuova cartella documentale;

\* nuovo documento ufficiale;

\* documento rinominato;

\* documento spostato;

\* cambio dell'ordine di lettura;

\* nuova fase del progetto;

\* cambio dello stato di un documento importante.



\---



\# 15. Regole sui nomi dei file



I documenti ufficiali devono usare nomi chiari e ordinati.



Formato consigliato:



```text

NUMERO-NOME\_DOCUMENTO\_mvp1\_vVERSIONE.md

```



Esempio:



```text

001-FLUTTER\_PLAN\_mvp1\_v1.0.0.md

```



Per documenti operativi Flutter:



```text

001-DESIGN\_CORE\_mvp1\_v1.0.0.md

001-CODING\_PLAN\_CORE\_mvp1\_v1.0.0.md

001-TODO\_CORE\_mvp1\_v1.0.0.md

```



Per il todo master:



```text

000-todo-master.md

```



\---



\# 16. Regole di stato dei documenti



Ogni documento importante dovrebbe indicare uno stato.



Stati consigliati:



```text

BOZZA

IN REVISIONE

APPROVATO

SUPERATO

```



\## BOZZA



Documento scritto ma non ancora validato.



\## IN REVISIONE



Documento inviato a revisori o consiglieri AI.



\## APPROVATO



Documento confermato e utilizzabile come riferimento operativo.



\## SUPERATO



Documento non più attuale, mantenuto solo per storico.



\---



\# 17. Regole per i consiglieri AI



Non tutti i documenti richiedono revisione esterna.



Richiedono revisione con consiglieri AI:



\* architettura;

\* schema database;

\* regole backend;

\* SQL critici;

\* RLS;

\* RPC;

\* API contracts;

\* design complessi;

\* coding plan importanti prima della codifica.



Non richiedono normalmente revisione esterna:



\* README indice;

\* todo master semplice;

\* aggiornamenti di changelog;

\* piccoli documenti di orientamento;

\* correzioni puramente editoriali.



La revisione esterna serve quando il documento introduce scelte tecniche o rischi architetturali.



Non serve quando il documento organizza materiale già approvato.



\---



\# 18. Regole di commit



Dopo ogni modifica documentale importante:



1\. salvare il file;

2\. controllare GitHub Desktop;

3\. verificare i file modificati;

4\. scrivere un messaggio commit chiaro;

5\. eseguire commit;

6\. eseguire push.



Esempi di messaggi commit:



```text

Aggiunge README documentazione

Approva API contracts MVP 1.0

Aggiunge todo master Flutter

Aggiunge design core Flutter

```



\---



\# 19. Relazione con il README principale del repository



Il file:



```text

README.md

```



nella root del repository descrive il progetto a livello generale.



Il file:



```text

docs/README.md

```



descrive invece la documentazione interna del progetto.



Quindi:



```text

README.md

```



serve a capire che cos'è il progetto.



```text

docs/README.md

```



serve a capire dove trovare le informazioni tecniche e progettuali.



\---



\# 20. Conclusione



La cartella `docs` è la memoria ufficiale del progetto.



Ogni decisione importante deve essere ritrovabile qui.



Ogni documento deve avere uno scopo chiaro.



La documentazione non deve diventare burocrazia inutile.



Deve servire a:



\* mantenere ordine;

\* ridurre errori;

\* aiutare la ripresa del lavoro dopo una pausa;

\* guidare la codifica;

\* aiutare le revisioni;

\* proteggere il progetto da modifiche confuse.



Con questo indice, la documentazione del Gestionale Magazzino Universale diventa più facile da consultare e pronta per accompagnare la fase Flutter.



