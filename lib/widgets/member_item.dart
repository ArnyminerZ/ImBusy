import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../data/member_data.dart';
import '../enum/confirmation_state.dart';

/// Used for drawing the text inside each member item.
Widget _memberItemText(bool isTitle, MemberData memberData, BuildContext ctx) {
  ThemeData theme = Theme.of(ctx);
  TextTheme textTheme = theme.textTheme;

  AppLocalizations localizations = AppLocalizations.of(ctx)!;

  return Text(
    isTitle ? memberData.name : memberData.role.displayName(localizations),
    overflow: TextOverflow.ellipsis,
    style: (isTitle ? textTheme.labelLarge : textTheme.bodySmall)?.copyWith(
      fontStyle: memberData.confirmationState == ConfirmationState.confirmed
          ? FontStyle.normal
          : FontStyle.italic,
      decoration: memberData.confirmationState == ConfirmationState.denied
          ? TextDecoration.lineThrough
          : TextDecoration.none,
    ),
  );
}

Widget memberItem(BuildContext context, MemberData memberData) {
  AppLocalizations localizations = AppLocalizations.of(context)!;

  return Card(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    child: Row(
      children: [
// Profile image
// TODO: Load profile image
        Positioned(
          child: Container(
            height: 40.0,
            width: 40.0,
            margin: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _memberItemText(true, memberData, context),
            _memberItemText(false, memberData, context),
          ],
        ),
        const Spacer(),
        Tooltip(
          message: memberData.confirmationState.name(localizations),
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(memberData.confirmationState.icon()),
          ),
        )
      ],
    ),
  );
}
