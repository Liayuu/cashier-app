import 'package:badges/badges.dart' as badges;
import 'package:cashier_app/themes/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Color backgroundColor;
  final Color itemColor;
  final Color selectedColor;
  final List<CustomBottomNavigationItem> children;
  final Function(int)? onChange;
  final int currentIndex;

  const CustomBottomNavigationBar(
      {super.key, required this.backgroundColor,
      required this.itemColor,
      this.currentIndex = 0,
      this.selectedColor = Colors.white,
      required this.children,
      this.onChange});

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  void _changeIndex(int index) {
    if (widget.onChange != null) {
      widget.onChange!(index);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Get.theme.shadowColor,
            blurRadius: 5,
            offset: const Offset(0, -3),
            spreadRadius: 2)
      ], color: widget.backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.children.map((item) {
          var color = item.color ?? widget.itemColor;
          var icon = item.icon;
          var assetIcon = item.assetIcon;
          var label = item.label;
          var isNotified = item.isNotified;
          int index = widget.children.indexOf(item);
          return GestureDetector(
            onTap: () {
              _changeIndex(index);
            },
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: widget.currentIndex == index
                      ? MediaQuery.of(context).size.width / widget.children.length + 40
                      : 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: widget.currentIndex == index ? color : Colors.transparent,
                      borderRadius: BorderRadius.circular(9)),
                  child: badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                        borderRadius: BorderRadius.circular(6),
                        shape: badges.BadgeShape.square,
                        badgeColor: widget.selectedColor),
                    position: (widget.currentIndex == index) ? badges.BadgePosition.topEnd() : null,
                    showBadge: (isNotified) ? true : false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        icon != null
                            ? Icon(
                                icon,
                                size: 24,
                                color: widget.currentIndex == index ? widget.selectedColor : color,
                              )
                            : SvgPicture.asset(
                                assetIcon!,
                                color: widget.currentIndex == index ? widget.selectedColor : color,
                                width: 24,
                                height: 24,
                              ),
                        widget.currentIndex == index
                            ? Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  label,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: Get.textTheme.labelLarge!.copyWith(
                                      color: widget.currentIndex == index
                                          ? widget.selectedColor
                                          : Pallete.transparent),
                                  // style: TextStyle(
                                  //     color: widget.currentIndex == index
                                  //         ? widget.selectedColor
                                  //         : Colors.transparent,
                                  //     fontWeight: FontWeight.bold),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CustomBottomNavigationItem {
  final IconData? icon;
  final String? assetIcon;
  final String label;
  final Color? color;
  final bool isNotified;

  CustomBottomNavigationItem(
      {this.icon, required this.label, this.color, this.isNotified = false, this.assetIcon})
      : assert(icon == null || assetIcon == null,
            'Select one type only\n' 'Do you want to use custom icon or default icon');
}
