import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePickerPopUp extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget title;
  final Color? bgColor;
  const ImagePickerPopUp({
    Key? key,
    this.width,
    this.height,
    required this.title,
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
            ..._imagePickerList()
          ],
        ),
      ),
    );
  }

  List<Widget> _imagePickerList() {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Get.back(result: 0);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.camera_alt_rounded,
                  size: 21,
                  color: Get.theme.primaryColor,
                ),
              ),
              Text(
                "Kamera",
                style: Get.textTheme.titleMedium,
              )
            ],
          ),
        ),
      ),
      Divider(thickness: 1, color: Get.theme.unselectedWidgetColor),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Get.back(result: 1);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.photo_library_rounded,
                  size: 21,
                  color: Get.theme.primaryColor,
                ),
              ),
              Text(
                "Galeri",
                style: Get.textTheme.titleMedium,
              )
            ],
          ),
        ),
      ),
    ];
  }
}
