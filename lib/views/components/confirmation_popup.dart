import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ConfirmationPopup extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget title;
  final Color? bgColor;
  const ConfirmationPopup({
    Key? key,
    this.width,
    this.height,
    required this.title,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
