// Урок 10. Stack, Positioned, IndexedStack.
// Задание: наложить виджеты друг на друга (Stack), расставить их
// через Positioned, переключать слои через IndexedStack
// и сделать анимированное переключение через AnimatedContainer.

import 'package:flutter/material.dart';

/// Экран урока 10. Открывается из главного меню.
class Lesson10Page extends StatelessWidget {
  const Lesson10Page({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Stack'),
            bottom: const TabBar(tabs: [
              Tab(text: 'Stack'),
              Tab(text: 'Карточка'),
              Tab(text: 'IndexedStack'),
            ]),
          ),
          body: const TabBarView(children: [
            BasicStack(),
            TravelCard(),
            LayersSwitcher(),
          ]),
        ),
      );
  }
}

/// 1. Простой Stack: каждый следующий ребёнок рисуется поверх предыдущего.
class BasicStack extends StatelessWidget {
  const BasicStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center, // выравнивание непозиционированных детей
        children: [
          Container(width: 240, height: 240, color: Colors.red.shade300),
          Container(width: 170, height: 170, color: Colors.green.shade300),
          Container(width: 100, height: 100, color: Colors.blue.shade300),
          // Positioned задаёт отступы от краёв Stack.
          const Positioned(
            top: 8,
            right: 8,
            child: Icon(Icons.star, color: Colors.white, size: 32),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: Text('Positioned внизу', textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}

/// 2. Практический пример: карточка путешествия.
/// Фото на фоне, затемнение, текст и кнопка "лайк" поверх.
class TravelCard extends StatefulWidget {
  const TravelCard({super.key});

  @override
  State<TravelCard> createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand, // дети без Positioned растягиваются на весь Stack
          children: [
            Image.network(
              'https://picsum.photos/id/1036/800/1200',
              fit: BoxFit.cover,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () => setState(() => _liked = !_liked),
                  icon: Icon(
                    _liked ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 20,
              right: 20,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Чарын каньон',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '200 км от Алматы. Лучшее время: весна и осень.',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 3. IndexedStack показывает только одного ребёнка по индексу,
/// но сохраняет состояние всех остальных.
/// Для сравнения рядом сделан вариант с анимацией через AnimatedContainer.
class LayersSwitcher extends StatefulWidget {
  const LayersSwitcher({super.key});

  @override
  State<LayersSwitcher> createState() => _LayersSwitcherState();
}

class _LayersSwitcherState extends State<LayersSwitcher> {
  int _index = 0;
  static const _colors = [Colors.purple, Colors.teal, Colors.amber];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        SegmentedButton<int>(
          segments: const [
            ButtonSegment(value: 0, label: Text('Слой 1')),
            ButtonSegment(value: 1, label: Text('Слой 2')),
            ButtonSegment(value: 2, label: Text('Слой 3')),
          ],
          selected: {_index},
          onSelectionChanged: (s) => setState(() => _index = s.first),
        ),
        const SizedBox(height: 16),
        const Text('IndexedStack (мгновенно)'),
        SizedBox(
          height: 120,
          child: IndexedStack(
            index: _index,
            children: [
              for (var i = 0; i < 3; i++)
                Container(
                  margin: const EdgeInsets.all(8),
                  color: _colors[i],
                  alignment: Alignment.center,
                  child: Text(
                    'Слой ${i + 1}',
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text('Stack + AnimatedContainer (с анимацией)'),
        SizedBox(
          height: 160,
          width: 260,
          child: Stack(
            // Порядок детей = порядок слоёв: выбранный слой рисуем последним (сверху).
            children: [
              for (final i in [...[0, 1, 2].where((e) => e != _index), _index])
                AnimatedPositioned(
                  key: ValueKey(i),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  left: i == _index ? 40 : 40.0 + (i - _index) * 30,
                  top: i == _index ? 10 : 40,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: i == _index ? 180 : 120,
                    height: i == _index ? 130 : 90,
                    decoration: BoxDecoration(
                      color: _colors[i].withValues(alpha: i == _index ? 1 : 0.4),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
