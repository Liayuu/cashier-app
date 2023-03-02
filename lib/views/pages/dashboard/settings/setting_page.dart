import 'dart:developer';

import 'package:cashier_app/controllers/merchant_controller.dart';
import 'package:cashier_app/controllers/user_controller.dart';
import 'package:cashier_app/models/merchant/merchant_model.dart';
import 'package:cashier_app/themes/asset_dir.dart';
import 'package:cashier_app/views/components/image_viewer.dart';
import 'package:cashier_app/views/pages/dashboard/menu/main_menu.dart';
import 'package:cashier_app/views/pages/forms/merchants/edit_merchant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});
  final _userController = Get.find<UserController>();
  final _merchantController = Get.find<MerchantController>();

  @override
  Widget build(BuildContext context) {
    if (_merchantController.merchant == MerchantModel()) {
      _merchantController.fetchMerchantModel(_userController.userModel.employeeAt!);
    }

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            width: Get.width,
            height: Get.height,
            child: ListView(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    GetBuilder<MerchantController>(builder: (controller) {
                      return Container(
                        width: Get.width,
                        height: Get.height / 4,
                        // color: Get.theme.primaryColor,
                        margin: const EdgeInsets.only(bottom: 75),
                        child: Image.network(_merchantController.branch.background!,
                            fit: BoxFit.cover),
                      );
                    }),
                    Positioned(
                      top: (Get.height / 4) - 75,
                      child: GetBuilder<MerchantController>(builder: (controller) {
                        return Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Get.theme.colorScheme.onBackground, width: 8),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Get.theme.shadowColor,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                      spreadRadius: 4)
                                ]),
                            child: GestureDetector(
                              onTap: () => Get.to(() => ImageViewer(
                                  tag: "Test",
                                  image: NetworkImage(_merchantController.branch.logo!),
                                  newsTitle: "Test")),
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(48),
                                  child: Hero(
                                    tag: "Test",
                                    child: Image.network(
                                      _merchantController.branch.logo!,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                              ),
                            ));
                      }),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width,
                        child: GetBuilder<MerchantController>(builder: (controller) {
                          return Text(
                            _merchantController.merchant.name!,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: Get.textTheme.titleLarge,
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Get.theme.cardColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Get.theme.shadowColor,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                  spreadRadius: 2)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _userMenu(
                                title: "Merchant Management",
                                icon: SvgPicture.asset(AssetsDirectory.shopIcon,
                                    color: Get.theme.primaryColor),
                                onTap: () async {
                                  await Get.to(() => EditMerchant());
                                },
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              _userMenu(
                                title: "Menu Management",
                                icon: SvgPicture.asset(AssetsDirectory.menuIcon,
                                    color: Get.theme.primaryColor),
                                onTap: () async {
                                  await Get.to(() => const MainMenu(
                                        isForMainMenu: false,
                                      ));
                                },
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              _userMenu(
                                title: "Promotion Management",
                                icon: SvgPicture.asset(AssetsDirectory.promoIcon,
                                    color: Get.theme.primaryColor),
                                onTap: () async {},
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              _userMenu(
                                title: "Logout",
                                icon: SvgPicture.asset(AssetsDirectory.logoutIcon,
                                    color: Get.theme.primaryColor),
                                onTap: () async {},
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget _userMenu({required String title, Function()? onTap, Widget? icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Get.theme.primaryColor.withAlpha(45)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: icon ?? const SizedBox(),
            ),
          ),
          Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  style: Get.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                ),
              )),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
            color: Get.theme.primaryColor,
          ),
        ],
      ),
    );
  }
}
