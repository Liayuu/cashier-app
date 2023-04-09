import 'dart:async';
import 'dart:developer';

import 'package:cashier_app/configs/language_config.dart';
import 'package:cashier_app/controllers/enums/promotion_type_enum.dart';
import 'package:cashier_app/controllers/merchant_controller.dart';
import 'package:cashier_app/controllers/transaction_controller.dart';
import 'package:cashier_app/controllers/menu_controller.dart';
import 'package:cashier_app/controllers/user_controller.dart';
import 'package:cashier_app/models/categories_model.dart';
import 'package:cashier_app/models/menu/menus_model.dart';
import 'package:cashier_app/models/promotion/promotion_model.dart';
import 'package:cashier_app/themes/color_pallete.dart';
import 'package:cashier_app/views/components/button_main.dart';
import 'package:cashier_app/views/components/in_page_search_bar.dart';
import 'package:cashier_app/views/components/snackbar_order.dart';
import 'package:cashier_app/views/components/underline_input_text.dart';
import 'package:cashier_app/views/pages/dashboard/menu/components/menu_card.dart';
import 'package:cashier_app/views/components/menu_popup.dart';
import 'package:cashier_app/views/pages/dashboard/menu/summary_order.dart';
import 'package:cashier_app/views/pages/forms/menus/edit_menu.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/views/pages/dashboard/menu/components/app_bar_menu.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:intl/intl.dart';

class MainMenu extends StatefulWidget {
  final bool isForMainMenu;
  const MainMenu({super.key, this.isForMainMenu = true});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  StreamController<bool> streamController = StreamController<bool>.broadcast();
  // TextEditingController _qty = TextEditingController(text: 1.toString());
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final _transactionController = Get.find<TransactionController>();
  // final _userController = Get.find<UserController>();
  Timer? _debouncer;
  final _merchantController = Get.find<MerchantController>();
  final _menuController = Get.find<MenusController>();
  final _userController = Get.find<UserController>();
  String _formatCurrency(double p) =>
      NumberFormat.currency(locale: 'id', decimalDigits: 2, symbol: "Rp. ").format(p);
  String? searchMenu;

