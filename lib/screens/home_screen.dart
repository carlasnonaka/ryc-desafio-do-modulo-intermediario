import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controllers/marvel_store.dart';
import 'package:mobx/mobx.dart';
import '../screens/details_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MarvelStore store = MarvelStore();

   @override
  void initState() {
    super.initState();
    // Chama a API uma vez quando o widget é montado
    store.fetchSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Marvel Series')),
      body: Observer(
        builder: (_) {
          final future = store.seriesFuture;

          if (future == null || future.status == FutureStatus.pending) {
            // Estado de loading
            return Center(child: CircularProgressIndicator());
          } else if (future.status == FutureStatus.fulfilled) {
            // Estado de sucesso: exibe os dados
            final series = future.result;
            return ListView.builder(
              itemCount: series.length,
              itemBuilder: (context, index) {
                  final currentSeries = series[index];
                  final imageUrl = '${currentSeries.thumbnail.path}.${currentSeries.thumbnail.extension}';
                  return ListTile(
                  title: Text(currentSeries.title),
                  subtitle: Text(currentSeries.description ?? 'Sem descrição'),
                  onTap: () {
                    // Navega para a página de detalhes ao clicar
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          title: currentSeries.title,
                          description: currentSeries.description,
                          imageUrl: imageUrl,
                        ),
                      ),
                    );
                  },
                   leading: Hero(
        tag: currentSeries.id.toString(), // Usa o ID como tag para animação
        child: Image.network(imageUrl, width: 50, fit: BoxFit.cover), // Imagem na lista
                )
                );
              },
            );
          } else if (future.status == FutureStatus.rejected) {
            // Estado de erro
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Erro ao carregar séries'),
                  ElevatedButton(
                    onPressed: store.fetchSeries, // Retentar buscar os dados
                    child: Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          return Container(); // Estado padrão
        },
      ),
    );
  }
}
