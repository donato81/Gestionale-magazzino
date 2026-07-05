import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/core/errors/supabase_error_mapper.dart';
import 'package:app/core/messages/app_messages.dart';

void main() {
  group('SupabaseErrorMapper Tests', () {
    test('Unrecognized / generic error maps to generic error message and preserves technical message', () {
      final genericError = Exception('Some unknown database error');
      final appEx = SupabaseErrorMapper.map(genericError);

      expect(appEx.message, AppMessages.genericError);
      expect(appEx.technicalMessage, contains('Some unknown database error'));
    });

    test('AuthException with invalid credentials maps to correct message', () {
      final authEx = const AuthException('Invalid login credentials', statusCode: '400', code: 'invalid_credentials');
      final appEx = SupabaseErrorMapper.map(authEx);

      expect(appEx.message, AppMessages.invalidCredentials);
      expect(appEx.technicalMessage, contains('Invalid login credentials'));
    });

    test('AuthException with expired session maps to correct message', () {
      final authEx = const AuthException('JWT expired', statusCode: '401', code: 'session_expired');
      final appEx = SupabaseErrorMapper.map(authEx);

      expect(appEx.message, AppMessages.sessionExpired);
    });

    test('AuthException with invalid session/user not authenticated maps to correct message', () {
      final authEx = const AuthException('session not found', statusCode: '401');
      final appEx = SupabaseErrorMapper.map(authEx);

      expect(appEx.message, AppMessages.invalidSession);
    });

    test('PostgrestException for duplicate barcode with constraint recognized maps to correct message', () {
      final postEx = const PostgrestException(
        message: 'duplicate key value violates unique constraint',
        code: '23505',
        details: 'Key (barcode)=(12345) already exists. Constraint: prodotti_barcode_unique_per_azienda',
      );
      final appEx = SupabaseErrorMapper.map(postEx);

      expect(appEx.message, AppMessages.duplicateBarcode);
    });

    test('PostgrestException for unique violation with unknown constraint maps to duplicate name message', () {
      final postEx = const PostgrestException(
        message: 'duplicate key value violates unique constraint',
        code: '23505',
        details: 'Key (nome)=(Test) already exists.',
      );
      final appEx = SupabaseErrorMapper.map(postEx);

      expect(appEx.message, AppMessages.duplicateName);
    });

    test('PostgrestException for permission denied / RLS violation maps to unauthorized message', () {
      final postEx = const PostgrestException(
        message: 'permission denied for table prodotti',
        code: '42501',
      );
      final appEx = SupabaseErrorMapper.map(postEx);

      expect(appEx.message, AppMessages.unauthorized);
    });

    test('PostgrestException for violates row-level security maps to unauthorized message', () {
      final postEx = const PostgrestException(
        message: 'new row violates row-level security policy for table prodotti',
      );
      final appEx = SupabaseErrorMapper.map(postEx);

      expect(appEx.message, AppMessages.unauthorized);
    });

    test('PostgrestException for Scorta insufficiente maps to correct message', () {
      final postEx = const PostgrestException(message: 'Scorta insufficiente');
      final appEx = SupabaseErrorMapper.map(postEx);

      expect(appEx.message, AppMessages.insufficientStock);
    });

    test('PostgrestException for Prodotto non trovato maps to correct message', () {
      final postEx = const PostgrestException(message: 'Prodotto non trovato');
      final appEx = SupabaseErrorMapper.map(postEx);

      expect(appEx.message, AppMessages.productNotFound);
    });

    test('PostgrestException for Fornitore non valido maps to correct message', () {
      final postEx = const PostgrestException(message: 'Fornitore non valido');
      final appEx = SupabaseErrorMapper.map(postEx);

      expect(appEx.message, AppMessages.invalidSupplier);
    });

    test('PostgrestException for Profilo già esistente maps to correct message', () {
      final postEx = const PostgrestException(message: 'Profilo già esistente');
      final appEx = SupabaseErrorMapper.map(postEx);

      expect(appEx.message, AppMessages.profileAlreadyCreated);
    });

    test('PostgrestException for Quantità non valida maps to correct message', () {
      final postEx = const PostgrestException(message: 'Quantità non valida');
      final appEx = SupabaseErrorMapper.map(postEx);

      expect(appEx.message, AppMessages.quantityMustBeGreaterThanZero);
    });

    test('PostgrestException for La nuova scorta coincide con quella attuale maps to correct message', () {
      final postEx = const PostgrestException(message: 'La nuova scorta coincide con quella attuale');
      final appEx = SupabaseErrorMapper.map(postEx);

      expect(appEx.message, AppMessages.newStockCoincides);
    });

    test('SocketException maps to connection absent message', () {
      final socketEx = const SocketException('Failed host lookup');
      final appEx = SupabaseErrorMapper.map(socketEx);

      expect(appEx.message, AppMessages.networkError);
    });

    test('Generic Network Error by string matching maps to connection absent message', () {
      final customErr = Exception('Connection failed or timeout occurred');
      final appEx = SupabaseErrorMapper.map(customErr);

      expect(appEx.message, AppMessages.networkError);
    });
  });
}