  @override
  void initState() {
    streamController.add(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.isForMainMenu
          ? null
          : FloatingActionButton(
              onPressed: () async {
                await Get.to(() => EditMenu(
                      locationId: _merchantController.branch.id!,
                      merchantId: _merchantController.merchant.id!,
                    ))?.then((value) {
                  _menuController.menu = MenuModel();
                  _menuController.newImage = null;
                  _menuController.listCategory.clear();
                });
              },
              backgroundColor: Get.theme.primaryColor,
              child: const Icon(Icons.add),
            ),
      // Dummy only. Change this in the next dev
      body: SafeArea(
        child: FutureBuilder<void>(
            future: _merchantController.initializeMerchant(_userController.userModel.employeeAt!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Stack(
                    children: [
                      Expanded(
                        child: StreamBuilder<List<CategoriesModel>>(
                            stream: _menuController.streamEditCategory(
                                _merchantController.merchant.id!, _merchantController.branch.id!,
                                searchMenu: searchMenu),
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
                                                        builder: (controller) {
                                                        return AppBarMenu(
                                                            companyLogo: controller.branch.logoUrl!,
                                                            companyName: controller.merchant.name!);
                                                      })
                                                    : const SizedBox(),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: InPageSearchBar(
                                                    hint: "Cari menu disini",
                                                    searchQuery: (query) {
                                                      if (_debouncer?.isActive ?? false)
                                                        _debouncer!.cancel();
                                                      _debouncer = Timer(
                                                          const Duration(milliseconds: 800), () {
                                                        if (searchMenu != query) {
                                                          setState(() {
                                                            searchMenu = query;
                                                          });
                                                        }
                                                        _debouncer?.cancel();
                                                      });
                                                    },
                                                  ),
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
                                                          style: Get.textTheme.bodyLarge!.copyWith(
                                                              fontWeight: FontWeight.w700),
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
                                      if (snapshot.data!.isNotEmpty) ...{
                                        SliverGrid.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2, childAspectRatio: 2 / 3),
                                          itemCount:
                                              snapshot.data?[_selectedIndex].menus?.length ?? 0,
                                          itemBuilder: (context, index) {
                                            return FutureBuilder<MenuModel>(
                                                future: _menuController.fetchMenuWithPrice(
                                                    snapshot.data![_selectedIndex].menus![index]),
                                                builder: (context, menu) {
                                                  if (menu.connectionState ==
                                                      ConnectionState.done) {
                                                    return GestureDetector(
                                                      onTap: () async {
                                                        if (widget.isForMainMenu) {
                                                          Get.dialog(_popUpMenu(menu.data!));
                                                        } else {
                                                          await _menuController
                                                              .fetchMenuForEdit(menu.data!)
                                                              .then((value) async {
                                                            _menuController.listCategory
                                                                .assignAll(snapshot.data!);
                                                            _menuController
                                                                .listCategory[_selectedIndex]
                                                                .isChoosed = true;
                                                            await Get.to(() => EditMenu(
                                                                  locationId: _merchantController
                                                                      .branch.id!,
                                                                  merchantId: _merchantController
                                                                      .merchant.id!,
                                                                ))?.then((value) {
                                                              _menuController.menu = MenuModel();
                                                              _menuController.newImage = null;
                                                              _menuController.listCategory.clear();
                                                            });
                                                          });
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: AspectRatio(
                                                          aspectRatio: 2 / 3,
                                                          child: MenuCard(
                                                              images: menu.data!.downloadLink!,
                                                              price: menu.data!.price!.price!,
                                                              availability: 99,
                                                              name: menu.data!.name!,
                                                              unit: "Portion"),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (menu.connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Center(
                                                      child: CircularProgressIndicator(),
                                                    );
                                                  } else {
                                                    return const Text("Something wrong");
                                                  }
                                                });
                                          },
                                        )
                                      }
                                    ]);
                              } else {
                                log(snapshot.error.toString(), error: "Error load menu");
                                return const SizedBox();
                              }
                            }),
                      ),
                      GetBuilder<TransactionController>(builder: (controller) {
                        if (controller.transaction.menus != null) {
                          if (controller.transaction.menus!.isNotEmpty) {
                            return _orderTrackingSnackbar();
                          }
                        } else {
                          // streamController.add(false);
                        }
                        return const SizedBox();
                      })
                    ],
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Text("Terjadi Kesalahan");
              }
            }),
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

  Widget _popUpMenu(MenuModel selectedMenu) {
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
                      selectedMenu.downloadLink!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 4),
            child: Text(selectedMenu.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              _formatCurrency(selectedMenu.price?.price ?? 0),
              // selectedMenu.price?.price.toString() ?? "0",
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
                  onTap: () {
                    if (_transactionController.menuQty > 1) {
                      _transactionController.menuQty = _transactionController.menuQty - 1;
                      _transactionController.update();
                    }
                  },
                  width: 40,
                  height: 40,
                  label: "-",
                  style: Get.textTheme.labelLarge,
                  background: Get.theme.primaryColor,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GetBuilder<TransactionController>(builder: (controller) {
                    return UnderlineInputText(
                      textEditingController: TextEditingController()
                        ..text = controller.menuQty.toString(),
                      maxLines: 1,
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    );
                  }),
                )),
                ButtonMain(
                  onTap: () {
                    _transactionController.menuQty = _transactionController.menuQty + 1;
                    _transactionController.update();
                  },
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
              onTap: () async {
                _transactionController.transaction.menus ??= [];
                // var promo = await _menuController.getMenuPromo(data: selectedMenu);
                // log(promo.toString());
                if (!_transactionController.transaction.menus!
                    .any((e) => e.id == selectedMenu.id)) {
                  // var buyingPrice;
                  // if (promo != PromotionModel()) {
                  //   switch (promo.nominalTypeName) {
                  //     case NominalTypeEnum.NOMINAL:
                  //       buyingPrice = selectedMenu.price!.price! - promo.nominal!;
                  //       break;
                  //     case NominalTypeEnum.PERCENT:
                  //       buyingPrice = selectedMenu.price!.price! -
                  //           (selectedMenu.price!.price! * promo.nominal!);
                  //       break;
                  //     default:
                  //       buyingPrice = selectedMenu.price!.price!;
                  //   }
                  // } else {
                  //   buyingPrice = selectedMenu.price!.price!;
                  // }
                  _transactionController.transaction.menus!
                      .add(selectedMenu.copyWith(qty: _transactionController.menuQty));
                  log(_transactionController.transaction.menus.toString());
                } else {
                  var idx = _transactionController.transaction.menus!
                      .indexWhere((e) => e.id == selectedMenu.id);
                  _transactionController.transaction.menus![idx].qty =
                      _transactionController.transaction.menus![idx].qty! +
                          _transactionController.menuQty;
                }
                _transactionController.insertGrandTotal();
                _transactionController.menuQty = 1;
                _transactionController.update();
                Get.back();
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
      primaryMessage: "${_transactionController.transaction.menus?.length ?? 0} Pesanan",
      onTap: () async {
        for (var i = 0; i < _transactionController.transaction.menus!.length; i++) {
          await _menuController
              .getMenuPromo(
                  data: _transactionController.transaction.menus![i],
                  qty: _transactionController.transaction.menus![i].qty!)
              .then((value) {
            if (value != null) {
              _transactionController.transaction.menus![i].promo = value;
              if (_transactionController.transaction.menus![i].promo!.nominalTypeName ==
                  NominalTypeEnum.NOMINAL) {
                _transactionController.transaction.menus![i].buyingPrice =
                    _transactionController.transaction.menus![i].price!.price! -
                        (_transactionController.transaction.menus![i].price!.price! *
                            _transactionController.transaction.menus![i].promo!.nominal!);
              } else {
                _transactionController.transaction.menus![i].buyingPrice =
                    _transactionController.transaction.menus![i].price!.price! -
                        _transactionController.transaction.menus![i].promo!.nominal!;
              }
            } else {
              _transactionController.transaction.menus![i].buyingPrice =
                  _transactionController.transaction.menus![i].price!.price!;
            }
          }).then((value) {
            // _transactionController.insertSubTotal();
            _transactionController.insertGrandTotal();
          });
        }
        // await Future.wait(_transactionController.transaction.menus!.map((e) {
        //   return _menuController.getMenuPromo(data: e, qty: e.qty!).then((value) {

        //   });
        // }));
        Get.to(() => SummaryOrder())?.then((value) {
          if (value) {
            // streamController.add(false);
          }
        });
      },
      secondaryMessage:
          _transactionController.transaction.menus?.map((e) => "${e.name},").toString(),
    );
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
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
