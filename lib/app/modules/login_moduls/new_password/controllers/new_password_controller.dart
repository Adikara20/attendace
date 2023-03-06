import 'package:attendace/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../constant/colors.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPwdctrl = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> newPasswrod() async {
    if (newPwdctrl.text.isNotEmpty) {
      if (newPwdctrl.text != "password") {
        try {
          String email = auth.currentUser!.email!;

          await auth.currentUser!.updatePassword(newPwdctrl.text);

          //after change password must sign out
          await auth.signOut();

          //then auto login to Home
          await auth.signInWithEmailAndPassword(
            email: email,
            password: newPwdctrl.text,
          );

          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar(
              "error occurred",
              "The password should be least 6 characters",
              backgroundColor: AppColors.removeColor,
            );
          }
        } catch (e) {
          Get.snackbar(
            "error occurred",
            "Cannot make new Password",
            backgroundColor: AppColors.removeColor,
          );
        }
      } else {
        Get.snackbar(
          "error occurred",
          "New Password must different with before",
          backgroundColor: AppColors.removeColor,
        );
      }
    } else {
      Get.snackbar(
        "error occurred",
        "New Password must be filled",
        backgroundColor: AppColors.removeColor,
      );
    }
  }
}
