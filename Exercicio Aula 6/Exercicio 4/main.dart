import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final base = ThemeData.dark();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercicio Responsividade',
      theme: base.copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: base.appBarTheme.copyWith(backgroundColor: Colors.black),
        textTheme: base.textTheme.copyWith(
          titleLarge: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white),
          bodyMedium: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ),
      home: const ResponsivePage(),
    );
  }
}

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  static const List<String> languages = ['Dart', 'JavaScript', 'PHP', 'C++'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Layouts'),
        centerTitle: true,
        elevation: 0,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;
          final padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
          return Padding(
            padding: padding,
            child: isPortrait ? _portrait(context) : _landscape(context),
          );
        },
      ),
    );
  }

  Widget _portrait(BuildContext context) {
    final mq = MediaQuery.of(context);
    final double btnWidth = (mq.size.width * 0.28).clamp(90.0, 160.0);
    final double btnHeight = 40.0;
    final double tileWidth = (mq.size.width * 0.9).clamp(200.0, 600.0);
    const double tileHeight = 72.0;

    return Column(
      children: [
        const SizedBox(height: 8),
        Text('Cheetah Coding', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: btnWidth,
              height: btnHeight,
              child: ElevatedButton(onPressed: () {}, child: const Text('BUTTON 1')),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: btnWidth,
              height: btnHeight,
              child: ElevatedButton(onPressed: () {}, child: const Text('BUTTON 2')),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            itemCount: languages.length,
            separatorBuilder: (_, __) => const Divider(color: Colors.white24, height: 1),
            itemBuilder: (context, index) {
              return Center(
                child: Container(
                  width: tileWidth,
                  height: tileHeight,
                  alignment: Alignment.center,
                  child: Text(languages[index], style: Theme.of(context).textTheme.bodyMedium),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _landscape(BuildContext context) {
    final mq = MediaQuery.of(context);
    final double leftColWidth = (mq.size.width * 0.38).clamp(220.0, mq.size.width * 0.5);
    final double btnWidth = (leftColWidth * 0.6).clamp(140.0, 340.0);
    const double btnHeight = 48.0;
    final double tileWidth = (mq.size.width - leftColWidth - 64).clamp(200.0, 700.0);
    const double tileHeight = 72.0;
    return Row(
      children: [
        SizedBox(
          width: leftColWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Cheetah Coding', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 20),
              SizedBox(
                width: btnWidth,
                height: btnHeight,
                child: ElevatedButton(onPressed: () {}, child: const Text('BUTTON 1')),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: btnWidth,
                height: btnHeight,
                child: ElevatedButton(onPressed: () {}, child: const Text('BUTTON 2')),
              ),
            ],
          ),
        ),

        const VerticalDivider(width: 32, thickness: 1, color: Colors.white24),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 24),
            itemCount: languages.length,
            separatorBuilder: (_, __) => const Divider(color: Colors.white24, height: 1),
            itemBuilder: (context, index) {
              return Center(
                child: Container(
                  width: tileWidth,
                  height: tileHeight,
                  alignment: Alignment.center,
                  child: Text(languages[index], style: Theme.of(context).textTheme.bodyMedium),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}