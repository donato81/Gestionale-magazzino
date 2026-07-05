import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/core/session/app_session_state.dart';
import 'package:app/core/session/app_session_controller.dart';

void main() {
  group('AppSessionController Tests', () {
    late AppSessionController controller;
    late User dummyUser;

    setUp(() {
      controller = AppSessionController();
      dummyUser = User(
        id: 'test-user-id',
        appMetadata: const {},
        userMetadata: const {},
        aud: 'authenticated',
        createdAt: DateTime.now().toIso8601String(),
        email: 'test@example.com',
      );
    });

    tearDown(() {
      controller.dispose();
    });

    test('Initial state status should be unknown', () {
      expect(controller.value.status, AppSessionStatus.unknown);
      expect(controller.value.user, isNull);
      expect(controller.value.profileId, isNull);
      expect(controller.value.companyId, isNull);
      expect(controller.value.companyName, isNull);
    });

    test('Transitions to unauthenticated correctly', () {
      controller.setUnauthenticated();
      expect(controller.value.status, AppSessionStatus.unauthenticated);
      expect(controller.value.user, isNull);
      expect(controller.value.profileId, isNull);
      expect(controller.value.companyId, isNull);
      expect(controller.value.companyName, isNull);
    });

    test('Transitions to authenticatedWithoutProfile correctly', () {
      controller.setAuthenticatedWithoutProfile(user: dummyUser);
      expect(controller.value.status, AppSessionStatus.authenticatedWithoutProfile);
      expect(controller.value.user, dummyUser);
      expect(controller.value.profileId, isNull);
      expect(controller.value.companyId, isNull);
      expect(controller.value.companyName, isNull);
    });

    test('Transitions to authenticatedWithProfile correctly and retains company data', () {
      controller.setAuthenticatedWithProfile(
        user: dummyUser,
        profileId: 'profile-123',
        companyId: 'company-456',
        companyName: 'ACME Corp',
      );

      expect(controller.value.status, AppSessionStatus.authenticatedWithProfile);
      expect(controller.value.user, dummyUser);
      expect(controller.value.profileId, 'profile-123');
      expect(controller.value.companyId, 'company-456');
      expect(controller.value.companyName, 'ACME Corp');
    });

    test('Transitions back to unknown correctly', () {
      controller.setAuthenticatedWithoutProfile(user: dummyUser);
      controller.setUnknown();

      expect(controller.value.status, AppSessionStatus.unknown);
      expect(controller.value.user, isNull);
      expect(controller.value.profileId, isNull);
      expect(controller.value.companyId, isNull);
      expect(controller.value.companyName, isNull);
    });
  });
}
