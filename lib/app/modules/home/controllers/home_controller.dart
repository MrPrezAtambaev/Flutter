import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/services/todo/todo_service.dart';

class HomeController extends GetxController {
  final TodoService todoService = Get.find();

  final titleInputController = TextEditingController();
  final updateTitleInputController = TextEditingController();

  final count = 0.obs;
  void increment() => count.value++;

  @override
  void onInit() {
    todoService.fetchTodos();

    super.onInit();
  }

  @override
  void onReady() {
    todoService.createTodo(titleInputController.text);
    super.onReady();
  }

  @override
  void onClose() {
    Get.log('HomeController onClose');
    super.onClose();
  }
}
