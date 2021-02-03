@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';

import 'package:statusquotes/stores/favorities_store.dart';
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

main() {
  group('FavoritiesStore', () {
    test('is empty when created', () {
      final store = FavoritiesStore.create();

      expect(store.favIdsList.isEmpty, isTrue);
      expect(store.favQuotesList.isEmpty, isTrue);
    });

    test('has an expected Quote when a Quote added', () {
      final store = FavoritiesStore.create();

      store.switchFavs(testQuote);

      expect(store.favIdsList.contains(testQuote.id), isTrue);
      expect(store.favIdsList.length == 1, isTrue);

      expect(store.favQuotesList.contains(testQuote), isTrue);
      expect(store.favQuotesList.length == 1, isTrue);
    });

    test('is empty when Quote added and removed', () {
      final store = FavoritiesStore.create();

      store.switchFavs(testQuote);
      store.switchFavs(testQuote);

      expect(store.favIdsList.isEmpty, isTrue);
      expect(store.favQuotesList.isEmpty, isTrue);
    });
  });
}
