import 'package:cashier_app/themes/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UnderlineInputText extends StatelessWidget {
  TextEditingController? textEditingController;
  bool readOnly;
  var maxLines;
  var initValue;
  TextInputType keyboardType;
  Function(dynamic)? onChanged;
  TextAlign textAlign;

  UnderlineInputText(
      {this.textEditingController,
      this.readOnly = false,
      this.maxLines,
      this.initValue,
      this.onChanged,
      this.keyboardType = TextInputType.text,
      this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign,
      initialValue: initValue,
      controller: textEditingController,
      keyboardType: keyboardType,
      readOnly: readOnly,
      maxLines: maxLines,
      onChanged: (value) {
        onChanged!(value);
      },
      style: Get.textTheme.bodyMedium,
      decoration: InputDecoration(
          fillColor: Pallete.transparent,
          border: UnderlineInputBorder(borderSide: BorderSide(color: Get.theme.primaryColor)),
          isDense: true,
          focusedBorder: Get.theme.inputDecorationTheme.focusedBorder!
              .copyWith(borderSide: BorderSide(color: Get.theme.colorScheme.secondary)),
          enabledBorder: Get.theme.inputDecorationTheme.focusedBorder!
              .copyWith(borderSide: BorderSide(color: Get.theme.colorScheme.secondary)),
          disabledBorder: Get.theme.inputDecorationTheme.disabledBorder),
    );
  }
}
