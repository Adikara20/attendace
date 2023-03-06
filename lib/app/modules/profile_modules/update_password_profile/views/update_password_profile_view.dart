import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/padding.dart';
import '../../../../widgets/round_button.dart';
import '../../../../widgets/text_costum.dart';
import '../../../../widgets/text_formfield_custom.dart';
import '../controllers/update_password_profile_controller.dart';

class UpdatePasswordProfileView
    extends GetView<UpdatePasswordProfileController> {
  static final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();

  final ValueNotifier<bool> _obsecurePassword1 = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obsecurePassword2 = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obsecurePassword3 = ValueNotifier<bool>(true);

  UpdatePasswordProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Update Password Profile'),
      //   centerTitle: true,
      // ),
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * (3 / 4),
            decoration: const BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(300),
                topRight: Radius.zero,
                topLeft: Radius.circular(220),
              ),
            ),
          ),
          ListView(
            padding: AppPadding.edgeInsetsOnly,
            children: [
              const Center(
                child: TextCostum(
                  text: 'Update Password',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  colorText: AppColors.primaryColor,
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              ValueListenableBuilder(
                valueListenable: _obsecurePassword1,
                builder: (context, value, child) {
                  return Obx(
                    () => TextFormFieldCustom(
                      formKey: _formKey1,
                      textController: controller.curpwdctrl,
                      obsecureText: true,
                      focusNode: controller.curpwdctrlFocusNode,
                      text: "Password",
                      keyboardType: TextInputType.text,
                      iconData: Icons.lock_open,
                      useObsecure: true,
                      iconColor: AppColors.primaryColor,
                      animatedFocusNode:
                          controller.curpwdctrlfocusAnimated.value,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder(
                valueListenable: _obsecurePassword2,
                builder: (context, value, child) {
                  return Obx(
                    () => TextFormFieldCustom(
                      formKey: _formKey2,
                      textController: controller.newpwdctrl,
                      obsecureText: true,
                      focusNode: controller.newpwdctrlFocusNode,
                      text: "New Password",
                      keyboardType: TextInputType.text,
                      iconData: Icons.lock,
                      useObsecure: true,
                      iconColor: AppColors.primaryColor,
                      animatedFocusNode:
                          controller.newpwdctrlfocusAnimated.value,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder(
                valueListenable: _obsecurePassword3,
                builder: (context, value, child) {
                  return Obx(
                    () => TextFormFieldCustom(
                      formKey: _formKey3,
                      textController: controller.confpwdctrl,
                      obsecureText: true,
                      focusNode: controller.confpwdctrlFocusNode,
                      text: "Confirm Password",
                      keyboardType: TextInputType.text,
                      iconData: Icons.lock,
                      useObsecure: true,
                      iconColor: AppColors.primaryColor,
                      animatedFocusNode:
                          controller.confpwdctrlfocusAnimated.value,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 55,
              ),
              Obx(
                () => RoundButton(
                  onPress: () async {
                    if (controller.isloading.isFalse) {
                      controller.updatePassword();
                    }
                  },
                  title: controller.isloading.isFalse
                      ? "Update Password"
                      : "Loading . . .",
                  fontSize: 18,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
