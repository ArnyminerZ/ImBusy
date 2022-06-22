import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ImBusyApp());
}

class ImBusyApp extends StatefulWidget {
  const ImBusyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ImBusyAppState();
}

class _ImBusyAppState extends State<ImBusyApp> {
  final Future<FirebaseApp> _initFirebaseSdk = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final _navigatorKey = GlobalKey<NavigatorState>();

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
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          navigatorKey: _navigatorKey,
          routes: {
            HomePage.routeName: (BuildContext context) => const HomePage(),
            LoginPage.routeName: (BuildContext context) => const LoginPage(),
          },
          home: FutureBuilder(
            future: _initFirebaseSdk,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Assign listener after the SDK is initialized successfully
                FirebaseAuth.instance.authStateChanges().listen((User? user) {
                  if (user == null) {
                    _navigatorKey.currentState!
                        .pushReplacementNamed(LoginPage.routeName);
                  } else {
                    _navigatorKey.currentState!
                        .pushReplacementNamed(HomePage.routeName);
                  }
                });
              }
              return const Text("loading..."); // TODO: Add loading screen
            },
          ),
        );
      },
    );
  }
}
