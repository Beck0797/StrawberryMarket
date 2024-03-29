import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strawberry_market/data/local/PrefsManager.dart';
import 'package:strawberry_market/ui/screens/login/login_screen.dart';
import 'package:flutter/services.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 255, 42, 35),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  // Required for async calls in `main`
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPrefs instance.
  await PrefsManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Hide the navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    return MaterialApp(
      theme: theme,
      home: LoginScreen(),
    );
  }
}
