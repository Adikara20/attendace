import 'package:attendace/app/routes/app_pages.dart';
import 'package:attendace/app/widgets/text_formfield_custom.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constant/colors.dart';
import '../../../../widgets/round_button.dart';
import '../../../../widgets/text_costum.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  static final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TextCostum(
                    text: 'Login',
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    colorText: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextCostum(
                    text: 'Please sign in to continue',
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    colorText: AppColors.greyColor,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Obx(
                    () => TextFormFieldCustom(
                      formKey: _formKey1,
                      textController: controller.emailctrl,
                      obsecureText: false,
                      focusNode: controller.emailFocusNode,
                      text: 'email',
                      keyboardType: TextInputType.emailAddress,
                      iconData: Icons.alternate_email,
                      useObsecure: false,
                      iconColor: AppColors.primaryColor,
                      animatedFocusNode: controller.emailfocusAnimated.value,
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _obsecurePassword,
                    builder: (context, value, child) {
                      return Obx(
                        () => TextFormFieldCustom(
                          formKey: _formKey2,
                          textController: controller.passctrl,
                          obsecureText: _obsecurePassword.value,
                          focusNode: controller.passwordFocusNode,
                          text: 'password',
                          keyboardType: TextInputType.text,
                          iconData: Icons.lock,
                          useObsecure: true,
                          iconColor: AppColors.primaryColor,
                          animatedFocusNode: controller.passfocusAnimated.value,
                        ),
                      );
                    },
                  ),

                  //
                  const SizedBox(
                    height: 40,
                  ),
                  Obx(
                    () => RoundButton(
                      title: controller.isloading.isFalse
                          ? 'Login'
                          : 'Loading . . .',
                      //loading: authViewMode.loading,
                      onPress: () async {
                        if (controller.isloading.isFalse) {
                          await controller.login();
                        }
                      },
                      fontSize: 18, color: AppColors.secondaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.FORGOT_PASSWORD);
                    },
                    child: const Text(
                      "forgot Password?",
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: RichText(
                      text: const TextSpan(
                        text: 'dont have an account ? ',
                        style: TextStyle(color: AppColors.greyColor),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(text: ' please!'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
