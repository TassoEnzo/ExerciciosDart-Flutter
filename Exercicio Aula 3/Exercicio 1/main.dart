<<<<<<< HEAD
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            'Flutter is Fun!',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 100, left: 100),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
              child: const Text('Hi Mom 🐣',
              textAlign: TextAlign.center,)
            ),
          ),
        ),
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            'Flutter is Fun!',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 100, left: 100),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
              child: const Text('Hi Mom 🐣',
              textAlign: TextAlign.center,)
            ),
          ),
        ),
      ),
    );
  }
}
>>>>>>> 3a656b2e9e71d4bb8465e9dc2c4dbeef97b9c1d1
