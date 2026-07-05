# CHANGELOG

## Gestionale Magazzino Universale

Questo file tiene traccia delle modifiche importanti del progetto.
Il changelog documenta l'evoluzione del progetto, mentre la versione tecnica dell'app Flutter viene mantenuta nel file:

```text
app/pubspec.yaml
```

Formato consigliato:

```text
MAJOR.MINOR.PATCH
```

Regola generale:

* MAJOR: cambiamenti grandi o incompatibili.
* MINOR: nuove funzionalità o nuove fasi completate.
* PATCH: correzioni, rifiniture, piccoli miglioramenti.

---

## [0.2.0] - 2026-07-05

### Aggiunto

* Aggiunto README principale del repository.
* Aggiunto README della cartella `docs/`.
* Aggiunto todo master Flutter in `docs/4-flutter/3-todos/000-todo-master.md`.
* Aggiunto design core Flutter approvato in `docs/4-flutter/1-design/001-DESIGN_CORE_mvp1_v1.0.0.md`.
* Aggiunto coding plan core Flutter approvato in `docs/4-flutter/2-coding-plans/001-CODING_PLAN_CORE_mvp1_v1.0.0.md`.
* Aggiunto TODO core Flutter approvato in `docs/4-flutter/3-todos/001-TODO_CORE_mvp1_v1.0.0.md`.
* Definiti gli otto file di produzione previsti per il core Dart minimo:

  * `lib/core/messages/app_messages.dart`;
  * `lib/core/errors/app_exception.dart`;
  * `lib/core/errors/supabase_error_mapper.dart`;
  * `lib/core/feedback/app_feedback_message.dart`;
  * `lib/core/feedback/app_feedback_controller.dart`;
  * `lib/core/accessibility/accessibility_service.dart`;
  * `lib/core/session/app_session_state.dart`;
  * `lib/core/session/app_session_controller.dart`.
* Definiti i quattro file di test automatici obbligatori previsti per il core Dart minimo:

  * `test/core/errors/supabase_error_mapper_test.dart`;
  * `test/core/feedback/app_feedback_controller_test.dart`;
  * `test/core/session/app_session_controller_test.dart`;
  * `test/core/accessibility/accessibility_service_test.dart`.
* Definita la regola secondo cui il blocco core non può essere considerato completato senza `flutter analyze` e `flutter test` entrambi con esito positivo.
* Definita la strategia dei test automatici minimi obbligatori per evitare debito di test nelle fasi successive.
* Definita la regola per cui il core Dart minimo non deve anticipare schermate complete, login reale, onboarding reale o servizi Supabase verticali.

### Modificato

* Aggiornato il todo master Flutter per segnare come completata la preparazione operativa del blocco 001 Core Flutter.
* Aggiornato il todo master Flutter per segnare il blocco Core Dart minimo come fase in corso.
* Aggiornata la regola generale di lavoro Flutter: design, coding plan, todo specifico, codice, test automatici, test manuali quando previsti, correzioni, changelog, commit e push.
* Rafforzata la regola di accessibilità permanente: l'accessibilità deve essere integrata fin dall'inizio e non rimandata alla fine.
* Rafforzata la regola backend fonte della verità: Flutter non modifica direttamente la scorta, non inserisce movimenti direttamente e non bypassa le RLS.
* Pulita e aggiornata la documentazione di orientamento prima della codifica del core.

### Note

* La preparazione documentale del blocco 001 Core Flutter è completata.
* Il prossimo passo tecnico sarà la codifica del core Dart minimo.
* La codifica dovrà seguire i documenti approvati:

  * `docs/4-flutter/1-design/001-DESIGN_CORE_mvp1_v1.0.0.md`;
  * `docs/4-flutter/2-coding-plans/001-CODING_PLAN_CORE_mvp1_v1.0.0.md`;
  * `docs/4-flutter/3-todos/001-TODO_CORE_mvp1_v1.0.0.md`.
* Il blocco core dovrà creare otto file di produzione e quattro file di test automatici obbligatori.
* Il blocco core non dovrà creare schermate complete.

## [0.1.0] - 2026-07-04

### Aggiunto

* Creato repository GitHub del progetto.
* Spostate le cartelle ufficiali `app/` e `docs/` dentro la root del repository.
* Aggiunta documentazione progettuale MVP 1.0.
* Salvato documento Flutter Plan approvato in `docs/4-flutter/001-FLUTTER_PLAN_mvp1_v1.0.0.md`.
* Definita strategia Flutter: prima core Dart minimo, poi schermate.
* Confermate regole fondamentali:

  * nessuna stringa utente hardcoded sparsa;
  * sistema centralizzato messaggi;
  * sistema centralizzato errori;
  * feedback persistente;
  * accessibilità non rimandata;
  * backend Supabase come fonte della verità;
  * movimenti sempre tramite RPC;
  * nessuna modifica diretta della scorta.

### Modificato

* Riorganizzata la struttura locale del progetto per allinearla al repository GitHub.

### Note

* La cartella personale `lavoro-consiglio-ai/` non fa parte del repository.
* Il primo commit è stato eseguito dopo lo spostamento di `app/` e `docs/`.
* Il prossimo passo tecnico sarà la creazione del core Dart minimo.
