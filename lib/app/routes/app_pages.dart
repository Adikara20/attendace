import 'package:get/get.dart';

import '../modules/home_modules/all_history_attendance/bindings/all_history_attendance_binding.dart';
import '../modules/home_modules/all_history_attendance/views/all_history_attendance_view.dart';
import '../modules/home_modules/detail_attendace/bindings/detail_attendace_binding.dart';
import '../modules/home_modules/detail_attendace/views/detail_attendace_view.dart';
import '../modules/home_modules/home/bindings/home_binding.dart';
import '../modules/home_modules/home/views/home_view.dart';
import '../modules/login_moduls/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/login_moduls/forgot_password/views/forgot_password_view.dart';
import '../modules/login_moduls/login/bindings/login_binding.dart';
import '../modules/login_moduls/login/views/login_view.dart';
import '../modules/login_moduls/new_password/bindings/new_password_binding.dart';
import '../modules/login_moduls/new_password/views/new_password_view.dart';
import '../modules/profile_modules/add_employee/bindings/add_employee_binding.dart';
import '../modules/profile_modules/add_employee/views/add_employee_view.dart';
import '../modules/profile_modules/profile/bindings/profile_binding.dart';
import '../modules/profile_modules/profile/views/profile_view.dart';
import '../modules/profile_modules/update_password_profile/bindings/update_password_profile_binding.dart';
import '../modules/profile_modules/update_password_profile/views/update_password_profile_view.dart';
import '../modules/profile_modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/profile_modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADD_EMPLOYEE,
      page: () => const AddEmployeeView(),
      binding: AddEmployeeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => const NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => const UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD_PROFILE,
      page: () => UpdatePasswordProfileView(),
      binding: UpdatePasswordProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ATTENDACE,
      page: () => const DetailAttendaceView(),
      binding: DetailAttendaceBinding(),
    ),
    GetPage(
      name: _Paths.ALL_HISTORY_ATTENDANCE,
      page: () => const AllHistoryAttendanceView(),
      binding: AllHistoryAttendanceBinding(),
    ),
  ];
}
