import 'package:cashier_app/themes/color_pallete.dart';
import 'package:cashier_app/views/components/in_page_search_bar.dart';
import 'package:cashier_app/views/pages/dashboard/menu/components/menu_card.dart';
import 'package:cashier_app/views/pages/dashboard/menu/components/menu_popup.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/views/pages/dashboard/menu/components/app_bar_menu.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dummy only. Change this in the next dev
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: CustomScrollView(
              shrinkWrap: true,
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 150,
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
                      height: 150,
                      width: Get.width,
                      child: Column(
                        children: const [
                          AppBarMenu(
                              companyLogo:
                                  "https://w7.pngwing.com/pngs/236/376/png-transparent-pepsi-logo-fizzy-drinks-company-pepsi.png",
                              companyName: "Toko Lorem"),
                          Padding(
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
                      itemCount: 10,
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
                                  "Makanan",
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
                  ),
                ),
                SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _dummyCard(),
                      childCount: 6,
                    ),
                    itemExtent: Get.width * 0.72)
              ]),
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

  Widget _dummyCard() {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () {
              Get.dialog(
                MenuPopUp(
                  width: Get.width * 0.8,
                  child: Column(
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
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: Text("Nasi Goreng Mak Jalal Biadap",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700)),
                      )
                    ],
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: MenuCard(
                    images: "https://www.bango.co.id/gfx/recipes/1460572810.jpg",
                    price: 15000,
                    availability: 15,
                    name: "Nasi Goreng Mak Jalal Biadap",
                    unit: "Portion"),
              ),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: MenuCard(
                    images: "https://www.bango.co.id/gfx/recipes/1460572810.jpg",
                    price: 15000,
                    availability: 15,
                    name: "Nasi Goreng",
                    unit: "Portion"),
              ),
            ),
          ),
        ),
      ],
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
