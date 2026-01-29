import 'package:cashier_app/configs/language_config.dart';
import 'package:cashier_app/controllers/merchant_controller.dart';
import 'package:cashier_app/controllers/transaction_controller.dart';
import 'package:cashier_app/models/transaction/transaction_model.dart';
import 'package:cashier_app/views/pages/dashboard/home/components/line_chart.dart';
import 'package:cashier_app/views/pages/dashboard/menu/summary_order.dart';
import 'package:cashier_app/views/pages/dashboard/reports/components/report_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainReport extends StatelessWidget {
  final TransactionController _transactionController = Get.find<TransactionController>();
  final MerchantController _merchantController = Get.find<MerchantController>();
  MainReport({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.surface,
        elevation: 1,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: Get.theme.colorScheme.outline,
              size: 24,
            )),
        centerTitle: true,
        title: Text(
          lang().report,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Get.textTheme.headlineSmall,
        ),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Statistik Laporan",
                    style: Get.textTheme.titleLarge,
                  ),
                ),
                Container(
                  width: Get.width,
                  height: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12),
                      color: Get.theme.cardColor),
                  child: const LineChartDashboard(),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Histori Transaksi",
                    style: Get.textTheme.titleLarge,
                  ),
                ),
                FutureBuilder<List<TransactionModel>>(
                    future: _transactionController.transactionList(
                        merchantId: _merchantController.merchant.id!,
                        locationId: _merchantController.branch.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemBuilder: (context, index) => ReportCard(
                              onTap: () async {
                                await _transactionController
                                    .getSingleTransaction(snapshot.data![index].id!)
                                    .then((value) {
                                  Get.to(() => SummaryOrder(
                                        isFromReport: true,
                                      ));
                                });
                              },
                              idTransaction: snapshot.data?[index].id ?? "Unknown",
                              transactionDate: snapshot.data?[index].createdAt ?? DateTime.now(),
                              totalTransaction: snapshot.data?[index].subTotal ?? 0,
                            ),
                            itemCount: snapshot.data?.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          );
                        }
                      }
                      return const SizedBox();
                    })
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
