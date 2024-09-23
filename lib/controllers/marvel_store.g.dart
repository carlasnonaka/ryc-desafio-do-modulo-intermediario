// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marvel_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MarvelStore on _MarvelStore, Store {
  late final _$seriesFutureAtom =
      Atom(name: '_MarvelStore.seriesFuture', context: context);

  @override
  ObservableFuture<List<Series>>? get seriesFuture {
    _$seriesFutureAtom.reportRead();
    return super.seriesFuture;
  }

  @override
  set seriesFuture(ObservableFuture<List<Series>>? value) {
    _$seriesFutureAtom.reportWrite(value, super.seriesFuture, () {
      super.seriesFuture = value;
    });
  }

  late final _$fetchSeriesAsyncAction =
      AsyncAction('_MarvelStore.fetchSeries', context: context);

  @override
  Future<void> fetchSeries() {
    return _$fetchSeriesAsyncAction.run(() => super.fetchSeries());
  }

  @override
  String toString() {
    return '''
seriesFuture: ${seriesFuture}
    ''';
  }
}
