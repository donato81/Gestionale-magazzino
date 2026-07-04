# FLOWS MVP 1.0

## Gestionale Magazzino Universale

Versione: 1.0.0
Stato: APPROVATO
Data: 12 Giugno 2026

---

# 1. Scopo del documento

Questo documento definisce i flussi operativi ufficiali dell'MVP 1 del Gestionale Magazzino Universale.

L'obiettivo è descrivere:

* cosa fa l'utente;
* quali dati inserisce;
* quali controlli esegue il sistema;
* quali risultati vengono prodotti.

Il documento non descrive:

* interfaccia grafica;
* schermate Flutter;
* widget;
* implementazione tecnica.

Lo scopo è definire il comportamento applicativo.

---

# 2. Principi Generali

## 2.1 Accessibilità

Ogni flusso deve essere utilizzabile tramite screen reader.

Il sistema deve sempre fornire:

* messaggi di conferma;
* messaggi di errore;
* messaggi di successo;
* avvisi di attenzione.

Nessuna operazione deve produrre feedback esclusivamente visivi.

---

## 2.2 Atomicità

Le operazioni che modificano il magazzino devono essere atomiche.

L'utente deve ricevere un unico risultato:

* operazione completata;
  oppure
* operazione fallita.

Non devono esistere stati intermedi.

---

## 2.3 Multi Tenant

Ogni operazione viene eseguita esclusivamente all'interno della propria azienda.

L'utente non può visualizzare né modificare dati appartenenti ad altre aziende.

---

# F001 - Registrazione Utente

## Obiettivo

Consentire la creazione di una nuova azienda e del relativo profilo utente.

---

## Flusso

```text
Registrazione utente
↓
Inserimento nome azienda
↓
Creazione azienda
↓
Creazione profilo
↓
Ingresso nell'app
```

---

## Dati richiesti

Utente:

* email
* password

Azienda:

* nome azienda

---

## Controlli

* email valida
* password valida
* nome azienda obbligatorio

---

## Risultato

Vengono creati:

* azienda
* profilo

L'utente viene associato alla nuova azienda.

---

# F002 - Creazione Categoria

## Obiettivo

Creare una categoria prodotti.

---

## Dati richiesti

* nome
* descrizione (facoltativa)

---

## Controlli

* nome obbligatorio
* nome univoco nell'azienda

---

## Risultato

Nuova categoria disponibile.

---

# F003 - Creazione Fornitore

## Obiettivo

Registrare un nuovo fornitore.

---

## Dati richiesti

* nome
* telefono (facoltativo)
* email (facoltativa)
* note (facoltative)

---

## Controlli

* nome obbligatorio
* nome univoco nell'azienda

---

## Risultato

Nuovo fornitore disponibile.

---

# F004 - Creazione Prodotto

## Obiettivo

Creare una nuova anagrafica prodotto.

---

## Dati richiesti

* nome
* barcode (facoltativo)
* categoria (facoltativa)
* fornitore preferito (facoltativo)
* unità di misura
* prezzo acquisto
* prezzo vendita
* aliquota IVA
* scorta minima

---

## Valori Predefiniti

Se non specificata:

```text
unità di misura = pz
```

---

## Controlli

Nome:

* obbligatorio

Barcode:

* univoco nell'azienda
* stringa vuota convertita in NULL

Prezzi:

* non negativi

Scorta minima:

* non negativa

Categoria:

* se selezionata deve essere attiva

Fornitore:

* se selezionato deve essere attivo

---

## Risultato

Nuovo prodotto creato.

Scorta iniziale:

```text
0
```

---

# F005 - Modifica Prodotto

## Obiettivo

Aggiornare i dati di un prodotto.

---

## Dati modificabili

* nome
* barcode
* categoria
* fornitore preferito
* unità di misura
* prezzi
* aliquota IVA
* scorta minima
* attributi extra

---

## Regole

Categorie e fornitori disattivati non possono essere selezionati.

---

## Risultato

Anagrafica aggiornata.

---

# F006 - Carico Magazzino

## Obiettivo

Registrare l'ingresso di merce.

---

## Dati richiesti

* prodotto
* fornitore
* quantità
* prezzo unitario
* note (facoltative)

---

## Comportamento

Il prezzo unitario viene precompilato utilizzando:

```text
prezzo_acquisto del prodotto
```

L'utente può modificarlo.

---

## Controlli

Prodotto:

* deve esistere
* deve essere attivo

Fornitore:

* deve appartenere all'azienda
* deve essere attivo

Quantità:

* maggiore di zero

Prezzo:

* non negativo

---

## Risultato

Movimento:

```text
tipo = carico
```

Scorta aumentata.

---

# F007 - Vendita / Scarico

## Obiettivo

