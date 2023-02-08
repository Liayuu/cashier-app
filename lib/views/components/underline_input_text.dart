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
          isDense: true,
          focusedBorder: Get.theme.inputDecorationTheme.focusedBorder,
          disabledBorder: Get.theme.inputDecorationTheme.disabledBorder),
    );
  }
}
