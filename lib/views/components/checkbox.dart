import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckboxButton extends StatefulWidget {
  bool isSelected;
  Function()? onTap;
  double width;
  double height;
  CheckboxButton({Key? key, this.isSelected = false, this.onTap, this.width = 24, this.height = 24})
      : super(key: key);

  @override
  _CheckboxButtonState createState() => _CheckboxButtonState();
}

class _CheckboxButtonState extends State<CheckboxButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      splashColor: Get.theme.primaryColor.withOpacity(0.4),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Get.theme.primaryColor),
              color: widget.isSelected ? Get.theme.primaryColor : Get.theme.unselectedWidgetColor,
              shape: BoxShape.circle),
          width: widget.width,
          height: widget.height,
          child: widget.isSelected
              ? const Icon(
                  Icons.check,
                  color: Color(0xFFFFFFFF),
                  size: 14,
                )
              : null,
        ),
      ),
    );
  }
}
