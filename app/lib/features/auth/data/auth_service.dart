import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthService {
  User? get currentUser;
  Stream<AuthState> get authStateChanges;
  Future<User> signInWithPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
}

class SupabaseAuthService implements AuthService {
  final SupabaseClient _supabaseClient;

  SupabaseAuthService(this._supabaseClient);

  @override
  User? get currentUser => _supabaseClient.auth.currentUser;

  @override
  Stream<AuthState> get authStateChanges => _supabaseClient.auth.onAuthStateChange;

  @override
  Future<User> signInWithPassword({
    required String email,
    required String password,
  }) async {
    final response = await _supabaseClient.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );
    final user = response.user;
    if (user == null) {
      throw const AuthException('No user returned after successful sign in');
    }
    return user;
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
}
