# ARCHITETTURA MVP 1.0 APPROVATA

## Gestionale Magazzino Universale

---

# 1. Scopo del documento

Questo documento definisce l'architettura ufficiale della prima versione del progetto Gestionale Magazzino Universale.

L'obiettivo è realizzare una base solida, semplice, accessibile ed evolutiva sulla quale costruire le versioni future del gestionale.

La prima versione non ha l'obiettivo di essere completa.

Deve invece validare il cuore del sistema:

> creare prodotti, registrare movimenti di magazzino e mantenere una scorta affidabile e tracciabile.

---

# 2. Visione del progetto

Il progetto nasce come gestionale magazzino adattabile a differenti settori commerciali.

La visione finale prevede un sistema basato su template di settore in grado di adattarsi a:

* Agricoltura
* Alimentari
* Abbigliamento
* Ferramenta
* Elettronica
* Magazzini generici
* Altri settori futuri

La prima versione non implementa ancora i template completi ma prepara le fondamenta necessarie.

---

# 3. Obiettivo dell'MVP 1

L'MVP 1 deve permettere di:

* autenticarsi;
* creare categorie;
* creare fornitori;
* creare prodotti;
* registrare carichi;
* registrare vendite/scarichi;
* visualizzare la scorta;
* consultare lo storico dei movimenti.

Se questo flusso funziona in modo affidabile, il nucleo del progetto è validato.

---

# 4. Principio fondamentale della scorta

La regola architetturale principale del sistema è:

> La scorta non viene mai modificata direttamente.

Ogni variazione deve essere registrata come movimento.

Tipi iniziali di movimento:

* carico
* vendita
* rettifica
* reso

La tabella prodotti mantiene una copia aggiornata della scorta corrente per ragioni di performance.

La fonte ufficiale della verità rimane comunque lo storico dei movimenti.

---

# 5. Atomicità delle operazioni

Ogni registrazione di movimento deve essere eseguita tramite una funzione server-side PostgreSQL esposta come RPC Supabase.

La funzione deve:

1. inserire il movimento;
2. aggiornare la scorta del prodotto;
3. completare entrambe le operazioni nella stessa transazione.

Non è consentito che Flutter esegua direttamente:

* insert movimento;
* update prodotto.

Questo evita inconsistenze in caso di errore, crash o perdita di connessione.

---

# 6. Flusso operativo minimo

1. Login utente
2. Creazione categoria
3. Creazione fornitore
4. Creazione prodotto
5. Registrazione carico
6. Registrazione vendita/scarico
7. Visualizzazione scorta aggiornata
8. Consultazione storico movimenti

---

# 7. Architettura multi-tenant

Ogni dato appartiene a una azienda.

Anche se inizialmente ogni utente avrà una sola azienda, il sistema deve essere progettato fin dall'inizio per supportare una futura crescita.

---

# 8. Entità principali

## 8.1 Profili Utente

Tabella di collegamento tra Supabase Auth e il dominio applicativo.

Campi iniziali:

* id
* user_id
* azienda_id
* nome
* email
* created_at

Scopo:

* associare l'utente autenticato a una azienda;
* permettere l'applicazione delle policy RLS;
* preparare futuri ruoli e collaboratori.

---

## 8.2 Aziende

Rappresenta il contenitore logico dei dati.

Campi minimi:

* id
* nome
* created_at

---

## 8.3 Categorie

Permettono la classificazione dei prodotti.

Campi minimi:

* id
* azienda_id
* nome
* descrizione

---

## 8.4 Fornitori

Anagrafica fornitori.

Campi minimi:

* id
* azienda_id
* nome
* telefono
* email
* note

---

## 8.5 Prodotti

Anagrafica principale del magazzino.

Campi iniziali:

* id (UUID)
* azienda_id
* categoria_id
* fornitore_preferito_id
* barcode
* nome
* descrizione
* unita_misura
* prezzo_acquisto
* prezzo_vendita
* aliquota_iva
* scorta_attuale
* scorta_minima
* attributi_extra (JSONB)
* attivo
* created_at
* updated_at

---

### Barcode

Il barcode deve essere univoco all'interno della stessa azienda.

Vincolo previsto:

UNIQUE (azienda_id, barcode)

---

### Attributi Extra

Campo JSONB predisposto per il futuro sistema di template.

Nell'MVP 1 può rimanere inutilizzato.

