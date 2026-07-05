import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../messages/app_messages.dart';
import 'app_exception.dart';

class SupabaseErrorMapper {
  SupabaseErrorMapper._();

  static AppException map(Object error) {
    final technicalMessage = error.toString();

    // 1. Check Native Exception Type
    if (error is AuthException) {
      return _mapAuthException(error, technicalMessage);
    }

    if (error is PostgrestException) {
      return _mapPostgrestException(error, technicalMessage);
    }

    if (error is SocketException || error is HttpException) {
      return AppException(
        AppMessages.networkError,
        technicalMessage: technicalMessage,
      );
    }

    // 2. Check general string indicators for Network Errors/Timeout
    final errLower = technicalMessage.toLowerCase();
    if (errLower.contains('failed host lookup') ||
        errLower.contains('connection failed') ||
        errLower.contains('networkerror') ||
        errLower.contains('timeout') ||
        errLower.contains('socketexception') ||
        errLower.contains('httpexception') ||
        errLower.contains('clientexception') ||
        errLower.contains('network_error')) {
      return AppException(
        AppMessages.networkError,
        technicalMessage: technicalMessage,
      );
    }

    // Fallback to unknown generic error
    return AppException(
      AppMessages.genericError,
      technicalMessage: technicalMessage,
    );
  }

  static AppException _mapAuthException(AuthException error, String technicalMessage) {
    final message = error.message;
    final code = error.code;

    // Credentials wrong
    if (code == 'invalid_credentials' ||
        message.contains('Invalid login credentials') ||
        message.contains('Email o password non corrette')) {
      return AppException(
        AppMessages.invalidCredentials,
        technicalMessage: technicalMessage,
      );
    }

    // Session / Token expired
    if (code == 'session_expired' ||
        message.contains('session_expired') ||
        message.contains('JWT expired') ||
        message.contains('Token expired')) {
      return AppException(
        AppMessages.sessionExpired,
        technicalMessage: technicalMessage,
      );
    }

    // Session invalid / User not authenticated
    if (message.contains('session not found') ||
        message.contains('User not authenticated') ||
        message.contains('Sessione non valida')) {
      return AppException(
        AppMessages.invalidSession,
        technicalMessage: technicalMessage,
      );
    }

    // Generic Auth exception
    return AppException(
      AppMessages.genericError,
      technicalMessage: technicalMessage,
    );
  }

  static AppException _mapPostgrestException(PostgrestException error, String technicalMessage) {
    final code = error.code;
    final message = error.message;
    final details = error.details?.toString() ?? '';
    final hint = error.hint?.toString() ?? '';

    // 2 & 3. PostgreSQL Code based checks
    if (code == '23505') {
      // Unique violation
      if (message.contains('prodotti_barcode_unique_per_azienda') ||
          details.contains('prodotti_barcode_unique_per_azienda') ||
          hint.contains('prodotti_barcode_unique_per_azienda')) {
        return AppException(
          AppMessages.duplicateBarcode,
          technicalMessage: technicalMessage,
        );
      }
      return AppException(
        AppMessages.duplicateName,
        technicalMessage: technicalMessage,
      );
    }

    // RLS / Authorization Error
    if (code == '42501' ||
        message.contains('permission denied') ||
        message.contains('violates row-level security') ||
        details.contains('violates row-level security')) {
      return AppException(
        AppMessages.unauthorized,
        technicalMessage: technicalMessage,
      );
    }

    // 4. Exact match checks on backend messages (API Contracts)
    final trimmedMessage = message.trim();
    if (trimmedMessage == 'Scorta insufficiente') {
      return AppException(
        AppMessages.insufficientStock,
        technicalMessage: technicalMessage,
      );
    }
    if (trimmedMessage == 'Prodotto non trovato') {
      return AppException(
        AppMessages.productNotFound,
        technicalMessage: technicalMessage,
      );
    }
    if (trimmedMessage == 'Prodotto disattivato' ||
        trimmedMessage == 'Il prodotto selezionato è disattivato') {
      return AppException(
        AppMessages.productDeactivated,
        technicalMessage: technicalMessage,
      );
    }
    if (trimmedMessage == 'Fornitore non valido') {
      return AppException(
        AppMessages.invalidSupplier,
        technicalMessage: technicalMessage,
      );
    }
    if (trimmedMessage == 'Profilo già esistente' ||
        trimmedMessage == 'Il profilo risulta già creato. Ricarico i dati.') {
      return AppException(
        AppMessages.profileAlreadyCreated,
        technicalMessage: technicalMessage,
      );
    }
    if (trimmedMessage == 'Nome azienda obbligatorio') {
      return AppException(
        AppMessages.companyNameRequired,
        technicalMessage: technicalMessage,
      );
    }
    if (trimmedMessage == 'Quantità non valida' ||
        trimmedMessage == 'La quantità deve essere maggiore di zero') {
      return AppException(
        AppMessages.quantityMustBeGreaterThanZero,
        technicalMessage: technicalMessage,
      );
    }
    if (trimmedMessage == 'La nuova scorta coincide con quella attuale') {
      return AppException(
        AppMessages.newStockCoincides,
        technicalMessage: technicalMessage,
      );
    }

    // 5. Fallback contains checks
    if (message.contains('Scorta insufficiente')) {
      return AppException(
        AppMessages.insufficientStock,
        technicalMessage: technicalMessage,
      );
    }
    if (message.contains('Prodotto non trovato')) {
      return AppException(
        AppMessages.productNotFound,
        technicalMessage: technicalMessage,
      );
    }
    if (message.contains('Prodotto disattivato') ||
        message.contains('Il prodotto selezionato è disattivato')) {
      return AppException(
        AppMessages.productDeactivated,
        technicalMessage: technicalMessage,
      );
    }
    if (message.contains('Fornitore non valido')) {
      return AppException(
        AppMessages.invalidSupplier,
        technicalMessage: technicalMessage,
      );
    }
    if (message.contains('Profilo già esistente') ||
        message.contains('Il profilo risulta già creato. Ricarico i dati.')) {
      return AppException(
        AppMessages.profileAlreadyCreated,
        technicalMessage: technicalMessage,
      );
    }
    if (message.contains('Nome azienda obbligatorio')) {
      return AppException(
        AppMessages.companyNameRequired,
        technicalMessage: technicalMessage,
      );
    }
    if (message.contains('Quantità non valida') ||
        message.contains('La quantità deve essere maggiore di zero')) {
      return AppException(
        AppMessages.quantityMustBeGreaterThanZero,
        technicalMessage: technicalMessage,
      );
    }
    if (message.contains('La nuova scorta coincide con quella attuale')) {
      return AppException(
        AppMessages.newStockCoincides,
        technicalMessage: technicalMessage,
      );
    }

    // Generic Postgrest exception fallback
    return AppException(
      AppMessages.genericError,
      technicalMessage: technicalMessage,
    );
  }
}
