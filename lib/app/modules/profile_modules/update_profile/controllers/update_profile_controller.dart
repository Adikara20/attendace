import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as s;

import '../../../../constant/colors.dart';

//import 'package:path_provider/path_provider.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nipctrl = TextEditingController();
  TextEditingController namectrl = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  TextEditingController pwdadminctrl = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  Future<void> updateProfileEmployee(String uid) async {
    if (nipctrl.text.isNotEmpty &&
        namectrl.text.isNotEmpty &&
        emailctrl.text.isNotEmpty) {
      isLoading.value = true;

      try {
        Map<String, dynamic> data = {
          "name": namectrl.text,
        };
        if (image != null) {
          // Directory appDocDir = await getApplicationDocumentsDirectory();
          // String filePath = '${appDocDir.absolute}/file-to-upload.png';
          File file = File(image!.path);

          String extension = image!.name.split(".").last;

          await s.FirebaseStorage.instance
              .ref('$uid/profile.$extension')
              .putFile(file);

          //get url image from firestore storage

          String urlImage = await s.FirebaseStorage.instance
              .ref('$uid/profile.$extension')
              .getDownloadURL();

          data.addAll({"profile": urlImage});
        }

        await firestore.collection("employee").doc(uid).update(data);

        Get.snackbar(
          "success",
          "Update profile successfully",
          backgroundColor: AppColors.succesColor,
        );
      } catch (e) {
        Get.snackbar(
          "error occurred",
          "Cannot update profile",
          backgroundColor: AppColors.removeColor,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  final ImagePicker picker = ImagePicker();

  XFile? image;

  void pickPhotoProfile() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
    } else {}
    //for monitor change state
    update();
  }

  void pickDeleteProfile(String uid) async {
    try {
      firestore.collection("employee").doc(uid).update({
        "profile": FieldValue.delete(),
      });
      update();
      Get.back();
      Get.snackbar(
        "success",
        "delete profile picture successfully",
        backgroundColor: AppColors.succesColor,
      );
    } catch (e) {
      Get.snackbar(
        "error occurred",
        "Cannot delete profile picture",
        backgroundColor: AppColors.removeColor,
      );
    }
  }

  //for display
  FocusNode nipctrlFocusNode = FocusNode();
  FocusNode namectrlFocusNode = FocusNode();
  FocusNode emailctrlFocusNode = FocusNode();
  FocusNode pwdadminctrlFocusNode = FocusNode();
  RxBool nipctrlfocusAnimated = false.obs;
  RxBool namectrlfocusAnimated = false.obs;
  RxBool emailctrlfocusAnimated = false.obs;
  RxBool pwdadminctrlfocusAnimated = false.obs;

  @override
  void onInit() {
    nipctrlFocusNode.addListener(() {
      nipctrlfocusAnimated.value = !nipctrlfocusAnimated.value;
    });

    namectrlFocusNode.addListener(() {
      namectrlfocusAnimated.value = !namectrlfocusAnimated.value;
    });

    emailctrlFocusNode.addListener(() {
      emailctrlfocusAnimated.value = !emailctrlfocusAnimated.value;
    });

    pwdadminctrlFocusNode.addListener(() {
      pwdadminctrlfocusAnimated.value = !pwdadminctrlfocusAnimated.value;
    });

    super.onInit();
  }

  @override
  onClose() {
    nipctrlFocusNode.dispose();
    namectrlFocusNode.dispose();
    emailctrlFocusNode.dispose();
    pwdadminctrlFocusNode.dispose();
    super.onClose();
  }
}
