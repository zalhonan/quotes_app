@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';

import 'package:statusquotes/stores/quote_store.dart';
import 'package:statusquotes/models/models.dart';

Quote testQuote = Quote(
    author: 'Test Author',
    content: 'Test Content',
    languageId: 1,
    authorId: 0,
    id: 999,
    rating: 999,
    emoji: '🧐',
    categoryId: 0);

QuoteCategory testCategory = QuoteCategory(
  id: 0,
  amount: 999,
  emoji: '🧐',
  name: 'Test name',
  avatar: '',
);

main() {
  group('QuoteStore', () {
    test('has expected Category and Quote when Category and Quote are set', () {
      final store = QuoteStore.create();

      store.setQuote(testQuote);
      store.setCategory(testCategory);

      expect(store.currentQuote == testQuote, isTrue);
      expect(store.currentCategory == testCategory, isTrue);
    });
  });
}
