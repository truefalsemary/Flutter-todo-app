import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_todo_app/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [
        Locale('ru'),
        Locale('en'),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFF7F6F2),
          onPrimary: Color(0xFF000000),
          // secondary: Color(0xFFFFFFFF),
          // onSecondary: Color(0x99000000),
          secondary: Color(0xFF007AFF),
          onSecondary: Color(0xFFFFFFFF),
          tertiary: Color(0x4D000000),
          error: Color(0xFFFF3B30),
          onError: Color(0xFFFFFFFF),
          surface: Color(0xFFF7F6F2),
          onSurface: Color(0xFF000000),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF007AFF),
          foregroundColor: Color(0xFFFFFFFF),
          shape: CircleBorder(),
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
