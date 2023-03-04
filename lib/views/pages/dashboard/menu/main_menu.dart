import 'dart:async';
import 'dart:developer';

import 'package:cashier_app/configs/language_config.dart';
import 'package:cashier_app/controllers/merchant_controller.dart';
import 'package:cashier_app/controllers/user_controller.dart';
import 'package:cashier_app/controllers/menu_controller.dart';
import 'package:cashier_app/models/categories_model.dart';
import 'package:cashier_app/models/menu/menus_model.dart';
import 'package:cashier_app/themes/color_pallete.dart';
import 'package:cashier_app/views/components/button_main.dart';
import 'package:cashier_app/views/components/in_page_search_bar.dart';
import 'package:cashier_app/views/components/snackbar_order.dart';
import 'package:cashier_app/views/components/underline_input_text.dart';
import 'package:cashier_app/views/pages/dashboard/menu/components/menu_card.dart';
import 'package:cashier_app/views/components/menu_popup.dart';
import 'package:cashier_app/views/pages/forms/menus/edit_menu.dart';
import 'package:cashier_app/views/pages/payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/views/pages/dashboard/menu/components/app_bar_menu.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class MainMenu extends StatefulWidget {
  final bool isForMainMenu;
  const MainMenu({super.key, this.isForMainMenu = true});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  StreamController<bool> streamController = StreamController<bool>();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final _userController = Get.find<UserController>();
  final _merchantController = Get.find<MerchantController>();
  final _menuController = Get.find<MenusController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.isForMainMenu
          ? null
          : FloatingActionButton(
              onPressed: () {
                Get.to(() => EditMenu());
              },
              backgroundColor: Get.theme.primaryColor,
              child: const Icon(Icons.add),
            ),
      // Dummy only. Change this in the next dev
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: StreamBuilder<List<CategoriesModel>>(
              stream: _menuController.streamEditCategory(
                  _merchantController.merchant.id!, _merchantController.branch.id!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CustomScrollView(
                      shrinkWrap: true,
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverAppBar(
                          expandedHeight: widget.isForMainMenu ? 150 : 70,
                          pinned: false,
                          floating: true,
                          foregroundColor: Pallete.transparent,
                          backgroundColor: Get.theme.colorScheme.background,
                          snap: true,
                          leading: const SizedBox(),
                          leadingWidth: 0,
                          stretch: false,
                          flexibleSpace: FlexibleSpaceBar(
                            background: SizedBox(
                              height: widget.isForMainMenu ? 150 : 70,
                              width: Get.width,
                              child: Column(
                                children: [
                                  widget.isForMainMenu
                                      ? GetBuilder<MerchantController>(
                                          init: Get.find<MerchantController>(),
                                          builder: (controller) {
                                            return AppBarMenu(
                                                companyLogo: controller.branch.logo!,
                                                companyName: controller.merchant.name!);
                                          })
                                      : const SizedBox(),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: InPageSearchBar(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        makeHeader(
                            maxHeight: 40,
                            minHeight: 40,
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Get.theme.shadowColor,
                                    blurRadius: 9,
                                    offset: const Offset(0, -3),
                                    spreadRadius: 1)
                              ], color: Get.theme.colorScheme.background),
                              width: Get.width,
                              child: ListView.builder(
                                itemCount: snapshot.data?.length ?? 0,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(left: 12),
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedIndex = index;
                                      });
                                    },
                                    child: SizedBox(
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot.data![index].name!,
                                            style: Get.textTheme.bodyLarge!
                                                .copyWith(fontWeight: FontWeight.w700),
                                          ),
                                          Container(
                                            height: 2,
                                            width: 30,
                                            color: _selectedIndex == index
                                                ? Get.theme.primaryColor
                                                : Colors.transparent,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        SliverGrid.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 2 / 3),
                          itemCount: snapshot.data?[_selectedIndex].menus?.length ?? 0,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              if (widget.isForMainMenu) {
                                Get.dialog(_popUpMenu());
                              } else {
                                _menuController.menu = snapshot.data![_selectedIndex].menus![index];
                                _menuController.listCategory.assignAll(snapshot.data!);
                                Get.to(() => const EditMenu());
                              }
                              // widget.isForMainMenu
                              //     ? Get.dialog(_popUpMenu())
                              //     : Get.to(() => EditMenu());
                            },
                            child: FutureBuilder<MenuModel>(
                                future: _menuController.fetchMenuWithPrice(
                                    snapshot.data![_selectedIndex].menus![index]),
                                builder: (context, snapshot) {
                                  return Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: AspectRatio(
                                      aspectRatio: 2 / 3,
                                      child: MenuCard(
                                          images: snapshot.data!.image!,
                                          price: snapshot.data!.price!.price!,
                                          availability: 99,
                                          name: snapshot.data!.name!,
                                          unit: "Portion"),
                                    ),
                                  );
                                }),
                          ),
                        )
                      ]);
                } else {
                  log(snapshot.error.toString(), error: "Error load menu");
                  return SizedBox();
                }
              }),
        ),
      ),
    );
  }

  SliverPersistentHeader makeHeader({required Widget child, double? minHeight, double? maxHeight}) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: minHeight ?? 150,
        maxHeight: maxHeight ?? 150,
        child: child,
      ),
    );
  }

  Widget _popUpMenu() {
    return CustomPopUp(
      width: Get.width * 0.8,
      height: Get.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipOval(
                    child: Image.network(
                      "https://www.bango.co.id/gfx/recipes/1460572810.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 4),
            child: Text("Nasi Goreng Mak Jalal Biadap",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              "\$ 6.99",
              style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonMain(
                  onTap: () {},
                  width: 40,
                  height: 40,
                  label: "-",
                  style: Get.textTheme.labelLarge,
                  background: Get.theme.primaryColor,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: UnderlineInputText(
                    initValue: 1.toString(),
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                )),
                ButtonMain(
                  onTap: () {},
                  width: 40,
                  height: 40,
                  label: "+",
                  style: Get.textTheme.labelLarge,
                  background: Get.theme.primaryColor,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ButtonMain(
              onTap: () {
                Get.back();
                Get.to(() => Payment());
                // _orderTrackingSnackbar();
              },
              background: Get.theme.primaryColor,
              height: 50,
              width: Get.width * 0.7,
              label: "Tambahkan",
              style: Get.textTheme.labelLarge,
            ),
          )
        ],
      ),
    );
  }

  Widget _orderTrackingSnackbar() {
    streamController.add(true);
    return SnackbarOrder(
      key: _globalKey,
      stream: streamController.stream,
      hyperlinkText: lang().payment,
      primaryMessage: "1 Pesanan",
      onTap: () {},
      secondaryMessage: "Nasi Goreng Mak Jalal Biadap",
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
