import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constant/colors.dart';
import '../../../widgets/round_button.dart';
import '../../../widgets/text_costum.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  static GlobalKey<FormState> _formKey1 = new GlobalKey<FormState>();
  static GlobalKey<FormState> _formKey2 = new GlobalKey<FormState>();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

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
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
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
                    () => AnimatedContainer(
                      duration: const Duration(seconds: 5),
                      margin: const EdgeInsets.all(16),
                      decoration: controller.emailfocusAnimated.value
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 15,
                                    offset: Offset(-5, 5),
                                  ),
                                ])
                          : null,
                      child: Form(
                        key: _formKey1,
                        child: TextFormField(
                          autocorrect: false,
                          cursorColor: AppColors.primaryColor,
                          controller: controller.emailctrl,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: controller.emailFocusNode,
                          decoration: const InputDecoration(
                              hintText: 'email',
                              prefixIcon: Icon(
                                Icons.alternate_email,
                                color: AppColors.primaryColor,
                              ),
                              fillColor: Colors.white,
                              hoverColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 1))),
                        ),
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _obsecurePassword,
                    builder: (context, value, child) {
                      return Obx(
                        () => AnimatedContainer(
                          duration: const Duration(seconds: 5),
                          margin: const EdgeInsets.all(16),
                          decoration: controller.passfocusAnimated.value
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 15,
                                        offset: Offset(-5, 5),
                                      ),
                                    ])
                              : null,
                          child: Form(
                            key: _formKey2,
                            child: TextFormField(
                              autocorrect: false,
                              cursorColor: AppColors.primaryColor,
                              controller: controller.passctrl,
                              obscureText: _obsecurePassword.value,
                              focusNode: controller.passwordFocusNode,
                              obscuringCharacter: '*',
                              decoration: InputDecoration(
                                  hintText: 'password',
                                  prefixIcon: const Icon(Icons.lock,
                                      color: AppColors.primaryColor),
                                  suffixIcon: InkWell(
                                    onTap: (() {
                                      _obsecurePassword.value =
                                          !_obsecurePassword.value;
                                    }),
                                    child: Icon(
                                        _obsecurePassword.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility,
                                        color: AppColors.primaryColor),
                                  ),
                                  fillColor: Colors.white,
                                  hoverColor: Colors.white,
                                  filled: true,
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: 1))),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
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
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () {},
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
