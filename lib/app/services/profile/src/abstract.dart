import 'package:get/get.dart';
import 'package:getx_todo/app/services/profile/src/data/profile.dart';

abstract class ProfileService extends GetxService {
  static ProfileService get to => Get.find();

  final RxList<Profile> profile = <Profile>[].obs;

  Future<List<Profile>> fetchProfile();
}
