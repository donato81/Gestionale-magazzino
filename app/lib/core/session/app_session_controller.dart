import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_session_state.dart';

class AppSessionController extends ValueNotifier<AppSessionState> {
  AppSessionController() : super(AppSessionState.unknown());

  void setUnknown() {
    value = AppSessionState.unknown();
  }

  void setUnauthenticated() {
    value = AppSessionState.unauthenticated();
  }

  void setAuthenticatedWithoutProfile({User? user}) {
    value = AppSessionState.authenticatedWithoutProfile(user: user);
  }

  void setAuthenticatedWithProfile({
    User? user,
    required String profileId,
    required String companyId,
    required String companyName,
  }) {
    value = AppSessionState.authenticatedWithProfile(
      user: user,
      profileId: profileId,
      companyId: companyId,
      companyName: companyName,
    );
  }
}
