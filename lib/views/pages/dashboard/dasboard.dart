import 'package:cashier_app/themes/asset_dir.dart';
import 'package:cashier_app/views/components/bottom_bar.dart';
import 'package:cashier_app/views/pages/dashboard/menu/main_menu.dart';
import 'package:cashier_app/views/pages/dashboard/promo/main_promo.dart';
import 'package:cashier_app/views/pages/dashboard/reports/main_report.dart';
import 'package:cashier_app/views/pages/dashboard/settings/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        children: const [MainMenu(), MainPromo(), MainReport(), SettingPage()],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        backgroundColor: Get.theme.colorScheme.background,
        itemColor: Get.theme.primaryColor,
        children: [
          CustomBottomNavigationItem(
              assetIcon: AssetsDirectory.homeIcon, color: Get.theme.primaryColor, label: "Home"),
          CustomBottomNavigationItem(
              assetIcon: AssetsDirectory.promoIcon,
              color: Get.theme.primaryColor,
              label: "Promotion"),
          CustomBottomNavigationItem(
              assetIcon: AssetsDirectory.homeIcon, color: Get.theme.primaryColor, label: "Home"),
          CustomBottomNavigationItem(
              assetIcon: AssetsDirectory.homeIcon, color: Get.theme.primaryColor, label: "Home")
        ],
        currentIndex: _currentIndex,
      ),
    );
  }
}
