import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BottomAppBar with FAB',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentTab = 0;

  void _selectedTab(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BottomAppBar with FAB"),
      ),
      body: Center(
        child: Text(
          "TAB: $_currentTab",
          style: const TextStyle(fontSize: 28),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.message, color: Colors.blue),
            label: 'Message',
            onTap: () => print("Message tapped"),
          ),
          SpeedDialChild(
            child: const Icon(Icons.mail, color: Colors.blue),
            label: 'Mail',
            onTap: () => print("Mail tapped"),
          ),
          SpeedDialChild(
            child: const Icon(Icons.phone, color: Colors.blue),
            label: 'Call',
            onTap: () => print("Call tapped"),
          ),
        ],
      ),
    
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabItem(Icons.menu, "This", 0),
            _buildTabItem(Icons.layers, "Is", 1),
            const SizedBox(width: 48), // espaço do FAB
            _buildTabItem(Icons.dashboard, "Bottom", 2),
            _buildTabItem(Icons.info, "Bar", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(IconData icon, String text, int index) {
    final color = _currentTab == index ? Colors.red : Colors.black;
    return InkWell(
      onTap: () => _selectedTab(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            Text(text, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}