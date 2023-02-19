import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final String tag, newsTitle;
  final ImageProvider image;
  const ImageViewer({Key? key, required this.tag, required this.image, required this.newsTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.background,
        titleSpacing: 8,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            newsTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.labelLarge,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              size: 24,
              color: Get.theme.colorScheme.outline,
            ),
          ),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoView(
          imageProvider: image,
          heroAttributes: PhotoViewHeroAttributes(tag: tag),
        ),
      ),
    );
  }
}
