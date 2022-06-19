import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:imbusy_app/widgets/right_panel.dart';

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
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("I'm Busy"),
        backgroundColor: colorScheme.surfaceVariant,
        foregroundColor: colorScheme.onSurfaceVariant,
        centerTitle: true,
      ),
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
              child: Text('selectedIndex: $_selectedIndex'),
            ),
          ),
          const RightPanel(
            eventName: "Event Name",
          ),
        ],
      ),
    );
  }
}