\# API CONTRACTS MVP 1.0



\## Gestionale Magazzino Universale



Versione: 1.0.0

Stato: APPROVATO

Data: 5 luglio 2026



\---



\# 1. Scopo del documento



Questo documento definisce il contratto operativo tra l'app Flutter e il backend Supabase per l'MVP 1 del progetto Gestionale Magazzino Universale.



Lo scopo non è descrivere l'interfaccia grafica.



Lo scopo è chiarire:



\* quali dati Flutter può leggere;

\* quali dati Flutter può creare;

\* quali dati Flutter può modificare;

\* quali operazioni Flutter non deve mai eseguire;

\* quali RPC deve usare;

\* quali parametri deve inviare;

\* quali risultati deve attendersi;

\* quali errori deve tradurre in messaggi comprensibili;

\* quali regole devono essere rispettate prima di iniziare i design e i coding plan Flutter.



Questo documento serve come ponte tra:



\* documentazione database;

\* regole backend;

\* script SQL Supabase;

\* piano Flutter;

\* futura implementazione Dart/Flutter.



\---



\# 2. Documenti di riferimento



Questo documento dipende dai seguenti documenti già approvati:



```text

docs/0-architettura/001-ARCHITETTURA\_mvp1\_v1.0.0.md

docs/1-database/001-DATABASE\_SCHEMA\_mvp1\_v1.0.0.md

docs/1-database/supabase/001\_schema.sql

docs/1-database/supabase/002\_rpc.sql

docs/1-database/supabase/003\_rls.sql

docs/1-database/supabase/004\_onboarding\_rpc.sql

docs/1-database/TEST\_PLAN\_MVP1\_v1.0.0.md

docs/2-flussi-applicativi/001-FLOWS\_mvp1\_v1.0.0.md

docs/3-backend/001-BACKEND\_RULES\_mvp1\_v1.0.0.md

docs/4-flutter/001-FLUTTER\_PLAN\_mvp1\_v1.0.0.md

```



In caso di dubbio, prevalgono:



1\. le regole backend;

2\. gli script SQL realmente eseguiti;

3\. il piano Flutter approvato;

4\. questo documento API Contracts.



\---



\# 3. Principio fondamentale



Il backend Supabase è la fonte della verità.



Flutter non deve mai comportarsi come se fosse lui il proprietario delle regole critiche.



Flutter deve:



\* raccogliere dati;

\* validare i form per aiutare l'utente;

\* invocare Supabase;

\* invocare le RPC;

\* leggere i risultati;

\* mostrare messaggi chiari;

\* tradurre gli errori tecnici;

\* aggiornare la UI.



Flutter non deve:



\* modificare direttamente `prodotti.scorta\_attuale`;

\* inserire direttamente record in `movimenti\_magazzino`;

\* aggiornare movimenti;

\* eliminare movimenti;

\* eliminare fisicamente categorie, fornitori o prodotti;

\* usare la service role key;

\* bypassare le RLS;

\* fidarsi dei dati locali come fonte definitiva.



Regola sintetica:



```text

Flutter usa il backend, ma non lo sostituisce.

```



\---



\# 4. Sicurezza e chiavi Supabase



Flutter deve usare esclusivamente:



```text

anon public key

```



Flutter non deve mai contenere:



```text

service role key

```



La service role key non deve essere:



\* inserita nel codice Flutter;

\* salvata in file `.env` committati;

\* copiata nei documenti pubblici;

\* usata in test lato app;

\* usata in build desktop, mobile o web.



Le autorizzazioni devono essere garantite da:



\* Supabase Auth;

\* RLS;

\* RPC server-side;

\* controlli interni alle funzioni PostgreSQL.



\---



\# 5. Multi-tenant



Ogni dato applicativo appartiene a una azienda.



La relazione logica è:



```text

auth.users

↓

profili

↓

aziende

↓

dati aziendali

```



Flutter non deve permettere all'utente di scegliere manualmente `azienda\_id`.



Quando serve creare un record collegato all'azienda, Flutter deve recuperare `azienda\_id` dal profilo corrente.



Esempio:



```text

utente autenticato

↓

lettura profilo

↓

azienda\_id corrente

↓

creazione categoria / fornitore / prodotto

```



Per le RPC principali, Flutter non invia `azienda\_id`.



Le RPC devono derivare l'azienda da:



```text

auth.uid()

↓

profili

↓

azienda\_id

```



\## 5.1 Nota di sicurezza su `azienda\_id`



Flutter recupera `azienda\_id` dal profilo corrente e lo usa per creare record come:



\* categorie;

\* fornitori;

\* prodotti.



Tuttavia la sicurezza non deve dipendere da Flutter.



Le RLS devono comunque verificare che ogni `insert` o `update` con `azienda\_id` sia compatibile con l'utente autenticato.



Se un client manipolato tenta di inviare un `azienda\_id` diverso da quello del proprio profilo, l'operazione deve essere bloccata dalle RLS.



Regola:



```text

Flutter usa azienda\_id dal profilo corrente.

Le RLS impediscono l'uso di azienda\_id non autorizzati.

```



\---



\# 6. Convenzioni generali



\## 6.1 UUID



Tutti gli identificatori principali sono UUID.



Flutter deve trattarli come stringhe.



Esempi:



