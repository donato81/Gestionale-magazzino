# Gestionale Magazzino Universale

Gestionale magazzino sviluppato con Flutter, Dart e Supabase.
Il progetto nasce con l'obiettivo di costruire un gestionale semplice, solido, accessibile e adattabile a diversi settori commerciali.
L'MVP 1 si concentra sul cuore del sistema:

* autenticazione utente;
* creazione azienda e profilo;
* gestione categorie;
* gestione fornitori;
* gestione prodotti;
* registrazione movimenti di magazzino;
* aggiornamento scorte;
* consultazione dello storico movimenti;
* utilizzo tramite screen reader.

---

# Stato del progetto

Stato attuale:

```text id="j6ykip"
MVP 1 in sviluppo
```

La fase backend Supabase è stata progettata, implementata e validata.
Sono già stati completati:

* architettura MVP 1;
* schema database;
* script SQL Supabase;
* RPC movimenti;
* RPC onboarding;
* RLS;
* test backend;
* piano Flutter;
* API Contracts;
* README principale del repository;
* README documentazione;
* todo master Flutter;
* design core Flutter;
* coding plan core Flutter;
* TODO core Flutter;
* codifica del core Dart minimo;
* test automatici del core Dart minimo;
* commit, push e merge del blocco core in `main`;
* design auth/session Flutter;
* coding plan auth/session Flutter;
* TODO auth/session Flutter;
* aggiornamento del todo master dopo la preparazione documentale del blocco auth/session;
* aggiornamento del changelog dopo la preparazione documentale del blocco auth/session.
  Il blocco 001 Core Dart minimo è completato.
  Il blocco 001 ha introdotto:
* messaggi centralizzati;
* errori applicativi;
* mapper errori Supabase;
* feedback applicativo;
* controller feedback;
* supporto accessibilità minimo;
* stato sessione minimo;
* controller sessione minimo;
* test automatici obbligatori del core.
  Dopo il merge del blocco 001 in `main`, risultano superati:

```text id="c6wqg7"
flutter analyze
flutter test
```

La preparazione documentale del blocco 002 Auth/Session è completata.
La fase attuale riguarda la preparazione del prompt operativo rigido per Antigravity e la successiva codifica del blocco 002:

```text id="q77fsg"
Login, logout e sessione
```

---

# Obiettivo dell'MVP 1

L'MVP 1 deve permettere a un utente di:

1. accedere al sistema;
2. completare l'onboarding iniziale;
3. creare categorie;
4. creare fornitori;
5. creare prodotti;
6. registrare carichi;
7. registrare vendite;
8. registrare rettifiche;
9. visualizzare la scorta aggiornata;
10. consultare lo storico dei movimenti;
11. usare il flusso principale tramite screen reader.
    L'MVP 1 non ha l'obiettivo di essere un gestionale completo e definitivo.
    Ha l'obiettivo di validare il nucleo affidabile del progetto.

---

# Tecnologie principali

## Frontend

```text id="eh0w9f"
Flutter
Dart
```

Il frontend viene costruito in modo progressivo.
La prima base Flutter, cioè il core Dart minimo, è stata completata.
Le schermate e le funzionalità applicative vengono costruite per blocchi successivi.
Il blocco attuale da codificare è:

```text id="ay4f59"
Login, logout e sessione
```

## Backend

```text id="um4lrv"
Supabase
PostgreSQL
Supabase Auth
RLS
RPC PostgreSQL
```

## Il backend è la fonte della verità per le regole critiche.

# Principi fondamentali

## 1. La scorta non si modifica direttamente

La scorta di un prodotto non deve mai essere modificata direttamente dal frontend.
Ogni variazione deve passare da un movimento di magazzino.
La modifica della scorta avviene tramite la RPC:

```text id="hlqaui"
registra_movimento
```

---

## 2. I movimenti sono lo storico ufficiale

La tabella dei movimenti rappresenta la storia ufficiale del magazzino.
I movimenti:

* vengono creati tramite RPC;
* non vengono modificati;
* non vengono eliminati.
  Eventuali errori devono essere corretti con nuovi movimenti.

---

## 3. Backend fonte della verità

Flutter non deve sostituire il backend.
Flutter deve:

