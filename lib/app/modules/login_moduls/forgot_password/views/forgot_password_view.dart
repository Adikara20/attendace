import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.emailctrl,
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isloading.isFalse) {
                  await controller.sendResetEmail();
                }
              },
              child: Text(
                controller.isloading.isFalse
                    ? "Send Reset Password"
                    : "Loading . . .",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
