import 'package:get/get.dart';

import '../controllers/all_history_attendance_controller.dart';

class AllHistoryAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllHistoryAttendanceController>(
      () => AllHistoryAttendanceController(),
    );
  }
}
