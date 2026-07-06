# Gestionale Magazzino Universale

Gestionale magazzino sviluppato con Flutter, Dart e Supabase.
Il progetto nasce con l'obiettivo di costruire un gestionale semplice, solido, accessibile e adattabile a diversi settori commerciali.
L'MVP 1 si concentra sul cuore del sistema:

* registrazione account;
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

```text
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
* codifica del blocco 002 Auth/Session;
* test automatici del blocco 002 Auth/Session;
* test manuali login/logout/sessione;
* correzione accessibilità feedback NVDA;
* commit, push e merge del blocco 002 Auth/Session in `main`;
* aggiornamento del todo master con la nuova sequenza Flutter;
* aggiornamento del Flutter plan con la decisione registrazione separata da onboarding.
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
  Il blocco 002 Auth/Session è completato.
  Il blocco 002 ha introdotto:
* controllo sessione Supabase all'avvio;
* login con email e password;
* logout;
* recupero sessione persistente;
* ascolto centrale degli eventi auth Supabase;
* lettura profilo applicativo;
* lettura azienda collegata al profilo;
* distinzione tra profilo assente, profilo incompleto ed errore tecnico;
* placeholder onboarding;
* placeholder home;
* feedback persistente;
* annunci accessibili dei feedback principali;
* test automatici obbligatori del blocco;
* test manuali con Supabase reale;
* verifica NVDA sui messaggi principali.
  Dopo il merge del blocco 002 in `main`, risultano superati:

```text
flutter analyze
flutter test
```

La prossima fase riguarda la progettazione del blocco 003:

```text
Registrazione account
```

---

# Decisione organizzativa attuale

Durante la validazione del blocco 002 è emerso che l'app permette il login di utenti già esistenti, ma non permette ancora a un nuovo utente di registrarsi dall'app.
Per l'MVP 1 questa possibilità è necessaria.
Un utente finale non deve entrare in Supabase, creare utenti manualmente, resettare password o lanciare query SQL.
Decisione:

```text
la registrazione account viene separata dall'onboarding azienda/profilo
```

Significato:

* registrazione account = crea l'utente Supabase Auth;
* onboarding = crea azienda e profilo applicativo tramite RPC `crea_azienda_e_profilo`.
  Nuova sequenza ufficiale:

```text
002 Login, logout e sessione
003 Registrazione account
004 Onboarding azienda/profilo
005 Home
006 Categorie
007 Fornitori
008 Prodotti
009 Movimenti di magazzino
010 Storico movimenti
011 Revisione accessibilità
012 Stabilizzazione MVP 1
```

Regola pratica:

```text
il blocco 003 non crea azienda e profilo
il blocco 004 non crea l'account Supabase Auth
```

---

# Obiettivo dell'MVP 1

L'MVP 1 deve permettere a un utente di:

1. registrare un nuovo account dall'app;
2. accedere al sistema;
3. completare l'onboarding iniziale;
4. creare azienda e profilo applicativo;
5. entrare nella home aziendale;
6. creare categorie;
7. creare fornitori;
8. creare prodotti;
9. registrare carichi;
10. registrare vendite;
11. registrare rettifiche;
12. visualizzare la scorta aggiornata;
13. consultare lo storico dei movimenti;
14. usare il flusso principale tramite screen reader.
    L'MVP 1 non ha l'obiettivo di essere un gestionale completo e definitivo.
    Ha l'obiettivo di validare il nucleo affidabile del progetto.

---

# Tecnologie principali

## Frontend

```text
Flutter
Dart
```

Il frontend viene costruito in modo progressivo.
La base Flutter, cioè il core Dart minimo, è stata completata.
Il blocco Auth/Session è stato completato.
Le schermate e le funzionalità applicative vengono costruite per blocchi successivi.
Il prossimo blocco da progettare è:

```text
Registrazione account
```

## Backend

```text
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

```text
registra_movimento
```

## 2. I movimenti sono lo storico ufficiale

La tabella dei movimenti rappresenta la storia ufficiale del magazzino.
I movimenti:

