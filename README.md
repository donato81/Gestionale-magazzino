\# Gestionale Magazzino Universale



Gestionale magazzino sviluppato con Flutter, Dart e Supabase.



Il progetto nasce con l'obiettivo di costruire un gestionale semplice, solido, accessibile e adattabile a diversi settori commerciali.



L'MVP 1 si concentra sul cuore del sistema:



\* autenticazione utente;

\* creazione azienda e profilo;

\* gestione categorie;

\* gestione fornitori;

\* gestione prodotti;

\* registrazione movimenti di magazzino;

\* aggiornamento scorte;

\* consultazione dello storico movimenti;

\* utilizzo tramite screen reader.



\---



\# Stato del progetto



Stato attuale:



```text

MVP 1 in sviluppo

```



La fase backend Supabase è stata progettata, implementata e validata.



Sono già stati completati:



\* architettura MVP 1;

\* schema database;

\* script SQL Supabase;

\* RPC movimenti;

\* RPC onboarding;

\* RLS;

\* test backend;

\* piano Flutter;

\* API Contracts;

\* README documentazione;

\* todo master Flutter.



La fase attuale riguarda la preparazione operativa Flutter e il successivo sviluppo del core Dart minimo.



\---



\# Obiettivo dell'MVP 1



L'MVP 1 deve permettere a un utente di:



1\. accedere al sistema;

2\. completare l'onboarding iniziale;

3\. creare categorie;

4\. creare fornitori;

5\. creare prodotti;

6\. registrare carichi;

7\. registrare vendite;

8\. registrare rettifiche;

9\. visualizzare la scorta aggiornata;

10\. consultare lo storico dei movimenti;

11\. usare il flusso principale tramite screen reader.



L'MVP 1 non ha l'obiettivo di essere un gestionale completo e definitivo.



Ha l'obiettivo di validare il nucleo affidabile del progetto.



\---



\# Tecnologie principali



\## Frontend



```text

Flutter

Dart

```



Il frontend sarà costruito in modo progressivo, partendo dal core Dart minimo prima delle schermate complete.



\## Backend



```text

Supabase

PostgreSQL

Supabase Auth

RLS

RPC PostgreSQL

```



Il backend è la fonte della verità per le regole critiche.



\---



\# Principi fondamentali



\## 1. La scorta non si modifica direttamente



La scorta di un prodotto non deve mai essere modificata direttamente dal frontend.



Ogni variazione deve passare da un movimento di magazzino.



La modifica della scorta avviene tramite la RPC:



```text

registra\_movimento

```



\---



\## 2. I movimenti sono lo storico ufficiale



La tabella dei movimenti rappresenta la storia ufficiale del magazzino.



I movimenti:



\* vengono creati tramite RPC;

\* non vengono modificati;

\* non vengono eliminati.



Eventuali errori devono essere corretti con nuovi movimenti.



\---



\## 3. Backend fonte della verità



Flutter non deve sostituire il backend.



Flutter deve:



\* raccogliere i dati;

\* validare i form per aiutare l'utente;

\* chiamare Supabase;

\* chiamare le RPC;

\* mostrare messaggi chiari;

\* tradurre gli errori tecnici;

\* aggiornare l'interfaccia.



Flutter non deve:



\* modificare direttamente `prodotti.scorta\_attuale`;

\* inserire direttamente in `movimenti\_magazzino`;

\* modificare movimenti;

\* eliminare movimenti;

\* usare service role key;

\* bypassare le RLS;

\* fidarsi dei dati locali come fonte definitiva.



\---



\## 4. Multi-tenant



Ogni dato appartiene a una azienda.



La relazione principale è:



```text

auth.users

↓

profili

↓

aziende

↓

dati aziendali

```



Ogni utente può accedere solo ai dati della propria azienda.



Le RLS sono obbligatorie.



\---



\## 5. Accessibilità obbligatoria



L'accessibilità non è una funzione secondaria.



Ogni flusso deve essere utilizzabile tramite screen reader.



Il progetto deve prevedere:



\* messaggi testuali chiari;

\* errori comprensibili;

\* feedback persistente;

\* pulsanti con testo esplicito;

\* campi con etichette chiare;

\* ordine logico del focus;

\* nessuna informazione affidata solo al colore;

\* nessuna informazione affidata solo alle icone.



\---



\# Struttura del repository



Struttura principale:



