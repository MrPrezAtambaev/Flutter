import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_todo/app/services/todo/todo_service.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: ButtonBar(
          children: [
            ButtonBar(
              children: [
                IconButton(
                  onPressed: () {
                    isDarkMode = !isDarkMode;
                    isDarkMode
                        ? Get.changeTheme(ThemeData.dark())
                        : Get.changeTheme(ThemeData.light());
                  },
                  icon: isDarkMode
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode),
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  Get.toNamed('/profile');
                },
                icon: const Icon(Icons.person)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            Container(
              color: isDarkMode ? Colors.black : Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Wrap(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Введите название',
                    ),
                    controller: controller.titleInputController,
                  ),
                  const SizedBox(height: 300),
                  ButtonBar(
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Отмена'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.todoService
                              .createTodo(controller.titleInputController.text);

                          Get.back();
                        },
                        child: const Text('Создать'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            clipBehavior: Clip.hardEdge,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: TodoService.to.fetchTodos,
        child: Obx(
          () => ListView.builder(
            itemBuilder: (context, index) {
              final todo = TodoService.to.todos[index];

              return ListTile(
                title: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        color: isDarkMode ? Colors.black : Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Wrap(
                          children: [
                            TextField(
                                decoration: const InputDecoration(
                                  hintText: 'Новое название',
                                ),
                                controller:
                                    controller.updateTitleInputController
                                      ..text = todo.title),
                            Checkbox(
                              value: todo.completed,
                              onChanged: (value) {
                                todo.completed = value ?? false;
                              },
                            ),
                            const SizedBox(height: 300),
                            ButtonBar(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('Отмена'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.todoService.updateTodo(
                                        todo.id,
                                        controller
                                            .updateTitleInputController.text,
                                        todo.completed);

                                    Get.back();
                                  },
                                  child: const Text('Обновить'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      backgroundColor: isDarkMode ? Colors.black : Colors.white,
                      clipBehavior: Clip.hardEdge,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    );
                  },
                  child: Text(todo.title),
                ),
                leading: Text(todo.id.toString()),
                trailing: SizedBox(
                  width: 96,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          TodoService.to.deleteTodo(todo.id);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      Checkbox(
                        value: todo.completed,
                        onChanged: (value) {
                          Get.snackbar(
                            'Статус задачи изменен',
                            (value ?? false) ? 'Завершено' : 'Не завершено',
                          );
                          Get.log(todo.completed.toString());
                          TodoService.to.updateTodo(
                            todo.id,
                            todo.title,
                            todo.completed = value ?? false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                subtitle: Text(todo.completed ? 'Завершено' : 'Не завершено'),
                onTap: () {
                  Get.snackbar(todo.title,
                      todo.completed ? 'Завершено' : 'Не завершено');
                },
              );
            },
            itemCount: TodoService.to.todos.length,
          ),
        ),
      ),
    );
  }
}
