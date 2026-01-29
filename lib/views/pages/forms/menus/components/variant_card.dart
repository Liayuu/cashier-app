import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VariantCard extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  const VariantCard({super.key, this.width, this.height, required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      shadowColor: Get.theme.shadowColor,
      color: Get.theme.cardColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Get.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue[400],
                          )),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.delete_rounded, color: Colors.red))
                    ],
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Get.theme.unselectedWidgetColor,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Level $index",
                      style: Get.textTheme.titleSmall,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
