// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PriceTextfield extends StatefulWidget {
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
  NumberFormat? currency;

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
      this.currency,
      this.onChanged})
      : super(key: key);

  @override
  State<PriceTextfield> createState() => _PriceTextfieldState();
}

class _PriceTextfieldState extends State<PriceTextfield> {
  String formatNumber(String s) => NumberFormat.decimalPattern('id').format(double.parse(s));
  @override
  void initState() {
    if (widget.initialValue != null && widget.controller != null) {
      widget.controller!.text = formatNumber(widget.initialValue!.replaceAll('.', ''));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title ?? const SizedBox(),
        Row(
          children: [
            widget.currency != null
                ? Text(
                    widget.currency!.currencySymbol,
                    style: Get.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                  )
                : const SizedBox(),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: TextFormField(
                decoration: InputDecoration(
                    border: widget.border,
                    labelText: widget.labelText,
                    hintText: widget.hintText,
                    isDense: true,
                    contentPadding: const EdgeInsets.all(9),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Get.theme.primaryColor),
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    fillColor: !widget.enabled
                        ? Get.theme.unselectedWidgetColor
                        : Get.theme.inputDecorationTheme.fillColor,
                    floatingLabelAlignment: widget.floatingLabelAlignment,
                    floatingLabelBehavior: widget.floatingLabelBehavior),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: Get.textTheme.bodyText1,
                cursorWidth: 2.0,
                controller: widget.controller,
                cursorColor: Get.theme.primaryColor,
                obscureText: widget.obsecure,
                keyboardType: widget.keyboardType,
                maxLines: 1,
                enabled: widget.enabled,
                initialValue: widget.controller != null ? null : widget.initialValue,
                textInputAction: widget.textInputAction,
                validator: widget.validator,
                onChanged: (value) {
                  if (widget.onChanged != null) widget.onChanged!(value);
                },
                onSaved: (value) {
                  if (widget.onSaved != null) widget.onSaved!(value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