```text

azienda\_id

profilo\_id

categoria\_id

fornitore\_id

prodotto\_id

movimento\_id

```



Flutter non deve generare manualmente questi UUID per i record gestiti da Supabase, salvo diversa decisione futura.



\---



\## 6.2 Date



Le date provenienti dal backend sono in formato timestamp.



Flutter deve mostrarle in forma leggibile per l'utente.



Esempio visuale:



```text

05/07/2026 18:30

```



Il formato esatto verrà definito nei design Flutter.



\---



\## 6.3 Numeri



Le quantità e i prezzi sono numerici.



Flutter deve evitare:



\* quantità negative;

\* prezzo negativo;

\* nuova scorta negativa;

\* stringhe vuote al posto di numeri nulli;

\* arrotondamenti non chiari.



La validazione frontend aiuta l'utente, ma il backend resta il controllo finale.



\---



\## 6.4 Stringhe vuote



Flutter deve convertire stringhe vuote in `NULL` quando il campo è facoltativo.



Esempi:



```text

barcode vuoto → NULL

telefono vuoto → NULL

email vuota → NULL

descrizione vuota → NULL

note vuote → NULL

```



Questa regola è particolarmente importante per il barcode.



Non devono essere salvate stringhe vuote dove il database si aspetta `NULL`.



\---



\# 7. Contratto Auth



\## 7.1 Login



Flutter deve permettere login tramite:



```text

email

password

```



Il login usa Supabase Auth.



Il risultato può essere:



```text

login riuscito

login fallito

```



In caso di login riuscito, Flutter deve controllare se l'utente ha già un profilo applicativo.



\---



\## 7.2 Logout



Flutter deve permettere il logout.



Dopo il logout:



\* la sessione deve essere terminata;

\* l'utente deve tornare alla schermata login;

\* la home non deve essere accessibile senza nuovo login;

\* deve essere mostrato un messaggio accessibile.



\---



\## 7.3 Sessione corrente



All'avvio dell'app Flutter deve controllare lo stato della sessione.



Possibili stati:



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



Questa logica deve essere centralizzata.



Non deve essere duplicata in più schermate.



\---



\## 7.4 Recupero password



Il recupero password non fa parte dell'MVP 1 Flutter.



Potrà essere progettato in una fase successiva.



L'assenza del recupero password è una scelta di scope, non una dimenticanza.



\---



\# 8. Contratto profilo corrente



\## 8.1 Scopo



Il profilo collega l'utente Supabase Auth al dominio applicativo.



Serve per sapere:



\* chi è l'utente;

\* a quale azienda appartiene;

\* se l'onboarding è già stato completato.



\---



\## 8.2 Tabella



```text

profili

```



Campi principali per Flutter:



```text

id

user\_id

azienda\_id

nome

email

created\_at

updated\_at

```



\---



\## 8.3 Lettura profilo corrente



Flutter deve leggere il profilo dell'utente autenticato.



La query logica è:



```text

leggi profili

dove user\_id = utente autenticato corrente

```



Grazie alle RLS, l'utente deve poter leggere solo il proprio profilo.



\---



\## 8.4 Profilo assente



Se il profilo non esiste, Flutter deve mostrare onboarding.



Non deve creare manualmente profilo e azienda con insert separati.



Deve usare la RPC:



```text

crea\_azienda\_e\_profilo

```



\---



\## 8.5 Modifica profilo



La modifica del profilo non è prioritaria nell'MVP 1.



Se verrà introdotta, Flutter potrà modificare solo i campi consentiti dalle RLS.



Non deve modificare:



```text

user\_id

azienda\_id

created\_at

updated\_at

```



\---



\# 9. Contratto azienda corrente



\## 9.1 Tabella



```text

aziende

```



Campi principali per Flutter:



```text

id

nome

created\_at

updated\_at

```



\---



\## 9.2 Lettura azienda corrente



Flutter deve leggere solo l'azienda collegata al profilo corrente.



La home deve poter mostrare:



```text

nome azienda

```



\---



\## 9.3 Creazione azienda



Flutter non deve creare azienda direttamente tramite insert normale durante onboarding.



Per onboarding deve usare:



```text

crea\_azienda\_e\_profilo

```



\---



\## 9.4 Modifica azienda



La modifica azienda non è prioritaria nell'MVP 1.



Se verrà introdotta, dovrà rispettare le RLS e i campi modificabili.



\---



\# 10. RPC crea\_azienda\_e\_profilo



\## 10.1 Scopo



La RPC:



```text

crea\_azienda\_e\_profilo

```



serve a completare il primo onboarding dell'utente.



Crea in una sola operazione:



\* azienda;

\* profilo utente.



\---



\## 10.2 Quando usarla



Flutter deve usarla quando:



```text

utente autenticato

↓

profilo non trovato

↓

utente compila onboarding

↓

crea\_azienda\_e\_profilo

```



\---



\## 10.3 Parametri



```text

p\_nome\_azienda text

p\_nome\_profilo text default null

p\_email text default null

```



\---



\## 10.4 Regole lato Flutter



Flutter deve verificare prima dell'invio:



\* nome azienda obbligatorio;

\* nome azienda non composto solo da spazi;

\* nome profilo facoltativo;

\* email facoltativa, se già disponibile dalla sessione.



Flutter deve convertire stringhe vuote facoltative in `NULL`.



