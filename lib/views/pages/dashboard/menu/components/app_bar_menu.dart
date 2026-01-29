
import 'package:cashier_app/views/components/image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarMenu extends StatelessWidget {
  final String companyName;
  final String? companyLogo;
  const AppBarMenu({super.key, this.companyLogo, required this.companyName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Get.theme.colorScheme.onSurface, width: 8),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Get.theme.shadowColor,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                            spreadRadius: 4)
                      ]),
                  child: GestureDetector(
                    onTap: () => companyLogo != null
                        ? Get.to(() => ImageViewer(
                            tag: companyName,
                            image: NetworkImage(companyLogo!),
                            newsTitle: companyName))
                        : {},
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(48),
                        child: Hero(
                          tag: "Test",
                          child: Image.network(
                            companyLogo!,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                  )),
              // child: Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       color: Get.theme.primaryColor.withOpacity(0.55)),
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Image.network(
              //       companyLogo,
              //       fit: BoxFit.contain,
              //     ),
              //   ),
              // ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    companyName,
                    style: Get.textTheme.headlineSmall,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
