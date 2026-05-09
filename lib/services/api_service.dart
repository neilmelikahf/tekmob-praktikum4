import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class ApiService {
  static const String baseUrl = 'https://69ff66b52b7ab349602f9c99.mockapi.io';

  // Fungsi untuk mengambil daftar todos dari MockAPI
  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todo'));

    if (response.statusCode == 200) {
      // Parse JSON response
      List<dynamic> jsonList = json.decode(response.body);
      // Konversi ke List<Todo>
      return jsonList.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load todos from MockAPI');
    }
  }

  Future<Todo> createTodo({
    required String title,
    required String description,
    required bool isDone,
  }) async {
    final int createdAt = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final response = await http.post(
      Uri.parse('$baseUrl/todo'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        'description': description,
        'isDone': isDone,
        'createdAt': createdAt,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create todo on MockAPI');
    }
  }

  Future<Todo> updateTodoStatus({
    required String id,
    required bool isDone,
  }) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/todo/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'isDone': isDone}),
    );

    if (response.statusCode == 200) {
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update todo status on MockAPI');
    }
  }
}
