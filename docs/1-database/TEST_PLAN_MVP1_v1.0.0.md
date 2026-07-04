docs/1-database/TEST_PLAN_MVP1_v1.0.0.md
```
```text

# TEST PLAN MVP 1.0

## Gestionale Magazzino Universale

Versione: 1.0.0

Stato: APPROVATO

Scopo: validazione completa del backend Supabase prima dell'inizio dello sviluppo Flutter.

---

# 1. Obiettivo

Verificare che:

* database;
* RLS;
* RPC;
* onboarding;
* movimenti di magazzino;
* isolamento multi-tenant;

funzionino correttamente in un ambiente reale.

Il completamento con esito positivo di questo piano di test costituisce il via libera per l'avvio dello sviluppo Flutter.

---

# 2. Prerequisiti

Devono essere già eseguiti senza errori:

```text
001_schema.sql
002_rpc.sql
003_rls.sql
004_onboarding_rpc.sql
```

Devono inoltre essere disponibili:

```text
Progetto Supabase attivo
Utente di test
Accesso a Supabase Studio
```

---

# 3. Regole di Esecuzione

Durante i test:

* eseguire un test alla volta;
* annotare eventuali errori;
* non modificare manualmente il database per aggirare problemi;
* in caso di errore fermarsi e analizzare la causa.

---

# 4. Regola Fondamentale sui Test RLS

Tutti i test relativi a:

* onboarding;
* RLS;
* RPC;
* multi-tenant;

devono essere eseguiti come:

```text
utente autenticato normale
```

e NON come:

```text
service_role
amministratore Supabase
owner del database
```

altrimenti le RLS non vengono realmente testate.

---

# 5. TEST 001 — Creazione Utente

## Obiettivo

Verificare Supabase Auth.

## Procedura

Creare:

```text
test@azienda.it
```

## Risultato Atteso

Utente presente in:

```text
Authentication
Users
```

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 6. TEST 002 — Onboarding Completo

## Obiettivo

Verificare:

```text
crea_azienda_e_profilo()
```

## Procedura

Autenticarsi come:

```text
test@azienda.it
```

Invocare la RPC.

Parametri:

```text
Azienda Test
Mario Rossi
test@azienda.it
```

## Risultato Atteso

Restituzione di:

```text
azienda_id
profilo_id
nome_azienda
```

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 7. TEST 003 — Onboarding Duplicato

## Obiettivo

Verificare il blocco del secondo onboarding.

## Procedura

Invocare nuovamente:

```text
crea_azienda_e_profilo()
```

con lo stesso utente.

## Risultato Atteso

Errore:

```text
Profilo già esistente
```

Nessuna nuova azienda.

Nessun nuovo profilo.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 8. TEST 004 — Verifica Azienda

## Obiettivo

Verificare la creazione azienda.

## Risultato Atteso

Presenza di:

```text
1 record
```

con:

```text
nome = Azienda Test
```

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 9. TEST 005 — Verifica Profilo

## Obiettivo

Verificare la creazione profilo.

## Risultato Atteso

Presenza di:

```text
user_id corretto
azienda_id corretto
```

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 10. TEST 006 — Creazione Categoria

## Procedura

Creare:

```text
Concimi
```

## Risultato Atteso

Categoria salvata.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 11. TEST 007 — Modifica Categoria

## Procedura

Rinominare:

```text
Concimi
```

in:

```text
Concimi Professionali
```

## Risultato Atteso

Modifica salvata.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 12. TEST 008 — Creazione Fornitore

## Procedura

Creare:

```text
Fornitore Test
```

## Risultato Atteso

Fornitore salvato.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 13. TEST 009 — Modifica Fornitore

## Procedura

Modificare il nome.

## Risultato Atteso

Modifica salvata.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 14. TEST 010 — Creazione Prodotto

## Procedura

Creare:

```text
Concime Universale
```

Scorta:

```text
0
```

## Risultato Atteso

Prodotto creato.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 15. TEST 011 — Modifica Prodotto

## Procedura

Modificare il nome prodotto.

## Risultato Atteso

Modifica salvata.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 16. TEST 012 — Carico Magazzino

## Procedura

