import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColorLight =
        Color(0xFF6A1B9A); // Cor roxa para o tema claro
    const Color primaryColorDark =
        Color(0xFFAB47BC); // Cor roxa mais clara para o tema escuro

    return MaterialApp(
      title: 'Meu App Flutter',
      theme: ThemeData(
        primarySwatch: MaterialColor(primaryColorLight.value, {
          50: primaryColorLight.withOpacity(0.1),
          100: primaryColorLight.withOpacity(0.2),
          200: primaryColorLight.withOpacity(0.3),
          300: primaryColorLight.withOpacity(0.4),
          400: primaryColorLight.withOpacity(0.5),
          500: primaryColorLight,
          600: primaryColorLight.withOpacity(0.7),
          700: primaryColorLight.withOpacity(0.8),
          800: primaryColorLight.withOpacity(0.9),
          900: primaryColorLight.withOpacity(1.0),
        }),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: MaterialColor(primaryColorDark.value, {
          50: primaryColorDark.withOpacity(0.1),
          100: primaryColorDark.withOpacity(0.2),
          200: primaryColorDark.withOpacity(0.3),
          300: primaryColorDark.withOpacity(0.4),
          400: primaryColorDark.withOpacity(0.5),
          500: primaryColorDark,
          600: primaryColorDark.withOpacity(0.7),
          700: primaryColorDark.withOpacity(0.8),
          800: primaryColorDark.withOpacity(0.9),
          900: primaryColorDark.withOpacity(1.0),
        }),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
        cardColor: Colors.grey[800],
        colorScheme: ColorScheme.dark(
          primary: primaryColorDark,
          secondary: primaryColorDark.withOpacity(0.7),
        ),
      ),
      themeMode: _themeMode,
      home: HomePage(toggleTheme: toggleTheme),
    );
  }
}
