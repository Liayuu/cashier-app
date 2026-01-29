import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// ignore: must_be_immutable
class BorderedInputText extends StatelessWidget {
  // Timer _timer;
  Function(dynamic)? data;
  // final productForm = Get.find<ProductController>();
  // final box = GetStorage();
  String? hint;
  bool addSuffix;
  TextEditingController? textEditingController;
  bool readOnly;
  var maxLines;
  var initValue;
  var textAlign;
  var focusNode;
  // var model;
  TextInputType? type;

  BorderedInputText(
      {super.key, this.hint,
      this.addSuffix = false,
      this.textEditingController,
      this.readOnly = false,
      this.maxLines,
      this.initValue,
      this.type,
      this.textAlign = TextAlign.left,
      this.focusNode,
      this.data});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      readOnly: readOnly,
      initialValue: initValue,
      focusNode: focusNode,
      keyboardType: type,
      textAlign: textAlign,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: Get.theme.primaryColor,
      maxLines: maxLines,
      decoration: InputDecoration(
        isDense: true,
        suffixIcon: addSuffix
            ? Icon(
                Icons.info_sharp,
                color: Get.theme.primaryColor,
                size: 24,
              )
            : null,
        enabledBorder: Get.theme.inputDecorationTheme.enabledBorder,
        focusedBorder: Get.theme.inputDecorationTheme.focusedBorder,
        hintText: hint,
        hintStyle: Get.textTheme.bodyMedium,
      ),
      onChanged: (value) {
        data!(value);
        // if (_timer?.isActive ?? false) _timer.cancel();
        // _timer = Timer(Duration(seconds: 3), () {
        //   productForm.productForm.productName = value;
        //   box.write('product', productForm.productForm);
        // });
      },
    );
  }
}
