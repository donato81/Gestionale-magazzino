import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/auth/domain/auth_profile_check_result.dart';

void main() {
  group('AuthProfileCheckResult Tests', () {
    test('missing status contains no profile or company info', () {
      final result = AuthProfileCheckResult.missing();
      expect(result.status, AuthProfileCheckStatus.missing);
      expect(result.profileId, isNull);
      expect(result.companyId, isNull);
      expect(result.companyName, isNull);
    });

    test('incomplete status contains profileId but no company info', () {
      final result = AuthProfileCheckResult.incomplete(profileId: 'prof_123');
      expect(result.status, AuthProfileCheckStatus.incomplete);
      expect(result.profileId, 'prof_123');
      expect(result.companyId, isNull);
      expect(result.companyName, isNull);
    });

    test('complete status contains profileId, companyId and companyName', () {
      final result = AuthProfileCheckResult.complete(
        profileId: 'prof_123',
        companyId: 'comp_456',
        companyName: 'ACME Corp',
      );
      expect(result.status, AuthProfileCheckStatus.complete);
      expect(result.profileId, 'prof_123');
      expect(result.companyId, 'comp_456');
      expect(result.companyName, 'ACME Corp');
    });

    test('complete status throws exception if companyId is empty or blank', () {
      expect(
        () => AuthProfileCheckResult.complete(
          profileId: 'prof_123',
          companyId: '',
          companyName: 'ACME Corp',
        ),
        throwsArgumentError,
      );

      expect(
        () => AuthProfileCheckResult.complete(
          profileId: 'prof_123',
          companyId: '   ',
          companyName: 'ACME Corp',
        ),
        throwsArgumentError,
      );
    });

    test('complete status throws exception if companyName is empty or blank', () {
      expect(
        () => AuthProfileCheckResult.complete(
          profileId: 'prof_123',
          companyId: 'comp_456',
          companyName: '',
        ),
        throwsArgumentError,
      );

      expect(
        () => AuthProfileCheckResult.complete(
          profileId: 'prof_123',
          companyId: 'comp_456',
          companyName: '   ',
        ),
        throwsArgumentError,
      );
    });
  });
}
