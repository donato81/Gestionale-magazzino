import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/features/auth/data/profile_service.dart';
import 'package:app/features/auth/domain/auth_profile_check_result.dart';

class FakeProfileService implements ProfileService {
  final AuthProfileCheckResult Function(User user) onCheck;

  FakeProfileService({required this.onCheck});

  @override
  Future<AuthProfileCheckResult> checkProfileForUser(User user) async {
    return onCheck(user);
  }
}

void main() {
  group('ProfileService Interface Tests', () {
    test('FakeProfileService resolves correctly for missing profile', () async {
      final fakeUser = User(
        id: 'user_123',
        appMetadata: const {},
        userMetadata: const {},
        aud: 'aud',
        createdAt: 'createdAt',
      );

      final service = FakeProfileService(
        onCheck: (u) => AuthProfileCheckResult.missing(),
      );

      final result = await service.checkProfileForUser(fakeUser);
      expect(result.status, AuthProfileCheckStatus.missing);
      expect(result.profileId, isNull);
    });

    test('FakeProfileService resolves correctly for incomplete profile', () async {
      final fakeUser = User(
        id: 'user_123',
        appMetadata: const {},
        userMetadata: const {},
        aud: 'aud',
        createdAt: 'createdAt',
      );

      final service = FakeProfileService(
        onCheck: (u) => AuthProfileCheckResult.incomplete(profileId: 'prof_abc'),
      );

      final result = await service.checkProfileForUser(fakeUser);
      expect(result.status, AuthProfileCheckStatus.incomplete);
      expect(result.profileId, 'prof_abc');
    });

    test('FakeProfileService resolves correctly for complete profile', () async {
      final fakeUser = User(
        id: 'user_123',
        appMetadata: const {},
        userMetadata: const {},
        aud: 'aud',
        createdAt: 'createdAt',
      );

      final service = FakeProfileService(
        onCheck: (u) => AuthProfileCheckResult.complete(
          profileId: 'prof_abc',
          companyId: 'comp_xyz',
          companyName: 'Test Company',
        ),
      );

      final result = await service.checkProfileForUser(fakeUser);
      expect(result.status, AuthProfileCheckStatus.complete);
      expect(result.profileId, 'prof_abc');
      expect(result.companyId, 'comp_xyz');
      expect(result.companyName, 'Test Company');
    });
  });
}
