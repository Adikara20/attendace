import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEmployeeController extends GetxController {
  TextEditingController nipctrl = TextEditingController();
  TextEditingController namectrl = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  TextEditingController pwdadminctrl = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  //for enter to database
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addEmployee() async {
    if (nipctrl.text.isNotEmpty &&
        namectrl.text.isNotEmpty &&
        emailctrl.text.isNotEmpty) {
      //
      //for handilng saving email and password for auto login
      Get.defaultDialog(
          title: "COnfirmation",
          content: Column(
            children: [
              Text("Input password admin"),
              TextField(
                controller: pwdadminctrl,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "password",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Get.back(),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await processAddEmployee();
              },
              child: Text("Add"),
            ),
          ]);
    } else {
      Get.snackbar("error occurred", "NIP, Name, Email must be filled");
    }
  }

  Future<void> processAddEmployee() async {
    if (pwdadminctrl.text.isNotEmpty) {
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
          Get.snackbar("success", "Employee successfully added");
        }
        print(employeeCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("error occurred", "The password provided is too weak");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("error occurred", "Wrong Passwrod");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar(
              "error occurred", "The account already exists for that email");
        } else {
          Get.snackbar("error occurred", e.code);
        }
      } catch (e) {
        Get.snackbar("error occurred", "Cannot add new Employee");
      }
    } else {
      Get.snackbar("error occurred", "The password is must be filled");
    }
  }
}
