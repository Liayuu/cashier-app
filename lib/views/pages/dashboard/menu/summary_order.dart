import 'dart:developer';

import 'package:cashier_app/controllers/transaction_controller.dart';
import 'package:cashier_app/views/components/confirmation_popup.dart';
import 'package:cashier_app/views/pages/dashboard/menu/components/transaction_menu_card.dart';
import 'package:cashier_app/views/pages/payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/views/components/button_main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SummaryOrder extends StatefulWidget {
  bool isFromReport;
  SummaryOrder({super.key, this.isFromReport = false});

  @override
  State<SummaryOrder> createState() => _SummaryOrderState();
}

class _SummaryOrderState extends State<SummaryOrder> {
  String _formatCurrency(double p) =>
      NumberFormat.currency(locale: 'id', decimalDigits: 2, symbol: "Rp. ").format(p);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Text("Order", style: Get.textTheme.headlineSmall),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: Text("Item", style: Get.textTheme.bodyMedium)),
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Qty",
                        style: Get.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      )),
                  Expanded(
                      flex: 3,
                      child: Text(
                        "Price",
                        style: Get.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Divider(
              color: Get.theme.primaryColor,
              thickness: 1,
            ),
          ),
          Expanded(
            flex: 9,
            child: GetBuilder<TransactionController>(
              init: Get.find<TransactionController>(),
              builder: (controller) {
                return ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: TransactionMenuCard(
                        width: Get.width,
                        onChanged: (value) {
                          controller.transaction.menus![index].note = value.toString();
                          controller.update();
                        },
                        onDeleted: !widget.isFromReport
                            ? () {
                                Get.dialog(ConfirmationPopup(
                                  title: Text(
                                    "Hapus Menu",
                                    style: Get.textTheme.titleMedium,
                                  ),
                                  content: Center(
                                    child: Text(
                                      "Apakah anda yakin ingin menghapus pesanan ini?",
                                      style: Get.textTheme.bodyMedium,
                                    ),
                                  ),
                                  width: Get.width * 0.8,
                                  action: Flexible(
                                    fit: FlexFit.loose,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                                borderRadius: BorderRadius.circular(12),
                                                splashColor: Colors.white.withOpacity(0.8),
                                                onTap: () {
                                                  controller.transaction.menus!.removeAt(index);
                                                  controller.insertGrandTotal();
                                                  controller.update();
                                                  Get.back();
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: Text(
                                                    "Ya",
                                                    style: Get.textTheme.labelMedium,
                                                  ),
                                                ))),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                                borderRadius: BorderRadius.circular(12),
                                                splashColor: Colors.white.withOpacity(0.8),
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: Text(
                                                    "Tidak",
                                                    style: Get.textTheme.labelMedium,
                                                  ),
                                                ))),
                                      ],
                                    ),
                                  ),
                                ));
                              }
                            : null,
                        images: controller.transaction.menus![index].downloadLink!,
                        price: controller.transaction.menus![index].price!.price!,
                        qty: controller.transaction.menus![index].qty!,
                        name: controller.transaction.menus![index].name!),
                  ),
                  itemCount: controller.transaction.menus?.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Divider(
              thickness: 1,
              color: Get.theme.primaryColor,
            ),
          ),
          Expanded(
            flex: 3,
            child: GetBuilder<TransactionController>(
              init: Get.find<TransactionController>(),
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Discount",
                                style: Get.textTheme.bodyLarge,
                              ),
                              Text(_formatCurrency(0), style: Get.textTheme.bodyLarge)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Pemesanan", style: Get.textTheme.bodyLarge),
                              Text(_formatCurrency(controller.getSubTotal()),
                                  style: Get.textTheme.bodyLarge)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: Get.height * 0.085,
                      width: Get.width,
                      color: Get.theme.colorScheme.background,
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ButtonMain(
                            height: Get.height,
                            width: Get.width,
                            onTap: () async {
                              log(controller.transaction.toString());
                              await Get.to(() => Payment())?.then((value) {
                                if (value != null) {
                                  if (value) {
                                    Get.back();
                                  }
                                }
                              });
                            },
                            color: Get.theme.primaryColor,
                            background: Get.theme.colorScheme.primary,
                            style: Get.textTheme.labelLarge,
                            label: "Konfirmasi Pembayaran",
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
