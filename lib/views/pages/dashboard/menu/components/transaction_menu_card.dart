import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cashier_app/views/components/profile_textfield.dart';
import 'package:intl/intl.dart';

class TransactionMenuCard extends StatelessWidget {
  final double? width;
  final double? height;
  final String images;
  final double price;
  final int qty;
  final String name;
  final ValueChanged<dynamic>? onChanged;
  final Function()? onDeleted;
  String _formatCurrency(double p) =>
      NumberFormat.currency(locale: 'id', decimalDigits: 2, symbol: "Rp. ").format(p);

  const TransactionMenuCard({
    Key? key,
    this.width,
    this.height,
    required this.images,
    required this.price,
    required this.qty,
    required this.name,
    this.onChanged,
    this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
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
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style:
                                    Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "@ ${_formatCurrency(price)}",
                                style: Get.textTheme.bodySmall,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Get.theme.unselectedWidgetColor),
                          child: Center(
                            child: Text(
                              qty.toString(),
                              style:
                                  Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          _formatCurrency((qty * price)),
                          style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                    )),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: AspectRatio(
                    aspectRatio: 6 / 1,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        child: ProfileTextfield(
                          hintText: "Note",
                          onChanged: (value) {
                            if (onChanged != null) onChanged;
                          },
                        ),
                      ),
                    ),
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
                            border: Border.all(color: Colors.red)),
                        child: IconButton(
                            onPressed: onDeleted ?? () {},
                            icon: const Icon(
                              Icons.delete_rounded,
                              size: 24,
                              color: Colors.red,
                            )),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
