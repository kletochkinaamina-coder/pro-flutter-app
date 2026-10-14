// Урок 2. Структура приложения.
// Задание: разобрать из чего состоит Flutter приложение
// (main -> runApp -> MaterialApp -> Scaffold) и заполнить все "слоты" Scaffold.

import 'package:flutter/material.dart';

/// Экран урока 2. Открывается из главного меню.
class Lesson02Page extends StatelessWidget {
  const Lesson02Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldDemo();
  }
}

/// Scaffold это "каркас" экрана Material Design.
/// У него есть готовые места: appBar, body, drawer,
/// floatingActionButton, bottomNavigationBar.
class ScaffoldDemo extends StatelessWidget {
  const ScaffoldDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Верхняя панель
      appBar: AppBar(
        title: const Text('appBar'),
        // Экран открыт поверх меню, поэтому слева стоит кнопка "назад".
        // Drawer открываем отдельной кнопкой (или свайпом от левого края).
        actions: [
          Builder(
            builder: (context) => IconButton(
              tooltip: 'Открыть drawer',
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu_open),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      // 2. Боковое меню (открывается кнопкой в appBar)
      drawer: const Drawer(
        child: SafeArea(
          child: ListTile(leading: Icon(Icons.menu), title: Text('drawer')),
        ),
      ),
      // 3. Основное содержимое
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _Slot(name: 'body', text: 'Основное содержимое экрана'),
          _Slot(name: 'Дерево виджетов', text: 'main → runApp → MaterialApp → Scaffold → ...'),
          _Slot(name: 'Всё есть виджет', text: 'Текст, отступ, кнопка, экран: всё это виджеты'),
        ],
      ),
      // 4. Плавающая кнопка
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'floatingActionButton',
        child: const Icon(Icons.add),
      ),
      // 5. Нижняя навигация
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Главная'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}

class _Slot extends StatelessWidget {
  const _Slot({required this.name, required this.text});

  final String name;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(text),
      ),
    );
  }
}
