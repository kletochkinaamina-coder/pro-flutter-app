/// Данные, которые передаём между экранами.
class Product {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.emoji,
  });

  final int id;
  final String title;
  final int price;
  final String emoji;

  static const demo = [
    Product(id: 1, title: 'Кофе', price: 1200, emoji: '☕'),
    Product(id: 2, title: 'Круассан', price: 900, emoji: '🥐'),
    Product(id: 3, title: 'Чизкейк', price: 1800, emoji: '🍰'),
  ];
}
