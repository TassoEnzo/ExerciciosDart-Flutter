import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskScreen(),
    );
  }
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addTask() async {
    final now = DateTime.now();
    await _firestore.collection('tasks').add({
      'description': 'Task criada em ${now.toLocal()}',
      'date': '${now.day}/${now.month}/${now.year}',
      'time': '${now.hour}:${now.minute.toString().padLeft(2, '0')}',
      'finished': false,
    });
  }

  Future<void> _updateTask(String id, bool value) async {
    await _firestore.collection('tasks').doc(id).update({'finished': value});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefas Firebase"),
        backgroundColor: Colors.blue,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Nenhuma tarefa encontrada."));
          }

          final tasks = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final data = task.data() as Map<String, dynamic>;

              return Card(
                color: data['finished'] ? Colors.green[300] : Colors.yellow[700],
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: Text(data['description'] ?? ''),
                  subtitle: Text(
                    "Data: ${data['date']} • Hora: ${data['time']}",
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Checkbox(
                    value: data['finished'] ?? false,
                    onChanged: (value) => _updateTask(task.id, value!),
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}