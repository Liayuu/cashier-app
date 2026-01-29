// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileTextfield extends StatefulWidget {
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

  ProfileTextfield(
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
      this.onChanged})
      : super(key: key);

  @override
  State<ProfileTextfield> createState() => _ProfileTextfieldState();
}

class _ProfileTextfieldState extends State<ProfileTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title ?? const SizedBox(),
        TextFormField(
          decoration: InputDecoration(
              border: widget.border,
              labelText: widget.labelText,
              hintText: widget.hintText,
              isDense: true,
              suffixIcon: widget.keyboardType == TextInputType.visiblePassword
                  ? IconButton(
                      icon: Icon(widget.obsecure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          widget.obsecure = !widget.obsecure;
                        });
                      },
                    )
                  : null,
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
          style: Get.textTheme.bodyMedium,
          cursorWidth: 2.0,
          controller: widget.controller,
          cursorColor: Get.theme.primaryColor,
          obscureText: widget.obsecure,
          keyboardType: widget.keyboardType,
          maxLines: 1,
          enabled: widget.enabled,
          initialValue: widget.initialValue,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
          },
          onSaved: (value) {
            if (widget.onSaved != null) widget.onSaved!(value);
          },
        ),
      ],
    );
  }
}
