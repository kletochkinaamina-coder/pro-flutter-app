import 'package:flutter/material.dart';

/// Глобальный переключатель светлой/тёмной темы.
/// main.dart слушает его, меню и урок 13 меняют значение.
class ThemeController {
  ThemeController._();

  static final mode = ValueNotifier<ThemeMode>(ThemeMode.light);

  static bool get isDark => mode.value == ThemeMode.dark;

  static void toggle() {
    mode.value = isDark ? ThemeMode.light : ThemeMode.dark;
  }
}
