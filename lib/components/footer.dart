import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

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
                "Made with ❤️ by Arnau Mora",
                style: textTheme.labelLarge,
              ),
              const SizedBox(width: 12),
              Text(
                "© 2022 ArnyminerZ",
                style: textTheme.labelLarge,
              ),
            ],
          ),
        ));
  }
}
