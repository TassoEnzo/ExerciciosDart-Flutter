// lib/main.dart
import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService api = ApiService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSONPlaceholder Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(api: api),
    );
  }
}

class HomePage extends StatefulWidget {
  final ApiService api;
  HomePage({required this.api});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() {
    _postsFuture = widget.api.getPosts();
  }

  Future<void> _refresh() async {
    setState(() {
      _loadPosts();
    });
  }

  void _openCreate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PostFormPage(api: widget.api)),
    );
    if (result == true) {
      _refresh();
    }
  }

  void _openDetail(Map<String, dynamic> post) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailPage(api: widget.api, postId: post['id'] as int)),
    );
    if (result == true) _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts (jsonplaceholder)'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final posts = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final p = posts[index] as Map<String, dynamic>;
                return ListTile(
                  title: Text(p['title']),
                  subtitle: Text('ID: ${p['id']} • User: ${p['userId']}'),
                  onTap: () => _openDetail(p),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreate,
        child: Icon(Icons.add),
        tooltip: 'Criar post (POST)',
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final ApiService api;
  final int postId;
  DetailPage({required this.api, required this.postId});

  @override
  _DetailPageState createState() => _DetailPageState();
}
class _DetailPageState extends State<DetailPage> {
  late Future<Map<String, dynamic>> _postFuture;

  @override
  void initState() {
    super.initState();
    _postFuture = widget.api.getPost(widget.postId);
  }

  void _edit(Map<String, dynamic> post) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PostFormPage(api: widget.api, post: post)),
    );
    if (result == true) {
      setState(() {
        _postFuture = widget.api.getPost(widget.postId);
      });
      Navigator.of(context).pop(true);
    }
  }

  void _delete(int id) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Confirmar'),
        content: Text('Deseja deletar o post $id?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Não')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Sim')),
        ],
      ),
    );
    if (ok == true) {
      try {
        await widget.api.deletePost(id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Post deletado')));
        Navigator.of(context).pop(true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao deletar: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhe do Post'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text('Erro: ${snapshot.error}'));
          final p = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${p['id']}', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Title:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(p['title'] ?? ''),
                SizedBox(height: 12),
                Text('Body:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(p['body'] ?? ''),
                Spacer(),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _edit(p),
                      icon: Icon(Icons.edit),
                      label: Text('Editar (PUT)'),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () => _delete(p['id'] as int),
                      icon: Icon(Icons.delete),
                      label: Text('Deletar (DELETE)'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class PostFormPage extends StatefulWidget {
  final ApiService api;
  final Map<String, dynamic>? post;
  PostFormPage({required this.api, this.post});

  @override
  _PostFormPageState createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleCtrl;
  late TextEditingController _bodyCtrl;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.post?['title'] ?? '');
    _bodyCtrl = TextEditingController(text: widget.post?['body'] ?? '');
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final title = _titleCtrl.text.trim();
    final body = _bodyCtrl.text.trim();
    try {
      if (widget.post == null) {
        final created = await widget.api.createPost(title, body, 1);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Criado ID: ${created['id']}')));
      } else {
        final id = widget.post!['id'] as int;
        final updated = await widget.api.updatePost(id, title, body, widget.post!['userId'] ?? 1);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Atualizado ID: ${updated['id']}')));
      }
      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.post != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar Post' : 'Criar Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (v) => (v == null || v.isEmpty) ? 'Informe título' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _bodyCtrl,
                decoration: InputDecoration(labelText: 'Conteúdo'),
                maxLines: 5,
                validator: (v) => (v == null || v.isEmpty) ? 'Informe conteúdo' : null,
              ),
              Spacer(),
              ElevatedButton(onPressed: _submit, child: Text(isEditing ? 'Salvar (PUT)' : 'Criar (POST)')),
            ],
          ),
        ),
      ),
    );
  }
}
