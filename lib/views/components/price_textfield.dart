// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PriceTextfield extends StatelessWidget {
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
  TextEditingController? controller;
  TextInputAction? textInputAction;
  String? Function(String?)? validator;
  ValueChanged<dynamic>? onSaved;
  ValueChanged<dynamic>? onChanged;
  NumberFormat currency;

  PriceTextfield(
      {Key? key,
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
      this.controller,
      this.textInputAction,
      this.validator,
      this.onSaved,
      required this.currency,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title ?? const SizedBox(),
        Row(
          children: [
            Text(
              currency.currencySymbol,
              style: Get.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: TextFormField(
                decoration: InputDecoration(
                    border: border,
                    labelText: labelText,
                    hintText: hintText,
                    isDense: true,
                    contentPadding: const EdgeInsets.all(9),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Get.theme.primaryColor),
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    fillColor: !enabled
                        ? Get.theme.unselectedWidgetColor
                        : Get.theme.inputDecorationTheme.fillColor,
                    floatingLabelAlignment: floatingLabelAlignment,
                    floatingLabelBehavior: floatingLabelBehavior),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: Get.textTheme.bodyText1,
                cursorWidth: 2.0,
                controller: controller,
                cursorColor: Get.theme.primaryColor,
                obscureText: obsecure,
                keyboardType: keyboardType,
                maxLines: 1,
                enabled: enabled,
                initialValue: initialValue,
                textInputAction: textInputAction,
                validator: validator,
                onChanged: (value) {
                  if (onChanged != null) onChanged!(value);
                },
                onSaved: (value) {
                  if (onSaved != null) onSaved!(value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
