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
      backgroundColor: AppColors.whiteColor,
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

            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        // padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(55),
                              bottomRight: Radius.circular(55),
                            ),
                            //color: Colors.grey[200],
                            color: AppColors.secondaryColor),
                        child: const SizedBox(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 130, left: 15, right: 15, bottom: 5),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipOval(
                            child: SizedBox(
                                width: 220,
                                height: 220,
                                child: Container(
                                  color: AppColors.whiteColor,
                                )),
                          ),
                          ClipOval(
                            child: SizedBox(
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      user['nip'].toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user['name'].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Divider(
                            thickness: 5,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            onTap: () {
                              Get.toNamed(
                                Routes.UPDATE_PROFILE,
                                arguments: user,
                              );
                            },
                            leading: const Icon(
                              Icons.person,
                              color: AppColors.primaryColor,
                            ),
                            title: const Text("Update Profile"),
                            trailing: const Icon(
                              Icons.arrow_forward,
                              color: Color.fromARGB(255, 255, 132, 218),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Get.toNamed(Routes.UPDATE_PASSWORD_PROFILE);
                            },
                            leading: const Icon(
                              Icons.vpn_key,
                              color: AppColors.primaryColor,
                            ),
                            title: const Text("Update Password"),
                            trailing: const Icon(
                              Icons.arrow_forward,
                              color: Color.fromARGB(255, 255, 132, 218),
                            ),
                          ),
                          if (user["role"] == "admin")
                            ListTile(
                              onTap: () {
                                Get.toNamed(Routes.ADD_EMPLOYEE);
                              },
                              leading: const Icon(
                                Icons.person_add,
                                color: AppColors.primaryColor,
                              ),
                              title: const Text("Add Employee"),
                              trailing: const Icon(
                                Icons.arrow_forward,
                                color: Color.fromARGB(255, 255, 132, 218),
                              ),
                            ),
                          ListTile(
                            onTap: () {
                              controller.logOut();
                            },
                            leading: const Icon(
                              Icons.logout,
                              color: AppColors.primaryColor,
                            ),
                            title: const Text("Sing out"),
                            trailing: const Icon(
                              Icons.arrow_forward,
                              color: Color.fromARGB(255, 255, 132, 218),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
