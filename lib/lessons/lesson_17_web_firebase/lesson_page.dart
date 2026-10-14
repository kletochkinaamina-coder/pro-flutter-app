// Урок 17. Веб приложение на Flutter + Firebase Hosting + GitHub Actions.
// Задание: собрать Flutter приложение под web, выложить его на
// Firebase Hosting и настроить автоматический деплой через GitHub Actions.
// Сам код: адаптивная одностраничная визитка (лендинг),
// которая подстраивает сетку под ширину окна браузера.
// Инструкция по деплою: README.md рядом и .github/workflows в корне репозитория.

import 'package:flutter/material.dart';

/// Экран урока 17. Открывается из главного меню.
class Lesson17Page extends StatelessWidget {
  const Lesson17Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const LandingPage();
  }
}

class _Skill {
  const _Skill(this.icon, this.title, this.text);
  final IconData icon;
  final String title;
  final String text;
}

const _skills = [
  _Skill(
      Icons.widgets, 'Виджеты', 'Stateless, Stateful, Container, Row, Column'),
  _Skill(Icons.view_list, 'Списки', 'ListView, GridView, PageView'),
  _Skill(Icons.layers, 'Слои', 'Stack, Positioned, IndexedStack'),
  _Skill(Icons.palette, 'Оформление', 'Шрифты, картинки, своя тема'),
  _Skill(Icons.alt_route, 'Навигация',
      'Navigator, именованные маршруты, аргументы'),
  _Skill(Icons.devices, 'Платформы', 'Mobile, Desktop и Web из одного кода'),
];

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Адаптивность: число колонок зависит от ширины окна браузера.
          final width = constraints.maxWidth;
          final columns = width > 1100 ? 3 : (width > 700 ? 2 : 1);

          return CustomScrollView(
            slivers: [
              // Панель с кнопкой "назад", чтобы вернуться в меню курса.
              const SliverAppBar(floating: true, title: Text('Web и Firebase')),
              SliverToBoxAdapter(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [colors.primary, colors.tertiary],
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Мой курс Flutter',
                        textAlign: TextAlign.center,
                        style: text.displayMedium
                            ?.copyWith(color: colors.onPrimary),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '17 уроков: от первого виджета до релиза в web',
                        textAlign: TextAlign.center,
                        style:
                            text.titleLarge?.copyWith(color: colors.onPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(24),
                sliver: SliverGrid.builder(
                  itemCount: _skills.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    mainAxisExtent: 180,
                  ),
                  itemBuilder: (context, i) {
                    final s = _skills[i];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Icon(s.icon, size: 40, color: colors.primary),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(s.title, style: text.titleLarge),
                                  const SizedBox(height: 6),
                                  Text(s.text),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Text(
                    'Ширина окна: ${width.round()} px, колонок: $columns',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
