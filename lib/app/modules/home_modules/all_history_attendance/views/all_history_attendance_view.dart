import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/all_history_attendance_controller.dart';

class AllHistoryAttendanceView extends GetView<AllHistoryAttendanceController> {
  const AllHistoryAttendanceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AllHistoryAttendanceView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AllHistoryAttendanceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
