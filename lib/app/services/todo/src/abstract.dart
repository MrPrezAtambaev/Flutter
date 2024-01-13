import 'package:get/get.dart';
import 'package:getx_todo/app/services/todo/src/data/todo.dart';

abstract class TodoService extends GetxService {
  static TodoService get to => Get.find();

  final RxList<Todo> todos = <Todo>[].obs;

  Future<List<Todo>> fetchTodos();
  Future<Todo> createTodo(String title);
  Future<Todo> updateTodo(
    int id,
    String title,
    bool completed,
  );
  Future<void> deleteTodo(
    int id,
  );
}
