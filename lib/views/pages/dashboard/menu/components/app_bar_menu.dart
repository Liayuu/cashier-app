import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarMenu extends StatelessWidget {
  final String companyName;
  final String companyLogo;
  const AppBarMenu({super.key, required this.companyLogo, required this.companyName});

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
                    borderRadius: BorderRadius.circular(20),
                    color: Get.theme.primaryColor.withOpacity(0.55)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    companyLogo,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
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
