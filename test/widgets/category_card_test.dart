import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:statusquotes/widgets/category_card.dart';
import 'package:statusquotes/models/models.dart';

void main() {
  Function onPressed = () {};
  QuoteCategory testCategory = QuoteCategory(
    avatar: "",
    name: 'expected category',
    emoji: "🤔",
    amount: 999,
    id: 0,
  );

  group('CategoryCard should', () {
    testWidgets('contain expected category, amount and emoji when created',
        (WidgetTester tester) async {
      await tester.pumpWidget(_wrap(CategoryCard(
        category: testCategory,
        onPressed: onPressed,
      )));

      final categoryFinder = find.textContaining(testCategory.name);
      expect(categoryFinder, findsOneWidget);

      final amountFinder = find.textContaining(testCategory.amount.toString());
      expect(amountFinder, findsOneWidget);

      final emojiFinder = find.textContaining(testCategory.emoji);
      expect(emojiFinder, findsOneWidget);
    });
  });
}

Widget _wrap(Widget child) => MaterialApp(
      home: Scaffold(body: child),
    );
