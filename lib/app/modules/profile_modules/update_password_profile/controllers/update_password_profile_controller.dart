import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../constant/colors.dart';

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

          Get.snackbar(
            "success",
            "Update password successfully",
            backgroundColor: AppColors.succesColor,
          );

          //
        } on FirebaseAuthException catch (e) {
          Get.snackbar(
            "error occurred",
            e.code.toLowerCase(),
            backgroundColor: AppColors.removeColor,
          );
        } catch (e) {
          Get.snackbar(
            "error occurred",
            "Cannot update password",
            backgroundColor: AppColors.removeColor,
          );
        } finally {
          isloading.value = false;
        }
      } else {
        Get.snackbar(
          "error occurred",
          "Confirm and New Password must be equal",
          backgroundColor: AppColors.removeColor,
        );
      }
    } else {
      Get.snackbar(
        "error occurred",
        "Column must be filled",
        backgroundColor: AppColors.removeColor,
      );
    }
  }

  //for display
  FocusNode curpwdctrlFocusNode = FocusNode();
  FocusNode newpwdctrlFocusNode = FocusNode();
  FocusNode confpwdctrlFocusNode = FocusNode();
  RxBool curpwdctrlfocusAnimated = false.obs;
  RxBool newpwdctrlfocusAnimated = false.obs;
  RxBool confpwdctrlfocusAnimated = false.obs;

  @override
  void onInit() {
    curpwdctrlFocusNode.addListener(() {
      curpwdctrlfocusAnimated.value = !curpwdctrlfocusAnimated.value;
    });

    newpwdctrlFocusNode.addListener(() {
      newpwdctrlfocusAnimated.value = !newpwdctrlfocusAnimated.value;
    });

    confpwdctrlFocusNode.addListener(() {
      confpwdctrlfocusAnimated.value = !confpwdctrlfocusAnimated.value;
    });

    super.onInit();
  }

  @override
  onClose() {
    curpwdctrlFocusNode.dispose();
    newpwdctrlFocusNode.dispose();
    confpwdctrlFocusNode.dispose();

    super.onClose();
  }
}
