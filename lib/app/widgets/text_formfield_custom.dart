import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  final FocusNode focusNode;
  final GlobalKey<FormState> formKey;
  final TextEditingController textController;
  final ValueNotifier<bool> obsecureText;
  final String text;
  final TextInputType keyboardType;
  final IconData iconData;
  final bool useObsecure;
  final Color iconColor;

  const TextFormFieldCustom({
    Key? key,
    required this.formKey,
    required this.textController,
    required this.obsecureText,
    required this.focusNode,
    required this.text,
    required this.keyboardType,
    required this.iconData,
    required this.useObsecure,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(16),
      decoration: focusNode.hasFocus
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
        key: formKey,
        child: TextFormField(
          keyboardType: keyboardType,
          controller: textController,
          obscureText: obsecureText.value,
          focusNode: focusNode,
          obscuringCharacter: '*',
          decoration: InputDecoration(
              hintText: text,
              prefixIcon: Icon(
                iconData,
                color: iconColor,
              ),
              suffixIcon: useObsecure
                  ? InkWell(
                      onTap: (() {
                        obsecureText.value = !obsecureText.value;
                      }),
                      child: Icon(
                        obsecureText.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility,
                        color: iconColor,
                      ),
                    )
                  : null,
              fillColor: Colors.white,
              hoverColor: Colors.white,
              filled: true,
              enabledBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey, width: 1))),
        ),
      ),
    );
  }
}
