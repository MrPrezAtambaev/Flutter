import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/services/profile/src/abstract.dart';
import 'package:getx_todo/app/services/profile/src/data/profile.dart';

class ProfileServiceImpl extends ProfileService {
  final Dio dio = Get.find();

  @override
  Future<List<Profile>> fetchProfile() async {
    final response = await dio.get('/profiles');

    final data = List<dynamic>.from(response.data)
        .map((e) => Profile.fromJson(e))
        .toList();

    profile.value = data;

    return data;
  }
}
