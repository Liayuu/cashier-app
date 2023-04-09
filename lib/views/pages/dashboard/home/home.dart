import 'dart:math';

import 'package:cashier_app/controllers/merchant_controller.dart';
import 'package:cashier_app/controllers/transaction_controller.dart';
import 'package:cashier_app/controllers/user_controller.dart';
import 'package:cashier_app/models/transaction/transaction_model.dart';
import 'package:cashier_app/views/pages/dashboard/home/components/line_chart.dart';
import 'package:cashier_app/views/pages/dashboard/menu/components/app_bar_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _transactionController = Get.find<TransactionController>();
  final _userController = Get.find<UserController>();
  final _merchantController = Get.find<MerchantController>();

  @override
  Widget build(BuildContext context) {
    _merchantController.initializeMerchant(_userController.userModel.employeeAt!);
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
                  child: GetBuilder<MerchantController>(
                      init: Get.find<MerchantController>(),
                      builder: (controller) {
                        return AppBarMenu(
                            companyLogo: controller.branch.logoUrl!,
                            companyName: controller.merchant.name!);
                      }),
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
                StreamBuilder<QuerySnapshot<TransactionModel>>(
                  stream: _transactionController.streamDashboardReport(
                      merchantId: _merchantController.merchant.id!,
                      locationId: _merchantController.branch.id!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: _cardChild(
                                              title: "Transaksi",
                                              info: NumberFormat.compact()
                                                  .format(snapshot.data?.docs.length)))),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _miniCard(
                                      height: 100,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: _cardChild(
                                              title: "Pemasukan",
                                              info: snapshot.data!.docs.isNotEmpty
                                                  ? NumberFormat.compact().format(snapshot
                                                      .data?.docs
                                                      .map((e) => e.data().grandTotal)
                                                      .toList()
                                                      .fold<double>(
                                                          0,
                                                          (previousValue, element) =>
                                                              previousValue + element!))
                                                  : 0.toString()))),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: _cardChild(
                                              title: "Transaksi Terkecil",
                                              info: snapshot.data!.docs.isNotEmpty
                                                  ? NumberFormat.compact().format(snapshot
                                                      .data?.docs
                                                      .map((e) => e.data().grandTotal)
                                                      .reduce((value, element) =>
                                                          value! < element! ? value : element))
                                                  : 0.toString()))),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _miniCard(
                                      height: 100,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: _cardChild(
                                              title: "Transaksi Terbesar",
                                              info: snapshot.data!.docs.isNotEmpty
                                                  ? NumberFormat.compact().format(snapshot
                                                      .data?.docs
                                                      .map((e) => e.data().grandTotal)
                                                      .reduce((value, element) =>
                                                          value! > element! ? value : element))
                                                  : 0.toString()))),
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  },
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
