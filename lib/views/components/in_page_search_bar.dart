import 'package:cashier_app/themes/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InPageSearchBar extends StatelessWidget {
  final String? hint;
  final Function(String)? searchQuery;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  const InPageSearchBar(
      {Key? key, this.onSubmitted, this.focusNode, this.hint, this.searchQuery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? lastInput;
    return Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? Pallete.darkFormBackground
            : Pallete.lightFormBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: TextField(
            onSubmitted: onSubmitted,
            focusNode: focusNode,
            style: Get.textTheme.bodyMedium,
            maxLines: 1,
            onChanged: (query) {
              if (lastInput != query) {
                searchQuery!(query);
                lastInput = query;
              }
            },
            decoration: InputDecoration(
              fillColor: Pallete.transparent,
              contentPadding: EdgeInsets.zero,
              iconColor:
                  Get.isDarkMode ? Pallete.lighterText : Pallete.darkText,
              prefixIcon: const Icon(Icons.search),
              hintText: hint,
              border: InputBorder.none,
            ),
            cursorColor: Get.theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
