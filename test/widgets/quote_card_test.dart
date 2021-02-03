import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:statusquotes/models/models.dart';
import 'package:statusquotes/widgets/quote_card.dart';
import 'package:statusquotes/stores/quote_store.dart';
import 'package:statusquotes/stores/favorities_store.dart';

Quote testQuote = Quote(
    author: 'Test Author',
    content: 'Test Content',
    languageId: 1,
    authorId: 0,
    id: 999,
    rating: 999,
    emoji: '🧐',
    categoryId: 0);

void main() {
  group('QuoteCard should', () {
    testWidgets(
        'contain expected author, content and to BE NOT favored if it IS NOT in favorites in state (MobX)',
        (WidgetTester tester) async {
      await tester.pumpWidget(_wrap(
          addToFav: false,
          removeFromFav: false,
          child: QuoteCard(
            quote: testQuote,
          )));

      final contentFinder = find.textContaining(testQuote.content);
      expect(contentFinder, findsOneWidget);

      final authorFinder = find.textContaining(testQuote.author);
      expect(authorFinder, findsOneWidget);

      final isFavoriteIconFinder = find.byIcon(Icons.favorite_border);
      expect(isFavoriteIconFinder, findsOneWidget);
    });

    testWidgets(
        'contain expected author, content and to BE favored if it IS in favorites in state (MobX)',
        (WidgetTester tester) async {
      await tester.pumpWidget(_wrap(
          addToFav: true,
          removeFromFav: false,
          child: QuoteCard(
            quote: testQuote,
          )));

      final contentFinder = find.textContaining(testQuote.content);
      expect(contentFinder, findsOneWidget);

      final authorFinder = find.textContaining(testQuote.author);
      expect(authorFinder, findsOneWidget);

      final isFavoriteIconFinder = find.byIcon(Icons.favorite);
      expect(isFavoriteIconFinder, findsOneWidget);
    });

    testWidgets(
        'contain all the shit and not BE favored if it added and then removed from favorites in state (MobX)',
        (WidgetTester tester) async {
      await tester.pumpWidget(_wrap(
          addToFav: true,
          removeFromFav: true,
          child: QuoteCard(
            quote: testQuote,
          )));

      final contentFinder = find.textContaining(testQuote.content);
      expect(contentFinder, findsOneWidget);

      final authorFinder = find.textContaining(testQuote.author);
      expect(authorFinder, findsOneWidget);

      final isFavoriteIconFinder = find.byIcon(Icons.favorite_border);
      expect(isFavoriteIconFinder, findsOneWidget);
    });
  });
}

Widget _wrap(
        {@required Widget child,
        @required bool addToFav,
        @required bool removeFromFav}) =>
    MultiProvider(
      providers: [
        Provider<QuoteStore>(create: (_) => QuoteStore.create()),
        Provider<FavoritiesStore>(create: (_) => FavoritiesStore.create()),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              //обращение к стору для избранного
              final favStore = Provider.of<FavoritiesStore>(context);
              if (addToFav) {
                favStore.switchFavs(testQuote);
              }

              if (removeFromFav) {
                favStore.switchFavs(testQuote);
              }

              return child;
            },
          ),
        ),
      ),
    );