* vengono creati tramite RPC;
* non vengono modificati;
* non vengono eliminati.
  Eventuali errori devono essere corretti con nuovi movimenti.

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

## 4. Multi-tenant

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

```text
Gestionale-magazzino/
  README.md
  CHANGELOG.md
  app/
  docs/
```

---

# Cartella app

Percorso:

```text
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

```text
app/README.md
```

è il README interno della sola app Flutter.
Non è il README principale del progetto.
Il README principale del progetto è questo file nella root del repository.
--------------------------------------------------------------------------

# Cartella docs

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

---

# Documentazione principale

I documenti principali del progetto sono:

```text
docs/0-architettura/001-ARCHITETTURA_mvp1_v1.0.0.md
docs/1-database/001-DATABASE_SCHEMA_mvp1_v1.0.0.md
docs/1-database/TEST_PLAN_MVP1_v1.0.0.md
docs/2-flussi-applicativi/001-FLOWS_mvp1_v1.0.0.md
docs/3-backend/001-BACKEND_RULES_mvp1_v1.0.0.md
docs/3-backend/002-API_CONTRACTS_mvp1_v1.0.0.md
docs/4-flutter/001-FLUTTER_PLAN_mvp1_v1.0.0.md
docs/4-flutter/1-design/001-DESIGN_CORE_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/001_CODING_PLAN_CORE_mvp1_v1.0.0.md
docs/4-flutter/3-todos/001-TODO_CORE_mvp1_v1.0.0.md
docs/4-flutter/1-design/002-DESIGN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/002-CODING_PLAN_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/3-todos/002-TODO_AUTH_SESSION_mvp1_v1.0.0.md
docs/4-flutter/3-todos/000-todo-master.md
```

Documenti previsti per il prossimo blocco:

```text
docs/4-flutter/1-design/003-DESIGN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/003-CODING_PLAN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
docs/4-flutter/3-todos/003-TODO_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
```

Nota:
i documenti del blocco 003 non sono ancora creati.
Saranno il prossimo lavoro documentale.
---------------------------------------

# Script Supabase

Gli script SQL principali sono:

```text
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

```text
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

```text
crea_azienda_e_profilo
```

## Questa RPC crea azienda e profilo durante l'onboarding iniziale.

# Flusso principale MVP 1

Il flusso principale previsto per un nuovo utente è:

```text
Registrazione account
↓
Login o sessione autenticata
↓
Onboarding azienda/profilo
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

Il flusso principale previsto per un utente già esistente è:

```text
Login
↓
Controllo sessione
↓
Onboarding se necessario
↓
Home
↓
Funzioni gestionali
```

---

# Tipi di movimento

L'MVP 1 prevede questi tipi di movimento:

