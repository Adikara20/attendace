import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_password_profile_controller.dart';

class UpdatePasswordProfileView
    extends GetView<UpdatePasswordProfileController> {
  const UpdatePasswordProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Password Profile'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          TextField(
            autocorrect: false,
            obscureText: true,
            controller: controller.curpwdctrl,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            autocorrect: false,
            obscureText: true,
            controller: controller.newpwdctrl,
            decoration: InputDecoration(
              labelText: "New Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            autocorrect: false,
            obscureText: true,
            controller: controller.confpwdctrl,
            decoration: InputDecoration(
              labelText: "Confirm Password",
              border: OutlineInputBorder(),
            ),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () {
                if (controller.isloading.isFalse) {
                  controller.updatePassword();
                }
              },
              child: Text(controller.isloading.isFalse
                  ? "Update Password"
                  : "Loading . . ."),
            ),
          ),
        ],
      ),
    );
  }
}
