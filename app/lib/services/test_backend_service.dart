import 'package:supabase_flutter/supabase_flutter.dart';

class TestBackendService {
  TestBackendService(this.supabase);

  final SupabaseClient supabase;

  Future<void> login({required String email, required String password}) async {
    await supabase.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  String? currentUserEmail() {
    return supabase.auth.currentUser?.email;
  }

  Future<dynamic> runOnboarding() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('Devi prima effettuare il login.');
    }

    return supabase.rpc(
      'crea_azienda_e_profilo',
      params: {
        'p_nome_azienda': 'Azienda Test',
        'p_nome_profilo': 'Mario Rossi',
        'p_email': user.email,
      },
    );
  }

  Future<String> getMyAziendaId() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('Utente non autenticato');
    }

    final profilo = await supabase
        .from('profili')
        .select('azienda_id')
        .eq('user_id', user.id)
        .single();

    final aziendaId = profilo['azienda_id'];

    if (aziendaId == null) {
      throw Exception('Azienda non trovata per il profilo corrente');
    }

    return aziendaId as String;
  }

  Future<dynamic> createCategoriaTest() async {
    final aziendaId = await getMyAziendaId();

    return supabase
        .from('categorie')
        .insert({
          'azienda_id': aziendaId,
          'nome': 'Concimi',
          'descrizione': 'Categoria test per concimi',
        })
        .select()
        .single();
  }

  Future<dynamic> updateCategoriaTest() async {
    final aziendaId = await getMyAziendaId();

    return supabase
        .from('categorie')
        .update({
          'nome': 'Concimi Professionali',
          'descrizione': 'Categoria test modificata',
        })
        .eq('azienda_id', aziendaId)
        .eq('nome', 'Concimi')
        .select()
        .single();
  }

  Future<dynamic> createFornitoreTest() async {
    final aziendaId = await getMyAziendaId();

    return supabase
        .from('fornitori')
        .insert({
          'azienda_id': aziendaId,
          'nome': 'Fornitore Test',
          'telefono': '0000000000',
          'email': 'fornitore@test.it',
          'note': 'Fornitore creato durante i test',
        })
        .select()
        .single();
  }

  Future<dynamic> updateFornitoreTest() async {
    final aziendaId = await getMyAziendaId();

    return supabase
        .from('fornitori')
        .update({
          'nome': 'Fornitore Test Modificato',
          'note': 'Fornitore modificato durante i test',
        })
        .eq('azienda_id', aziendaId)
        .eq('nome', 'Fornitore Test')
        .select()
        .single();
  }

  Future<String> getCategoriaTestId() async {
    final aziendaId = await getMyAziendaId();

    final categoria = await supabase
        .from('categorie')
        .select('id')
        .eq('azienda_id', aziendaId)
        .eq('nome', 'Concimi Professionali')
        .single();

    return categoria['id'] as String;
  }

  Future<String> getFornitoreTestId() async {
    final aziendaId = await getMyAziendaId();

    final fornitore = await supabase
        .from('fornitori')
        .select('id')
        .eq('azienda_id', aziendaId)
        .eq('nome', 'Fornitore Test Modificato')
        .single();

    return fornitore['id'] as String;
  }

  Future<dynamic> createProdottoTest() async {
    final aziendaId = await getMyAziendaId();
    final categoriaId = await getCategoriaTestId();
    final fornitoreId = await getFornitoreTestId();

    return supabase
        .from('prodotti')
        .insert({
          'azienda_id': aziendaId,
          'categoria_id': categoriaId,
          'fornitore_preferito_id': fornitoreId,
          'barcode': 'TEST-001',
          'nome': 'Concime Universale',
          'descrizione': 'Prodotto creato durante i test',
          'unita_misura': 'pz',
          'prezzo_acquisto': 5.50,
          'prezzo_vendita': 9.90,
          'aliquota_iva': 22.00,
          'scorta_minima': 2,
        })
        .select()
        .single();
  }

  Future<dynamic> updateProdottoTest() async {
    final aziendaId = await getMyAziendaId();

    return supabase
        .from('prodotti')
        .update({
          'nome': 'Concime Universale Modificato',
          'descrizione': 'Prodotto modificato durante i test',
          'prezzo_vendita': 10.90,
        })
        .eq('azienda_id', aziendaId)
        .eq('barcode', 'TEST-001')
        .select()
        .single();
  }

  Future<String> getProdottoTestId() async {
    final aziendaId = await getMyAziendaId();

    final prodotto = await supabase
        .from('prodotti')
        .select('id')
        .eq('azienda_id', aziendaId)
        .eq('barcode', 'TEST-001')
        .single();

    return prodotto['id'] as String;
  }

  Future<dynamic> registraCaricoTest() async {
    final prodottoId = await getProdottoTestId();
    final fornitoreId = await getFornitoreTestId();

    return supabase.rpc(
      'registra_movimento',
      params: {
        'p_prodotto_id': prodottoId,
        'p_tipo_movimento': 'carico',
        'p_quantita': 10,
        'p_nuova_scorta': null,
        'p_fornitore_id': fornitoreId,
        'p_prezzo_unitario': 5.50,
        'p_note': 'Carico test di 10 unità',
      },
    );
  }

  Future<dynamic> registraVenditaTest() async {
    final prodottoId = await getProdottoTestId();

    return supabase.rpc(
      'registra_movimento',
      params: {
        'p_prodotto_id': prodottoId,
        'p_tipo_movimento': 'vendita',
        'p_quantita': 3,
        'p_nuova_scorta': null,
        'p_fornitore_id': null,
        'p_prezzo_unitario': 10.90,
        'p_note': 'Vendita test di 3 unità',
      },
    );
  }

  Future<dynamic> registraVenditaScortaInsufficienteTest() async {
    final prodottoId = await getProdottoTestId();

    return supabase.rpc(
      'registra_movimento',
      params: {
        'p_prodotto_id': prodottoId,
        'p_tipo_movimento': 'vendita',
        'p_quantita': 100,
        'p_nuova_scorta': null,
        'p_fornitore_id': null,
        'p_prezzo_unitario': 10.90,
        'p_note': 'Tentativo vendita test con scorta insufficiente',
      },
    );
  }

  Future<dynamic> registraRettificaPositivaTest() async {
    final prodottoId = await getProdottoTestId();

    return supabase.rpc(
      'registra_movimento',
      params: {
        'p_prodotto_id': prodottoId,
        'p_tipo_movimento': 'rettifica',
        'p_quantita': null,
        'p_nuova_scorta': 20,
        'p_fornitore_id': null,
        'p_prezzo_unitario': null,
        'p_note': 'Rettifica positiva test a 20 unità',
      },
    );
  }

  Future<dynamic> registraRettificaNegativaTest() async {
    final prodottoId = await getProdottoTestId();

    return supabase.rpc(
      'registra_movimento',
      params: {
        'p_prodotto_id': prodottoId,
        'p_tipo_movimento': 'rettifica',
        'p_quantita': null,
        'p_nuova_scorta': 5,
        'p_fornitore_id': null,
        'p_prezzo_unitario': null,
        'p_note': 'Rettifica negativa test a 5 unità',
      },
    );
  }

  Future<dynamic> registraRettificaNullaTest() async {
    final prodottoId = await getProdottoTestId();

    return supabase.rpc(
      'registra_movimento',
      params: {
        'p_prodotto_id': prodottoId,
        'p_tipo_movimento': 'rettifica',
        'p_quantita': null,
        'p_nuova_scorta': 5,
        'p_fornitore_id': null,
        'p_prezzo_unitario': null,
        'p_note': 'Tentativo rettifica nulla test a 5 unità',
      },
    );
  }

  Future<dynamic> tentaUpdateDirettoScortaTest() async {
    final aziendaId = await getMyAziendaId();

    return supabase
        .from('prodotti')
        .update({'scorta_attuale': 999})
        .eq('azienda_id', aziendaId)
        .eq('barcode', 'TEST-001')
        .select()
        .single();
  }

  Future<dynamic> runOnboardingAziendaB() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('Devi prima effettuare il login.');
    }

    return supabase.rpc(
      'crea_azienda_e_profilo',
      params: {
        'p_nome_azienda': 'Azienda B',
        'p_nome_profilo': 'Utente B',
        'p_email': user.email,
      },
    );
  }

  Future<String> tentaLetturaProdottoAziendaATest() async {
    final aziendaId = await getMyAziendaId();

    final prodotto = await supabase
        .from('prodotti')
        .select('id, azienda_id, nome, barcode, scorta_attuale')
        .eq('barcode', 'TEST-001')
        .maybeSingle();

    if (prodotto == null) {
      await supabase.from('categorie').insert({
        'azienda_id': aziendaId,
        'nome': 'TEST 021 PASS LETTURA',
        'descrizione': 'Utente B non riesce a leggere prodotti di Azienda A',
      });

      return 'PASS: Utente B non legge prodotti di Azienda A.';
    }

    await supabase.from('categorie').insert({
      'azienda_id': aziendaId,
      'nome': 'TEST 021 FAIL LETTURA',
      'descrizione': 'Utente B riesce a leggere prodotti di Azienda A',
    });

    throw Exception(
      'FAIL: Utente B riesce a leggere un prodotto di Azienda A: $prodotto',
    );
  }

  Future<String> tentaScritturaProdottoAziendaATest() async {
    final aziendaId = await getMyAziendaId();

    final updateResult = await supabase
        .from('prodotti')
        .update({'nome': 'ERRORE MODIFICA DA UTENTE B'})
        .eq('barcode', 'TEST-001')
        .select();

    final deleteResult = await supabase
        .from('prodotti')
        .delete()
        .eq('barcode', 'TEST-001')
        .select();

    final updateBloccato = updateResult.isEmpty;
    final deleteBloccato = deleteResult.isEmpty;

    if (updateBloccato && deleteBloccato) {
      await supabase.from('categorie').insert({
        'azienda_id': aziendaId,
        'nome': 'TEST 022 PASS SCRITTURA',
        'descrizione':
            'Utente B non riesce a modificare o cancellare prodotti di Azienda A',
      });

      return 'PASS: Utente B non può scrivere su prodotti di Azienda A.';
    }

    await supabase.from('categorie').insert({
      'azienda_id': aziendaId,
      'nome': 'TEST 022 FAIL SCRITTURA',
      'descrizione':
          'Utente B è riuscito a modificare o cancellare prodotti di Azienda A',
    });

    throw Exception(
      'FAIL: updateResult=$updateResult deleteResult=$deleteResult',
    );
  }

  Future<String> tentaCancellazioneCategoriaTest() async {
    final aziendaId = await getMyAziendaId();

    final categoriaCreata = await supabase
        .from('categorie')
        .insert({
          'azienda_id': aziendaId,
          'nome': 'TEST 023 CATEGORIA DA NON CANCELLARE',
          'descrizione': 'Categoria temporanea per test cancellazione',
        })
        .select('id, nome')
        .single();

    final categoriaId = categoriaCreata['id'] as String;

    List<dynamic> deleteResult;

    try {
      deleteResult = await supabase
          .from('categorie')
          .delete()
          .eq('id', categoriaId)
          .select();
    } catch (e) {
      await supabase.from('categorie').insert({
        'azienda_id': aziendaId,
        'nome': 'TEST 023 PASS CANCELLAZIONE CATEGORIA',
        'descrizione': 'Cancellazione categoria bloccata correttamente: $e',
      });

      return 'PASS: cancellazione categoria bloccata correttamente.';
    }

    final categoriaAncoraPresente = await supabase
        .from('categorie')
        .select('id, nome')
        .eq('id', categoriaId)
        .maybeSingle();

    if (deleteResult.isEmpty && categoriaAncoraPresente != null) {
      await supabase.from('categorie').insert({
        'azienda_id': aziendaId,
        'nome': 'TEST 023 PASS CANCELLAZIONE CATEGORIA',
        'descrizione': 'Cancellazione categoria non eseguita.',
      });

      return 'PASS: categoria ancora presente, cancellazione non eseguita.';
    }

    await supabase.from('categorie').insert({
      'azienda_id': aziendaId,
      'nome': 'TEST 023 FAIL CANCELLAZIONE CATEGORIA',
      'descrizione': 'La categoria è stata cancellata da utente normale.',
    });

    throw Exception(
      'FAIL: la categoria è stata cancellata. deleteResult=$deleteResult',
    );
  }

  Future<String> tentaCancellazioneFornitoreTest() async {
    final aziendaId = await getMyAziendaId();
    final codiceTest = DateTime.now().millisecondsSinceEpoch.toString();

    final fornitoreCreato = await supabase
        .from('fornitori')
        .insert({
          'azienda_id': aziendaId,
          'nome': 'TEST 024 FORNITORE DA NON CANCELLARE $codiceTest',
          'telefono': '0000000000',
          'email': 'test024${codiceTest}@test.it',
          'note': 'Fornitore temporaneo per test cancellazione',
        })
        .select('id, nome')
        .single();

    final fornitoreId = fornitoreCreato['id'] as String;

    List<dynamic> deleteResult;

    try {
      deleteResult = await supabase
          .from('fornitori')
          .delete()
          .eq('id', fornitoreId)
          .select();
    } catch (e) {
      await supabase.from('categorie').insert({
        'azienda_id': aziendaId,
        'nome': 'TEST 024 PASS CANCELLAZIONE FORNITORE',
        'descrizione': 'Cancellazione fornitore bloccata correttamente: $e',
      });

      return 'PASS: cancellazione fornitore bloccata correttamente.';
    }

    final fornitoreAncoraPresente = await supabase
        .from('fornitori')
        .select('id, nome')
        .eq('id', fornitoreId)
        .maybeSingle();

    if (deleteResult.isEmpty && fornitoreAncoraPresente != null) {
      await supabase.from('categorie').insert({
        'azienda_id': aziendaId,
        'nome': 'TEST 024 PASS CANCELLAZIONE FORNITORE',
        'descrizione': 'Cancellazione fornitore non eseguita.',
      });

      return 'PASS: fornitore ancora presente, cancellazione non eseguita.';
    }

    await supabase.from('categorie').insert({
      'azienda_id': aziendaId,
      'nome': 'TEST 024 FAIL CANCELLAZIONE FORNITORE',
      'descrizione': 'Il fornitore è stato cancellato da utente normale.',
    });

    throw Exception(
      'FAIL: il fornitore è stato cancellato. deleteResult=$deleteResult',
    );
  }

  Future<String> tentaCancellazioneProdottoTest() async {
    final aziendaId = await getMyAziendaId();
    final codiceTest = DateTime.now().millisecondsSinceEpoch.toString();

    final categoriaCreata = await supabase
        .from('categorie')
        .insert({
          'azienda_id': aziendaId,
          'nome': 'TEST 025 CATEGORIA TEMP ${codiceTest}',
          'descrizione': 'Categoria temporanea per test cancellazione prodotto',
        })
        .select('id, nome')
        .single();

    final categoriaId = categoriaCreata['id'] as String;

    final fornitoreCreato = await supabase
        .from('fornitori')
        .insert({
          'azienda_id': aziendaId,
          'nome': 'TEST 025 FORNITORE TEMP ${codiceTest}',
          'telefono': '0000000000',
          'email': 'test025${codiceTest}@test.it',
          'note': 'Fornitore temporaneo per test cancellazione prodotto',
        })
        .select('id, nome')
        .single();

    final fornitoreId = fornitoreCreato['id'] as String;
    final barcodeTest = 'TEST-025-${codiceTest}';

    final prodottoCreato = await supabase
        .from('prodotti')
        .insert({
          'azienda_id': aziendaId,
          'categoria_id': categoriaId,
          'fornitore_preferito_id': fornitoreId,
          'barcode': barcodeTest,
          'nome': 'TEST 025 PRODOTTO DA NON CANCELLARE',
          'descrizione': 'Prodotto temporaneo per test cancellazione',
          'unita_misura': 'pz',
          'prezzo_acquisto': 1.00,
          'prezzo_vendita': 2.00,
          'aliquota_iva': 22.00,
          'scorta_minima': 0,
        })
        .select('id, nome, barcode')
        .single();

    final prodottoId = prodottoCreato['id'] as String;

    List<dynamic> deleteResult;

    try {
      deleteResult = await supabase
          .from('prodotti')
          .delete()
          .eq('id', prodottoId)
          .select();
    } catch (e) {
      await supabase.from('categorie').insert({
        'azienda_id': aziendaId,
        'nome': 'TEST 025 PASS CANCELLAZIONE PRODOTTO',
        'descrizione': 'Cancellazione prodotto bloccata correttamente: ${e}',
      });

      return 'PASS: cancellazione prodotto bloccata correttamente.';
    }

    final prodottoAncoraPresente = await supabase
        .from('prodotti')
        .select('id, nome, barcode')
        .eq('id', prodottoId)
        .maybeSingle();

    if (deleteResult.isEmpty && prodottoAncoraPresente != null) {
      await supabase.from('categorie').insert({
        'azienda_id': aziendaId,
        'nome': 'TEST 025 PASS CANCELLAZIONE PRODOTTO',
        'descrizione': 'Cancellazione prodotto non eseguita.',
      });

      return 'PASS: prodotto ancora presente, cancellazione non eseguita.';
    }

    await supabase.from('categorie').insert({
      'azienda_id': aziendaId,
      'nome': 'TEST 025 FAIL CANCELLAZIONE PRODOTTO',
      'descrizione': 'Il prodotto è stato cancellato da utente normale.',
    });

    throw Exception(
      'FAIL: il prodotto è stato cancellato. deleteResult=${deleteResult}',
    );
  }
}