* raccogliere i dati;
* validare i form per aiutare l'utente;
* chiamare Supabase;
* chiamare le RPC;
* mostrare messaggi chiari;
* tradurre gli errori tecnici;
* aggiornare l'interfaccia.
  Flutter non deve:
* modificare direttamente `prodotti.scorta_attuale`;
* inserire direttamente in `movimenti_magazzino`;
* modificare movimenti;
* eliminare movimenti;
* usare service role key;
* bypassare le RLS;
* fidarsi dei dati locali come fonte definitiva.

---

## 4. Multi-tenant

Ogni dato appartiene a una azienda.
La relazione principale è:

```text id="sp1689"
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
-------------------------

## 5. Accessibilità obbligatoria

L'accessibilità non è una funzione secondaria.
Ogni flusso deve essere utilizzabile tramite screen reader.
Il progetto deve prevedere:

* messaggi testuali chiari;
* errori comprensibili;
* feedback persistente;
* pulsanti con testo esplicito;
* campi con etichette chiare;
* ordine logico del focus;
* nessuna informazione affidata solo al colore;
* nessuna informazione affidata solo alle icone.

---

# Struttura del repository

Struttura principale:

```text id="euw8q2"
Gestionale-magazzino/
  README.md
  CHANGELOG.md
  app/
  docs/
```

---

# Cartella app

Percorso:

```text id="fxmtdm"
app/
```

Contiene il progetto Flutter.
Questa cartella è dedicata al codice dell'applicazione.
Al suo interno si trovano o si troveranno:

* configurazione Flutter;
* codice Dart;
* core applicativo;
* messaggi centralizzati;
* errori applicativi;
* feedback persistente;
* accessibilità minima;
* stato sessione;
* servizi;
* schermate;
* collegamento a Supabase;
* test Flutter.
  Il file:

```text id="lavhkt"
app/README.md
```

è il README interno della sola app Flutter.
Non è il README principale del progetto.
Il README principale del progetto è questo file nella root del repository.
--------------------------------------------------------------------------

# Cartella docs

Percorso:

```text id="e9wv5f"
docs/
```

Contiene la documentazione ufficiale del progetto.
Il file:

```text id="vwe9vh"
docs/README.md
```

è l'indice della documentazione tecnica e progettuale.
Per capire dove si trovano i documenti, partire da:

```text id="vi2tes"
docs/README.md
```

---

# Documentazione principale

I documenti principali del progetto sono:

```text id="wh2y5m"
docs/0-architettura/001-ARCHITETTURA_mvp1_v1.0.0.md
docs/1-database/001-DATABASE_SCHEMA_mvp1_v1.0.0.md
docs/1-database/TEST_PLAN_MVP1_v1.0.0.md
docs/2-flussi-applicativi/001-FLOWS_mvp1_v1.0.0.md
docs/3-backend/001-BACKEND_RULES_mvp1_v1.0.0.md
docs/3-backend/002-API_CONTRACTS_mvp1_v1.0.0.md
docs/4-flutter/001-FLUTTER_PLAN_mvp1_v1.0.0.md
docs/4-flutter/1-design/001-DESIGN_CORE_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/001-CODING_PLAN_CORE_mvp1_v1.0.0.md
docs/4-flutter/3-todos/001-TODO_CORE_mvp1_v1.0.0.md
docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/3-todos/000-todo-master.md
```

---

# Script Supabase

Gli script SQL principali sono:

```text id="jc31ro"
docs/1-database/supabase/001_schema.sql
docs/1-database/supabase/002_rpc.sql
docs/1-database/supabase/003_rls.sql
docs/1-database/supabase/004_onboarding_rpc.sql
```

## 001_schema.sql

Definisce:

* tabelle;
* vincoli;
* indici;
* trigger `updated_at`;
* protezione della scorta;
* immutabilità dei movimenti.

## 002_rpc.sql

Definisce la RPC:

```text id="kk118m"
registra_movimento
```

Questa RPC gestisce:

* carico;
* vendita;
* reso;
* rettifica.

## 003_rls.sql

Definisce le Row Level Security.
Garantisce che ogni utente possa accedere solo ai dati della propria azienda.

## 004_onboarding_rpc.sql

Definisce la RPC:

```text id="8v0pav"
crea_azienda_e_profilo
```

## Questa RPC crea azienda e profilo durante l'onboarding iniziale.

# Flusso principale MVP 1

Il flusso principale previsto è:

```text id="c27dzj"
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

