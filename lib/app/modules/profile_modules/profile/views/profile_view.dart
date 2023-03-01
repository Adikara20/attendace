import 'package:attendace/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
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
              padding: const EdgeInsets.all(10),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 100,
                        height: 100,
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
    );
  }
}
