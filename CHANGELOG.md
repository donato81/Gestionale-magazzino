\# CHANGELOG



\## Gestionale Magazzino Universale



Questo file tiene traccia delle modifiche importanti del progetto.



Il changelog documenta l'evoluzione del progetto, mentre la versione tecnica dell'app Flutter viene mantenuta nel file:



```text

app/pubspec.yaml

````



Formato consigliato:



```text

MAJOR.MINOR.PATCH

```



Regola generale:



\* MAJOR: cambiamenti grandi o incompatibili.

\* MINOR: nuove funzionalità o nuove fasi completate.

\* PATCH: correzioni, rifiniture, piccoli miglioramenti.



\---



\## \[0.1.0] - 2026-07-04



\### Aggiunto



\* Creato repository GitHub del progetto.

\* Spostate le cartelle ufficiali `app/` e `docs/` dentro la root del repository.

\* Aggiunta documentazione progettuale MVP 1.0.

\* Salvato documento Flutter Plan approvato in `docs/4-flutter/001-FLUTTER\_PLAN\_mvp1\_v1.0.0.md`.

\* Definita strategia Flutter: prima core Dart minimo, poi schermate.

\* Confermate regole fondamentali:



&#x20; \* nessuna stringa utente hardcoded sparsa;

&#x20; \* sistema centralizzato messaggi;

&#x20; \* sistema centralizzato errori;

&#x20; \* feedback persistente;

&#x20; \* accessibilità non rimandata;

&#x20; \* backend Supabase come fonte della verità;

&#x20; \* movimenti sempre tramite RPC;

&#x20; \* nessuna modifica diretta della scorta.



\### Modificato



\* Riorganizzata la struttura locale del progetto per allinearla al repository GitHub.



\### Note



\* La cartella personale `lavoro-consiglio-ai/` non fa parte del repository.

\* Il primo commit è stato eseguito dopo lo spostamento di `app/` e `docs/`.

\* Il prossimo passo tecnico sarà la creazione del core Dart minimo.





