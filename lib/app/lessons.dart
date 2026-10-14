import 'package:flutter/material.dart';

import '../lessons/lesson_01_first_app/lesson_page.dart' show Lesson01Page;
import '../lessons/lesson_02_app_structure/lesson_page.dart' show Lesson02Page;
import '../lessons/lesson_03_stateless/lesson_page.dart' show Lesson03Page;
import '../lessons/lesson_04_stateful/lesson_page.dart' show Lesson04Page;
import '../lessons/lesson_05_container/lesson_page.dart' show Lesson05Page;
import '../lessons/lesson_06_column_row/lesson_page.dart' show Lesson06Page;
import '../lessons/lesson_07_listview/lesson_page.dart' show Lesson07Page;
import '../lessons/lesson_08_gridview/lesson_page.dart' show Lesson08Page;
import '../lessons/lesson_09_pageview/lesson_page.dart' show Lesson09Page;
import '../lessons/lesson_10_stack/lesson_page.dart' show Lesson10Page;
import '../lessons/lesson_11_fonts/lesson_page.dart' show Lesson11Page;
import '../lessons/lesson_12_images/lesson_page.dart' show Lesson12Page;
import '../lessons/lesson_13_theme/lesson_page.dart' show Lesson13Page;
import '../lessons/lesson_14_navigation/lesson_page.dart'
    show Lesson14Page, NavigationRoutes;
import '../lessons/lesson_15_route_params/lesson_page.dart'
    show Lesson15Page, ParamsRoutes;
import '../lessons/lesson_16_desktop/lesson_page.dart' show Lesson16Page;
import '../lessons/lesson_17_web_firebase/lesson_page.dart' show Lesson17Page;

/// Описание одного урока для главного меню.
class Lesson {
  const Lesson({
    required this.number,
    required this.title,
    required this.summary,
    required this.icon,
    required this.route,
    required this.builder,
  });

  final int number;
  final String title;
  final String summary;
  final IconData icon;

  /// Именованный маршрут, по которому урок открывается из меню.
  final String route;
  final WidgetBuilder builder;
}

/// Раздел курса: заголовок и его уроки.
class Section {
  const Section(this.title, this.lessons);

  final String title;
  final List<Lesson> lessons;
}

String _r(int n) => '/lesson-${n.toString().padLeft(2, '0')}';

/// Структура курса Pro Flutter: 5 разделов, 17 уроков.
final List<Section> sections = [
  Section('1. Введение', [
    Lesson(
      number: 1,
      title: 'Установка и создание приложения',
      summary: 'Dart, Flutter SDK, flutter create, первый запуск',
      icon: Icons.rocket_launch,
      route: _r(1),
      builder: (_) => const Lesson01Page(),
    ),
    Lesson(
      number: 2,
      title: 'Структура приложения',
      summary: 'main, runApp, MaterialApp, Scaffold, дерево виджетов',
      icon: Icons.account_tree,
      route: _r(2),
      builder: (_) => const Lesson02Page(),
    ),
  ]),
  Section('2. Виджеты', [
    Lesson(
      number: 3,
      title: 'Stateless виджеты',
      summary: 'Виджеты без состояния, параметры через конструктор',
      icon: Icons.widgets,
      route: _r(3),
      builder: (_) => const Lesson03Page(),
    ),
    Lesson(
      number: 4,
      title: 'Stateful виджеты',
      summary: 'State, setState, initState и dispose',
      icon: Icons.touch_app,
      route: _r(4),
      builder: (_) => const Lesson04Page(),
    ),
    Lesson(
      number: 5,
      title: 'Container и BoxDecoration',
      summary: 'Размеры, отступы, рамка, градиент, тень, круг',
      icon: Icons.crop_square,
      route: _r(5),
      builder: (_) => const Lesson05Page(),
    ),
    Lesson(
      number: 6,
      title: 'Column и Row',
      summary: 'Главная и поперечная оси, все параметры',
      icon: Icons.view_column,
      route: _r(6),
      builder: (_) => const Lesson06Page(),
    ),
    Lesson(
      number: 7,
      title: 'ListView',
      summary: 'children, builder, separated, custom',
      icon: Icons.view_list,
      route: _r(7),
      builder: (_) => const Lesson07Page(),
    ),
    Lesson(
      number: 8,
      title: 'GridView',
      summary: 'count, extent, builder, custom',
      icon: Icons.grid_view,
      route: _r(8),
      builder: (_) => const Lesson08Page(),
    ),
    Lesson(
      number: 9,
      title: 'PageView',
      summary: 'PageController, анимированный переход между страницами',
      icon: Icons.view_carousel,
      route: _r(9),
      builder: (_) => const Lesson09Page(),
    ),
    Lesson(
      number: 10,
      title: 'Stack, Positioned, IndexedStack',
      summary: 'Слои, позиционирование, AnimatedContainer',
      icon: Icons.layers,
      route: _r(10),
      builder: (_) => const Lesson10Page(),
    ),
  ]),
  Section('3. Разработка', [
    Lesson(
      number: 11,
      title: 'Изменение шрифта',
      summary: 'Свой шрифт из assets, пакет google_fonts',
      icon: Icons.text_fields,
      route: _r(11),
      builder: (_) => const Lesson11Page(),
    ),
    Lesson(
      number: 12,
      title: 'Добавление картинок',
      summary: 'Image.asset, Image.network, fit, SVG через flutter_svg',
      icon: Icons.image,
      route: _r(12),
      builder: (_) => const Lesson12Page(),
    ),
    Lesson(
      number: 13,
      title: 'Собственная тема приложения',
      summary: 'ThemeData, TextTheme, темы кнопок и иконок, тёмная тема',
      icon: Icons.palette,
      route: _r(13),
      builder: (_) => const Lesson13Page(),
    ),
  ]),
  Section('4. Маршрутизация и навигация', [
    Lesson(
      number: 14,
      title: 'Маршруты и Navigator',
      summary: 'push, pop, pushNamed, анонимные и именованные маршруты',
      icon: Icons.alt_route,
      route: NavigationRoutes.home,
      builder: (_) => const Lesson14Page(),
    ),
    Lesson(
      number: 15,
      title: 'Передача параметров',
      summary: 'Через конструктор, arguments и onGenerateRoute',
      icon: Icons.send,
      route: ParamsRoutes.home,
      builder: (_) => const Lesson15Page(),
    ),
  ]),
  Section('5. Бонус: desktop и web', [
    Lesson(
      number: 16,
      title: 'Десктопное приложение',
      summary: 'Адаптивный интерфейс, горячие клавиши, релизная сборка',
      icon: Icons.desktop_windows,
      route: _r(16),
      builder: (_) => const Lesson16Page(),
    ),
    Lesson(
      number: 17,
      title: 'Web, Firebase и GitHub Actions',
      summary: 'Адаптивная web страница, деплой на Firebase Hosting',
      icon: Icons.public,
      route: _r(17),
      builder: (_) => const Lesson17Page(),
    ),
  ]),
];

/// Плоский список всех уроков.
final List<Lesson> allLessons = [for (final s in sections) ...s.lessons];
