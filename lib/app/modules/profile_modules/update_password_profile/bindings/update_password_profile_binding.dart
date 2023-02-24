import 'package:get/get.dart';

import '../controllers/update_password_profile_controller.dart';

class UpdatePasswordProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePasswordProfileController>(
      () => UpdatePasswordProfileController(),
    );
  }
}
