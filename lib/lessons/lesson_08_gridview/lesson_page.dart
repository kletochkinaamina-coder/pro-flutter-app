// Урок 8. GridView.
// Задание: разобрать конструкторы GridView:
// GridView.count, GridView.extent, GridView.builder, GridView.custom.

import 'package:flutter/material.dart';

/// Экран урока 8. Открывается из главного меню.
class Lesson08Page extends StatelessWidget {
  const Lesson08Page({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GridView'),
          bottom: const TabBar(tabs: [
            Tab(text: 'count'),
            Tab(text: 'extent'),
            Tab(text: 'builder'),
            Tab(text: 'custom'),
          ]),
        ),
        body: const TabBarView(children: [
          CountGrid(),
          ExtentGrid(),
          BuilderGrid(),
          CustomGrid(),
        ]),
      ),
    );
  }
}

class GridTileBox extends StatelessWidget {
  const GridTileBox(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    final color = Colors.primaries[index % Colors.primaries.length];
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text('$index', style: const TextStyle(fontSize: 24)),
    );
  }
}

/// GridView.count: фиксированное количество колонок.
class CountGrid extends StatelessWidget {
  const CountGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      children: [for (var i = 0; i < 24; i++) GridTileBox(i)],
    );
  }
}

/// GridView.extent: задаём максимальную ширину плитки,
/// количество колонок считается само (удобно для планшетов и web).
class ExtentGrid extends StatelessWidget {
  const ExtentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 150,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      children: [for (var i = 0; i < 24; i++) GridTileBox(i)],
    );
  }
}

/// GridView.builder: ленивое построение, подходит для больших и бесконечных сеток.
class BuilderGrid extends StatelessWidget {
  const BuilderGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3 / 2, // ширина к высоте
      ),
      itemCount: 100,
      itemBuilder: (context, index) => GridTileBox(index),
    );
  }
}

/// GridView.custom: свой gridDelegate + childrenDelegate.
class CustomGrid extends StatelessWidget {
  const CustomGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) => GridTileBox(index * 2),
        childCount: 40,
      ),
    );
  }
}
