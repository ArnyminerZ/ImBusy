import 'dart:math';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:imbusy_app/data/busy_dates.dart';
import 'package:imbusy_app/data/event_data.dart';
import 'package:imbusy_app/data/member_data.dart';
import 'package:imbusy_app/enum/confirmation_state.dart';
import 'package:table_calendar/table_calendar.dart';

import 'components/footer.dart';
import 'widgets/right_panel.dart';

int random(min, max) {
  return min + Random().nextInt(max - min);
}

void main() {
  runApp(const ImBusyApp());
}

class ImBusyApp extends StatelessWidget {
  const ImBusyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: "I'm Busy",
          theme: ThemeData(
            colorScheme: lightDynamic,
          ),
          darkTheme: ThemeData(
            colorScheme: darkDynamic,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Faker faker = Faker();

    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    DateTime now = DateTime.now();

    EventData eventData = EventData(
      name: "Event Name",
      members: List.generate(
        4,
        (index) => MemberData(
          name: faker.person.name(),
          confirmationState: index == 0
              ? ConfirmationState.confirmed
              : ConfirmationState
                  .values[random(0, ConfirmationState.values.length)],
          role: index == 0 ? Role.organizer : Role.member,
          profileUri: "",
        ),
      ),
      busyDates: List.generate(
        random(1, 10),
        (_) {
          DateTime start = DateTime(now.year, now.month, random(0, 30));
          return BusyDates(
            start: start,
            end: start.add(Duration(days: random(0, 5))),
            userUid: faker.guid.guid(),
          );
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("I'm Busy"),
        backgroundColor: colorScheme.surfaceVariant,
        foregroundColor: colorScheme.onSurfaceVariant,
        centerTitle: true,
      ),
      bottomSheet: footer(context),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            leading: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add_rounded),
            ),
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.calendar_today_outlined),
                selectedIcon: Icon(Icons.calendar_today_rounded),
                label: Text('Calendar'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people_alt_outlined),
                selectedIcon: Icon(Icons.people_alt),
                label: Text('Members'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Summary'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(
              child: TableCalendar<BusyDates>(
                firstDay: now,
                lastDay: DateTime.utc(now.year + 10, 12, 31),
                focusedDay: now,
                eventLoader: (day) {
                  List<BusyDates> list = [];
                  for (var element in eventData.busyDates) {
                    if (element.start.day == day.day &&
                        element.start.month == day.month) {
                      list.add(element);
                    }
                  }
                  return list;
                },
              ),
            ),
          ),
          RightPanel(
            event: eventData,
          ),
        ],
      ),
    );
  }
}
