import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:johndeereapp/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:johndeereapp/onboardig.dart';
import 'package:johndeereapp/provider/test_provider.dart';
import 'package:johndeereapp/services/local_storage.dart';
import 'package:johndeereapp/services/task_provider.dart';
import 'package:johndeereapp/splash.dart';

int? initScreen = 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Practica 3
  //await Firebase.initializeApp();
  await LocalStorage.configurePrefs(); //Practica 3
  initScreen = LocalStorage.prefs.getInt('initScreen');
  await LocalStorage.prefs.setInt('initScreen', 1);
 // NotificationService().initNotification();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => TaskProvider()),
          ChangeNotifierProvider(create: (_) => TestProvider())
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        dark: ThemeData.dark(),
        light: ThemeData.light(),
        initial: AdaptiveThemeMode.light, //Practica 3
        builder: (theme, darkTheme) {
          return MaterialApp(
            title: 'Food App',
            theme: theme,
            darkTheme: darkTheme,
            initialRoute:
                //initScreen == 0 || initScreen == 1 ? 'onboard' : 'home',
                'login',
            routes: {
              'onboard': (context) => const Onboarding(),
              'home': (context) => const SplashView(),
              'login': (context) => const LoginScreen()
            },
          );
        });
  }
}
