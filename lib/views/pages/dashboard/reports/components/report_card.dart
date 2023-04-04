import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportCard extends StatefulWidget {
  String? idTransaction;
  DateTime transactionDate;
  double totalTransaction;
  Function()? onTap;
  ReportCard({
    Key? key,
    this.idTransaction,
    this.onTap,
    required this.transactionDate,
    required this.totalTransaction,
  }) : super(key: key);

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> with TickerProviderStateMixin {
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Waktu Pemesanan',
                            style: Get.textTheme.labelMedium!,
                          ),
                          Text(
                            DateFormat("dd MMM yyyy hh:mm").format(widget.transactionDate),
                            style: Get.textTheme.labelMedium,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Total Transaksi",
                            style: Get.textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.w700, color: Get.theme.primaryColor),
                          ),
                          Text(
                            NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: 'Rp.')
                                .format(widget.totalTransaction),
                            style: Get.textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.w700, color: Get.theme.primaryColor),
                          ),
                        ],
                      )
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
}
