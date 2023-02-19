import 'package:cashier_app/configs/language_config.dart';
import 'package:cashier_app/themes/asset_dir.dart';
import 'package:cashier_app/views/components/bottom_bar.dart';
import 'package:cashier_app/views/pages/dashboard/home/home.dart';
import 'package:cashier_app/views/pages/dashboard/menu/main_menu.dart';
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
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
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
        children: const [Home(), MainMenu(), MainReport(), SettingPage()],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        backgroundColor: Get.theme.colorScheme.background,
        itemColor: Get.theme.primaryColor,
        selectedColor: Get.theme.colorScheme.onBackground,
        onChange: (p0) {
          _pageController.animateToPage(p0,
              duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        },
        children: [
          CustomBottomNavigationItem(
              assetIcon: AssetsDirectory.homeIcon,
              color: Get.theme.primaryColor,
              label: lang().promotion),
          CustomBottomNavigationItem(
              assetIcon: AssetsDirectory.menuIcon,
              color: Get.theme.primaryColor,
              label: lang().home),
          CustomBottomNavigationItem(
              assetIcon: AssetsDirectory.reportIcon,
              color: Get.theme.primaryColor,
              label: lang().report),
          CustomBottomNavigationItem(
              assetIcon: AssetsDirectory.settingIcon,
              color: Get.theme.primaryColor,
              label: lang().setting)
        ],
        currentIndex: _currentIndex,
      ),
    );
  }
}
