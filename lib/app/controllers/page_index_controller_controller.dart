import 'package:attendace/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageIndexControllerController extends GetxController {
  RxInt indexPage = 0.obs;

  List<IconData> iconList = [
    //list of icons that required by animated navigation bar.
    Icons.dashboard,

    Icons.person,
  ];

  void changePage(int index) {
    switch (index) {
      case 1:
        print("object");
        break;
      case 2:
        indexPage.value = index;
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        indexPage.value = index;
        Get.offAllNamed(Routes.HOME);
    }
  }
}