Caricare:

```text
10
```

unità.

## Risultato Atteso

Scorta:

```text
10
```

Movimento registrato.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 17. TEST 013 — Vendita

## Procedura

Vendere:

```text
3
```

unità.

## Risultato Atteso

Scorta:

```text
7
```

Movimento registrato.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 18. TEST 014 — Vendita con Scorta Insufficiente

## Procedura

Tentare vendita:

```text
100
```

unità.

## Risultato Atteso

Errore:

```text
Scorta insufficiente
```

Scorta invariata:

```text
7
```

Nessun nuovo movimento.

## Esito

```text
[ ] PASS*
Nota: backend corretto. Messaggio di errore non intercettato chiaramente da NVDA/app, ma scorta e movimenti confermano il blocco.
[ ] FAIL
```

---

# 19. TEST 015 — Rettifica Positiva

## Procedura

Impostare:

```text
20
```

## Risultato Atteso

Scorta:

```text
20
```

## Esito

```text
[ ] PASS*
Nota: messaggio app non letto/visibile, ma DB corretto.
[ ] FAIL
```

---

# 20. TEST 016 — Rettifica Negativa

## Procedura

Impostare:

```text
5
```

## Risultato Atteso

Scorta:

```text
5
```

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 21. TEST 017 — Rettifica Nulla

## Prerequisito

Il TEST 016 deve essere passato.

## Procedura

Impostare nuovamente:

```text
5
```

## Risultato Atteso

Errore:

```text
La nuova scorta coincide con quella attuale
```

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 22. TEST 018 — Immutabilità Movimenti (UPDATE)

## Procedura

Tentare UPDATE.

## Risultato Atteso

Operazione bloccata.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 23. TEST 019 — Immutabilità Movimenti (DELETE)

## Procedura

Tentare DELETE.

## Risultato Atteso

Operazione bloccata.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 24. TEST 020 — Protezione Scorta (UPDATE)

## Procedura

Tentare:

```sql
UPDATE prodotti
SET scorta_attuale = 999;
```

come utente autenticato normale.

## Risultato Atteso

Operazione bloccata.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 25. TEST 021 — Isolamento Multi-Tenant (LETTURA)

## Procedura

Creare:

```text
Utente B
Azienda B
```

Tentare di leggere dati Azienda A.

## Risultato Atteso

Accesso negato.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 26. TEST 022 — Isolamento Multi-Tenant (SCRITTURA)

## Procedura

Come Utente B tentare:

```text
INSERT
UPDATE
DELETE
```

su record appartenenti ad Azienda A.

## Risultato Atteso

Tutte le operazioni bloccate dalle RLS.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 27. TEST 023 — Cancellazione Categoria

## Procedura

Tentare DELETE.

## Risultato Atteso

Operazione bloccata oppure gestione conforme alle regole definite.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 28. TEST 024 — Cancellazione Fornitore

## Procedura

Tentare DELETE.

## Risultato Atteso

Operazione bloccata oppure gestione conforme alle regole definite.

## Esito

```text
[ ] PASS*
[ ] FAIL
```

---

# 29. TEST 025 — Cancellazione Prodotto

## Procedura

Tentare DELETE.

## Risultato Atteso

Operazione bloccata oppure gestione conforme alle regole definite.

## Esito

```text
[ ] PASS
[ ] FAIL
```

---

# 30. Criterio di Accettazione Finale

Il backend MVP 1.0 è approvato se:

```text
Tutti i test PASS
```

oppure:

```text
FAIL corretti
?
ritestati
?
PASS
```

---

# Stato Documento

APPROVATO

Esito finale: APPROVATO
Data collaudo: 14 giugno 2026
Risultato: tutti i test previsti sono stati superati
Note: alcuni messaggi dell’app test non erano leggibili chiaramente da NVDA, ma la validazione backend è stata confermata tramite Supabase.

Documento ufficiale di collaudo del backend MVP 1.0 prima dell'avvio dello sviluppo Flutter.

Una volta eseguiti questi test e corretti eventuali problemi emersi, il backend potrà essere considerato realmente validato e potremo passare alla fase Flutter con molta più tranquillità.