Ridurre la scorta di un prodotto.

---

## Dati richiesti

* prodotto
* quantità
* prezzo unitario (facoltativo)
* note (facoltative)

---

## Comportamento

Il prezzo unitario viene precompilato utilizzando:

```text
prezzo_vendita del prodotto
```

L'utente può modificarlo.

---

## Controlli

Prodotto:

* esistente
* attivo

Quantità:

* maggiore di zero

Scorta:

* sufficiente

Prezzo:

* non negativo

---

## Risultato

Movimento:

```text
tipo = vendita
```

Scorta diminuita.

---

## Avvisi

Se la nuova scorta scende sotto:

```text
scorta_minima
```

il sistema deve notificare:

```text
Attenzione: scorta inferiore al livello minimo.
```

Il messaggio deve essere accessibile agli screen reader.

---

# F008 - Reso Cliente

## Obiettivo

Registrare la restituzione di merce da parte di un cliente.

---

## Significato

Il reso rappresenta esclusivamente:

```text
merce restituita da cliente
```

che rientra in magazzino.

---

## Dati richiesti

* prodotto
* quantità
* note (facoltative)

---

## Controlli

Prodotto:

* esistente
* attivo

Quantità:

* maggiore di zero

---

## Risultato

Movimento:

```text
tipo = reso
```

Scorta aumentata.

---

## Regola

Il campo:

```text
fornitore_id
```

non viene utilizzato per questo tipo di movimento.

---

# F009 - Rettifica Inventario

## Obiettivo

Correggere la scorta reale.

---

## Dati richiesti

* prodotto
* nuova scorta reale
* motivazione

---

## Controlli

Prodotto:

* esistente
* attivo

Nuova scorta:

* maggiore o uguale a zero

Motivazione:

* obbligatoria

---

## Flusso

```text
Selezione prodotto
↓
Inserimento nuova scorta
↓
Inserimento motivazione
↓
Registrazione rettifica
```

---

## Risultato

Movimento:

```text
tipo = rettifica
```

La RPC calcola automaticamente:

```text
differenza =
nuova_scorta - scorta_attuale
```

---

## Avvisi

Se la nuova scorta risulta inferiore alla scorta minima:

```text
Attenzione: scorta inferiore al livello minimo.
```

---

# F010 - Consultazione Prodotto

## Obiettivo

Visualizzare una scheda prodotto.

---

## Informazioni mostrate

* nome
* barcode
* categoria
* fornitore preferito
* scorta attuale
* scorta minima
* prezzo acquisto
* prezzo vendita
* attributi extra

---

# F011 - Storico Movimenti

## Obiettivo

Consultare i movimenti di un prodotto.

---

## Filtri previsti

* prodotto
* data da
* data a
* tipo movimento

---

## Informazioni mostrate

* data
* tipo
* quantità
* scorta prima
* scorta dopo
* operatore
* note

Per carichi:

* fornitore

---

# F012 - Disattivazione Categoria

## Obiettivo

Archiviare una categoria.

---

## Regola

Non viene eliminata.

Viene impostato:

```text
attiva = false
```

---

# F013 - Disattivazione Fornitore

## Obiettivo

Archiviare un fornitore.

---

## Regola

Non viene eliminato.

Viene impostato:

```text
attivo = false
```

---

# F014 - Disattivazione Prodotto

## Obiettivo

Archiviare un prodotto.

---

## Regola

Non viene eliminato.

Viene impostato:

```text
attivo = false
```

---

## Effetti

Un prodotto disattivato:

* non può ricevere carichi;
* non può ricevere vendite;
* non può ricevere resi;
* non può ricevere rettifiche.

Questa regola deve essere applicata sia nel frontend sia nella RPC server-side.

---

# 3. Decisioni Architetturali Confermate

## D01 - Categoria Obbligatoria

Decisione:

```text
NO
```

La categoria è facoltativa.

Motivazione:

semplifica l'onboarding e la creazione rapida dei prodotti.

---

## D02 - Fornitore Preferito Obbligatorio

Decisione:

```text
NO
```

Il fornitore preferito è facoltativo.

---

## D03 - Significato del Reso

Decisione:

```text
Reso da cliente
```

Il reso aumenta la scorta.

Il reso a fornitore non fa parte dell'MVP 1.

---

## D04 - Movimenti su Prodotto Disattivato

Decisione:

```text
NO
```

I prodotti disattivati non possono ricevere movimenti.

---

# Stato Documento

Stato: APPROVATO

Versione: 1.0.0

Data approvazione: 12 Giugno 2026

Documento validato tramite revisione congiunta:

* ChatGPT (coordinatore)
* Gemini
* DeepSeek

Passo successivo:

> progettazione dello script SQL Supabase MVP 1.0

