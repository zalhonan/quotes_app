// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorities_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$_FavoritiesImpl on FavoritiesStore, Store {
  final _$favIdsListAtom = Atom(name: 'FavoritiesStore.favIdsList');

  @override
  ObservableList<int> get favIdsList {
    _$favIdsListAtom.reportRead();
    return super.favIdsList;
  }

  @override
  set favIdsList(ObservableList<int> value) {
    _$favIdsListAtom.reportWrite(value, super.favIdsList, () {
      super.favIdsList = value;
    });
  }

  final _$favQuotesListAtom = Atom(name: 'FavoritiesStore.favQuotesList');

  @override
  ObservableList<Quote> get favQuotesList {
    _$favQuotesListAtom.reportRead();
    return super.favQuotesList;
  }

  @override
  set favQuotesList(ObservableList<Quote> value) {
    _$favQuotesListAtom.reportWrite(value, super.favQuotesList, () {
      super.favQuotesList = value;
    });
  }

  final _$FavoritiesStoreActionController =
      ActionController(name: 'FavoritiesStore');

  @override
  void switchFavs(Quote quote) {
    final _$actionInfo = _$FavoritiesStoreActionController.startAction(
        name: 'FavoritiesStore.switchFavs');
    try {
      return super.switchFavs(quote);
    } finally {
      _$FavoritiesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favIdsList: ${favIdsList},
favQuotesList: ${favQuotesList}
    ''';
  }
}
