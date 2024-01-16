import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_todo/app/services/profile/profile_service.dart';
import 'package:getx_todo/app/services/todo/todo_service.dart';
import 'package:dio/dio.dart';

import 'app/routes/app_pages.dart';

Future<void> initModules() async {
  // Get.put<TodoService>(TodoServiceImpl());
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000'));

  Get
    ..put<Dio>(dio)
    ..put<TodoService>(TodoServiceImpl())
    ..put<ProfileService>(ProfileServiceImpl());
}

void main() async {
  await initModules();

  runApp(
    GetMaterialApp(
      title: "My first app",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
