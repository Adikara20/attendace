import 'package:attendace/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/colors.dart';

class LoginController extends GetxController {
  RxBool isloading = false.obs;
  TextEditingController emailctrl = TextEditingController();
  TextEditingController passctrl = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  RxBool emailfocusAnimated = false.obs;
  RxBool passfocusAnimated = false.obs;

  @override
  void onInit() {
    emailFocusNode.addListener(() {
      emailfocusAnimated.value = !emailfocusAnimated.value;
    });

    passwordFocusNode.addListener(() {
      passfocusAnimated.value = !passfocusAnimated.value;
    });

    super.onInit();
  }

  @override
  onClose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailctrl.text.isNotEmpty && passctrl.text.isNotEmpty) {
      isloading.value = true;
      try {
        final credential = await auth.signInWithEmailAndPassword(
          email: emailctrl.text,
          password: passctrl.text,
        );

        //checking verified email
        if (credential.user != null) {
          if (credential.user!.emailVerified == true) {
            isloading.value = false;
            //checking default password
            if (passctrl.text == "password") {
              //change default password
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              title: "Not Verified",
              middleText:
                  "This account not yet verified, please verifiy your email",
              actions: [
                OutlinedButton(
                  onPressed: () {
                    isloading.value = false;
                    Get.back();
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await credential.user!.sendEmailVerification();
                      Get.back();
                      Get.snackbar(
                        "succes",
                        "email verification has been sent",
                        backgroundColor: AppColors.succesColor,
                      );
                      isloading.value = false;
                    } catch (e) {
                      isloading.value = false;
                      Get.snackbar(
                        "error occurred",
                        "Cannot send email verification",
                        backgroundColor: AppColors.removeColor,
                      );
                    }
                  },
                  child: const Text("Send Verifiy"),
                ),
              ],
            );
          }
        }
        isloading.value = false;
      } on FirebaseAuthException catch (e) {
        isloading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar(
            "error occurred",
            "No user found for that email.",
            backgroundColor: AppColors.removeColor,
          );
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
            "error occurred",
            "Wrong password provided for that user.",
            backgroundColor: AppColors.removeColor,
          );
        }
      } catch (e) {
        isloading.value = false;
        Get.snackbar(
          "error occurred",
          "Cannot Login",
          backgroundColor: AppColors.removeColor,
        );
      }
    } else {
      Get.snackbar(
        "error occurred",
        "Email and Password must be filled",
        backgroundColor: AppColors.removeColor,
      );
    }
  }
}
