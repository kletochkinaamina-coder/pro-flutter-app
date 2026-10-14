// Урок 1. Установка Flutter и первое приложение.
// Задание: создать проект, запустить его на эмуляторе и вывести свой первый экран.
//
// Точка входа в любую Flutter программу находится в lib/main.dart:
//   void main() => runApp(const ProFlutterApp());
// runApp делает переданный виджет корнем всего дерева виджетов.
// Команды из видео: flutter doctor, flutter create, flutter run.

import 'package:flutter/material.dart';

/// Экран урока 1. Открывается из главного меню.
class Lesson01Page extends StatelessWidget {
  const Lesson01Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const HelloScreen();
  }
}

class HelloScreen extends StatelessWidget {
  const HelloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Привет, Flutter!')),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlutterLogo(size: 96),
            SizedBox(height: 24),
            Text(
              'Моё первое приложение запущено',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text('Измени этот текст и нажми Hot Reload (r в консоли)'),
          ],
        ),
      ),
    );
  }
}
