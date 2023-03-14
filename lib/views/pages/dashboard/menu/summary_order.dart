import 'package:cashier_app/controllers/transaction_controller.dart';
import 'package:cashier_app/views/pages/dashboard/menu/components/transaction_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummaryOrder extends StatefulWidget {
  const SummaryOrder({super.key});

  @override
  State<SummaryOrder> createState() => _SummaryOrderState();
}

class _SummaryOrderState extends State<SummaryOrder> {
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
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(flex: 4, child: Text("Item", style: Get.textTheme.bodyMedium)),
                  Expanded(
                      flex: 1,
                      child: Text(
                        "Qty",
                        style: Get.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(
                        "Price",
                        style: Get.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: GetBuilder<TransactionController>(
              init: Get.find<TransactionController>(),
              builder: (controller) {
                return ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TransactionMenuCard(
                        width: Get.width,
                        images: controller.transaction.menus![index].downloadLink!,
                        price: controller.transaction.menus![index].price!.price!,
                        qty: controller.transaction.menus![index].qty!,
                        name: controller.transaction.menus![index].name!),
                  ),
                  itemCount: controller.transaction.menus?.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