---

# Tipi di movimento

L'MVP 1 prevede questi tipi di movimento:

```text id="zx0821"
carico
vendita
reso
rettifica
```

## Carico

Aumenta la scorta.
Richiede un fornitore.

## Vendita

Diminuisce la scorta.
Non usa il fornitore.

## Reso

Rappresenta merce restituita dal cliente.
Aumenta la scorta.
Il reso a fornitore non fa parte dell'MVP 1.

## Rettifica

Imposta la nuova scorta reale.
La quantità del movimento viene calcolata dal backend.
Flutter non deve inviare la quantità della rettifica.
-----------------------------------------------------

# Stato backend

Il backend MVP 1 è considerato validato.
Sono stati testati:

* onboarding;
* creazione azienda;
* creazione profilo;
* categorie;
* fornitori;
* prodotti;
* carichi;
* vendite;
* rettifiche;
* blocco scorta insufficiente;
* blocco rettifica nulla;
* immutabilità movimenti;
* protezione modifica diretta scorta;
* isolamento multi-tenant;
* blocco delete dove previsto.

---

# Stato Flutter

La fase Flutter è in sviluppo progressivo.
Il progetto Flutter è presente nella cartella:

```text id="fo1g9j"
app/
```

Il piano Flutter approvato stabilisce che il lavoro non deve partire dalle schermate complete, ma da una base comune.
Il primo blocco Flutter, cioè il core Dart minimo, è completato.
Il core Dart minimo ha preparato:

* messaggi centralizzati;
* errori centralizzati;
* mapper errori Supabase;
* feedback persistente;
* controller feedback;
* supporto accessibilità minimo;
* gestione sessione minima;
* controller sessione minimo;
* test automatici obbligatori.
  Il blocco core è stato verificato con:

```text id="j0irog"
flutter analyze
flutter test
```

entrambi con esito positivo.
La documentazione del secondo blocco Flutter è completata.
Il secondo blocco Flutter riguarda:

```text id="wfha4v"
Login, logout e sessione
```

Il blocco 002 dovrà implementare:

* controllo sessione Supabase all'avvio;
* login con email e password;
* logout;
* recupero sessione persistente;
* ascolto centrale degli eventi auth Supabase;
* lettura profilo applicativo;
* lettura azienda collegata al profilo;
* distinzione tra profilo assente, profilo incompleto ed errore tecnico;
* gestione RLS silenti durante la lettura azienda;
* placeholder onboarding;
* placeholder home;
* feedback persistente;
* accessibilità minima;
* test automatici obbligatori;
* test manuali con Supabase reale.
  Il blocco 002 non dovrà implementare:
* registrazione nuovo utente;
* recupero password;
* onboarding reale;
* home reale;
* categorie;
* fornitori;
* prodotti;
* movimenti;
* storico movimenti.

---

# Metodo di lavoro

Il progetto segue un metodo documentale e progressivo.
Per ogni blocco importante:

1. si scrive il design;
2. si scrive il coding plan;
3. si scrive il todo specifico;
4. si implementa solo quel blocco;
5. si eseguono i test automatici obbligatori;
6. si esegue il test manuale e la verifica accessibilità, quando previsti;
7. si corregge;
8. si aggiorna il changelog;
9. si esegue commit;
10. si esegue push.
    Regola sintetica:

```text id="fyvuj2"
un blocco, un obiettivo, un test, un commit
```

---

# Prossimo passo

Il prossimo passo operativo è preparare il prompt rigido per Antigravity relativo al blocco:

```text id="cqfvie"
Login, logout e sessione
```

La codifica dovrà seguire i documenti approvati:

```text id="h02tq2"
docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md
```

Il blocco dovrà creare i file di produzione e i test automatici previsti dal TODO auth/session.
Il blocco non sarà completato senza:

```text id="d5syr7"
flutter analyze
flutter test
```

entrambi con esito positivo.
Non si devono ancora creare:

* onboarding reale;
* home reale;
* categorie;
* fornitori;
* prodotti;
* movimenti;
* storico movimenti.

---

# Regole di sicurezza

Non inserire mai nel codice Flutter:

```text id="vgclax"
service role key
```

Il client Flutter deve usare solo la chiave pubblica anon dove previsto.
Le regole di sicurezza devono essere garantite da:

