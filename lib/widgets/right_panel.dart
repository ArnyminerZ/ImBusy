import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:imbusy_app/data/event_data.dart';
import 'package:imbusy_app/widgets/member_item.dart';

class RightPanel extends StatefulWidget {
  const RightPanel({Key? key, required this.event}) : super(key: key);

  final EventData event;

  @override
  State<RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
  @override
  Widget build(BuildContext context) {
    Faker faker = Faker();

    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    EventData event = widget.event;

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
                event.name,
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
                  ...event.members.map(
                    (member) => MemberItem(
                      member: member,
                    ),
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
