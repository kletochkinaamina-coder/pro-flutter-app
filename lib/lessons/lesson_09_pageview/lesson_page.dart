// Урок 9. PageView.
// Задание: сделать листаемые страницы, анимированный переход
// через PageController (animateToPage, nextPage, jumpToPage)
// и разобрать PageView, PageView.builder.

import 'package:flutter/material.dart';

/// Экран урока 9. Открывается из главного меню.
class Lesson09Page extends StatelessWidget {
  const Lesson09Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingPage();
  }
}

class _Slide {
  const _Slide(this.title, this.text, this.icon, this.color);
  final String title;
  final String text;
  final IconData icon;
  final Color color;
}

const _slides = [
  _Slide('Добро пожаловать', 'Листай страницы пальцем', Icons.waving_hand, Colors.orange),
  _Slide('PageController', 'Управляет текущей страницей', Icons.tune, Colors.teal),
  _Slide('Анимация', 'animateToPage плавно переключает', Icons.animation, Colors.indigo),
  _Slide('Готово', 'jumpToPage переходит без анимации', Icons.check_circle, Colors.green),
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // viewportFraction < 1 показывает края соседних страниц.
  final _controller = PageController(initialPage: 0);
  int _current = 0;
  bool _vertical = false;

  @override
  void dispose() {
    // Контроллеры обязательно освобождаем.
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_current == _slides.length - 1) {
      _controller.jumpToPage(0); // мгновенно в начало
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView'),
        actions: [
          IconButton(
            tooltip: 'Сменить направление',
            onPressed: () => setState(() => _vertical = !_vertical),
            icon: Icon(_vertical ? Icons.swap_horiz : Icons.swap_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            // PageView.builder создаёт страницы по мере необходимости.
            child: PageView.builder(
              controller: _controller,
              scrollDirection: _vertical ? Axis.vertical : Axis.horizontal,
              itemCount: _slides.length,
              onPageChanged: (i) => setState(() => _current = i),
              itemBuilder: (context, i) => _SlideView(_slides[i]),
            ),
          ),
          // Индикатор: по точке можно перейти на нужную страницу.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < _slides.length; i++)
                GestureDetector(
                  onTap: () => _controller.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.all(4),
                    width: i == _current ? 24 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: i == _current ? Colors.pink : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton(
              onPressed: _next,
              child: Text(_current == _slides.length - 1 ? 'В начало' : 'Далее'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SlideView extends StatelessWidget {
  const _SlideView(this.slide);

  final _Slide slide;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: slide.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(slide.icon, size: 96, color: slide.color),
          const SizedBox(height: 16),
          Text(slide.title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(slide.text, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
