// Урок 4. StatefulWidget.
// Задание: сделать виджет с изменяемым состоянием (счётчик),
// понять роль setState и жизненный цикл State.

import 'package:flutter/material.dart';

/// Экран урока 4. Открывается из главного меню.
class Lesson04Page extends StatelessWidget {
  const Lesson04Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const CounterPage(title: 'StatefulWidget');
  }
}

/// Сам виджет неизменяемый. Изменяемые данные живут в объекте State.
class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  bool _liked = false;

  @override
  void initState() {
    super.initState();
    // Вызывается один раз при создании State.
    debugPrint('initState');
  }

  @override
  void dispose() {
    // Вызывается при удалении виджета из дерева: здесь освобождают ресурсы.
    debugPrint('dispose');
    super.dispose();
  }

  void _increment() {
    // setState сообщает Flutter: данные изменились, нужно заново вызвать build.
    setState(() => _counter++);
  }

  void _reset() => setState(() => _counter = 0);

  @override
  Widget build(BuildContext context) {
    debugPrint('build: counter=$_counter');
    return Scaffold(
      // Доступ к полям самого виджета из State: widget.title
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Кнопка нажата столько раз:'),
            Text('$_counter', style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 24),
            IconButton(
              iconSize: 48,
              onPressed: () => setState(() => _liked = !_liked),
              icon: Icon(
                _liked ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
            TextButton(onPressed: _reset, child: const Text('Сбросить')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Увеличить',
        child: const Icon(Icons.add),
      ),
    );
  }
}
