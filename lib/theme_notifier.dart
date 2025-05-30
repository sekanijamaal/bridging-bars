import 'package:flutter/material.dart';

class ThemeNotifier extends ValueNotifier<bool> {
  static final ThemeNotifier _instance = ThemeNotifier._internal();

  factory ThemeNotifier() {
    return _instance;
  }

  ThemeNotifier._internal() : super(true); // true = dark mode by default

  void toggleTheme() {
    value = !value;
  }
}
