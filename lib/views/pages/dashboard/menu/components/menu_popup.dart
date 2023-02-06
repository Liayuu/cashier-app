import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MenuPopUp extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  const MenuPopUp({super.key, this.width, this.height, this.child});

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