\---



\## 10.5 Regole lato backend



Il backend verifica:



\* utente autenticato;

\* nome azienda obbligatorio;

\* profilo non già esistente;

\* creazione atomica di azienda e profilo;

\* protezione da doppia chiamata simultanea.



\---



\## 10.6 Risultato atteso



La RPC restituisce:



```text

out\_azienda\_id

out\_profilo\_id

out\_nome\_azienda

```



\---



\## 10.7 Errori principali



Possibili errori da tradurre:



```text

Utente non autenticato

Nome azienda obbligatorio

Profilo già esistente

```



Messaggi utente consigliati:



```text

Sessione non valida. Accedi di nuovo.

Inserisci il nome dell'azienda.

Il profilo risulta già creato. Ricarico i dati.

```



\---



\# 11. Contratto categorie



\## 11.1 Tabella



```text

categorie

```



Campi principali:



```text

id

azienda\_id

nome

descrizione

attiva

created\_at

updated\_at

```



\---



\## 11.2 Lettura categorie



Flutter può leggere categorie della propria azienda.



Uso previsto:



\* lista categorie;

\* selezione categoria nel form prodotto;

\* consultazione dati già collegati a prodotti esistenti.



Per i nuovi prodotti, Flutter dovrebbe proporre solo categorie attive.



\---



\## 11.3 Creazione categoria



Flutter può creare una categoria.



Campi inviati:



```text

azienda\_id

nome

descrizione

```



Regole:



\* `azienda\_id` deve essere preso dal profilo corrente;

\* `nome` è obbligatorio;

\* `descrizione` è facoltativa;

\* `attiva` non va normalmente inviato in creazione;

\* il database imposta automaticamente `attiva = true`.



Flutter non deve permettere all'utente di scegliere manualmente `azienda\_id`.



La creazione di una categoria già inattiva non fa parte dell'MVP 1.



Le RLS devono comunque verificare che `azienda\_id` appartenga all'utente autenticato.



\---



\## 11.4 Modifica categoria



Flutter può modificare:



```text

nome

descrizione

attiva

```



Flutter non deve modificare:



```text

id

azienda\_id

created\_at

updated\_at

```



\---



\## 11.5 Disattivazione categoria



Non si usa delete fisico.



Per archiviare una categoria:



```text

attiva = false

```



Categorie inattive:



\* non devono essere proposte nei nuovi prodotti;

\* possono restare visibili nei prodotti già associati;

\* devono essere indicate come inattive con testo chiaro, non solo colore.



\---



\## 11.6 Errori principali



Possibili errori:



```text

nome obbligatorio

nome duplicato nella stessa azienda

operazione non autorizzata

errore di connessione

```



Messaggi utente consigliati:



```text

Inserisci il nome della categoria.

Esiste già una categoria con questo nome.

Operazione non autorizzata.

Connessione assente. Controlla Internet e riprova.

```



\---



\# 12. Contratto fornitori



\## 12.1 Tabella



```text

fornitori

```



Campi principali:



```text

id

azienda\_id

nome

telefono

email

note

attivo

created\_at

updated\_at

```



\---



\## 12.2 Lettura fornitori



Flutter può leggere fornitori della propria azienda.



Uso previsto:



\* lista fornitori;

\* selezione fornitore preferito nel form prodotto;

\* selezione fornitore nel carico magazzino;

\* consultazione storico carichi.



Per nuovi carichi e nuovi prodotti, Flutter dovrebbe proporre solo fornitori attivi.



\---



\## 12.3 Creazione fornitore



Flutter può creare un fornitore.



Campi inviati:



```text

azienda\_id

nome

telefono

email

note

```



Regole:



\* `azienda\_id` deve essere preso dal profilo corrente;

\* `nome` è obbligatorio;

\* `telefono` è facoltativo;

\* `email` è facoltativa;

\* `note` è facoltativo;

\* `attivo` non va normalmente inviato in creazione;

\* il database imposta automaticamente `attivo = true`.



Stringhe vuote facoltative devono diventare `NULL`.



Flutter non deve permettere all'utente di scegliere manualmente `azienda\_id`.



La creazione di un fornitore già inattivo non fa parte dell'MVP 1.



Le RLS devono comunque verificare che `azienda\_id` appartenga all'utente autenticato.



\---



\## 12.4 Modifica fornitore



Flutter può modificare:



```text

nome

telefono

email

note

attivo

```



Flutter non deve modificare:



```text

id

azienda\_id

created\_at

updated\_at

```



\---



\## 12.5 Disattivazione fornitore



Non si usa delete fisico.



Per archiviare un fornitore:



```text

attivo = false

```



Fornitori inattivi:



\* non devono essere proposti nei nuovi carichi;

\* non devono essere proposti come fornitore preferito nei nuovi prodotti;

\* possono restare visibili nello storico dei movimenti passati;

\* devono essere indicati come inattivi con testo chiaro, non solo colore.



\---



\## 12.6 Errori principali



Possibili errori:



```text

nome obbligatorio

nome duplicato nella stessa azienda

operazione non autorizzata

errore di connessione

```



Messaggi utente consigliati:



```text

Inserisci il nome del fornitore.

Esiste già un fornitore con questo nome.

Operazione non autorizzata.

Connessione assente. Controlla Internet e riprova.

```



