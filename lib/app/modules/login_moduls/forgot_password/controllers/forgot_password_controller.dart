import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailctrl = TextEditingController();
  RxBool isloading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sendResetEmail() async {
    if (emailctrl.text.isNotEmpty) {
      isloading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailctrl.text);
        Get.snackbar("Success", "Send email reset password successfully");
        Get.back();
      } catch (e) {
        Get.snackbar("error occurred", "Cannot send email reset password");
      } finally {
        isloading.value = false;
      }
    }
  }
}
