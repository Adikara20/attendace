// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/colors.dart';

class AddEmployeeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAdd = false.obs;
  TextEditingController nipctrl = TextEditingController();
  TextEditingController namectrl = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  TextEditingController pwdadminctrl = TextEditingController();
  TextEditingController jobctrl = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  //for enter to database
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addEmployee() async {
    if (nipctrl.text.isNotEmpty &&
        namectrl.text.isNotEmpty &&
        emailctrl.text.isNotEmpty &&
        jobctrl.text.isNotEmpty) {
      //
      //for handilng saving email and password for auto login
      isLoading.value = true;
      Get.defaultDialog(
          title: "Confirmation",
          content: Column(
            children: [
              const Text("Input password admin"),
              TextField(
                controller: pwdadminctrl,
                autocorrect: false,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "password",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                isLoading.value = false;
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (isLoadingAdd.isFalse) {
                    await processAddEmployee();
                  }

                  isLoading.value = false;
                },
                child: Text(isLoadingAdd.isFalse ? "Add" : "Loading . . ."),
              ),
            ),
          ]);
    } else {
      Get.snackbar(
        "error occurred",
        "NIP, Name, Email must be filled",
        backgroundColor: AppColors.removeColor,
      );
    }
  }

  Future<void> processAddEmployee() async {
    if (pwdadminctrl.text.isNotEmpty) {
      isLoading.value = true;
      try {
        String emailCurAdmin = auth.currentUser!.email!;

        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
          email: emailCurAdmin,
          password: pwdadminctrl.text,
        );

        UserCredential employeeCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailctrl.text,
          password: "password",
        );

        if (employeeCredential.user != null) {
          String uid = employeeCredential.user!.uid;

          //for enter to database
          firestore.collection("employee").doc(uid).set({
            "nip": nipctrl.text,
            "name": namectrl.text,
            "email": emailctrl.text,
            "uid": uid,
            "role": "employee",
            "jobs": jobctrl.text,
            "createdAt": DateTime.now().toIso8601String(),
          });

          //for sending verification email
          await employeeCredential.user!.sendEmailVerification();

          //auto login as admin
          UserCredential userCredentialAdmin =
              await auth.signInWithEmailAndPassword(
            email: emailCurAdmin,
            password: pwdadminctrl.text,
          );

          Get.back(); // close dialog
          Get.back(); // to Home
          Get.snackbar(
            "success",
            "Employee successfully added",
            backgroundColor: AppColors.succesColor,
          );
        }
        isLoading.value = false;
        if (kDebugMode) {
          print(employeeCredential);
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar(
            "error occurred",
            "The password provided is too weak",
            backgroundColor: AppColors.removeColor,
          );
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
            "error occurred",
            "Wrong Passwrod",
            backgroundColor: AppColors.removeColor,
          );
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar(
            "error occurred",
            "The account already exists for that email",
            backgroundColor: AppColors.removeColor,
          );
        } else {
          Get.snackbar(
            "error occurred",
            e.code,
            backgroundColor: AppColors.removeColor,
          );
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar(
          "error occurred",
          "Cannot add new Employee",
          backgroundColor: AppColors.removeColor,
        );
      }
    } else {
      isLoading.value = false;
      Get.snackbar(
        "error occurred",
        "The password is must be filled",
        backgroundColor: AppColors.removeColor,
      );
    }
  }

  //for display
  FocusNode nipctrlFocusNode = FocusNode();
  FocusNode namectrlFocusNode = FocusNode();
  FocusNode emailctrlFocusNode = FocusNode();
  FocusNode pwdadminctrlFocusNode = FocusNode();
  FocusNode jobctrlFocusNode = FocusNode();
  RxBool nipctrlfocusAnimated = false.obs;
  RxBool namectrlfocusAnimated = false.obs;
  RxBool emailctrlfocusAnimated = false.obs;
  RxBool pwdadminctrlfocusAnimated = false.obs;
  RxBool jobctrlfocusAnimated = false.obs;

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

    jobctrlFocusNode.addListener(() {
      jobctrlfocusAnimated.value = !jobctrlfocusAnimated.value;
    });

    super.onInit();
  }

  @override
  onClose() {
    nipctrlFocusNode.dispose();
    namectrlFocusNode.dispose();
    emailctrlFocusNode.dispose();
    pwdadminctrlFocusNode.dispose();
    jobctrlFocusNode.dispose();
    super.onClose();
  }
}
