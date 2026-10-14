// Урок 11. Изменение шрифта.
// Задание: подключить свой шрифт из файла (assets + pubspec.yaml),
// задать шрифт для всего приложения и для отдельных виджетов,
// подключить пакет google_fonts.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Экран урока 11. Шрифт для "всего приложения" в видео задаётся в ThemeData.
/// В нашем единственном приложении тема общая, поэтому для этого экрана
/// переопределяем textTheme локально через Theme: тот же эффект на поддереве.
class Lesson11Page extends StatelessWidget {
  const Lesson11Page({super.key});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context);
    return Theme(
      data: base.copyWith(
        textTheme: GoogleFonts.montserratTextTheme(base.textTheme),
      ),
      child: const FontsPage(),
    );
  }
}

class FontsPage extends StatelessWidget {
  const FontsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Шрифт только для одного виджета: локальный файл из assets.
        title: const Text(
          'Шрифты во Flutter',
          style: TextStyle(fontFamily: 'Lobster', fontSize: 26),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _Sample(
            label: 'Тема приложения (Montserrat из google_fonts)',
            child: Text('Этот текст берёт шрифт из ThemeData.textTheme'),
          ),
          const _Sample(
            label: 'Свой шрифт из assets/fonts',
            child: Text(
              'Привет, Lobster!',
              style: TextStyle(fontFamily: 'Lobster', fontSize: 32),
            ),
          ),
          _Sample(
            label: 'GoogleFonts.<имя>() для одного виджета',
            child: Text(
              'Pacifico из google_fonts',
              style: GoogleFonts.pacifico(fontSize: 28, color: Colors.brown),
            ),
          ),
          _Sample(
            label: 'Стиль поверх стиля темы: copyWith',
            child: Text(
              'Заголовок темы, но красный',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.red),
            ),
          ),
          const _Sample(
            label: 'Параметры TextStyle',
            child: Text(
              'жирный, курсив, разрядка, подчёркивание',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                letterSpacing: 1.5,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Sample extends StatelessWidget {
  const _Sample({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}
