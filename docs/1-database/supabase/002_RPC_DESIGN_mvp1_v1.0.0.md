# RPC DESIGN MVP 1.0

## registra_movimento()

Versione: 1.0.0

Stato: APPROVATO

Data: 12 Giugno 2026

---

# 1. Scopo

La funzione `registra_movimento()` rappresenta il cuore operativo del gestionale.

Ogni variazione della scorta deve passare esclusivamente da questa funzione.

Nessun client può:

* aggiornare direttamente `prodotti.scorta_attuale`;
* inserire direttamente record in `movimenti_magazzino`;
* modificare movimenti esistenti;
* eliminare movimenti esistenti.

La RPC costituisce l'unico punto autorizzato per la modifica delle scorte.

---

# 2. Obiettivi

La funzione deve:

1. verificare l'identità dell'utente;
2. individuare l'azienda associata all'utente;
3. verificare che il prodotto appartenga all'azienda;
4. verificare che il prodotto sia attivo;
5. verificare il fornitore se presente;
6. leggere la scorta corrente;
7. calcolare la nuova scorta;
8. impedire scorte negative;
9. registrare il movimento;
10. aggiornare la scorta;
11. restituire il risultato.

Tutte le operazioni devono avvenire nella stessa transazione.

---

# 3. Tipi Movimento Supportati

```text
carico
vendita
reso
rettifica
```

---

# 4. Parametri della Funzione

## Parametri comuni

```text
p_prodotto_id UUID

p_tipo_movimento TEXT

p_fornitore_id UUID DEFAULT NULL

p_note TEXT DEFAULT NULL

p_prezzo_unitario NUMERIC DEFAULT NULL
```

---

## Parametri quantità

Utilizzati esclusivamente da:

```text
carico
vendita
reso
```

```text
p_quantita NUMERIC DEFAULT NULL
```

---

## Parametri rettifica

Utilizzati esclusivamente da:

```text
rettifica
```

```text
p_nuova_scorta NUMERIC DEFAULT NULL
```

---

# 5. Regole Parametri

La funzione deve validare rigorosamente i parametri ricevuti.

---

## Carico

```text
p_quantita obbligatorio

p_quantita > 0

p_nuova_scorta = NULL
```

---

## Vendita

```text
p_quantita obbligatorio

p_quantita > 0

p_nuova_scorta = NULL
```

---

## Reso

```text
p_quantita obbligatorio

p_quantita > 0

p_nuova_scorta = NULL
```

---

## Rettifica

```text
p_nuova_scorta obbligatorio

p_nuova_scorta >= 0

p_quantita = NULL
```

Qualsiasi combinazione diversa deve produrre errore.

---

# 6. Identificazione Azienda

La funzione NON deve ricevere:

```text
azienda_id
```

come parametro.

L'azienda deve essere individuata internamente.

Flusso:

```text
auth.uid()
↓
profili
↓
azienda_id
```

La funzione non deve fidarsi di alcun dato inviato dal client.

---

# 7. Verifiche Iniziali

La funzione deve verificare:

---

## Utente autenticato

```text
auth.uid() presente
```

---

## Profilo esistente

Deve esistere un record valido nella tabella:

```text
profili
```

---

## Azienda valida

L'utente deve appartenere ad una azienda esistente.

---

# 8. Lock del Prodotto

Prima di leggere la scorta corrente la funzione deve bloccare la riga del prodotto.

Obiettivo:

impedire race condition dovute ad operazioni concorrenti.

La lettura deve utilizzare:

```sql
SELECT ...
FOR UPDATE
```

sulla riga del prodotto.

Questo garantisce che due operazioni simultanee non possano alterare la stessa scorta contemporaneamente.

---

# 9. Verifica Prodotto

La funzione deve verificare:

```text
prodotto esistente
```

```text
prodotto appartenente all'azienda dell'utente
```

```text
prodotto attivo
```

In caso contrario:

```text
Prodotto non valido
```

---

# 10. Verifica Fornitore

Se viene fornito:

```text
p_fornitore_id
```

deve essere verificato che:

* esista;
* appartenga alla stessa azienda;
* sia attivo.

In caso contrario:

```text
Fornitore non valido
```

---

# 11. Regole Carico

Input:

```text
quantita > 0
```

Nuova scorta:

```text
scorta_attuale + quantita
```

Movimento:

```text
tipo_movimento = carico
```

---

# 12. Regole Vendita

Input:

```text
quantita > 0
```

Nuova scorta:

```text
scorta_attuale - quantita
```

Controllo obbligatorio:

```text
nuova_scorta >= 0
```

Se il controllo fallisce:

```text
Scorta insufficiente
```

---

# 13. Regole Reso

Il reso rappresenta:

```text
reso cliente
```

Nuova scorta:

```text
scorta_attuale + quantita
```

Movimento:

```text
tipo_movimento = reso
```

---

# 14. Regole Rettifica

Input:

```text
p_nuova_scorta
```

La funzione deve leggere:

```text
scorta_attuale
```

e calcolare:

```text
differenza =
p_nuova_scorta - scorta_attuale
```

---

## Rettifica nulla

Se:

```text
differenza = 0
```

la funzione deve rifiutare l'operazione.

Errore:

```text
La nuova scorta coincide con quella attuale
```

---

## Quantità registrata

Decisione architetturale confermata:

Le quantità vengono sempre salvate positive.

Pertanto:

```text
quantita = ABS(differenza)
```

---

### Esempio

```text
10 → 15

quantita = 5
```

---

### Esempio

```text
10 → 8

quantita = 2
```

---

La direzione della rettifica è determinata da:

```text
scorta_prima
scorta_dopo
```

come già stabilito nello schema database approvato.

---

# 15. Aggiornamento della Scorta

Per aggiornare:

```text
prodotti.scorta_attuale
```

la funzione deve abilitare temporaneamente il flag:

```text
app.allow_stock_update
```

utilizzando:

```sql
set_config(...)
```

all'interno della transazione.

Questo consente il superamento controllato del trigger di protezione.

---

# 16. Inserimento del Movimento

La funzione deve registrare:

```text
azienda_id

prodotto_id

fornitore_id

tipo_movimento

quantita

scorta_prima

scorta_dopo

prezzo_unitario

note

creato_da
```

nella tabella:

```text
movimenti_magazzino
```

---

# 17. Valore Restituito

La funzione deve restituire almeno:

```text
movimento_id

nuova_scorta

tipo_movimento
```

---

# 18. Gestione Errori

Errori previsti:

```text
Utente non autenticato
```

```text
Profilo non trovato
```

```text
Prodotto non trovato
```

```text
Prodotto disattivato
```

```text
Fornitore non valido
```

```text
Quantità non valida
```

```text
Nuova scorta non valida
```

```text
La nuova scorta coincide con quella attuale
```

```text
Scorta insufficiente
```

```text
Tipo movimento non valido
```

```text
Operazione non autorizzata
```

---

# 19. Sicurezza

La funzione deve essere creata utilizzando:

```text
SECURITY DEFINER
```

per poter operare sulle tabelle protette dalle RLS.

---

## Search Path Sicuro

La funzione deve impostare esplicitamente un:

```text
search_path
```

sicuro nella definizione SQL.

Obiettivo:

evitare attacchi derivanti dall'utilizzo di oggetti PostgreSQL non previsti.

Questa è una misura tecnica obbligatoria.

---

# 20. Atomicità

L'intera operazione deve essere atomica.

Se una qualsiasi fase fallisce:

```text
nessun movimento inserito
```

```text
nessuna scorta aggiornata
```

Il database deve tornare allo stato precedente.

---

# 21. Decisioni Architetturali Confermate

1. Nessun parametro azienda_id.
2. Azienda derivata da auth.uid().
3. SECURITY DEFINER obbligatorio.
4. Search path sicuro obbligatorio.
5. Lock pessimista con SELECT FOR UPDATE.
6. Rettifica tramite nuova scorta.
7. Quantità sempre positive.
8. Rettifica nulla vietata.
9. Scorte negative vietate.
10. Controllo prodotto attivo.
11. Controllo fornitore attivo.
12. Controllo appartenenza aziendale.
13. Movimenti immutabili.
14. Movimenti creati esclusivamente tramite RPC.
15. Aggiornamento scorta consentito solo tramite RPC.
16. Inserimento movimento e aggiornamento prodotto nella stessa transazione.

---

# Stato Documento

Stato: APPROVATO

Versione: 1.0.0

Data approvazione: 12 Giugno 2026

Documento validato tramite revisione congiunta:

* ChatGPT (coordinatore)
* Gemini
* DeepSeek

---

# Passo Successivo

Scrittura del file:

```text
docs/1-database/supabase/002_rpc.sql
```

contenente l'implementazione completa della funzione:

```text
registra_movimento()
```

Questo documento, per quanto mi riguarda, può essere considerato chiuso. Da qui in avanti non stiamo più progettando: stiamo iniziando a scrivere il vero backend eseguibile.
