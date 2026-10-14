import 'package:flutter/material.dart';

import 'lessons.dart';
import 'theme_controller.dart';

/// Главный экран: оглавление курса. Каждый урок это отдельный экран,
/// который открывается через Navigator.pushNamed (урок 14).
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pro Flutter'),
        actions: [
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
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          for (final section in sections) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                section.title,
                style: text.titleLarge?.copyWith(color: colors.primary),
              ),
            ),
            for (final lesson in section.lessons)
              ListTile(
                leading: CircleAvatar(child: Text('${lesson.number}')),
                title: Text(lesson.title),
                subtitle: Text(lesson.summary),
                trailing: Icon(lesson.icon),
                onTap: () => Navigator.pushNamed(context, lesson.route),
              ),
          ],
        ],
      ),
    );
  }
}
