import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget footer(BuildContext context) {
  ThemeData theme = Theme.of(context);
  ColorScheme colorScheme = theme.colorScheme;
  TextTheme textTheme = theme.textTheme;

  AppLocalizations localizations = AppLocalizations.of(context)!;

  return DecoratedBox(
    decoration: BoxDecoration(
      color: colorScheme.primaryContainer,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            localizations.footer_author,
            style: textTheme.labelLarge,
          ),
          const SizedBox(width: 12),
          Text(
            localizations.footer_copyright,
            style: textTheme.labelLarge,
          ),
        ],
      ),
    ),
  );
}
