import 'package:flutter/material.dart';

import '../models/product.dart';

/// Экран получает данные через конструктор (способы 1 и 3).
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.product, required this.source});

  final Product product;
  final String source;

  @override
  Widget build(BuildContext context) {
    return _ProductView(product: product, source: source);
  }
}

/// Экран сам достаёт данные из arguments текущего маршрута (способ 2).
class ProductFromArgumentsScreen extends StatelessWidget {
  const ProductFromArgumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    return _ProductView(product: product, source: 'arguments + ModalRoute.of');
  }
}

class _ProductView extends StatelessWidget {
  const _ProductView({required this.product, required this.source});

  final Product product;
  final String source;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(product.emoji, style: const TextStyle(fontSize: 96)),
            Text(product.title, style: text.headlineMedium),
            Text('${product.price} ₸', style: text.titleLarge),
            const SizedBox(height: 24),
            Chip(label: Text('Данные пришли через: $source')),
            const SizedBox(height: 8),
            Text('id = ${product.id}'),
          ],
        ),
      ),
    );
  }
}
