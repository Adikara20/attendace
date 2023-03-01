import 'package:get/get.dart';

import '../controllers/detail_attendace_controller.dart';

class DetailAttendaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailAttendaceController>(
      () => DetailAttendaceController(),
    );
  }
}
