import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MenuCard extends StatelessWidget {
  final double? width;
  final double? height;
  final String images;
  final double price;
  final String name;
  final double availability;
  // final String unit;
  String _formatCurrency(double p) =>
      NumberFormat.currency(locale: 'id', decimalDigits: 2, symbol: "Rp. ").format(p);

  const MenuCard({
    super.key,
    this.height,
    this.width,
    required this.images,
    required this.price,
    required this.name,
    required this.availability,
    // required this.unit
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              margin: EdgeInsets.only(top: height != null ? height! * 0.12 : Get.height * 0.12),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  color: Get.theme.cardColor),
            ),
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Get.theme.primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Text(_formatCurrency(price),
                                  style: Get.textTheme.bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                        //   child: Text(
                        //     "$availability $unit tersedia",
                        //     style: Get.textTheme.bodySmall,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