---

## 8.6 Movimenti di Magazzino

Registro ufficiale delle variazioni di scorta.

Campi iniziali:

* id (UUID)
* azienda_id
* prodotto_id
* fornitore_id
* tipo_movimento
* quantita
* scorta_prima
* scorta_dopo
* prezzo_unitario
* note
* data_movimento
* creato_da

---

### Tipi movimento iniziali

* carico
* vendita
* rettifica
* reso

---

### Provenienza della merce

Il campo:

* fornitore_id

viene mantenuto direttamente sul movimento.

Motivazione:

lo stesso prodotto può essere acquistato da fornitori differenti nel tempo.

Il movimento deve quindi conservare la provenienza reale della merce registrata.

---

# 9. Identificatori

Tutte le tabelle principali utilizzano UUID come chiavi primarie.

Motivazioni:

* maggiore sicurezza;
* migliore supporto futuro all'offline;
* assenza di collisioni tra dispositivi;
* maggiore evolutività.

---

# 10. Backend

Tecnologia scelta:

Supabase.

Componenti utilizzati:

* Auth
* PostgreSQL
* RLS
* RPC

Storage verrà introdotto successivamente.

---

# 11. Sicurezza

Le Row Level Security sono obbligatorie.

Ogni utente può accedere esclusivamente ai dati della propria azienda.

Tutte le policy devono basarsi sulla relazione:

utente → profilo → azienda.

---

# 12. Frontend

Tecnologia scelta:

Flutter + Dart.

Schermate previste:

* Login
* Home
* Lista prodotti
* Dettaglio prodotto
* Nuovo prodotto
* Modifica prodotto
* Carico prodotto
* Vendita prodotto
* Lista categorie
* Lista fornitori
* Storico movimenti

---

# 13. Accessibilità

L'accessibilità è un requisito architetturale.

Principi obbligatori:

* utilizzo corretto di Semantics;
* etichette accessibili;
* feedback testuali chiari;
* ordine logico del focus;
* compatibilità con TalkBack;
* compatibilità con VoiceOver;
* compatibilità con screen reader desktop dove applicabile.

Nessuna funzionalità deve dipendere esclusivamente da elementi visivi.

---

# 14. Barcode

Nella prima versione il barcode è gestito come semplice campo testuale.

L'integrazione con scanner HID/Bluetooth verrà sviluppata successivamente.

Questo approccio permette di:

* testare il modello dati;
* validare i flussi;
* ridurre la complessità iniziale.

---

# 15. Offline

L'offline non fa parte dell'MVP 1.

Tuttavia tutte le scelte architetturali devono evitare di bloccare una futura implementazione della sincronizzazione.

L'uso di UUID e la separazione delle responsabilità preparano il terreno per questa evoluzione.

---

# 16. Template di settore

I template non vengono implementati nell'MVP 1.

La predisposizione è garantita dal campo:

attributi_extra JSONB

L'evoluzione futura prevede:

* template_settore
* campi_template
* associazione categoria-template

---

# 17. Regole architetturali

1. La scorta non viene mai modificata direttamente.
2. Ogni variazione genera un movimento.
3. I movimenti sono la fonte ufficiale della verità.
4. La scorta viene aggiornata tramite RPC server-side.
5. Ogni dato appartiene a una azienda.
6. Ogni utente appartiene a una azienda.
7. Barcode univoco per azienda.
8. UUID come identificatori.
9. Accessibilità obbligatoria.
10. Offline rimandato.
11. Template rimandati.

---

# 18. Criterio di successo dell'MVP 1

L'MVP 1 sarà considerato completato quando un utente potrà:

1. accedere al sistema;
2. creare categorie;
3. creare fornitori;
4. creare prodotti;
5. registrare carichi;
6. registrare vendite;
7. visualizzare la scorta corretta;
8. consultare lo storico dei movimenti;
9. utilizzare l'intero flusso tramite screen reader.

---

# 19. Evoluzione prevista

MVP 2

* Template di settore

MVP 3

* Scanner barcode HID

MVP 4

* Offline e sincronizzazione

MVP 5

* Immagini prodotto

MVP 6

* Report e statistiche

---

# 20. Stato del documento

STATO: APPROVATO

Versione: 1.0

Data approvazione: 12 giugno 2026

Primo passo successivo:

> progettazione dello schema database Supabase.