\---



\# 13. Contratto prodotti



\## 13.1 Tabella



```text

prodotti

```



Campi principali:



```text

id

azienda\_id

categoria\_id

fornitore\_preferito\_id

barcode

nome

descrizione

unita\_misura

prezzo\_acquisto

prezzo\_vendita

aliquota\_iva

scorta\_attuale

scorta\_minima

attributi\_extra

attivo

created\_at

updated\_at

```



\---



\## 13.2 Lettura prodotti



Flutter può leggere i prodotti della propria azienda.



Uso previsto:



\* lista prodotti;

\* dettaglio prodotto;

\* selezione prodotto nei movimenti;

\* controllo scorta;

\* visualizzazione scorta minima;

\* storico movimenti collegati al prodotto.



\---



\## 13.3 Creazione prodotto



Flutter può creare prodotti.



Campi inviati:



```text

azienda\_id

categoria\_id

fornitore\_preferito\_id

barcode

nome

descrizione

unita\_misura

prezzo\_acquisto

prezzo\_vendita

aliquota\_iva

scorta\_minima

attributi\_extra

```



Regole:



\* `azienda\_id` deve essere preso dal profilo corrente;

\* `nome` è obbligatorio;

\* `categoria\_id` è facoltativo;

\* `fornitore\_preferito\_id` è facoltativo;

\* `barcode` è facoltativo;

\* `barcode` vuoto deve diventare `NULL`;

\* `unita\_misura` ha default `pz`;

\* prezzi e aliquota non devono essere negativi;

\* `scorta\_minima` non deve essere negativa;

\* `attributi\_extra` può restare `{}`;

\* `attivo` non va normalmente inviato in creazione;

\* il database imposta automaticamente `attivo = true`.



Flutter non deve inviare manualmente:



```text

scorta\_attuale

```



La scorta iniziale deve essere lasciata al default del database:



```text

0

```



Flutter non deve permettere all'utente di scegliere manualmente `azienda\_id`.



La creazione di un prodotto già inattivo non fa parte dell'MVP 1.



Le RLS devono comunque verificare che `azienda\_id` appartenga all'utente autenticato.



\---



\## 13.4 Modifica prodotto



Flutter può modificare:



```text

categoria\_id

fornitore\_preferito\_id

barcode

nome

descrizione

unita\_misura

prezzo\_acquisto

prezzo\_vendita

aliquota\_iva

scorta\_minima

attributi\_extra

attivo

```



Flutter non deve modificare:



```text

id

azienda\_id

scorta\_attuale

created\_at

updated\_at

```



La scorta deve cambiare solo tramite:



```text

registra\_movimento

```



\---



\## 13.5 Disattivazione prodotto



Non si usa delete fisico.



Per archiviare un prodotto:



```text

attivo = false

```



Un prodotto inattivo:



\* resta nello storico;

\* può restare visibile nella lista prodotti, se utile;

\* deve essere indicato come inattivo con testo chiaro;

\* non deve essere selezionabile nei movimenti;

\* non deve ricevere carichi;

\* non deve ricevere vendite;

\* non deve ricevere resi;

\* non deve ricevere rettifiche.



\---



\## 13.6 Barcode



Il barcode è univoco all'interno della stessa azienda.



Regole Flutter:



\* campo facoltativo;

\* stringa vuota convertita in `NULL`;

\* non salvare `''`;

\* in caso di duplicato, mostrare messaggio comprensibile.



Messaggio utente consigliato:



```text

Esiste già un prodotto con questo barcode.

```



\---



\## 13.7 Scorta



Il campo:



```text

scorta\_attuale

```



è leggibile da Flutter.



Non è modificabile direttamente da Flutter.



Flutter deve mostrarlo come valore informativo.



Per modificare la scorta si deve usare:



```text

registra\_movimento

```



\---



\## 13.8 Errori principali



Possibili errori:



```text

nome obbligatorio

barcode duplicato

prezzo negativo

scorta minima negativa

categoria non valida

fornitore non valido

aggiornamento diretto scorta non consentito

operazione non autorizzata

errore di connessione

```



Messaggi utente consigliati:



```text

Inserisci il nome del prodotto.

Esiste già un prodotto con questo barcode.

Il prezzo non può essere negativo.

La scorta minima non può essere negativa.

Categoria non valida.

Fornitore non valido.

La scorta può essere modificata solo tramite un movimento.

Operazione non autorizzata.

Connessione assente. Controlla Internet e riprova.

```



\---



\# 14. Contratto movimenti\_magazzino



\## 14.1 Tabella



```text

movimenti\_magazzino

```



Campi principali:



```text

id

azienda\_id

prodotto\_id

fornitore\_id

tipo\_movimento

quantita

scorta\_prima

scorta\_dopo

prezzo\_unitario

note

data\_movimento

creato\_da

created\_at

```



\---



\## 14.2 Lettura movimenti



Flutter può leggere movimenti della propria azienda.



Uso previsto:



\* storico generale;

\* storico per prodotto;

\* controllo carichi;

\* controllo vendite;

\* controllo rettifiche;

\* consultazione scorta prima e dopo.



Filtri previsti:



```text

prodotto\_id

tipo\_movimento

data da

data a

```



Ordinamento consigliato:



```text

data\_movimento decrescente

```



\---



