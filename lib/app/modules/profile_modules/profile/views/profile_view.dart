import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:attendace/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constant/colors.dart';
import '../../../../controllers/page_index_controller_controller.dart';
import '../../../../controllers/presence_controller_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  final pageController = Get.find<PageIndexControllerController>();

  final presenceCtrl = Get.find<PresenceControllerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamDataUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;

            String defaultImage =
                "https://ui-avatars.com/api/?name=${user['name']}";

            return ListView(
              padding: const EdgeInsets.only(
                  top: 70, left: 15, right: 15, bottom: 5),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Image.network(
                          user["profile"] != null
                              ? user["profile"] != ""
                                  ? user["profile"]
                                  : defaultImage
                              : defaultImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(user['nip'].toString()),
                Text(user['name'].toString()),
                ListTile(
                  onTap: () {
                    Get.toNamed(
                      Routes.UPDATE_PROFILE,
                      arguments: user,
                    );
                  },
                  leading: const Icon(Icons.person),
                  title: const Text("Update Profile"),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.UPDATE_PASSWORD_PROFILE);
                  },
                  leading: const Icon(Icons.vpn_key),
                  title: const Text("Update Password"),
                ),
                if (user["role"] == "admin")
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.ADD_EMPLOYEE);
                    },
                    leading: const Icon(Icons.person_add),
                    title: const Text("Add Employee"),
                  ),
                ListTile(
                  onTap: () {
                    controller.logOut();
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text("Sing out"),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Cannot get display User"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        child: const Icon(
          Icons.fingerprint,
          size: 45,
          color: AppColors.primaryColor,
        ),
        onPressed: () async {
          await presenceCtrl.getPresenceFunc();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeColor: AppColors.secondaryColor,
        inactiveColor: Colors.white,
        icons: pageController.iconList,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        activeIndex: pageController.indexPage.value,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) => pageController.changePage(index),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
