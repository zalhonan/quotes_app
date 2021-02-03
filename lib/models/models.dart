import 'package:flutter/material.dart';
import 'dart:convert';

class Quote {
  Quote({
    this.id,
    this.categoryId,
    this.rating,
    this.authorId,
    this.author,
    this.languageId,
    this.content,
    this.emoji,
  });

  final int id;
  final int categoryId;
  final int rating;
  final int authorId;
  final String author;
  final int languageId;
  final String content;
  final String emoji;

  factory Quote.fromJson(Map<String, dynamic> jsonData) {
    return Quote(
      id: jsonData["id"],
      categoryId: jsonData["categoryId"],
      rating: jsonData["rating"],
      authorId: jsonData["authorId"],
      author: jsonData["author"],
      languageId: jsonData["languageId"],
      content: jsonData["content"],
      emoji: jsonData["emoji"],
    );
  }

  static Map<String, dynamic> toMap(Quote quote) => {
        'id': quote.id,
        'categoryId': quote.categoryId,
        'rating': quote.rating,
        'authorId': quote.authorId,
        'author': quote.author,
        'languageId': quote.languageId,
        'content': quote.content,
        'emoji': quote.emoji,
      };

  static String encode(List<Quote> quotes) => json.encode(
        quotes
            .map<Map<String, dynamic>>((quote) => Quote.toMap(quote))
            .toList(),
      );

  static List<Quote> decode(String quote) =>
      (json.decode(quote) as List<dynamic>)
          .map<Quote>((item) => Quote.fromJson(item))
          .toList();
}

class QuoteCategory {
  QuoteCategory({this.id, this.name, this.emoji, this.avatar, this.amount});

  final int id;
  final String name;
  final String emoji;
  final String avatar;
  final int amount;
}

class Author {
  Author({this.id, this.name, this.avatar});

  final int id;
  final String name;
  final String avatar;
}

class QuoteFontSize {
  QuoteFontSize({this.name, this.quoteSize, this.authorSize});

  final String name;
  final int quoteSize;
  final int authorSize;
}

class TextShadow {
  TextShadow({this.name, this.quoteShadow, this.textColor});

  final String name;
  final List<Shadow> quoteShadow;
  final Color textColor;
}
