import 'package:get/get.dart';
import 'package:getx_todo/app/services/profile/profile_service.dart';

class ProfileController extends GetxController {
  final ProfileService profileService = Get.find();
  final count = 0.obs;

  void increment() => count.value++;

  @override
  void onInit() {
    profileService.fetchProfile();

    super.onInit();
  }

  @override
  void onReady() {
    Get.log('ProfileController onReady');
    super.onReady();
  }

  @override
  void onClose() {
    Get.log('ProfileController onClose');
    super.onClose();
  }
}
