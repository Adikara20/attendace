import 'package:attendace/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class PageIndexControllerController extends GetxController {
  RxInt indexPage = 0.obs;

  List<IconData> iconList = [
    //list of icons that required by animated navigation bar.
    Icons.dashboard,

    Icons.person,
  ];

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void changePage(int index) async {
    switch (index) {
      case 0:
        indexPage.value = index;
        Get.offAllNamed(Routes.HOME);
        break;
      case 1:
        Map<String, dynamic> dataResponse = await determinePosition();
        if (dataResponse["error"] != true) {
          Position position = dataResponse["position"];

          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);

          String address =
              "${placemarks[0].name}, ${placemarks[0].subLocality}, ${placemarks[0].locality}";

          //check area
          double distance = Geolocator.distanceBetween(
              -6.175392, 106.827153, position.latitude, position.longitude);

          await updatePosition(position, address);

          await presence(position, address, distance);

          Get.snackbar("Successfully", "You got attendance");
        } else {
          Get.snackbar("error occurred", dataResponse["message"]);
        }
        break;
      case 2:
        indexPage.value = index;
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        indexPage.value = index;
        Get.offAllNamed(Routes.HOME);
        break;
    }
  }

  Future<void> presence(
      Position position, String address, double distance) async {
    String uid = await firebaseAuth.currentUser!.uid;

    //put data into sub collection in database
    CollectionReference<Map<String, dynamic>> colPresence =
        await firestore.collection("employee").doc(uid).collection("presence");

    //get data for checking any data
    QuerySnapshot<Map<String, dynamic>> snapPresence = await colPresence.get();

    //uniq id for sub collection, meaning uid for data presence
    DateTime timeNow = DateTime.now();

    String docIdNow = DateFormat.yMd().format(timeNow).replaceAll("/", "-");

    //status, in or out area
    String status = "out of area";

    if (distance <= 10000) {
      status = "in of area";
    }

    if (snapPresence.docs.length == 0) {
      //not yet presence then set presence in

      await colPresence.doc(docIdNow).set({
        "date": timeNow.toIso8601String(), // for order by
        "in": {
          "date": timeNow.toIso8601String(),
          "lat": position.latitude,
          "long": position.longitude,
          "address": address,
          "status": status,
          "distance": distance,
        }
      });
    } else {
      //got presence, then check
      DocumentSnapshot<Map<String, dynamic>> todayDoc =
          await colPresence.doc(docIdNow).get();

      if (todayDoc.exists == true) {
        //presence out, or presence out and in
        Map<String, dynamic>? dataPresenceToday = todayDoc.data();

        dataPresenceToday?["out"] == null
            ? await colPresence.doc(docIdNow).update({
                "out": {
                  "date": timeNow.toIso8601String(),
                  "lat": position.latitude,
                  "long": position.longitude,
                  "address": address,
                  "status": status,
                  "distance": distance,
                }
              })
            : Get.snackbar("Successfully", "You got attendance in & out");
      } else {
        //presence in
        await colPresence.doc(docIdNow).set({
          "date": timeNow.toIso8601String(), // for order by
          "in": {
            "date": timeNow.toIso8601String(),
            "lat": position.latitude,
            "long": position.longitude,
            "address": address,
            "status": status,
            "distance": distance,
          }
        });
      }
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = await firebaseAuth.currentUser!.uid;

    await firestore.collection("employee").doc(uid).update({
      "position": {
        "lat": position.latitude,
        "long": position.longitude,
      },
      "address": address,
    });
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      //return Future.error('Location services are disabled.');

      return {
        "message": "Cannot get data GPS form device",
        "error": true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        //return Future.error('Location permissions are denied');

        return {
          "message": "Location permissions are denied",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');

      return {
        "message":
            "Location permissions are permanently denied, change setting location permissions",
        "error": true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    //return await Geolocator.getCurrentPosition();

    Position position = await Geolocator.getCurrentPosition();
    return {
      "position": position,
      "message": "Successfully get location",
      "error": false,
    };
  }
}
