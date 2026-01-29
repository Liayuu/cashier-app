import 'package:cashier_app/views/components/button_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CompletePayment extends StatelessWidget {
  const CompletePayment({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/check-right-tick.json',
                  height: 200, width: 200, fit: BoxFit.fill),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Transaksi Berhasil",
                  style: Get.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonMain(
                  height: 50,
                  width: Get.width * 0.5,
                  label: "Kembali",
                  onTap: () {
                    Get.back(result: true);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
