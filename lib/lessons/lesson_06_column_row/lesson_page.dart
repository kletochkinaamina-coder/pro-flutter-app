// Урок 6. Column и Row.
// Задание: изучить все параметры Column и Row.
// Здесь сделана "песочница": меняешь параметры в меню и сразу видишь результат.

import 'package:flutter/material.dart';

/// Экран урока 6. Открывается из главного меню.
class Lesson06Page extends StatelessWidget {
  const Lesson06Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlexPlayground();
  }
}

class FlexPlayground extends StatefulWidget {
  const FlexPlayground({super.key});

  @override
  State<FlexPlayground> createState() => _FlexPlaygroundState();
}

class _FlexPlaygroundState extends State<FlexPlayground> {
  bool _isRow = true;
  MainAxisAlignment _main = MainAxisAlignment.start;
  CrossAxisAlignment _cross = CrossAxisAlignment.center;
  MainAxisSize _size = MainAxisSize.max;
  VerticalDirection _vertical = VerticalDirection.down;
  TextDirection _text = TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    final children = [
      const _Box(text: '1', color: Colors.limeAccent, size: 60),
      const _Box(text: '2', color: Colors.cyanAccent, size: 90),
      const _Box(text: '3', color: Colors.purpleAccent, size: 40),
    ];

    // Row и Column работают одинаково, отличается только главная ось:
    // у Row она горизонтальная, у Column вертикальная.
    final Widget flex = _isRow
        ? Row(
            mainAxisAlignment: _main,
            crossAxisAlignment: _cross,
            mainAxisSize: _size,
            verticalDirection: _vertical,
            textDirection: _text,
            textBaseline: TextBaseline.alphabetic,
            children: children,
          )
        : Column(
            mainAxisAlignment: _main,
            crossAxisAlignment: _cross,
            mainAxisSize: _size,
            verticalDirection: _vertical,
            textDirection: _text,
            textBaseline: TextBaseline.alphabetic,
            children: children,
          );

    return Scaffold(
      appBar: AppBar(title: Text(_isRow ? 'Row' : 'Column')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Align(alignment: Alignment.topLeft, child: flex),
            ),
          ),
          _controls(),
        ],
      ),
    );
  }

  Widget _controls() {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Wrap(
          spacing: 12,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text('Row')),
                ButtonSegment(value: false, label: Text('Column')),
              ],
              selected: {_isRow},
              onSelectionChanged: (s) => setState(() {
                _isRow = s.first;
                // baseline работает только у Row (горизонтальная главная ось).
                if (!_isRow && _cross == CrossAxisAlignment.baseline) {
                  _cross = CrossAxisAlignment.center;
                }
              }),
            ),
            _dropdown('mainAxisAlignment', _main, MainAxisAlignment.values,
                (v) => setState(() => _main = v)),
            _dropdown(
                'crossAxisAlignment',
                _cross,
                CrossAxisAlignment.values
                    .where((v) => _isRow || v != CrossAxisAlignment.baseline)
                    .toList(),
                (v) => setState(() => _cross = v)),
            _dropdown('mainAxisSize', _size, MainAxisSize.values,
                (v) => setState(() => _size = v)),
            _dropdown('verticalDirection', _vertical, VerticalDirection.values,
                (v) => setState(() => _vertical = v)),
            _dropdown('textDirection', _text, TextDirection.values,
                (v) => setState(() => _text = v)),
          ],
        ),
      ),
    );
  }

  Widget _dropdown<T extends Enum>(
    String label,
    T value,
    List<T> values,
    ValueChanged<T> onChanged,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$label: '),
        DropdownButton<T>(
          value: value,
          items: [
            for (final v in values) DropdownMenuItem(value: v, child: Text(v.name)),
          ],
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ],
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({required this.text, required this.color, required this.size});

  final String text;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: color,
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(fontSize: size / 2)),
    );
  }
}
