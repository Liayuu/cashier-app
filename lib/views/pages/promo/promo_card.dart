import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:cashier_app/controllers/enums/promotion_type_enum.dart';

class PromoCard extends StatefulWidget {
  String idPromo;
  DateTime startTime;
  DateTime endTime;
  String name;
  double nominal;
  double? maximumNominal;
  double? minimumNominal;
  Function()? onTap;
  NominalTypeEnum nominalType;
  PromoCard({
    Key? key,
    required this.idPromo,
    required this.startTime,
    required this.endTime,
    required this.name,
    required this.nominal,
    this.maximumNominal,
    this.minimumNominal,
    this.onTap,
    required this.nominalType,
  }) : super(key: key);

  @override
  State<PromoCard> createState() => _PromoCardState();
}

class _PromoCardState extends State<PromoCard> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isExpanded = false;

  @override
  void initState() {
    _prepareAnimation();
    _runExpandCheck();

    super.initState();
  }

  void _prepareAnimation() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500));
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn);
  }

  void _runExpandCheck() {
    if (isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: Get.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _promoText(),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          widget.minimumNominal != null
                              ? _minMaxTransaction(isMinimum: true)
                              : const SizedBox(),
                          const SizedBox(
                            width: 4,
                          ),
                          widget.maximumNominal != null
                              ? _minMaxTransaction(isMinimum: false)
                              : const SizedBox()
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Mulai berlaku",
                            style: Get.textTheme.labelMedium,
                          ),
                          Text(
                            DateFormat("dd MMM yyyy hh:mm").format(widget.startTime),
                            style: Get.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Kadaluarsa",
                            style: Get.textTheme.labelMedium,
                          ),
                          Text(
                            DateFormat("dd MMM yyyy hh:mm").format(widget.endTime),
                            style: Get.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _minMaxTransaction({bool isMinimum = false}) {
    return Text(
      isMinimum
          ? "Min. ${NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: 'Rp.').format(widget.minimumNominal)}"
          : "Max. ${NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: 'Rp.').format(widget.maximumNominal)}",
      style: Get.textTheme.labelMedium,
    );
  }

  Widget _promoText() {
    switch (widget.nominalType) {
      case NominalTypeEnum.NOMINAL:
        return Text(
          NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: 'Rp.')
              .format(widget.nominal),
          style: Get.textTheme.titleLarge!
              .copyWith(fontWeight: FontWeight.w700, color: Get.theme.primaryColor),
        );
      case NominalTypeEnum.PERCENT:
        return Text(
          NumberFormat.decimalPercentPattern(decimalDigits: 0).format(widget.nominal),
          style: Get.textTheme.titleLarge!
              .copyWith(fontWeight: FontWeight.w700, color: Get.theme.primaryColor),
        );
      default:
        return Text(
          widget.nominal.toString(),
          style: Get.textTheme.titleLarge!
              .copyWith(fontWeight: FontWeight.w700, color: Get.theme.primaryColor),
        );
    }
  }
}
