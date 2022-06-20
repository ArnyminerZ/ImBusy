import 'package:flutter/material.dart';

import '../data/member_data.dart';
import '../enum/confirmation_state.dart';

/// Used for drawing the text inside each member item.
Widget _memberItemText(
        bool isTitle, MemberData memberData, TextTheme textTheme) =>
    Text(
      isTitle ? memberData.name : memberData.role.displayName(),
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

class MemberItem extends StatefulWidget {
  const MemberItem({Key? key, required this.member}) : super(key: key);

  final MemberData member;

  @override
  State<MemberItem> createState() => _MemberItemState();
}

class _MemberItemState extends State<MemberItem> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    MemberData memberData = widget.member;

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
              _memberItemText(true, memberData, textTheme),
              _memberItemText(false, memberData, textTheme),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(memberData.confirmationState.icon()),
          ),
        ],
      ),
    );
  }
}
