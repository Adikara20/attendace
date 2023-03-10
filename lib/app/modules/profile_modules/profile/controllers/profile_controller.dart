import 'package:attendace/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamDataUser() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("employee").doc(uid).snapshots();
  }

  void logOut() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