* Supabase Auth;
* RLS;
* RPC;
* controlli server-side.
  Nel blocco 002 Auth/Session, Flutter non deve chiamare:

```text id="tbcqch"
crea_azienda_e_profilo
```

Questa RPC appartiene al blocco onboarding.
Nel blocco 002 Auth/Session, Flutter deve solo:

* autenticare l'utente;
* leggere il profilo;
* leggere l'azienda collegata;
* decidere se mostrare login, placeholder onboarding o placeholder home.

---

# Regole di accessibilità

Ogni schermata dovrà rispettare questi principi:

* pulsanti con testo chiaro;
* campi con label leggibili;
* messaggi di errore comprensibili;
* messaggi di successo persistenti;
* avvisi non solo visivi;
* nessuna funzione critica solo tramite icona;
* nessuna informazione importante solo tramite colore;
* compatibilità con screen reader.
  Per il blocco 002 Auth/Session sono particolarmente importanti:
* campo Email con etichetta chiara;
* campo Password con etichetta chiara;
* pulsante Accedi leggibile;
* pulsante Esci leggibile;
* pulsante Riprova leggibile;
* messaggi di errore persistenti;
* caricamento sessione leggibile;
* placeholder onboarding leggibile;
* placeholder home leggibile.
  La revisione finale di accessibilità servirà a controllare l'intero flusso, non ad aggiungere accessibilità alla fine.

---

# Cosa non fa l'MVP 1

Non fanno parte dell'MVP 1:

* sincronizzazione offline completa;
* scanner barcode HID/Bluetooth;
* immagini prodotto;
* report avanzati;
* template di settore completi;
* ruoli avanzati;
* multi-azienda per singolo utente;
* recupero password Flutter;
* reso a fornitore;
* visualizzazione amichevole del nome operatore nei movimenti.
  Queste funzionalità potranno essere valutate in versioni successive.

---

# Evoluzione futura

Evoluzioni previste dopo l'MVP 1:

## MVP 2

Template di settore.

## MVP 3

Scanner barcode HID/Bluetooth.

## MVP 4

Offline e sincronizzazione.

## MVP 5

Immagini prodotto.

## MVP 6

## Report e statistiche.

# Changelog

Il file:

```text id="vqk7br"
CHANGELOG.md
```

racconta l'evoluzione del progetto.
Dopo ogni blocco importante, il changelog deve essere aggiornato.
Il changelog è già stato aggiornato per registrare:

* completamento del core Dart minimo;
* preparazione documentale del blocco auth/session.
  Dovrà essere aggiornato nuovamente dopo la codifica effettiva del blocco auth/session.

---

# Convenzioni di commit

I commit devono essere chiari.
Esempi corretti:

```text id="qij9lg"
Aggiunge README principale del progetto
Aggiunge design core Flutter
Aggiunge coding plan core Flutter
Aggiunge core messaggi ed errori
Aggiunge TODO auth session Flutter
Aggiunge login logout e gestione sessione
```

Esempi da evitare:

```text id="vsurq1"
modifiche
fix
aggiornamento
varie
```

---

# Come riprendere il progetto dopo una pausa

Per riprendere il lavoro:

1. leggere `CHANGELOG.md`;
2. leggere questo `README.md`;
3. leggere `docs/README.md`;
4. aprire `docs/4-flutter/3-todos/000-todo-master.md`;
5. seguire il prossimo passo indicato.
   In questo momento il prossimo passo indicato è:

```text id="btiq5b"
preparare il prompt operativo rigido per Antigravity sul blocco 002 Auth/Session
```

---

# Licenza

Licenza non ancora definita.
Prima di distribuire pubblicamente il progetto o consentirne l'uso a terzi, sarà necessario scegliere una licenza.
------------------------------------------------------------------------------------------------------------------

# Stato finale di questo README

Questo README è la porta d'ingresso del repository.
Serve a capire:

* che cos'è il progetto;
* qual è il suo stato;
* dove si trova la documentazione;
* quali sono le regole fondamentali;
* quale lavoro viene dopo.
  Stato attuale sintetico:

```text id="93st70"
Backend validato.
Core Dart minimo completato.
Documentazione Auth/Session completata.
Prossimo passo: prompt Antigravity e codifica blocco 002.
```

Per i dettagli tecnici completi, consultare la cartella:

```text id="xj1g0m"
docs/
```
