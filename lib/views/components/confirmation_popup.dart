import 'package:flutter/material.dart';

class ConfirmationPopup extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget title;
  final Widget? content;
  final Widget? action;
  final Color? bgColor;
  const ConfirmationPopup({
    Key? key,
    this.width,
    this.height,
    required this.title,
    this.content,
    this.action,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: 0, maxHeight: height ?? 200, maxWidth: width ?? 200, minWidth: width ?? 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            const SizedBox(
              height: 24,
            ),
            if (content != null) ...{content!},
            if (action != null) ...{action!}
          ],
        ),
      ),
    );
  }
}
