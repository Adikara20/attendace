import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdatePasswordProfileController extends GetxController {
  RxBool isloading = false.obs;
  TextEditingController curpwdctrl = TextEditingController();
  TextEditingController newpwdctrl = TextEditingController();
  TextEditingController confpwdctrl = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePassword() async {
    if (curpwdctrl.text.isNotEmpty &&
        newpwdctrl.text.isNotEmpty &&
        confpwdctrl.text.isNotEmpty) {
      if (newpwdctrl.text == confpwdctrl.text) {
        isloading.value = true;
        try {
          //for checking user
          String emailUser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: emailUser, password: curpwdctrl.text);

          await auth.currentUser!.updatePassword(newpwdctrl.text);

          Get.back();

          Get.snackbar("success", "Update password successfully");

          //
        } on FirebaseAuthException catch (e) {
          Get.snackbar("error occurred", e.code.toLowerCase());
        } catch (e) {
          Get.snackbar("error occurred", "Cannot update password");
        } finally {
          isloading.value = false;
        }
      } else {
        Get.snackbar(
            "error occurred", "Confirm and New Password must be equal");
      }
    } else {
      Get.snackbar("error occurred", "Column must be filled");
    }
  }
}
