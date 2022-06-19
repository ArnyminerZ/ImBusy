import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:imbusy_app/enum/confirmation_state.dart';
import 'package:imbusy_app/widgets/member_item.dart';

class RightPanel extends StatefulWidget {
  const RightPanel({Key? key, required this.eventName}) : super(key: key);

  final String eventName;

  @override
  State<RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
  @override
  Widget build(BuildContext context) {
    Faker faker = Faker();

    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.eventName,
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Members",
                    style: textTheme.labelLarge,
                  ),
                  MemberItem(
                    name: faker.person.name(),
                    role: "Organizer",
                    state: ConfirmationState.confirmed,
                  ),
                  MemberItem(
                    name: faker.person.name(),
                    role: "Member",
                    state: ConfirmationState.unconfirmed,
                  ),
                  MemberItem(
                    name: faker.person.name(),
                    role: "Member",
                    state: ConfirmationState.denied,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "Reference code: xxx",
                style: textTheme.labelSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
