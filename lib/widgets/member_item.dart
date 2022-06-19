import 'package:flutter/material.dart';

import '../enum/confirmation_state.dart';

class MemberItem extends StatefulWidget {
  const MemberItem(
      {Key? key, required this.name, required this.role, required this.state})
      : super(key: key);

  final String name;
  final String role;
  final ConfirmationState state;

  @override
  State<MemberItem> createState() => _MemberItemState();
}

class _MemberItemState extends State<MemberItem> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Row(
        children: [
          // Profile image
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
              Text(
                widget.name,
                style: textTheme.labelLarge?.copyWith(
                  decoration: widget.state == ConfirmationState.denied
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              Text(
                widget.role,
                style: textTheme.bodySmall?.copyWith(
                  decoration: widget.state == ConfirmationState.denied
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
