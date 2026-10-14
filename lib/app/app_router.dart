import 'package:flutter/material.dart';

import '../lessons/lesson_14_navigation/lesson_page.dart' show NavigationRoutes;
import '../lessons/lesson_15_route_params/lesson_page.dart' show ParamsRoutes;
import 'lessons.dart';
import 'menu_page.dart';

/// Единый генератор маршрутов приложения (урок 15, onGenerateRoute).
/// Порядок: меню, уроки из списка, именованные маршруты уроков 14 и 15,
/// затем экран "не найдено".
class AppRouter {
  AppRouter._();

  static const menu = '/';

  static Route<dynamic> generate(RouteSettings settings) {
    final name = settings.name ?? menu;

    if (name == menu) {
      return _page(settings, (_) => const MenuPage());
    }

    // Уроки: маршрут каждого урока описан в lessons.dart
    for (final lesson in allLessons) {
      if (lesson.route == name) {
        return _page(settings, lesson.builder);
      }
    }

    // Именованные маршруты урока 14 (таблица routes)
    final builder = NavigationRoutes.table[name];
    if (builder != null) {
      return _page(settings, builder);
    }

    // Маршруты урока 15 (с проверкой аргументов)
    final params = ParamsRoutes.generate(settings);
    if (params != null) {
      return params;
    }

    return _page(
      settings,
      (_) => Scaffold(
        appBar: AppBar(title: const Text('Ошибка')),
        body: Center(child: Text('Маршрут $name не найден')),
      ),
    );
  }

  static MaterialPageRoute<dynamic> _page(
      RouteSettings settings, WidgetBuilder builder) {
    return MaterialPageRoute(settings: settings, builder: builder);
  }
}
