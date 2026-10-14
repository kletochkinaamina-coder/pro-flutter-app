import 'package:flutter/material.dart';

/// Карточка, которая не задаёт ни одного цвета вручную:
/// всё оформление приходит из темы.
class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.text,
  });

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon),
        title: Text(title, style: textTheme.titleLarge),
        subtitle: Text(text, style: textTheme.bodyMedium),
      ),
    );
  }
}
