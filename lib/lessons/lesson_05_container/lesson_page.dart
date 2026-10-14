// Урок 5. Container и BoxDecoration.
// Задание: разобрать параметры Container (размеры, отступы, выравнивание)
// и оформление через BoxDecoration: цвет, рамка, скругление, градиент,
// тень, форма круга и картинка на фоне.

import 'package:flutter/material.dart';

/// Экран урока 5. Открывается из главного меню.
class Lesson05Page extends StatelessWidget {
  const Lesson05Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Container и BoxDecoration')),
        body: const ContainerGallery(),
      );
  }
}

class ContainerGallery extends StatelessWidget {
  const ContainerGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        // 1. Только цвет и размер
        const _Example(
          title: 'color + width/height',
          child: ColoredBox(
            color: Colors.amber,
            child: SizedBox(width: 160, height: 80),
          ),
        ),
        // 2. padding (внутренний отступ) и margin (внешний отступ)
        _Example(
          title: 'padding и margin',
          child: Container(
            color: Colors.blueGrey.shade100,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              color: Colors.blueGrey,
              child: const Text('Текст', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        // 3. alignment: где внутри контейнера стоит child
        _Example(
          title: 'alignment: bottomRight',
          child: Container(
            width: 200,
            height: 100,
            color: Colors.pink.shade100,
            alignment: Alignment.bottomRight,
            child: const Text('я тут'),
          ),
        ),
        // 4. Рамка и скругление углов
        _Example(
          title: 'border + borderRadius',
          child: Container(
            width: 200,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.deepPurple, width: 4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Скруглённая рамка'),
          ),
        ),
        // 5. Градиент
        _Example(
          title: 'LinearGradient',
          child: Container(
            width: 200,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Colors.red, Colors.orange, Colors.yellow],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        // 6. Тень
        _Example(
          title: 'boxShadow',
          child: Container(
            width: 200,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: Offset(4, 6),
                ),
              ],
            ),
          ),
        ),
        // 7. Круг с картинкой из интернета
        _Example(
          title: 'shape: circle + DecorationImage',
          child: Container(
            width: 160,
            height: 160,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/id/1015/400/400'),
                fit: BoxFit.cover,
              ),
              boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 8)],
            ),
            child: const Text(
              'Flutter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // 8. На всю ширину экрана
        _Example(
          title: 'width: double.infinity',
          child: Container(
            width: double.infinity,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.teal,
          ),
        ),
      ],
    );
  }
}

class _Example extends StatelessWidget {
  const _Example({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
