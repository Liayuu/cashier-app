import 'dart:async';
import 'package:cashier_app/themes/asset_dir.dart';
import 'package:cashier_app/views/pages/authentication/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // _splashscreenStart();
    super.initState();
  }

  // void _splashscreenStart() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
      height: Get.height,
      width: Get.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                AssetsDirectory.mainLogo,
                scale: 0.70,
              )),
        ),
      ),
    )));
  }
}
