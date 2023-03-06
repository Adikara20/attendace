import 'package:attendace/app/widgets/text_formfield_custom.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/padding.dart';
import '../../../../widgets/round_button.dart';
import '../../../../widgets/text_costum.dart';
import '../controllers/add_employee_controller.dart';

class AddEmployeeView extends GetView<AddEmployeeController> {
  static final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKey4 = GlobalKey<FormState>();

  const AddEmployeeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Add Employee'),
      //   centerTitle: true,
      // ),
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * (3 / 4),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
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
                  text: 'Add New Employee',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  colorText: AppColors.whiteColor,
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
                  text: "NIP",
                  keyboardType: TextInputType.text,
                  iconData: Icons.perm_identity,
                  useObsecure: false,
                  iconColor: AppColors.primaryColor,
                  animatedFocusNode: controller.emailctrlfocusAnimated.value,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => TextFormFieldCustom(
                  formKey: _formKey2,
                  textController: controller.namectrl,
                  obsecureText: false,
                  focusNode: controller.namectrlFocusNode,
                  text: "Name",
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
              Obx(
                () => TextFormFieldCustom(
                  formKey: _formKey3,
                  textController: controller.emailctrl,
                  obsecureText: false,
                  focusNode: controller.emailctrlFocusNode,
                  text: "Email",
                  keyboardType: TextInputType.emailAddress,
                  iconData: Icons.alternate_email,
                  useObsecure: false,
                  iconColor: AppColors.primaryColor,
                  animatedFocusNode: controller.emailctrlfocusAnimated.value,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => TextFormFieldCustom(
                  formKey: _formKey4,
                  textController: controller.jobctrl,
                  obsecureText: false,
                  focusNode: controller.jobctrlFocusNode,
                  text: "Jobs",
                  keyboardType: TextInputType.text,
                  iconData: Icons.work,
                  useObsecure: false,
                  iconColor: AppColors.primaryColor,
                  animatedFocusNode: controller.jobctrlfocusAnimated.value,
                ),
              ),
              const SizedBox(
                height: 55,
              ),
              Obx(
                () => RoundButton(
                  onPress: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.addEmployee();
                    }
                  },
                  title: controller.isLoading.isFalse
                      ? "Add Employee"
                      : "Loading . . .",
                  fontSize: 18,
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
