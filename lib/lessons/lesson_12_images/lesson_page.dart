// Урок 12. Добавление картинок.
// Задание: добавить картинку в проект (assets + pubspec.yaml),
// разобрать конструкторы Image (asset, network, memory, file),
// параметр fit и вывести SVG через пакет flutter_svg.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Экран урока 12. Открывается из главного меню.
class Lesson12Page extends StatelessWidget {
  const Lesson12Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImagesPage();
  }
}

class ImagesPage extends StatefulWidget {
  const ImagesPage({super.key});

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  BoxFit _fit = BoxFit.cover;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Картинки')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. Картинка из проекта
          const _Title('Image.asset (файл из assets/images)'),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('assets/images/mountains.png'),
          ),

          // 2. Картинка из интернета + индикатор загрузки и обработка ошибки
          const _Title('Image.network'),
          SizedBox(
            height: 200,
            child: Image.network(
              'https://picsum.photos/id/1043/800/500',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) => progress == null
                  ? child
                  : const Center(child: CircularProgressIndicator()),
              errorBuilder: (context, error, stack) =>
                  const Center(child: Icon(Icons.broken_image, size: 48)),
            ),
          ),

          // 3. Плавное появление после загрузки
          const _Title('FadeInImage (заглушка, потом картинка)'),
          SizedBox(
            height: 200,
            child: FadeInImage(
              placeholder: const AssetImage('assets/images/mountains.png'),
              image: const NetworkImage('https://picsum.photos/id/1018/800/500'),
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 800),
            ),
          ),

          // 4. Параметр fit: как вписать картинку в рамку
          const _Title('Параметр fit'),
          Wrap(
            spacing: 8,
            children: [
              for (final f in BoxFit.values)
                ChoiceChip(
                  label: Text(f.name),
                  selected: _fit == f,
                  onSelected: (_) => setState(() => _fit = f),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 160,
            color: Colors.grey.shade300,
            child: Image.asset('assets/images/mountains.png', fit: _fit),
          ),

          // 5. Картинка как фон контейнера
          const _Title('DecorationImage + круглая аватарка'),
          const Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage('https://picsum.photos/id/64/200/200'),
              ),
              SizedBox(width: 16),
              Expanded(child: Text('CircleAvatar с backgroundImage')),
            ],
          ),

          // 6. SVG через пакет flutter_svg
          const _Title('SvgPicture.asset (пакет flutter_svg)'),
          SvgPicture.asset('assets/images/rocket.svg', height: 120),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
