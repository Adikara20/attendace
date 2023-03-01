import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  const UpdateProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> user = Get.arguments;

    controller.emailctrl.text = user["email"];
    controller.nipctrl.text = user["nip"];
    controller.namectrl.text = user["name"];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          TextField(
            readOnly: true,
            controller: controller.nipctrl,
            decoration: const InputDecoration(
              labelText: "NIP",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            readOnly: true,
            controller: controller.emailctrl,
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.namectrl,
            decoration: const InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text("Photo Profile"),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (builder) {
                  if (builder.image != null) {
                    return ClipOval(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(builder.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (user["profile"] != null) {
                      return Column(
                        children: [
                          ClipOval(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.network(
                                user["profile"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.pickDeleteProfile(user["uid"]);
                            },
                            child: Text("delete"),
                          ),
                        ],
                      );
                    } else {
                      return Text("data");
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  controller.pickPhotoProfile();
                },
                child: Text("choose"),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateProfileEmployee(user["uid"]);
                }
              },
              child: Text(controller.isLoading.isFalse
                  ? "Add Profile Employee"
                  : "Loading . . ."),
            ),
          ),
        ],
      ),
    );
  }
}