\## 14.3 Creazione movimenti



Flutter non deve mai inserire direttamente record in:



```text

movimenti\_magazzino

```



La creazione dei movimenti deve passare sempre da:



```text

registra\_movimento

```



\---



\## 14.4 Modifica movimenti



Flutter non deve modificare movimenti.



Operazione vietata:



```text

UPDATE movimenti\_magazzino

```



\---



\## 14.5 Eliminazione movimenti



Flutter non deve eliminare movimenti.



Operazione vietata:



```text

DELETE movimenti\_magazzino

```



\---



\## 14.6 Operatore movimento



Il campo:



```text

creato\_da

```



registra l'utente Supabase che ha creato il movimento.



Per l'MVP 1 il nome dell'operatore non verrà mostrato in forma amichevole.



Flutter può mostrare lo storico movimenti usando:



\* data movimento;

\* tipo movimento;

\* quantità;

\* scorta prima;

\* scorta dopo;

\* note;

\* fornitore nei carichi.



La visualizzazione del nome operatore tramite profilo o vista dedicata verrà valutata in una fase successiva.



Flutter non deve interrogare direttamente tabelle riservate di Supabase Auth.



\---



\# 15. RPC registra\_movimento



\## 15.1 Scopo



La RPC:



```text

registra\_movimento

```



è l'unico punto di ingresso per modificare la scorta.



Gestisce:



\* carico;

\* vendita;

\* reso;

\* rettifica.



La funzione:



\* verifica l'utente;

\* ricava l'azienda dal profilo;

\* verifica il prodotto;

\* verifica il fornitore quando serve;

\* impedisce scorte negative;

\* inserisce il movimento;

\* aggiorna la scorta prodotto;

\* restituisce il risultato.



\---



\## 15.2 Parametri



```text

p\_prodotto\_id uuid

p\_tipo\_movimento text

p\_quantita numeric default null

p\_nuova\_scorta numeric default null

p\_fornitore\_id uuid default null

p\_prezzo\_unitario numeric default null

p\_note text default null

```



\## 15.3 Nota sui parametri null o omessi



In fase di codifica Flutter, i parametri non pertinenti al tipo di movimento possono essere omessi dalla mappa inviata alla RPC, oppure inviati come `null` se il client Supabase li gestisce correttamente.



La regola funzionale resta:



\* carico, vendita e reso usano `p\_quantita`;

\* rettifica usa `p\_nuova\_scorta`;

\* Flutter non deve inviare `p\_azienda\_id`;

\* Flutter non deve inviare valori non pertinenti al tipo movimento;

\* Flutter non deve inviare `p\_quantita` per la rettifica;

\* Flutter non deve inviare `p\_nuova\_scorta` per carico, vendita e reso.



Questa nota serve a distinguere il contratto logico dal payload tecnico che verrà costruito nel servizio Dart.



\---



\## 15.4 Risultato



La RPC restituisce:



```text

out\_movimento\_id uuid

out\_nuova\_scorta numeric

out\_tipo\_movimento text

```



Flutter deve usare:



\* `out\_movimento\_id` per conferma o storico;

\* `out\_nuova\_scorta` per aggiornare la UI;

\* `out\_tipo\_movimento` per confermare il tipo registrato.



\---



\# 16. Contratto carico



\## 16.1 Uso



Il carico registra ingresso merce.



Tipo movimento:



```text

carico

```



\---



\## 16.2 Parametri Flutter



Flutter deve inviare logicamente:



```text

p\_prodotto\_id = prodotto selezionato

p\_tipo\_movimento = carico

p\_quantita = quantità caricata

p\_nuova\_scorta = null oppure omesso

p\_fornitore\_id = fornitore selezionato

p\_prezzo\_unitario = prezzo unitario, se disponibile

p\_note = note facoltative

```



\---



\## 16.3 Regole



\* prodotto obbligatorio;

\* prodotto attivo;

\* quantità obbligatoria;

\* quantità maggiore di zero;

\* fornitore obbligatorio;

\* fornitore attivo;

\* prezzo non negativo, se inserito;

\* note facoltative.



\---



\## 16.4 Risultato atteso



La scorta aumenta.



Esempio:



```text

scorta prima = 5

quantità = 10

scorta dopo = 15

```



\---



\## 16.5 Errori principali



```text

Prodotto non trovato

Prodotto disattivato

Quantità obbligatoria

Quantità non valida

Fornitore obbligatorio per il carico

Fornitore non valido

Prezzo unitario non valido

```



Messaggi utente consigliati:



```text

Seleziona un prodotto valido.

Il prodotto selezionato è disattivato.

Inserisci la quantità.

La quantità deve essere maggiore di zero.

Seleziona un fornitore.

Il fornitore selezionato non è valido o è disattivato.

Il prezzo unitario non può essere negativo.

```



\---



\# 17. Contratto vendita



\## 17.1 Uso



La vendita registra uscita merce.



Tipo movimento:



```text

vendita

```



\---



\## 17.2 Parametri Flutter



Flutter deve inviare logicamente:



```text

p\_prodotto\_id = prodotto selezionato

p\_tipo\_movimento = vendita

p\_quantita = quantità venduta

p\_nuova\_scorta = null oppure omesso

p\_fornitore\_id = null oppure omesso

p\_prezzo\_unitario = prezzo unitario, se disponibile

p\_note = note facoltative

```



