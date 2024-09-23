import 'package:mobx/mobx.dart';
import '../models/series.dart';
import '../services/marvel_api.dart';

part 'marvel_store.g.dart';

class MarvelStore = _MarvelStore with _$MarvelStore;

abstract class _MarvelStore with Store {
  @observable
  ObservableFuture<List<Series>>? seriesFuture;

 @action
  Future<void> fetchSeries() async {
    try {
      // Aqui, chamamos a API e atribuimos o resultado ao ObservableFuture
      seriesFuture = ObservableFuture(MarvelApi.getSeries());
      await seriesFuture;  // Espera a conclusão do Future
    } catch (e) {
      print('Erro ao carregar séries: $e');
      seriesFuture = ObservableFuture.error(e);  // Se falhar, armazena o erro
    }
  }
}
