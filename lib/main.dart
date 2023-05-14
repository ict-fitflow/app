import 'package:fitflow/providers/bluetooth.dart';
import 'package:fitflow/providers/settings.dart';
import 'package:fitflow/providers/user.dart';
import 'package:fitflow/ui/pages/onboardingpage.dart';
import 'package:fitflow/ui/pages/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fitflow/ui/pages/tabs.dart';

late SharedPreferences prefs;

// select the page to show
// if is the first time the customer use the app
// he will see the OnBoardingPage
Widget entryPoint() {
  late Widget entryPoint;
  if (prefs.containsKey('firstTime') == false) {
    prefs.setBool('firstTime', false);
    entryPoint = const OnBoardingPage();
  }
  else {
    entryPoint = const TabsPage();
  }
  return entryPoint;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(prefs: prefs),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(prefs: prefs),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => BluetoothProvider(),
          lazy: false,
        )
      ],
      child: const SplashScreen(nextPage: FitFlowApp()),
    )
  );
}

class FitFlowApp extends StatelessWidget {
  const FitFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FitFlow',
          theme: ThemeData.light(),
          darkTheme:  ThemeData.dark(),
          themeMode: settings.darkTheme ? ThemeMode.dark : ThemeMode.light,
          home: entryPoint(),
        );
      }
    );
  }
}
