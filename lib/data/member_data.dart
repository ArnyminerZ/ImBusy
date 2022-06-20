import 'package:imbusy_app/enum/confirmation_state.dart';

enum Role { organizer, member }

extension RoleExtension on Role {
  String displayName() {
    switch (this) {
      case Role.organizer:
        return "Organizer"; // TODO: Localize
      case Role.member:
        return "Member"; // TODO: Localize
    }
  }
}

class MemberData {
  MemberData(
      {required this.name,
      required this.confirmationState,
      this.role = Role.member,
      required this.profileUri});

  String name;
  ConfirmationState confirmationState;
  Role role;
  String profileUri;
}
