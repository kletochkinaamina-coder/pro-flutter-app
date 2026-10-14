// Pro Flutter: одно приложение по всем 17 урокам курса.
// Главный экран это меню, каждый урок открывается отдельным экраном.

import 'package:flutter/material.dart';

import 'app/app_router.dart';
import 'app/theme_controller.dart';
import 'lessons/lesson_13_theme/app_theme.dart';

void main() => runApp(const ProFlutterApp());

class ProFlutterApp extends StatelessWidget {
  const ProFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.mode,
      builder: (context, mode, _) => MaterialApp(
        title: 'Pro Flutter',
        debugShowCheckedModeBanner: false,
        // Тема из урока 13 применена ко всему приложению.
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: mode,
        // Маршруты из уроков 14 и 15.
        initialRoute: AppRouter.menu,
        onGenerateRoute: AppRouter.generate,
      ),
    );
  }
}
