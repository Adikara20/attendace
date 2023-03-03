import 'package:attendace/app/controllers/page_index_controller_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/controllers/presence_controller_controller.dart';
import 'app/routes/app_pages.dart';

import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final pageController =
      Get.put(PageIndexControllerController(), permanent: true);

  final presenceCtrl = Get.put(PresenceControllerController(), permanent: true);

  runApp(
    StreamBuilder<User?>(
        //checking any user
        stream: FirebaseAuth.instance
            .authStateChanges(), //monitoring all activity or state
        //current user always change
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Application",
            //initialRoute: Routes.HOME,
            //initialRoute: Routes.ADD_EMPLOYEE,
            //checking for auto login
            initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        }),
  );
}