```text

Gestionale-magazzino/

&#x20; README.md

&#x20; CHANGELOG.md



&#x20; app/

&#x20; docs/

```



\---



\# Cartella app



Percorso:



```text

app/

```



Contiene il progetto Flutter.



Questa cartella è dedicata al codice dell'applicazione.



Al suo interno si trovano o si troveranno:



\* configurazione Flutter;

\* codice Dart;

\* schermate;

\* servizi;

\* core applicativo;

\* collegamento a Supabase;

\* test Flutter futuri.



Il file:



```text

app/README.md

```



è il README interno della sola app Flutter.



Non è il README principale del progetto.



Il README principale del progetto è questo file nella root del repository.



\---



\# Cartella docs



Percorso:



```text

docs/

```



Contiene la documentazione ufficiale del progetto.



Il file:



```text

docs/README.md

```



è l'indice della documentazione tecnica e progettuale.



Per capire dove si trovano i documenti, partire da:



```text

docs/README.md

```



\---



\# Documentazione principale



I documenti principali del progetto sono:



```text

docs/0-architettura/001-ARCHITETTURA\_mvp1\_v1.0.0.md

docs/1-database/001-DATABASE\_SCHEMA\_mvp1\_v1.0.0.md

docs/1-database/TEST\_PLAN\_MVP1\_v1.0.0.md

docs/2-flussi-applicativi/001-FLOWS\_mvp1\_v1.0.0.md

docs/3-backend/001-BACKEND\_RULES\_mvp1\_v1.0.0.md

docs/3-backend/002-API\_CONTRACTS\_mvp1\_v1.0.0.md

docs/4-flutter/001-FLUTTER\_PLAN\_mvp1\_v1.0.0.md

docs/4-flutter/3-todos/000-todo-master.md

```



\---



\# Script Supabase



Gli script SQL principali sono:



```text

docs/1-database/supabase/001\_schema.sql

docs/1-database/supabase/002\_rpc.sql

docs/1-database/supabase/003\_rls.sql

docs/1-database/supabase/004\_onboarding\_rpc.sql

```



\## 001\_schema.sql



Definisce:



\* tabelle;

\* vincoli;

\* indici;

\* trigger `updated\_at`;

\* protezione della scorta;

\* immutabilità dei movimenti.



\## 002\_rpc.sql



Definisce la RPC:



```text

registra\_movimento

```



Questa RPC gestisce:



\* carico;

\* vendita;

\* reso;

\* rettifica.



\## 003\_rls.sql



Definisce le Row Level Security.



Garantisce che ogni utente possa accedere solo ai dati della propria azienda.



\## 004\_onboarding\_rpc.sql



Definisce la RPC:



```text

crea\_azienda\_e\_profilo

```



Questa RPC crea azienda e profilo durante l'onboarding iniziale.



\---



\# Flusso principale MVP 1



Il flusso principale previsto è:



```text

Login

↓

Controllo sessione

↓

Onboarding se necessario

↓

Home

↓

Gestione categorie

↓

Gestione fornitori

↓

Gestione prodotti

↓

Registrazione movimenti

↓

Visualizzazione scorta

↓

Storico movimenti

```



\---



\# Tipi di movimento



L'MVP 1 prevede questi tipi di movimento:



```text

carico

vendita

reso

rettifica

```



\## Carico



Aumenta la scorta.



Richiede un fornitore.



\## Vendita



Diminuisce la scorta.



Non usa il fornitore.



\## Reso



Rappresenta merce restituita dal cliente.



Aumenta la scorta.



Il reso a fornitore non fa parte dell'MVP 1.



\## Rettifica



Imposta la nuova scorta reale.



La quantità del movimento viene calcolata dal backend.



Flutter non deve inviare la quantità della rettifica.



\---



\# Stato backend



Il backend MVP 1 è considerato validato.



Sono stati testati:



\* onboarding;

\* creazione azienda;

\* creazione profilo;

\* categorie;

\* fornitori;

\* prodotti;

\* carichi;

\* vendite;

\* rettifiche;

\* blocco scorta insufficiente;

\* blocco rettifica nulla;

\* immutabilità movimenti;

\* protezione modifica diretta scorta;

\* isolamento multi-tenant;

\* blocco delete dove previsto.



\---



\# Stato Flutter



La fase Flutter è in preparazione operativa.



Il progetto Flutter è presente nella cartella:



```text

app/

```



Il piano Flutter approvato stabilisce che il primo blocco di lavoro non deve partire dalle schermate complete.



