import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Home Page'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0, // remove sombra da AppBar
      ),
      body: Column(
        children: [
          // Linha azul abaixo da AppBar
          Container(
            height: 2,
            color: const Color.fromARGB(255, 0, 95, 173),
          ),

          // Espaço entre a linha e o conteúdo
          const SizedBox(height: 40),

          // Conteúdo centralizado no topo
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Hello, World!',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 0, 95, 173),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 95, 173),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    // ação do botão
                  },
                  child: const Text('A button'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}