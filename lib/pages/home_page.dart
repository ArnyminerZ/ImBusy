import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/footer.dart';
import '../data/busy_dates.dart';
import '../data/event_data.dart';
import '../data/member_data.dart';
import '../enum/confirmation_state.dart';
import '../utils/random.dart';
import '../widgets/right_panel.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "Home";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  int _selectedIndex = 0;

  late EventData eventData;

  @override
  void initState() {
    Faker faker = Faker();
    DateTime now = DateTime.now();

    eventData = EventData(
      name: "Event Name",
      members: List.generate(
        4,
        (index) => MemberData(
          name: faker.person.name(),
          confirmationState: index == 0
              ? ConfirmationState.confirmed
              : ConfirmationState
                  .values[randomInt(0, ConfirmationState.values.length)],
          role: index == 0 ? Role.organizer : Role.member,
          profileUri: "",
        ),
      ),
      busyDates: List.generate(
        randomInt(1, 10),
        (_) {
          DateTime start = DateTime(now.year, now.month, randomInt(0, 30));
          return BusyDates(
            start: start,
            end: start.add(Duration(days: randomInt(0, 5))),
            userUid: faker.guid.guid(),
          );
        },
      ),
    );

    super.initState();
  }

  Future<void> _showLogOutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign out'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure that you want to log out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Log Out'),
              onPressed: () {
                auth.signOut();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    AppLocalizations localizations = AppLocalizations.of(context)!;

    DateTime now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text("I'm Busy"),
        backgroundColor: colorScheme.surfaceVariant,
        foregroundColor: colorScheme.onSurfaceVariant,
        centerTitle: true,
        actions: [
          if (_user?.photoURL != null)
            IconButton(
                onPressed: _showLogOutDialog,
                icon: Image.network(_user!.photoURL!))
        ],
      ),
      bottomSheet: footer(context),
      body: Row(children: <Widget>[
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
          destinations: <NavigationRailDestination>[
            NavigationRailDestination(
              icon: const Icon(Icons.calendar_today_outlined),
              selectedIcon: const Icon(Icons.calendar_today_rounded),
              label: Text(localizations.menu_calendar),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.people_alt_outlined),
              selectedIcon: const Icon(Icons.people_alt),
              label: Text(localizations.menu_members),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.dashboard_outlined),
              selectedIcon: const Icon(Icons.dashboard),
              label: Text(localizations.menu_summary),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings),
              label: Text(localizations.menu_settings),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        // This is the main content.
        Expanded(
          child: Center(
            child: _selectedIndex == 0
                ? TableCalendar<BusyDates>(
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
                  )
                : const Text("Sup?"),
          ),
        ),
        if (_selectedIndex == 0)
          RightPanel(
            event: eventData,
          ),
      ]),
    );
  }
}
