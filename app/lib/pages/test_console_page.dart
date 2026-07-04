import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/test_backend_service.dart';

class TestConsolePage extends StatefulWidget {
  const TestConsolePage({super.key});

  @override
  State<TestConsolePage> createState() => _TestConsolePageState();
}

class _TestConsolePageState extends State<TestConsolePage> {
  final emailController = TextEditingController(text: 'testa@azienda.it');
  final passwordController = TextEditingController();

  late final TestBackendService service;

  String message = 'Inserisci la password e premi Accedi.';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    service = TestBackendService(Supabase.instance.client);
  }

  Future<void> runAction(
    String loadingMessage,
    Future<dynamic> Function() action,
    String successMessage,
  ) async {
    setState(() {
      loading = true;
      message = loadingMessage;
    });

    try {
      final result = await action();

      setState(() {
        message = '$successMessage Risultato: $result';
      });
    } catch (e) {
      setState(() {
        message = 'Errore: $e';
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> login() async {
    await runAction(
      'Accesso in corso...',
      () => service.login(
        email: emailController.text,
        password: passwordController.text,
      ),
      'Accesso riuscito.',
    );
  }

  Future<void> logout() async {
    await runAction(
      'Disconnessione in corso...',
      () => service.logout(),
      'Utente disconnesso.',
    );

    passwordController.clear();
  }

  void checkSession() {
    final email = service.currentUserEmail();

    setState(() {
      message = email == null
          ? 'Nessun utente autenticato.'
          : 'Sessione attiva. Utente: $email';
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentEmail = service.currentUserEmail();

    return Scaffold(
      appBar: AppBar(title: const Text('Console Test Backend')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Console test backend',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loading ? null : login,
              child: Text(loading ? 'Attendere...' : 'Accedi'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Onboarding in corso...',
                      service.runOnboarding,
                      'Onboarding completato.',
                    ),
              child: const Text('Esegui onboarding'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Onboarding Azienda B in corso...',
                      service.runOnboardingAziendaB,
                      'Onboarding Azienda B completato.',
                    ),
              child: const Text('Esegui onboarding Azienda B'),
            ),

            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Creazione categoria in corso...',
                      service.createCategoriaTest,
                      'Categoria creata correttamente.',
                    ),
              child: const Text('Crea categoria test'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Modifica categoria in corso...',
                      service.updateCategoriaTest,
                      'Categoria modificata correttamente.',
                    ),
              child: const Text('Modifica categoria test'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Creazione fornitore in corso...',
                      service.createFornitoreTest,
                      'Fornitore creato correttamente.',
                    ),
              child: const Text('Crea fornitore test'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Modifica fornitore in corso...',
                      service.updateFornitoreTest,
                      'Fornitore modificato correttamente.',
                    ),
              child: const Text('Modifica fornitore test'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Creazione prodotto in corso...',
                      service.createProdottoTest,
                      'Prodotto creato correttamente.',
                    ),
              child: const Text('Crea prodotto test'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Modifica prodotto in corso...',
                      service.updateProdottoTest,
                      'Prodotto modificato correttamente.',
                    ),
              child: const Text('Modifica prodotto test'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Carico magazzino in corso...',
                      service.registraCaricoTest,
                      'Carico registrato correttamente.',
                    ),
              child: const Text('Registra carico test'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Vendita magazzino in corso...',
                      service.registraVenditaTest,
                      'Vendita registrata correttamente.',
                    ),
              child: const Text('Registra vendita test'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Tentativo vendita con scorta insufficiente...',
                      service.registraVenditaScortaInsufficienteTest,
                      'Vendita registrata.',
                    ),
              child: const Text('Test vendita scorta insufficiente'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Rettifica positiva in corso...',
                      service.registraRettificaPositivaTest,
                      'Rettifica positiva registrata correttamente.',
                    ),
              child: const Text('Registra rettifica positiva test'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Rettifica negativa in corso...',
                      service.registraRettificaNegativaTest,
                      'Rettifica negativa registrata correttamente.',
                    ),
              child: const Text('Registra rettifica negativa test'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Rettifica nulla in corso...',
                      service.registraRettificaNullaTest,
                      'Rettifica nulla registrata.',
                    ),
              child: const Text('Test rettifica nulla'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Tentativo modifica diretta scorta...',
                      service.tentaUpdateDirettoScortaTest,
                      'Scorta modificata direttamente.',
                    ),
              child: const Text('Test protezione scorta'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Test lettura dati Azienda A in corso...',
                      service.tentaLetturaProdottoAziendaATest,
                      'Test isolamento lettura completato.',
                    ),
              child: const Text('Test isolamento lettura Azienda A'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Test scrittura dati Azienda A in corso...',
                      service.tentaScritturaProdottoAziendaATest,
                      'Test isolamento scrittura completato.',
                    ),
              child: const Text('Test isolamento scrittura Azienda A'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Test cancellazione categoria in corso...',
                      service.tentaCancellazioneCategoriaTest,
                      'Test cancellazione categoria completato.',
                    ),
              child: const Text('Test cancellazione categoria'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Test cancellazione fornitore in corso...',
                      service.tentaCancellazioneFornitoreTest,
                      'Test cancellazione fornitore completato.',
                    ),
              child: const Text('Test cancellazione fornitore'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () => runAction(
                      'Test cancellazione prodotto in corso...',
                      service.tentaCancellazioneProdottoTest,
                      'Test cancellazione prodotto completato.',
                    ),
              child: const Text('Test cancellazione prodotto'),
            ),

            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading ? null : checkSession,
              child: const Text('Controlla sessione'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: loading ? null : logout,
              child: const Text('Esci'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Messaggio:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message),
            const SizedBox(height: 24),
            Text(
              currentEmail == null
                  ? 'Nessun utente autenticato.'
                  : 'Sessione attiva: $currentEmail',
            ),
          ],
        ),
      ),
    );
  }
}