\## 17.3 Prezzo unitario nella vendita



Per la vendita, Flutter può precompilare il prezzo unitario leggendo:



```text

prodotti.prezzo\_vendita

```



L'utente può modificarlo prima della registrazione.



Se il prezzo non è disponibile o non viene usato, Flutter può inviare `null` oppure omettere il parametro.



Il backend non calcola automaticamente il prezzo di vendita.



Il prezzo unitario salvato nel movimento rappresenta il prezzo registrato per quella specifica operazione.



\---



\## 17.4 Regole



\* prodotto obbligatorio;

\* prodotto attivo;

\* quantità obbligatoria;

\* quantità maggiore di zero;

\* fornitore non consentito;

\* prezzo non negativo, se inserito;

\* scorta sufficiente.



\---



\## 17.5 Risultato atteso



La scorta diminuisce.



Esempio:



```text

scorta prima = 10

quantità = 3

scorta dopo = 7

```



\---



\## 17.6 Avviso scorta minima



Se dopo la vendita la scorta scende sotto la scorta minima, Flutter deve mostrare un avviso accessibile.



Messaggio consigliato:



```text

Attenzione: scorta inferiore al livello minimo.

```



Questo avviso deve essere testuale e leggibile da screen reader.



\---



\## 17.7 Errori principali



```text

Prodotto non trovato

Prodotto disattivato

Quantità obbligatoria

Quantità non valida

Fornitore non consentito per questo tipo movimento

Prezzo unitario non valido

Scorta insufficiente

```



Messaggi utente consigliati:



```text

Seleziona un prodotto valido.

Il prodotto selezionato è disattivato.

Inserisci la quantità.

La quantità deve essere maggiore di zero.

La vendita non deve avere un fornitore.

Il prezzo unitario non può essere negativo.

Scorta insufficiente per completare la vendita.

```



\---



\# 18. Contratto reso



\## 18.1 Uso



Il reso rappresenta merce restituita dal cliente.



Tipo movimento:



```text

reso

```



Il reso aumenta la scorta.



Il reso a fornitore non fa parte dell'MVP 1.



\---



\## 18.2 Stato nell'MVP 1 Flutter



La logica backend supporta il reso.



L'interfaccia reso può essere implementata dopo:



\* carico;

\* vendita;

\* rettifica.



\---



\## 18.3 Parametri Flutter



Quando verrà implementato, Flutter dovrà inviare logicamente:



```text

p\_prodotto\_id = prodotto selezionato

p\_tipo\_movimento = reso

p\_quantita = quantità resa

p\_nuova\_scorta = null oppure omesso

p\_fornitore\_id = null oppure omesso

p\_prezzo\_unitario = null oppure prezzo, se si decide di usarlo

p\_note = note facoltative

```



\---



\## 18.4 Regole



\* prodotto obbligatorio;

\* prodotto attivo;

\* quantità obbligatoria;

\* quantità maggiore di zero;

\* fornitore non consentito.



\---



\## 18.5 Risultato atteso



La scorta aumenta.



\---



\# 19. Contratto rettifica



\## 19.1 Uso



La rettifica corregge la scorta reale di un prodotto.



Tipo movimento:



```text

rettifica

```



\---



\## 19.2 Parametri Flutter



Flutter deve inviare logicamente:



```text

p\_prodotto\_id = prodotto selezionato

p\_tipo\_movimento = rettifica

p\_quantita = null oppure omesso

p\_nuova\_scorta = nuova scorta reale

p\_fornitore\_id = null oppure omesso

p\_prezzo\_unitario = null oppure omesso

p\_note = motivazione

```



\---



\## 19.3 Regole



\* prodotto obbligatorio;

\* prodotto attivo;

\* nuova scorta obbligatoria;

\* nuova scorta maggiore o uguale a zero;

\* quantità non consentita;

\* fornitore non consentito;

\* motivazione obbligatoria lato Flutter.



Nota importante:



il backend accetta `p\_note` come parametro facoltativo, ma Flutter deve rendere la motivazione obbligatoria per rendere lo storico più utile.



\---



\## 19.4 Quantità nella rettifica



La RPC calcola automaticamente la quantità della rettifica come differenza assoluta tra:



```text

nuova\_scorta

scorta\_attuale

```



Flutter non deve calcolare questa quantità.



Flutter non deve inviare `p\_quantita` per la rettifica.



Esempio:



```text

scorta attuale = 7

nuova scorta = 20

quantità calcolata dalla RPC = 13

```



La quantità salvata nel movimento è sempre positiva.



La direzione si capisce da:



```text

scorta\_prima

scorta\_dopo

```



\---



\## 19.5 Risultato atteso



La scorta viene impostata alla nuova quantità reale.



Esempio rettifica positiva:



```text

scorta prima = 7

nuova scorta = 20

quantità movimento = 13

scorta dopo = 20

```



Esempio rettifica negativa:



```text

scorta prima = 20

nuova scorta = 5

quantità movimento = 15

scorta dopo = 5

```



\---



\## 19.6 Avviso scorta minima



Se la nuova scorta è inferiore alla scorta minima, Flutter deve mostrare un avviso accessibile.



Messaggio consigliato:



```text

Attenzione: scorta inferiore al livello minimo.

```



\---



