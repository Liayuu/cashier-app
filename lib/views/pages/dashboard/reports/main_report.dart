import 'package:cashier_app/configs/language_config.dart';
import 'package:cashier_app/views/pages/dashboard/home/components/line_chart.dart';
import 'package:cashier_app/views/pages/dashboard/reports/components/report_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class MainReport extends StatelessWidget {
  const MainReport({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.background,
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
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Histori Transaksi",
                    style: Get.textTheme.titleLarge,
                  ),
                ),
                ListView.builder(
                  itemBuilder: (context, index) => ReportCard(),
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
