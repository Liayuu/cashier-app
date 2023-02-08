import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SnackbarTemplate extends StatelessWidget {
  IconData? icon;
  String? primaryMsg;
  String? secondaryMsg;
  String? hyperlinkText;
  Function()? onTap;

  SnackbarTemplate(
      {this.icon, required this.primaryMsg, this.secondaryMsg, this.hyperlinkText, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 50,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.0),
            blurRadius: 6.0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              icon == null
                  ? SizedBox()
                  : Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          icon,
                          color: Get.theme.colorScheme.outline,
                        ),
                      ),
                    ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          primaryMsg!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: Get.textTheme.bodyLarge,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          secondaryMsg ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: Get.textTheme.bodySmall,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: onTap,
                  child: Text(
                    hyperlinkText ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Get.textTheme.bodyLarge,
                    textAlign: TextAlign.right,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
