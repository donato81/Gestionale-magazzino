import 'package:supabase_flutter/supabase_flutter.dart';

enum AppSessionStatus {
  unknown,
  unauthenticated,
  authenticatedWithoutProfile,
  authenticatedWithProfile,
}

class AppSessionState {
  final AppSessionStatus status;

  // Conscious architectural choice for MVP 1: we use Supabase's User type directly.
  // This avoids redundant model wrappers until advanced user roles/relations are introduced.
  final User? user;
  
  final String? profileId;
  final String? companyId;
  final String? companyName;

  const AppSessionState({
    required this.status,
    this.user,
    this.profileId,
    this.companyId,
    this.companyName,
  });

  factory AppSessionState.unknown() {
    return const AppSessionState(status: AppSessionStatus.unknown);
  }

  factory AppSessionState.unauthenticated() {
    return const AppSessionState(status: AppSessionStatus.unauthenticated);
  }

  factory AppSessionState.authenticatedWithoutProfile({User? user}) {
    return AppSessionState(
      status: AppSessionStatus.authenticatedWithoutProfile,
      user: user,
    );
  }

  factory AppSessionState.authenticatedWithProfile({
    User? user,
    required String profileId,
    required String companyId,
    required String companyName,
  }) {
    return AppSessionState(
      status: AppSessionStatus.authenticatedWithProfile,
      user: user,
      profileId: profileId,
      companyId: companyId,
      companyName: companyName,
    );
  }

  @override
  String toString() {
    return 'AppSessionState(status: $status, user: ${user?.id}, profileId: $profileId, companyId: $companyId, companyName: $companyName)';
  }
}
