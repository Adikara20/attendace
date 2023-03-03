import 'package:attendace/app/controllers/presence_controller_controller.dart';
import 'package:attendace/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class PageIndexControllerController extends GetxController {
  //final presenceCtrl = Get.find<PresenceControllerController>();

  RxInt indexPage = 0.obs;

  List<IconData> iconList = [
    //list of icons that required by animated navigation bar.
    Icons.dashboard,
    Icons.person,
  ];

  void changePage(int index) async {
    switch (index) {
      case 0:
        indexPage.value = index;
        Get.offAllNamed(Routes.HOME);
        break;
      // case 1:
      //   await presenceCtrl.getPresenceFunc();
      //   break;
      case 1:
        indexPage.value = index;
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        indexPage.value = index;
        Get.offAllNamed(Routes.HOME);
        break;
    }
  }
}
