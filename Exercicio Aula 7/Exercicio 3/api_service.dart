import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String base = 'jsonplaceholder.typicode.com';

  Future<List<dynamic>> getPosts() async {
    final url = Uri.https(base, '/posts');
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Falha ao obter lista de posts: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getPost(int id) async {
    final url = Uri.https(base, '/posts/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Falha ao obter post $id: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> createPost(String title, String body, int userId) async {
    final url = Uri.https(base, '/posts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'title': title, 'body': body, 'userId': userId}),
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Falha ao criar post: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> updatePost(int id, String title, String body, int userId) async {
    final url = Uri.https(base, '/posts/$id');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'id': id, 'title': title, 'body': body, 'userId': userId}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Falha ao atualizar post $id: ${response.statusCode}');
    }
  }

  Future<bool> deletePost(int id) async {
    final url = Uri.https(base, '/posts/$id');
    final response = await http.delete(url);
    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Falha ao deletar post $id: ${response.statusCode}');
    }
  }
}
