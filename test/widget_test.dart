import 'package:flutter_test/flutter_test.dart';
import 'package:pro_flutter_app/main.dart';

void main() {
  testWidgets('Главное меню показывает уроки и открывает урок', (tester) async {
    await tester.pumpWidget(const ProFlutterApp());

    expect(find.text('Pro Flutter'), findsOneWidget);
    expect(find.text('Stateless виджеты'), findsOneWidget);

    await tester.tap(find.text('Stateless виджеты'));
    await tester.pumpAndSettle();

    expect(find.text('StatelessWidget'), findsOneWidget);
  });
}
