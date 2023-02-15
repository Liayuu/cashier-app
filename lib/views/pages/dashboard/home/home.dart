import 'package:cashier_app/views/pages/dashboard/home/components/line_chart.dart';
import 'package:cashier_app/views/pages/dashboard/menu/components/app_bar_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 100,
                  width: Get.width,
                  child: AppBarMenu(
                      companyLogo:
                          "https://w7.pngwing.com/pngs/236/376/png-transparent-pepsi-logo-fizzy-drinks-company-pepsi.png",
                      companyName: "Toko Lorem"),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _miniCard(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Income",
                                    style: Get.textTheme.bodyLarge,
                                  ),
                                  Text(
                                    "200k",
                                    style: Get.textTheme.bodyLarge,
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _miniCard(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Income",
                                    style: Get.textTheme.bodyLarge,
                                  ),
                                  Text(
                                    "200k",
                                    style: Get.textTheme.bodyLarge,
                                  )
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _miniCard(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Income",
                                    style: Get.textTheme.bodyLarge,
                                  ),
                                  Text(
                                    "200k",
                                    style: Get.textTheme.bodyLarge,
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _miniCard(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Income",
                                    style: Get.textTheme.bodyLarge,
                                  ),
                                  Text(
                                    "200k",
                                    style: Get.textTheme.bodyLarge,
                                  )
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                ),
                _dashboardChart()
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _dashboardChart({double? width, double? height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
          color: Get.theme.cardColor),
      child: LineChartDashboard(),
    );
  }

  Widget _miniCard({double? width, double? height, required Widget child}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
          color: Get.theme.cardColor),
      child: child,
    );
  }
}
