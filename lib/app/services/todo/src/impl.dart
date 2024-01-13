import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/services/todo/src/abstract.dart';
import 'package:getx_todo/app/services/todo/src/data/todo.dart';

class TodoServiceImpl extends TodoService {
  final Dio dio = Get.find();

  @override
  Future<List<Todo>> fetchTodos() async {
    final response = await dio.get('/todos');

    final data =
        List<dynamic>.from(response.data).map((e) => Todo.fromJson(e)).toList();

    todos.value = data;

    return data;
  }

  @override
  Future<Todo> createTodo(String title) async {
    final response = await dio.post('/todos', data: {
      'title': title,
      'completed': false,
    });

    final data = Todo.fromJson(response.data);

    todos.add(data);

    return data;
  }

  @override
  Future<Todo> updateTodo(
    int id,
    String title,
    bool completed,
  ) async {
    final response = await dio.patch('/todos/$id', data: {
      'title': title,
      'completed': completed,
    });

    final data = Todo.fromJson(response.data);

    final index = todos.indexWhere((element) => element.id == id);

    todos[index] = data;

    return data;
  }

  @override
  Future<void> deleteTodo(
    int id,
  ) async {
    await dio.delete('/todos/$id');

    todos.removeWhere((element) => element.id == id);
  }
}
