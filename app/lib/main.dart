import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/supabase_config.dart';
import 'pages/test_console_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.url,
    publishableKey: SupabaseConfig.anonKey,
  );

  runApp(const GestionaleMagazzinoApp());
}

class GestionaleMagazzinoApp extends StatelessWidget {
  const GestionaleMagazzinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Gestionale Magazzino',
      debugShowCheckedModeBanner: false,
      home: TestConsolePage(),
    );
  }
}