```text
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

```text
app/
```

Il piano Flutter approvato stabilisce che il lavoro non deve partire dalle schermate complete, ma da una base comune.

## Blocco 001 — Core Dart minimo

Stato:

```text
COMPLETATO
```

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

```text
flutter analyze
flutter test
```

entrambi con esito positivo.

## Blocco 002 — Login, logout e sessione

Stato:

```text
COMPLETATO
```

Il blocco 002 ha implementato:

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
* annunci NVDA dei feedback principali;
* test automatici obbligatori;
* test manuali con Supabase reale.
  Il blocco 002 è stato verificato con:

```text
flutter analyze
flutter test
```

entrambi con esito positivo.
Il blocco 002 è stato committato, pushato e mergiato in `main`.

## Blocco 003 — Registrazione account

Stato:

```text
DA PROGETTARE
```

Il blocco 003 dovrà implementare:

* accesso alla registrazione dalla login;
* schermata registrazione;
* email;
* password;
* conferma password;
* creazione account tramite Supabase Auth;
* gestione email già registrata;
* gestione password non valida;
* feedback persistente;
* annunci accessibili;
* test automatici;
* test manuali con Supabase reale.
  Il blocco 003 non dovrà implementare:
* creazione azienda;
* creazione profilo applicativo;
* onboarding reale;
* home reale;
* categorie;
* fornitori;
* prodotti;
* movimenti;
* storico movimenti.

## Blocco 004 — Onboarding azienda/profilo

Stato:

```text
DA FARE
```

Il blocco 004 sostituirà il placeholder onboarding con onboarding reale.
Dovrà usare la RPC:

```text
crea_azienda_e_profilo
```

## Blocco 005 — Home

Stato:

```text
DA FARE
```

## Il blocco 005 sostituirà il placeholder home con la home reale.

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
10. si esegue push;
11. si esegue merge in `main` dopo validazione;
12. si verifica `flutter analyze` e `flutter test` su `main`.
    Regola sintetica:

```text
un blocco, un obiettivo, un test, un commit
```

---

# Prossimo passo

Il prossimo passo operativo è progettare il blocco:

```text
003 — Registrazione account
```

Prima della codifica dovranno essere creati:

```text
docs/4-flutter/1-design/003-DESIGN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
docs/4-flutter/2-coding-plans/003-CODING_PLAN_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
docs/4-flutter/3-todos/003-TODO_ACCOUNT_REGISTRATION_mvp1_v1.0.0.md
```

Il blocco 003 dovrà concentrarsi solo su:

* registrazione account Supabase Auth;
* validazione form;
* feedback persistente;
* accessibilità;
* test automatici;
* test manuali reali.
  Il blocco 003 non dovrà creare:
* azienda;
* profilo applicativo;
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

```text
service role key
```

Il client Flutter deve usare solo la chiave pubblica anon dove previsto.
Le regole di sicurezza devono essere garantite da:

* Supabase Auth;
* RLS;
* RPC;
* controlli server-side.
  Nel blocco 003 Registrazione account, Flutter non deve chiamare:

```text
crea_azienda_e_profilo
```

Questa RPC appartiene al blocco 004 Onboarding azienda/profilo.
Nel blocco 003 Registrazione account, Flutter deve solo:

* creare l'utente Supabase Auth;
* gestire validazioni e messaggi;
* mantenere accessibilità;
* preparare il passaggio logico verso onboarding, senza creare ancora azienda e profilo.

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
  Per il blocco 003 Registrazione account saranno particolarmente importanti:
* link o pulsante Crea account leggibile;
* campo Email con etichetta chiara;
* campo Password con etichetta chiara;
* campo Conferma password con etichetta chiara;
* pulsante Registrati leggibile;
* pulsante Torna al login leggibile;
* messaggi di errore persistenti;
* messaggi di successo persistenti;
* annunci NVDA dei feedback principali.
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

```text
CHANGELOG.md
```

racconta l'evoluzione del progetto.
Dopo ogni blocco importante, il changelog deve essere aggiornato.
Il changelog è già stato aggiornato per registrare:

* completamento del core Dart minimo;
* preparazione documentale del blocco auth/session;
* completamento della codifica Auth/Session;
* correzione accessibilità feedback NVDA del blocco Auth/Session.
  Dovrà essere aggiornato nuovamente dopo l'aggiornamento documentale che separa registrazione account e onboarding, se questa modifica viene committata come blocco documentale.

---

# Convenzioni di commit

I commit devono essere chiari.
Esempi corretti:

```text
Aggiunge README principale del progetto
Aggiunge design core Flutter
Aggiunge coding plan core Flutter
Aggiunge core messaggi ed errori
Aggiunge TODO auth session Flutter
Aggiunge login logout e gestione sessione
Aggiorna piano Flutter con registrazione separata
Aggiunge design registrazione account
Aggiunge registrazione account
```

Esempi da evitare:

```text
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

```text
progettare il blocco 003 Registrazione account
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

```text
Backend validato.
Core Dart minimo completato.
Auth/Session completato e mergiato in main.
Decisione registrazione account separata da onboarding documentata.
Prossimo passo: design del blocco 003 Registrazione account.
```

Per i dettagli tecnici completi, consultare la cartella:

```text
docs/
```