\## 19.7 Errori principali



```text

Prodotto non trovato

Prodotto disattivato

Nuova scorta obbligatoria

Nuova scorta non valida

Quantità non consentita per rettifica

Fornitore non consentito per questo tipo movimento

La nuova scorta coincide con quella attuale

```



Messaggi utente consigliati:



```text

Seleziona un prodotto valido.

Il prodotto selezionato è disattivato.

Inserisci la nuova scorta.

La nuova scorta non può essere negativa.

Per una rettifica non devi inserire una quantità.

La rettifica non deve avere un fornitore.

La nuova scorta coincide con quella attuale.

```



\---



\# 20. Operazioni vietate a Flutter



Flutter non deve mai eseguire queste operazioni:



```text

UPDATE prodotti SET scorta\_attuale = ...

INSERT INTO movimenti\_magazzino ...

UPDATE movimenti\_magazzino ...

DELETE FROM movimenti\_magazzino ...

DELETE FROM prodotti ...

DELETE FROM categorie ...

DELETE FROM fornitori ...

```



Per archiviare:



```text

categorie → attiva = false

fornitori → attivo = false

prodotti → attivo = false

```



Per la scorta:



```text

usare sempre registra\_movimento

```



\---



\# 21. Contratto errori



\## 21.1 Regola generale



Gli errori tecnici non devono essere mostrati all'utente nella forma grezza.



Flutter deve avere un sistema centralizzato di traduzione degli errori.



Il file previsto dal piano Flutter è:



```text

lib/core/errors/supabase\_error\_mapper.dart

```



o modulo equivalente.



\---



\## 21.2 Errori Auth



| Errore tecnico            | Messaggio utente                                   |

| ------------------------- | -------------------------------------------------- |

| invalid login credentials | Email o password non corrette.                     |

| email not confirmed       | Email non confermata. Controlla la posta.          |

| JWT expired               | Sessione scaduta. Accedi di nuovo.                 |

| user not found            | Utente non trovato.                                |

| network error             | Connessione assente. Controlla Internet e riprova. |



\---



\## 21.3 Errori onboarding



| Errore backend            | Messaggio utente                                |

| ------------------------- | ----------------------------------------------- |

| Utente non autenticato    | Sessione non valida. Accedi di nuovo.           |

| Nome azienda obbligatorio | Inserisci il nome dell'azienda.                 |

| Profilo già esistente     | Il profilo risulta già creato. Ricarico i dati. |



\---



\## 21.4 Errori movimenti



| Errore backend                                     | Messaggio utente                                       |

| -------------------------------------------------- | ------------------------------------------------------ |

| Profilo non trovato                                | Profilo non trovato. Completa l'onboarding.            |

| Tipo movimento non valido                          | Tipo movimento non valido.                             |

| Prezzo unitario non valido                         | Il prezzo unitario non può essere negativo.            |

| Quantità obbligatoria                              | Inserisci la quantità.                                 |

| Quantità non valida                                | La quantità deve essere maggiore di zero.              |

| Nuova scorta obbligatoria                          | Inserisci la nuova scorta.                             |

| Nuova scorta non valida                            | La nuova scorta non può essere negativa.               |

| Quantità non consentita per rettifica              | Per una rettifica non devi inserire una quantità.      |

| Fornitore obbligatorio per il carico               | Seleziona un fornitore.                                |

| Fornitore non consentito per questo tipo movimento | Questo movimento non deve avere un fornitore.          |

| Prodotto non trovato                               | Prodotto non trovato.                                  |

| Prodotto disattivato                               | Il prodotto selezionato è disattivato.                 |

| Fornitore non valido                               | Il fornitore selezionato non è valido o è disattivato. |

| Scorta insufficiente                               | Scorta insufficiente per completare l'operazione.      |

| La nuova scorta coincide con quella attuale        | La nuova scorta coincide con quella attuale.           |



\---



\## 21.5 Errori vincoli database



| Caso                       | Messaggio utente                           |

| -------------------------- | ------------------------------------------ |

| categoria duplicata        | Esiste già una categoria con questo nome.  |

| fornitore duplicato        | Esiste già un fornitore con questo nome.   |

| barcode duplicato          | Esiste già un prodotto con questo barcode. |

| nome vuoto                 | Inserisci un nome valido.                  |

| valore numerico negativo   | Il valore non può essere negativo.         |

| operazione non autorizzata | Operazione non autorizzata.                |

| RLS blocca operazione      | Non hai i permessi per questa operazione.  |



\---



\## 21.6 Errori di rete e server



| Caso                         | Messaggio utente                                        |

| ---------------------------- | ------------------------------------------------------- |

| assenza rete                 | Connessione assente. Controlla Internet e riprova.      |

| timeout                      | Il server non risponde. Riprova tra poco.               |

| errore generico Supabase     | Impossibile completare l'operazione. Riprova.           |

| errore imprevisto del server | Impossibile completare l'operazione. Riprova più tardi. |



\---



\# 22. Contratto messaggi accessibili



Ogni operazione importante deve produrre un messaggio persistente nella schermata.



Il messaggio può anche essere annunciato allo screen reader, ma non deve esistere solo come annuncio temporaneo.



Regola:



```text

prima il messaggio esiste nella schermata

poi, se utile, viene annunciato

```



Esempi:



