// Урок 13. Создание собственной темы приложения.
// Задание: вынести стили в ThemeData (цвета, TextTheme, темы кнопок,
// IconThemeData и т.д.), использовать их через Theme.of(context)
// и добавить переключение светлой/тёмной темы.
//
// Сама тема лежит в app_theme.dart и подключена в lib/main.dart ко всему приложению.

import 'package:flutter/material.dart';

import '../../app/theme_controller.dart';
import 'feature_card.dart';

class Lesson13Page extends StatelessWidget {
  const Lesson13Page({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Своя тема'),
        actions: [
          // Слушаем контроллер, чтобы иконка менялась вместе с темой.
          ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeController.mode,
            builder: (context, mode, _) => IconButton(
              tooltip: 'Светлая / тёмная тема',
              onPressed: ThemeController.toggle,
              icon: Icon(
                  mode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Привет!', style: text.displaySmall),
          const SizedBox(height: 8),
          Text(
            'Все цвета, шрифты и кнопки этого приложения берутся из AppTheme. '
            'Поменяй _brand в app_theme.dart и всё приложение перекрасится.',
            style: text.bodyMedium,
          ),
          const SizedBox(height: 20),
          const TextField(
              decoration: InputDecoration(labelText: 'Поле ввода из темы')),
          const SizedBox(height: 20),
          const FeatureCard(
            icon: Icons.palette,
            title: 'ColorScheme',
            text: 'Палитра строится из одного цвета через ColorScheme.fromSeed',
          ),
          const FeatureCard(
            icon: Icons.text_fields,
            title: 'TextTheme',
            text: 'Единые размеры и начертания текста',
          ),
          const FeatureCard(
            icon: Icons.smart_button,
            title: 'Темы кнопок',
            text: 'ElevatedButtonThemeData и OutlinedButtonThemeData',
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Главная')),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {}, child: const Text('Вторая')),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Локально переопределить тему для части дерева.
          Theme(
            data: theme.copyWith(
              iconTheme: const IconThemeData(color: Colors.orange, size: 40),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.star),
                Icon(Icons.favorite),
                Icon(Icons.bolt),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
