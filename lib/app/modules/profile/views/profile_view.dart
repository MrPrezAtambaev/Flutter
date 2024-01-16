import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_todo/app/services/profile/profile_service.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Профили'),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: ProfileService.to.fetchProfile,
          child: Obx(
            () => ListView.builder(
              itemCount: ProfileService.to.profile.length,
              itemBuilder: (context, index) {
                final profile = ProfileService.to.profile[index];
                return ListTile(
                  title: Wrap(
                    children: [
                      Text(
                        '${profile.id}' '${profile.name}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${profile.age} лет',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  // subtitle: Text(),
                );
              },
            ),
          ),
        ));
  }
}
