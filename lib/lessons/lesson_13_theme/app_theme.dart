import 'package:flutter/material.dart';

/// Урок 13. Вся тема приложения собрана в одном месте.
/// Этот класс применён ко ВСЕМУ приложению (см. lib/main.dart):
/// виджеты не задают цвета и шрифты сами, а берут их из Theme.of(context).
class AppTheme {
  AppTheme._();

  static const _brand = Color(0xFF6A1B9A);

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colors =
        ColorScheme.fromSeed(seedColor: _brand, brightness: brightness);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colors,

      // Общие стили текста. В виджете: Theme.of(context).textTheme.titleLarge
      // Незаданные стили Flutter берёт из стандартной типографики.
      textTheme: const TextTheme(
        displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        bodyMedium: TextStyle(fontSize: 16, height: 1.4),
        labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),

      appBarTheme:
          const AppBarTheme(centerTitle: true, scrolledUnderElevation: 2),

      // Стиль всех ElevatedButton в приложении.
      // (Старый ButtonThemeData относится к устаревшим RaisedButton/FlatButton,
      // сейчас для этого используют ElevatedButtonThemeData и другие *ButtonThemeData.)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),

      // Тема иконок: Icon без явного цвета возьмёт этот.
      iconTheme: IconThemeData(color: colors.primary, size: 26),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
