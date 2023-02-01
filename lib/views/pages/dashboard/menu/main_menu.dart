import 'package:cashier_app/views/pages/dashboard/menu/components/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/views/pages/dashboard/menu/components/app_bar_menu.dart';
import 'package:get/get.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dummy only. Change this in the next dev
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              AppBarMenu(),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AspectRatio(
                        aspectRatio: 3 / 5,
                        child: MenuCard(
                            images: "https://www.bango.co.id/gfx/recipes/1460572810.jpg",
                            price: 15000,
                            availability: 15,
                            name: "Nasi Goreng Mak Jalal Biadap",
                            unit: "Portion"),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AspectRatio(
                        aspectRatio: 3 / 5,
                        child: MenuCard(
                            images: "https://www.bango.co.id/gfx/recipes/1460572810.jpg",
                            price: 15000,
                            availability: 15,
                            name: "Nasi Goreng",
                            unit: "Portion"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
