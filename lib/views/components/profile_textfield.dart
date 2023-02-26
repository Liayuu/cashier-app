// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileTextfield extends StatelessWidget {
  String? labelText;
  String? hintText;
  Widget? title;
  OutlineInputBorder? border;
  TextInputType? keyboardType;
  FloatingLabelAlignment? floatingLabelAlignment;
  FloatingLabelBehavior? floatingLabelBehavior;
  String? initialValue;
  bool enabled;
  bool obsecure;
  TextInputAction? textInputAction;
  String? Function(String?)? validator;
  ValueChanged<dynamic>? onSaved;

  ProfileTextfield({
    Key? key,
    this.labelText,
    this.hintText,
    this.title,
    this.border,
    this.keyboardType,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    this.initialValue,
    this.enabled = true,
    this.obsecure = false,
    this.textInputAction,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title ?? const SizedBox(),
        TextFormField(
          decoration: InputDecoration(
              border: border,
              labelText: labelText,
              hintText: hintText,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Get.theme.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              fillColor: !enabled
                  ? Get.theme.unselectedWidgetColor
                  : Get.theme.inputDecorationTheme.fillColor,
              floatingLabelAlignment: floatingLabelAlignment,
              floatingLabelBehavior: floatingLabelBehavior),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: Get.textTheme.bodyText1,
          cursorWidth: 2.0,
          cursorColor: Get.theme.primaryColor,
          obscureText: obsecure,
          keyboardType: keyboardType,
          maxLines: 1,
          enabled: enabled,
          initialValue: initialValue,
          textInputAction: textInputAction,
          validator: validator,
          onSaved: (value) {
            if (onSaved != null) onSaved!(value);
          },
        ),
      ],
    );
  }
}