Il primo blocco deve essere il core Dart minimo.



Il core Dart minimo dovrà preparare:



\* messaggi centralizzati;

\* errori centralizzati;

\* feedback persistente;

\* supporto accessibilità;

\* gestione sessione;

\* base per servizi Supabase.



\---



\# Metodo di lavoro



Il progetto segue un metodo documentale e progressivo.



Per ogni blocco importante:



1\. si scrive il design;

2\. si scrive il coding plan;

3\. si scrive il todo specifico;

4\. si implementa solo quel blocco;

5\. si testa;

6\. si corregge;

7\. si aggiorna il changelog;

8\. si esegue commit;

9\. si esegue push.



Regola sintetica:



```text

un blocco, un obiettivo, un test, un commit

```



\---



\# Prossimo passo



Il prossimo documento operativo da creare è:



```text

docs/4-flutter/1-design/001-DESIGN\_CORE\_mvp1\_v1.0.0.md

```



Dopo il design core verranno creati:



```text

docs/4-flutter/2-coding-plans/001-CODING\_PLAN\_CORE\_mvp1\_v1.0.0.md

docs/4-flutter/3-todos/001-TODO\_CORE\_mvp1\_v1.0.0.md

```



Solo dopo questi documenti si passerà al primo blocco di codice Flutter.



\---



\# Regole di sicurezza



Non inserire mai nel codice Flutter:



```text

service role key

```



Il client Flutter deve usare solo la chiave pubblica anon dove previsto.



Le regole di sicurezza devono essere garantite da:



\* Supabase Auth;

\* RLS;

\* RPC;

\* controlli server-side.



\---



\# Regole di accessibilità



Ogni schermata dovrà rispettare questi principi:



\* pulsanti con testo chiaro;

\* campi con label leggibili;

\* messaggi di errore comprensibili;

\* messaggi di successo persistenti;

\* avvisi non solo visivi;

\* nessuna funzione critica solo tramite icona;

\* nessuna informazione importante solo tramite colore;

\* compatibilità con screen reader.



La revisione finale di accessibilità servirà a controllare l'intero flusso, non ad aggiungere accessibilità alla fine.



\---



\# Cosa non fa l'MVP 1



Non fanno parte dell'MVP 1:



\* sincronizzazione offline completa;

\* scanner barcode HID/Bluetooth;

\* immagini prodotto;

\* report avanzati;

\* template di settore completi;

\* ruoli avanzati;

\* multi-azienda per singolo utente;

\* recupero password Flutter;

\* reso a fornitore;

\* visualizzazione amichevole del nome operatore nei movimenti.



Queste funzionalità potranno essere valutate in versioni successive.



\---



\# Evoluzione futura



Evoluzioni previste dopo l'MVP 1:



\## MVP 2



Template di settore.



\## MVP 3



Scanner barcode HID/Bluetooth.



\## MVP 4



Offline e sincronizzazione.



\## MVP 5



Immagini prodotto.



\## MVP 6



Report e statistiche.



\---



\# Changelog



Il file:



```text

CHANGELOG.md

```



racconta l'evoluzione del progetto.



Dopo ogni blocco importante, il changelog deve essere aggiornato.



\---



\# Convenzioni di commit



I commit devono essere chiari.



Esempi corretti:



```text

Aggiunge README principale del progetto

Aggiunge design core Flutter

Aggiunge coding plan core Flutter

Aggiunge core messaggi ed errori

```



Esempi da evitare:



```text

modifiche

fix

aggiornamento

varie

```



\---



\# Come riprendere il progetto dopo una pausa



Per riprendere il lavoro:



1\. leggere `CHANGELOG.md`;

2\. leggere questo `README.md`;

3\. leggere `docs/README.md`;

4\. aprire `docs/4-flutter/3-todos/000-todo-master.md`;

5\. seguire il prossimo passo indicato.



\---



\# Licenza



Licenza non ancora definita.



Prima di distribuire pubblicamente il progetto o consentirne l'uso a terzi, sarà necessario scegliere una licenza.



\---



\# Stato finale di questo README



Questo README è la porta d'ingresso del repository.



Serve a capire:



\* che cos'è il progetto;

\* qual è il suo stato;

\* dove si trova la documentazione;

\* quali sono le regole fondamentali;

\* quale lavoro viene dopo.



Per i dettagli tecnici completi, consultare la cartella:



```text

docs/

```



