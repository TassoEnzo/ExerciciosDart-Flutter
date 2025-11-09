import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GridView Exercicio',
      home: GridViewPage(),
    );
  }
}

class GridViewPage extends StatelessWidget {
  const GridViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> lugares = [
      {
        'titulo': 'Hollow Knight',
        'imagem': 'assets/images/Hollow_Knight.png'
      },
      {
        'titulo': 'God of War',
        'imagem': 'assets/images/God_Of_War.png'
      },
      {
        'titulo': 'The Witcher 3',
        'imagem': 'assets/images/TW3.png'
      },
      {
        'titulo': 'Cyberpunk 2077',
        'imagem': 'assets/images/Cyberpunk.png'
      },
      {
        'titulo': 'Red Dead Redemption 2',
        'imagem': 'assets/images/Red_Dead.png'
      },
      {
        'titulo': 'Elden Ring',
        'imagem': 'assets/images/Elden_Ring.png'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView de Lugares'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: lugares.length,
          itemBuilder: (context, index) {
            final lugar = lugares[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    lugar['imagem']!,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      color: Colors.black87,
                      width: double.infinity,
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        lugar['titulo']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
