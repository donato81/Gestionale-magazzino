import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/auth_profile_check_result.dart';

abstract class ProfileService {
  Future<AuthProfileCheckResult> checkProfileForUser(User user);
}

class SupabaseProfileService implements ProfileService {
  final SupabaseClient _supabaseClient;

  SupabaseProfileService(this._supabaseClient);

  @override
  Future<AuthProfileCheckResult> checkProfileForUser(User user) async {
    // 1. Fetch user profile from 'profili' table
    final profileResponse = await _supabaseClient
        .from('profili')
        .select('id, user_id, azienda_id')
        .eq('user_id', user.id)
        .maybeSingle();

    if (profileResponse == null) {
      return AuthProfileCheckResult.missing();
    }

    final profileId = profileResponse['id'] as String?;
    final companyId = profileResponse['azienda_id'] as String?;

    if (profileId == null || profileId.trim().isEmpty) {
      throw const PostgrestException(message: 'Profilo trovato ma senza ID valido');
    }

    if (companyId == null || companyId.trim().isEmpty) {
      return AuthProfileCheckResult.incomplete(profileId: profileId);
    }

    // 2. Fetch associated company from 'aziende' table
    // Under Supabase RLS, if read permission is denied, it may return null
    final companyResponse = await _supabaseClient
        .from('aziende')
        .select('id, nome')
        .eq('id', companyId)
        .maybeSingle();

    if (companyResponse == null) {
      // azienda_id was present in profile, but not found or not readable under RLS
      throw const PostgrestException(
        message: 'Azienda collegata al profilo non trovata o non leggibile per RLS',
      );
    }

    final companyName = companyResponse['nome'] as String?;
    if (companyName == null || companyName.trim().isEmpty) {
      throw const PostgrestException(
        message: 'Nome azienda mancante o vuoto',
      );
    }

    return AuthProfileCheckResult.complete(
      profileId: profileId,
      companyId: companyId,
      companyName: companyName,
    );
  }
}
