// Урок 15. Передача параметров между экранами.
// Задание: передать данные на другой экран тремя способами:
//  1) через конструктор (анонимный маршрут),
//  2) через arguments в Navigator.pushNamed,
//  3) через onGenerateRoute (свой генератор маршрутов).

import 'package:flutter/material.dart';

import 'models/product.dart';
import 'screens/product_screen.dart';

/// Имена маршрутов и генератор для урока.
/// Главное приложение вызывает ParamsRoutes.generate из onGenerateRoute.
abstract class ParamsRoutes {
  static const home = '/params';
  static const product = '/params/product';
  static const productArgs = '/params/product-args';

  static Route<dynamic>? generate(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case product:
        // Проверяем тип аргумента, прежде чем отдавать его экрану.
        if (args is Product) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                ProductScreen(product: args, source: 'onGenerateRoute'),
          );
        }
        return _error('Для $product нужен аргумент Product');

      case productArgs:
        // settings передаём дальше, чтобы экран мог прочитать arguments сам.
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ProductFromArgumentsScreen(),
        );
    }
    return null; // не наш маршрут
  }

  static Route<dynamic> _error(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Ошибка')),
        body: Center(child: Text(message)),
      ),
    );
  }
}

class Lesson15Page extends StatelessWidget {
  const Lesson15Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Передача параметров')),
      body: ListView.separated(
        itemCount: Product.demo.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, i) {
          final p = Product.demo[i];
          return ExpansionTile(
            leading: CircleAvatar(child: Text(p.emoji)),
            title: Text(p.title),
            subtitle: Text('${p.price} ₸'),
            children: [
              Wrap(
                spacing: 8,
                children: [
                  // 1. Через конструктор
                  ActionChip(
                    label: const Text('Конструктор'),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductScreen(product: p, source: 'конструктор'),
                      ),
                    ),
                  ),
                  // 2. Через arguments: экран сам достаёт их из ModalRoute
                  ActionChip(
                    label: const Text('arguments'),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      ParamsRoutes.productArgs,
                      arguments: p,
                    ),
                  ),
                  // 3. Через onGenerateRoute: генератор проверяет аргументы
                  // и передаёт их в конструктор экрана
                  ActionChip(
                    label: const Text('onGenerateRoute'),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      ParamsRoutes.product,
                      arguments: p,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        // Маршрут без аргумента: покажется экран ошибки из генератора.
        onPressed: () => Navigator.pushNamed(context, ParamsRoutes.product),
        label: const Text('Без аргумента'),
        icon: const Icon(Icons.error_outline),
      ),
    );
  }
}
