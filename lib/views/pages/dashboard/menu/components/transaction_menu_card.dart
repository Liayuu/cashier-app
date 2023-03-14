import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionMenuCard extends StatelessWidget {
  final double? width;
  final double? height;
  final String images;
  final double price;
  final int qty;
  final String name;

  const TransactionMenuCard(
      {super.key,
      this.width,
      this.height,
      required this.images,
      required this.price,
      required this.qty,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ClipOval(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            images,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style:
                                  Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Get.theme.unselectedWidgetColor),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Get.theme.unselectedWidgetColor),
                      ),
                    ),
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Get.theme.unselectedWidgetColor),
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: Get.theme.unselectedWidgetColor),
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}
