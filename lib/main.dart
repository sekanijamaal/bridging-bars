import 'package:flutter/material.dart';
import 'package:starter/pages/splash.dart';
import 'package:starter/pages/home.dart';
import 'package:starter/theme_notifier.dart';

void main() {
  runApp(const StudentCounselingApp());
}

class StudentCounselingApp extends StatelessWidget {
  const StudentCounselingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ThemeNotifier(),
      builder: (context, isDarkMode, _) {
        return MaterialApp(
          title: 'Student Counseling',
          debugShowCheckedModeBanner: false,
          theme: isDarkMode ? _darkTheme() : _lightTheme(),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashPage(),
            '/home': (context) => const HomePage(),
          },
        );
      },
    );
  }

  ThemeData _darkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      cardColor: Colors.grey.shade900,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.grey,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
      ),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.grey.shade100,
      cardColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.black),
      ),
    );
  }
}
