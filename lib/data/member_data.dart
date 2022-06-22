import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:imbusy_app/enum/confirmation_state.dart';

enum Role { organizer, member }

extension RoleExtension on Role {
  String displayName(AppLocalizations localizations) {
    switch (this) {
      case Role.organizer:
        return localizations.role_organizer;
      case Role.member:
        return localizations.role_member;
    }
  }
}

class MemberData {
  MemberData({required this.name,
    required this.confirmationState,
    this.role = Role.member,
    required this.profileUri});

  String name;
  ConfirmationState confirmationState;
  Role role;
  String profileUri;
}
