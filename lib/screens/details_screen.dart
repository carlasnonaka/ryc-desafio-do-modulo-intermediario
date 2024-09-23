import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final String? description;
  final String imageUrl;

  const DetailsScreen({
    required this.title,
    this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(imageUrl,
                  height: 300), // Exibe a imagem da série
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(description ?? 'Sem descrição disponível'),
          ],
        ),
      ),
    );
  }
}
