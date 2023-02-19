import 'package:cashier_app/views/pages/dashboard/home/components/line_chart.dart';
import 'package:cashier_app/views/pages/dashboard/menu/components/app_bar_menu.dart';
import 'package:flutter/material.dart';
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
                  child: const AppBarMenu(
                      companyLogo:
                          "https://w7.pngwing.com/pngs/236/376/png-transparent-pepsi-logo-fizzy-drinks-company-pepsi.png",
                      companyName: "Toko Lorem"),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Statistik Hari ini",
                    style: Get.textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(
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
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: _cardChild(title: "Transaksi", info: "39"))),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _miniCard(
                            height: 100,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: _cardChild(title: "Pemasukan", info: "200K"))),
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
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: _cardChild(title: "Menu Terjual", info: "50"))),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _miniCard(
                            height: 100,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: _cardChild(title: "Transaksi Terbesar", info: "75K"))),
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

  Widget _cardChild({required String title, required String info}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            info,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: Get.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
          ),
        )
      ],
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
      child: const LineChartDashboard(),
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