```text

Accesso eseguito correttamente.

Uscita eseguita correttamente.

Categoria salvata correttamente.

Fornitore salvato correttamente.

Prodotto salvato correttamente.

Movimento registrato correttamente.

Scorta insufficiente.

Connessione assente. Controlla Internet e riprova.

```



Nessun errore importante deve essere comunicato solo tramite:



\* colore;

\* icona;

\* snackbar temporaneo;

\* animazione;

\* cambio visivo non descritto.



\---



\# 23. Servizi Flutter suggeriti



Questo documento non impone codice definitivo.



Tuttavia suggerisce una separazione logica dei servizi Flutter.



Possibili servizi:



```text

AuthService

SessionService / AppSessionController

ProfileService

OnboardingService

CategoryService

SupplierService

ProductService

MovementService

ErrorMapper

FeedbackController

AccessibilityService

```



Regola:



```text

le schermate non devono contenere query Supabase sparse

```



Le schermate devono chiamare servizi o controller.



Questi servizi non devono essere creati tutti immediatamente.



Vanno introdotti in modo progressivo, seguendo i design e i coding plan dei singoli blocchi.



\---



\# 24. Relazione con il core Flutter



Il piano Flutter prevede un core minimo.



Questo documento aiuta a definire cosa deve contenere quel core.



Core minimo iniziale:



```text

messages

errors

feedback

accessibility

session

```



Questo API contract alimenta in particolare:



```text

app\_messages.dart

app\_error\_messages.dart

supabase\_error\_mapper.dart

app\_feedback\_message.dart

accessibility\_service.dart

app\_session\_controller.dart

```



\---



\# 25. Non obiettivi dell'MVP 1



Non fanno parte di questo contratto MVP 1:



\* sincronizzazione offline completa;

\* recupero password;

\* gestione ruoli avanzati;

\* multi-azienda per singolo utente;

\* service role in Flutter;

\* scanner barcode HID/Bluetooth;

\* immagini prodotto;

\* report avanzati;

\* template di settore completi;

\* gestione reso a fornitore;

\* visualizzazione amichevole del nome operatore nei movimenti.



Alcuni di questi elementi sono già predisposti a livello architetturale, ma non vengono implementati nell'MVP 1 Flutter.



\---



\# 26. Checklist di conformità per Flutter



Prima di considerare corretto un servizio Flutter, verificare:



```text

\[ ] non usa service role key

\[ ] non modifica scorta\_attuale direttamente

\[ ] non inserisce movimenti direttamente

\[ ] non modifica movimenti

\[ ] non elimina movimenti

\[ ] non elimina fisicamente categorie, fornitori o prodotti

\[ ] usa azienda\_id solo dal profilo corrente

\[ ] le RLS proteggono comunque azienda\_id da manipolazioni client

\[ ] usa crea\_azienda\_e\_profilo per onboarding

\[ ] usa registra\_movimento per carico, vendita, reso e rettifica

\[ ] per rettifica non invia p\_quantita

\[ ] per carico, vendita e reso non invia p\_nuova\_scorta

\[ ] traduce errori tecnici in messaggi utente

\[ ] produce feedback persistente

\[ ] non usa stringhe utente hardcoded sparse

\[ ] rispetta i prodotti inattivi

\[ ] rispetta categorie e fornitori inattivi

\[ ] gestisce assenza rete con messaggio comprensibile

\[ ] non mostra errori solo tramite colore, icona o snackbar temporaneo

```



\---



\# 27. Revisione AI



Questo documento è stato revisionato tramite confronto con:



\* ChatGPT;

\* Gemini;

\* DeepSeek.



Le osservazioni dei revisori sono state integrate.



In particolare sono state rafforzate le sezioni relative a:



\* sicurezza multi-tenant e RLS su `azienda\_id`;

\* valori `attiva` e `attivo` in creazione;

\* gestione del nome operatore nei movimenti;

\* parametri `null` oppure omessi nelle RPC;

\* prezzo unitario nella vendita;

\* quantità della rettifica calcolata dalla RPC;

\* errore imprevisto del server;

\* checklist di conformità Flutter.



\---



\# 28. Stato del documento



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

docs/3-backend/002-API\_CONTRACTS\_mvp1\_v1.0.0.md

```



\---



\# 29. Prossimo passo dopo approvazione



Dopo l'approvazione di questo documento, si potrà procedere con:



```text

docs/README.md

```



e poi con:



```text

docs/4-flutter/3-todos/000-todo-master.md

docs/4-flutter/1-design/001-DESIGN\_CORE\_mvp1\_v1.0.0.md

docs/4-flutter/2-coding-plans/001-CODING\_PLAN\_CORE\_mvp1\_v1.0.0.md

docs/4-flutter/3-todos/001-TODO\_CORE\_mvp1\_v1.0.0.md

```



Il primo blocco di codice dovrà riguardare il core Dart minimo, non le schermate complete.



\---



\# 30. Conclusione



Questo documento definisce il contratto tra Flutter e Supabase per l'MVP 1.



Il principio più importante è:



```text

Flutter usa il backend, ma non lo sostituisce.

```



Il backend mantiene le regole critiche.



Flutter deve essere ordinato, accessibile e prevedibile.



Questo contratto serve a evitare errori strutturali prima dell'inizio dei design, dei coding plan e della codifica.



