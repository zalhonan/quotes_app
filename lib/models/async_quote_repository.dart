import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import '../services/constants.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:easy_localization/easy_localization.dart';

class AsyncQuoteRepository {
  //передаём клиент в конструктор для удобства мокирования
  http.Client client;

  AsyncQuoteRepository({@required this.client});

  // адаптер для перевода ответа сервера в модель Quote
  Quote _responseToQuote(Map<dynamic, dynamic> responseMap) {
    return Quote(
      id: responseMap["id"],
      categoryId: responseMap["category_id"],
      rating: responseMap["rating"],
      authorId: responseMap["author_id"],
      author: 'fixedAuthor'.tr(),
      languageId: responseMap["language_id"],
      content: responseMap["content"],
      emoji: responseMap["emoji"],
    );
  }

  Future<Quote> getQuoteOfTheDayFromAPI(String language, int author) async {
    // ходит по адресу из константы и возвращает случайную цитату по языку и автору

    String url =
        kQuotesApi + "random_quote/?language=${language}&author=${author}";
    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // utf8
      String source = Utf8Decoder().convert(response.bodyBytes);
      Map responseMap = json.decode(source);
      // парсинг в изоляте - демо
      // return compute(_responseToQuote, responseMap);
      return _responseToQuote(responseMap);
    } else {
      throw Exception('Failed ' + response.statusCode.toString());
    }
  }

  Future<List<QuoteCategory>> getCategoriesFromAPI(String language) async {
    // возвращает список категорий из API

    List<QuoteCategory> res = []; //TODO заменить на []
    String url = kQuotesApi + "categories/";

    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // utf8
      String source = Utf8Decoder().convert(response.bodyBytes);

      var responseListMap = json.decode(source);

      for (var category in responseListMap) {
        if (category["count_${language}"] > 0) {
          res.add(
            QuoteCategory(
              name: category["name_${language}"],
              amount: category["count_${language}"],
              id: category["id"],
              emoji: category["emoji"],
              avatar: category["avatar"],
            ),
          );
        }
      }
      return res;
    } else {
      throw Exception('Failed ' + response.statusCode.toString());
    }
  }

  Future<List<Quote>> getQuotesFromAPI(
      String language, int author, int category) async {
    // возвращает цитаты по языку, автору и категории

    List<Quote> res = []; //TODO заменить на []

    String url = kQuotesApi +
        "quotes/?language=${language}&author=${author}&category=${category}";
    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // utf8
      String source = Utf8Decoder().convert(response.bodyBytes);

      var responseListMap = json.decode(source);

      for (var quote in responseListMap) {
        res.add(_responseToQuote(quote));
      }
      return res;
    } else {
      throw Exception('Failed ' + response.statusCode.toString());
    }
  }
}
