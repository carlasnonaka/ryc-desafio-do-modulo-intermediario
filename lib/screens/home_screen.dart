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
                final imageUrl =
                    '${currentSeries.thumbnail.path}.${currentSeries.thumbnail.extension}';
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Color(0xFF333333), // Cor de fundo para o card
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Exibição da imagem (thumbnail)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              10), // Bordas arredondadas para a imagem
                          child: Image.network(
                            imageUrl,
                            height: 200, // Altura da imagem
                            width: 200, // Largura total
                            fit: BoxFit.cover, // Cobrir a área sem distorcer
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                                size: 50,
                              ); // Ícone de imagem quebrada se houver erro
                            },
                          ),
                        ),
                        SizedBox(height: 8),
                        // Título da série
                        Text(
                          series[index].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        // Botão de ver detalhes
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color(0xFFED1D24), // Cor vermelha Marvel
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Bordas arredondadas
                            ),
                            elevation: 5, // Sombra
                          ),
                          onPressed: () {
                            // Navegar para a página de detalhes
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  title: series[index].title,
                                  description: series[index].description,
                                  imageUrl:
                                      '${series[index].thumbnail.path}.${series[index].thumbnail.extension}',
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Ver Detalhes',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (future.status == FutureStatus.rejected) {
            // Estado de erro
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Erro ao carregar séries',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: store.fetchSeries, // Retentar buscar os dados
                    child: Text('Tentar novamente',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFED1D24), // Cor vermelha Marvel
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Bordas arredondadas
                      ),
                      elevation: 5, // Sombra
                    ),
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
