import 'package:attendace/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPwdctrl = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void newPasswrod() async {
    if (newPwdctrl.text.isNotEmpty) {
      if (newPwdctrl.text != "password") {
        try {
          await auth.currentUser!.updatePassword(newPwdctrl.text);

          //after change password must sign out
          await auth.signOut();

          //then auto login to Home
          await auth.signInWithEmailAndPassword(
            email: auth.currentUser!.email!,
            password: newPwdctrl.text,
          );

          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar(
                "error occurred", "The password should be least 6 characters");
          }
        } catch (e) {
          Get.snackbar("error occurred", "Cannot make new Password");
        }
      } else {
        Get.snackbar(
            "error occurred", "New Password must different with before");
      }
    } else {
      Get.snackbar("error occurred", "New Password must be filled");
    }
  }
}
