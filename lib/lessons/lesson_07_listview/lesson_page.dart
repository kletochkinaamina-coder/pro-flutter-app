// Урок 7. ListView.
// Задание: разобрать все конструкторы ListView:
// ListView(children), ListView.builder (бесконечный список),
// ListView.separated (с разделителями), ListView.custom.

import 'package:flutter/material.dart';

/// Экран урока 7. Открывается из главного меню.
class Lesson07Page extends StatelessWidget {
  const Lesson07Page({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('ListView'),
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'children'),
                Tab(text: 'builder'),
                Tab(text: 'separated'),
                Tab(text: 'custom'),
                Tab(text: 'horizontal'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              SimpleListView(),
              InfiniteListView(),
              SeparatedListView(),
              CustomListView(),
              HorizontalListView(),
            ],
          ),
        ),
      );
  }
}

class NumberTile extends StatelessWidget {
  const NumberTile(this.number, {super.key});

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('$number', style: const TextStyle(fontSize: 28)),
    );
  }
}

/// 1. ListView(children): все элементы создаются сразу. Подходит для коротких списков.
class SimpleListView extends StatelessWidget {
  const SimpleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      // physics: const NeverScrollableScrollPhysics(), // запретить прокрутку
      // reverse: true,                                  // список снизу вверх
      children: [for (var i = 1; i <= 10; i++) NumberTile(i)],
    );
  }
}

/// 2. ListView.builder: элементы создаются только когда видны на экране.
/// Без itemCount список бесконечный.
class InfiniteListView extends StatelessWidget {
  const InfiniteListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => NumberTile(index),
    );
  }
}

/// 3. ListView.separated: между элементами строится разделитель. itemCount обязателен.
class SeparatedListView extends StatelessWidget {
  const SeparatedListView({super.key});

  static const _cities = ['Алматы', 'Астана', 'Шымкент', 'Караганда', 'Актобе', 'Тараз'];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _cities.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(_cities[index]),
        trailing: const Icon(Icons.chevron_right),
      ),
      separatorBuilder: (context, index) => const Divider(height: 1),
    );
  }
}

/// 4. ListView.custom: полный контроль через SliverChildDelegate.
class CustomListView extends StatelessWidget {
  const CustomListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.custom(
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) => NumberTile(index * index),
        childCount: 30,
      ),
    );
  }
}

/// 5. Горизонтальный список с начальным смещением через ScrollController.
class HorizontalListView extends StatelessWidget {
  const HorizontalListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: ScrollController(initialScrollOffset: 100),
          itemCount: 20,
          itemBuilder: (context, index) =>
              SizedBox(width: 100, child: NumberTile(index)),
        ),
      ),
    );
  }
}
