import 'dart:convert'; // Para converter strings em bytes
import 'package:crypto/crypto.dart'; // Para gerar o hash
import 'package:http/http.dart' as http;
import '../models/series.dart';

class MarvelApi {
  static const String publicKey = '37aaeb3af4586fdd33b69ea10a3dc351';
  static const String privateKey = '523b8f24344acf114742164ceb023985077326bb';
  static const String baseUrl = 'http://gateway.marvel.com/';

  // Função para buscar as séries e retornar uma lista de objetos "Series"
  static Future<List<Series>> getSeries() async {
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    final String hash = _generateHash(timestamp);

    final url = Uri.parse(
      '${baseUrl}v1/public/series?ts=$timestamp&apikey=$publicKey&hash=$hash'
    );

    // Fazendo a requisição HTTP GET
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Se a requisição for bem-sucedida, faça o parsing do JSON
      final data = jsonDecode(response.body);
      
      // Converte o JSON para uma lista de objetos Series
      List<Series> seriesList = (data['data']['results'] as List)
          .map((item) => Series.fromJson(item))
          .toList();
      
      // Retorna a lista de séries
      return seriesList;
    } else {
      // Se a requisição falhar, lance uma exceção
      throw Exception('Erro ao carregar séries');
    }
  }

  static String _generateHash(int timestamp) {
    // Gera o hash para autenticação (exemplo MD5)
    final input = '$timestamp$privateKey$publicKey';
    final bytes = utf8.encode(input);
    final digest = md5.convert(bytes);
    return digest.toString();
  }
}