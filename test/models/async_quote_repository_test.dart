@TestOn('vm')
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:statusquotes/models/async_quote_repository.dart';
import 'package:statusquotes/models/models.dart';
import 'package:statusquotes/services/constants.dart';

class MockClient extends Mock implements http.Client {}

main() {
  group('getRandomQuote', () {
    test('returns Quote if the http call completes successfully', () async {
      final client = MockClient();

      final repository = AsyncQuoteRepository(client: client);

      const exampleQuote =
          '{"id":67,"rating":0,"content":"Peace comes from within. Do not seek it without.","emoji":"","author_id":1,"category_id":7,"language_id":1}';
      when(client.get(
        kQuotesApi + "random_quote/?language=en&author=1",
        headers: anyNamed("headers"),
      )).thenAnswer(
          (Invocation _) => Future.value(http.Response(exampleQuote, 200)));

      expect(await repository.getQuoteOfTheDayFromAPI('en', 1), isA<Quote>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      final repository = AsyncQuoteRepository(client: client);

      when(client.get(
        kQuotesApi + "random_quote/?language=en&author=1",
        headers: anyNamed("headers"),
      )).thenAnswer(
          (Invocation _) => Future.value(http.Response('Not Found', 404)));

      expect(repository.getQuoteOfTheDayFromAPI('en', 1), throwsException);
    });
  });

  group('getCategoriesFromApi', () {
    test('returns List of Categories if the http call completes successfully',
        () async {
      final client = MockClient();

      final repository = AsyncQuoteRepository(client: client);

      const exampleCategoriesList = '[]';
      when(client.get(
        kQuotesApi + "categories/",
        headers: anyNamed("headers"),
      )).thenAnswer((Invocation _) =>
          Future.value(http.Response(exampleCategoriesList, 200)));

      expect(await repository.getCategoriesFromAPI(kLang),
          isA<List<QuoteCategory>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      final repository = AsyncQuoteRepository(client: client);

      when(client.get(
        kQuotesApi + "categories/",
        headers: anyNamed("headers"),
      )).thenAnswer(
          (Invocation _) => Future.value(http.Response('Not Found', 404)));

      expect(repository.getCategoriesFromAPI(kLang), throwsException);
    });
  });

  group('getQuotesFromApi', () {
    test('returns List of Quotes if the http call completes successfully',
        () async {
      final client = MockClient();

      final repository = AsyncQuoteRepository(client: client);

      const exampleQuotesList = '[]';
      when(client.get(
        kQuotesApi + "quotes/?language=en&author=1&category=1",
        headers: anyNamed("headers"),
      )).thenAnswer((Invocation _) =>
          Future.value(http.Response(exampleQuotesList, 200)));

      expect(await repository.getQuotesFromAPI('en', 1, 1), isA<List<Quote>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      final repository = AsyncQuoteRepository(client: client);

      when(client.get(
        kQuotesApi + "quotes/?language=en&author=1&category=1",
        headers: anyNamed("headers"),
      )).thenAnswer(
          (Invocation _) => Future.value(http.Response('Not Found', 404)));

      expect(repository.getQuotesFromAPI('en', 1, 1), throwsException);
    });
  });
}
