import 'package:flutter/material.dart';

class CustomPopUp extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  const CustomPopUp({super.key, this.width, this.height, this.child});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 0,
          maxHeight: height ?? 200,
          maxWidth: width ?? 200,
          minWidth: 0,
        ),
        child: child,
      ),
    );
  }
}
