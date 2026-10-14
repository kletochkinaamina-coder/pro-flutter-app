// Урок 3. StatelessWidget.
// Задание: создать свои виджеты без состояния, передать в них данные
// через конструктор и переиспользовать их несколько раз.

import 'package:flutter/material.dart';

/// Экран урока 3. Открывается из главного меню.
class Lesson03Page extends StatelessWidget {
  const Lesson03Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StatelessWidget')),
      body: const TeamList(),
    );
  }
}

/// Список из нескольких одинаковых по виду, но разных по данным карточек.
class TeamList extends StatelessWidget {
  const TeamList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        SimpleText('Мой первый StatelessWidget'),
        SizedBox(height: 16),
        PersonCard(
            name: 'Амина', role: 'Product manager', icon: Icons.lightbulb),
        PersonCard(
            name: 'Иван',
            role: 'Flutter разработчик',
            icon: Icons.phone_android),
        PersonCard(name: 'Мария', role: 'Дизайнер', icon: Icons.brush),
      ],
    );
  }
}

/// Самый простой виджет: только выводит текст.
class SimpleText extends StatelessWidget {
  const SimpleText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text, style: const TextStyle(fontSize: 22)),
    );
  }
}

/// Виджет с параметрами. Поля final: stateless виджет не меняется после создания.
class PersonCard extends StatelessWidget {
  const PersonCard({
    super.key,
    required this.name,
    required this.role,
    this.icon = Icons.person,
  });

  final String name;
  final String role;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(name),
        subtitle: Text(role),
      ),
    );
  }
}
