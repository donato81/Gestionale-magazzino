enum AuthProfileCheckStatus {
  missing,
  incomplete,
  complete,
}

class AuthProfileCheckResult {
  final AuthProfileCheckStatus status;
  final String? profileId;
  final String? companyId;
  final String? companyName;

  const AuthProfileCheckResult({
    required this.status,
    this.profileId,
    this.companyId,
    this.companyName,
  });

  factory AuthProfileCheckResult.missing() {
    return const AuthProfileCheckResult(
      status: AuthProfileCheckStatus.missing,
    );
  }

  factory AuthProfileCheckResult.incomplete({
    required String profileId,
  }) {
    return AuthProfileCheckResult(
      status: AuthProfileCheckStatus.incomplete,
      profileId: profileId,
    );
  }

  factory AuthProfileCheckResult.complete({
    required String profileId,
    required String companyId,
    required String companyName,
  }) {
    if (companyId.trim().isEmpty) {
      throw ArgumentError('companyId cannot be empty or blank for a complete status');
    }
    if (companyName.trim().isEmpty) {
      throw ArgumentError('companyName cannot be empty or blank for a complete status');
    }
    return AuthProfileCheckResult(
      status: AuthProfileCheckStatus.complete,
      profileId: profileId,
      companyId: companyId,
      companyName: companyName,
    );
  }

  @override
  String toString() {
    return 'AuthProfileCheckResult(status: $status, profileId: $profileId, companyId: $companyId, companyName: $companyName)';
  }
}
