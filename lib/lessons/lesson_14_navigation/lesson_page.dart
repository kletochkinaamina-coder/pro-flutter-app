// Урок 14. Анонимные и именованные маршруты. Виджет Navigator.
// Задание: переходить между экранами и возвращаться назад через
// Navigator.push / Navigator.pop (анонимные маршруты)
// и Navigator.pushNamed (именованные маршруты).
//
// Именованные маршруты этого урока (/navigation/catalog, /navigation/settings)
// регистрируются в lib/app/app_router.dart через NavigationRoutes.

import 'package:flutter/material.dart';

/// Имена маршрутов держим в одном месте, чтобы не ошибиться в строках.
abstract class NavigationRoutes {
  static const home = '/navigation';
  static const catalog = '/navigation/catalog';
  static const settings = '/navigation/settings';

  /// Таблица именованных маршрутов урока (аналог параметра routes у MaterialApp).
  static final Map<String, WidgetBuilder> table = {
    catalog: (context) => const CatalogScreen(),
    settings: (context) => const SettingsScreen(),
  };
}

class Lesson14Page extends StatelessWidget {
  const Lesson14Page({super.key});

  Future<void> _openQuestion(BuildContext context) async {
    // push возвращает Future: дождёмся результата, который вернёт pop.
    final answer = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const QuestionScreen()),
    );
    if (!context.mounted || answer == null) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Вы выбрали: $answer')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigator')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Анонимный маршрут', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              ),
              child: const Text('push: О приложении'),
            ),
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: () => _openQuestion(context),
              child: const Text('push и получить результат из pop'),
            ),
            const SizedBox(height: 32),
            const Text('Именованные маршруты', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, NavigationRoutes.catalog),
              child: const Text('pushNamed: Каталог'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, NavigationRoutes.settings),
              child: const Text('pushNamed: Настройки'),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Кнопка "назад" в AppBar появляется сама и вызывает Navigator.pop.
    return Scaffold(
      appBar: AppBar(title: const Text('О приложении')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Navigator.pop: назад'),
        ),
      ),
    );
  }
}

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const options = ['Flutter', 'Kotlin', 'Swift'];
    return Scaffold(
      appBar: AppBar(title: const Text('Любимая технология?')),
      body: ListView(
        children: [
          for (final o in options)
            ListTile(
              title: Text(o),
              trailing: const Icon(Icons.chevron_right),
              // pop с результатом: значение вернётся в await Navigator.push
              onTap: () => Navigator.pop(context, o),
            ),
        ],
      ),
    );
  }
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Каталог')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              // Заменить текущий экран (назад на Каталог уже не вернуться).
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, NavigationRoutes.settings),
              child: const Text('pushReplacementNamed: Настройки'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: Center(
        child: FilledButton(
          // Закрыть все экраны до экрана урока.
          onPressed: () =>
              Navigator.popUntil(context, ModalRoute.withName(NavigationRoutes.home)),
          child: const Text('popUntil: к экрану урока'),
        ),
      ),
    );
  }
}
