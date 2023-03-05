import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/padding.dart';
import '../../../../widgets/round_button.dart';
import '../../../../widgets/text_costum.dart';
import '../../../../widgets/text_formfield_custom.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  static final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();

  const UpdateProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> user = Get.arguments;

    controller.emailctrl.text = user["email"];
    controller.nipctrl.text = user["nip"];
    controller.namectrl.text = user["name"];

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Update Profile'),
      //   centerTitle: true,
      // ),
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        //alignment: Alignment.center,
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
                  text: 'Update Profile',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  colorText: AppColors.primaryColor,
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              Obx(
                () => TextFormFieldCustom(
                  formKey: _formKey1,
                  textController: controller.nipctrl,
                  obsecureText: false,
                  focusNode: controller.nipctrlFocusNode,
                  text: 'nip',
                  keyboardType: TextInputType.text,
                  iconData: Icons.perm_identity,
                  useObsecure: false,
                  iconColor: AppColors.primaryColor,
                  animatedFocusNode: controller.nipctrlfocusAnimated.value,
                ),
              ),
              Obx(
                () => TextFormFieldCustom(
                  formKey: _formKey2,
                  textController: controller.emailctrl,
                  obsecureText: false,
                  focusNode: controller.emailctrlFocusNode,
                  text: 'email',
                  keyboardType: TextInputType.emailAddress,
                  iconData: Icons.alternate_email,
                  useObsecure: false,
                  iconColor: AppColors.primaryColor,
                  animatedFocusNode: controller.emailctrlfocusAnimated.value,
                ),
              ),
              Obx(
                () => TextFormFieldCustom(
                  formKey: _formKey3,
                  textController: controller.namectrl,
                  obsecureText: false,
                  focusNode: controller.namectrlFocusNode,
                  text: 'name',
                  keyboardType: TextInputType.text,
                  iconData: Icons.abc_rounded,
                  useObsecure: false,
                  iconColor: AppColors.primaryColor,
                  animatedFocusNode: controller.namectrlfocusAnimated.value,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const TextCostum(
                        text: 'Photo Profile',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        colorText: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GetBuilder<UpdateProfileController>(
                        builder: (builder) {
                          if (builder.image != null) {
                            return ClipOval(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.file(
                                  File(builder.image!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          } else {
                            if (user["profile"] != null) {
                              return Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      ClipOval(
                                        child: Container(
                                          width: 108,
                                          height: 108,
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                      ClipOval(
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(
                                            user["profile"],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controller.pickDeleteProfile(user["uid"]);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 70,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.whiteColor,
                                      ),
                                      child: const TextCostum(
                                        text: 'Delete',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        colorText: AppColors.removeColor,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const Text("Photo");
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      controller.pickPhotoProfile();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 70,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.whiteColor,
                      ),
                      child: const TextCostum(
                        text: 'Choose\n  Photo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        colorText: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Obx(
                () => RoundButton(
                  onPress: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.updateProfileEmployee(user["uid"]);
                    }
                  },
                  title: controller.isLoading.isFalse
                      ? "Update Profile Employee"
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
