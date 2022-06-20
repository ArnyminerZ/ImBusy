import 'package:flutter/material.dart';

enum ConfirmationState {
  confirmed,
  unconfirmed,
  denied,
}

extension ConfirmationStateExtension on ConfirmationState {
  String name() {
    switch (this) {
      case ConfirmationState.confirmed:
        return "Confirmed";
      case ConfirmationState.unconfirmed:
        return "Unconfirmed";
      case ConfirmationState.denied:
        return "Won't come";
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
