import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nipctrl = TextEditingController();
  TextEditingController namectrl = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  TextEditingController pwdadminctrl = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateProfileEmployee(String uid) async {
    if (nipctrl.text.isNotEmpty &&
        namectrl.text.isNotEmpty &&
        emailctrl.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await firestore
            .collection("employee")
            .doc(uid)
            .update({"name": namectrl.text});
        Get.snackbar("success", "Update profile successfully");
      } catch (e) {
        Get.snackbar("error occurred", "Cannot update profile");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
