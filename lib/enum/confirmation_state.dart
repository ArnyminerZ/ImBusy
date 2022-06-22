import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ConfirmationState {
  confirmed,
  unconfirmed,
  denied,
}

extension ConfirmationStateExtension on ConfirmationState {
  String name(AppLocalizations localizations) {
    switch (this) {
      case ConfirmationState.confirmed:
        return localizations.confirmation_confirmed;
      case ConfirmationState.unconfirmed:
        return localizations.confirmation_unconfirmed;
      case ConfirmationState.denied:
        return localizations.confirmation_denied;
    }
  }

  IconData icon() {
    switch (this) {
      case ConfirmationState.confirmed:
        return Icons.check_rounded;
      case ConfirmationState.unconfirmed:
        return Icons.dark_mode_rounded;
      case ConfirmationState.denied:
        return Icons.close_rounded;
    }
  }
}
