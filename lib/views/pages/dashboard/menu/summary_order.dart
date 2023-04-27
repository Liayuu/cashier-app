import 'dart:developer';

import 'package:cashier_app/controllers/enums/promotion_type_enum.dart';
import 'package:cashier_app/controllers/merchant_controller.dart';
import 'package:cashier_app/controllers/promotion_controller.dart';
import 'package:cashier_app/controllers/transaction_controller.dart';
import 'package:cashier_app/models/menu/menus_model.dart';
import 'package:cashier_app/models/promotion/promotion_model.dart';
import 'package:cashier_app/views/components/confirmation_popup.dart';
import 'package:cashier_app/views/components/menu_popup.dart';
import 'package:cashier_app/views/components/underline_input_text.dart';
import 'package:cashier_app/views/pages/dashboard/menu/components/transaction_menu_card.dart';
import 'package:cashier_app/views/pages/payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/views/components/button_main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SummaryOrder extends StatefulWidget {
  bool isFromReport;
  SummaryOrder({super.key, this.isFromReport = false});

  @override
  State<SummaryOrder> createState() => _SummaryOrderState();
}

class _SummaryOrderState extends State<SummaryOrder> {
  final _promotionController = Get.find<PromotionController>();
  final _merchantController = Get.find<MerchantController>();
  final _transactionController = Get.find<TransactionController>();
  String _formatCurrency(double p) =>
      NumberFormat.currency(locale: 'id', decimalDigits: 2, symbol: "Rp. ").format(p);
  String _formatPercent(double p) =>
      NumberFormat.decimalPercentPattern(locale: 'id', decimalDigits: 0).format(p);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Text("Order", style: Get.textTheme.headlineSmall),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: Text("Item", style: Get.textTheme.bodyMedium)),
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Qty",
                        style: Get.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      )),
                  Expanded(
                      flex: 3,
                      child: Text(
                        "Price",
                        style: Get.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Divider(
              color: Get.theme.primaryColor,
              thickness: 1,
            ),
          ),
          Expanded(
            flex: 9,
            child: GetBuilder<TransactionController>(
              init: Get.find<TransactionController>(),
              builder: (controller) {
                return ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: TransactionMenuCard(
                        width: Get.width,
                        noteEnabled: !widget.isFromReport,
                        noteInitialValue: controller.transaction.menus![index].note,
                        onQtyTapped: () {
                          _transactionController.menuQty =
                              _transactionController.transaction.menus![index].qty!;
                          Get.dialog(_popUpMenu(index));
                        },
                        onChanged: (value) {
                          controller.transaction.menus![index].note = value.toString();
                          controller.update();
                        },
                        onDeleted: !widget.isFromReport
                            ? () {
                                Get.dialog(ConfirmationPopup(
                                  title: Text(
                                    "Hapus Menu",
                                    style: Get.textTheme.titleMedium,
                                  ),
                                  content: Center(
                                    child: Text(
                                      "Apakah anda yakin ingin menghapus pesanan ini?",
                                      style: Get.textTheme.bodyMedium,
                                    ),
                                  ),
                                  width: Get.width * 0.8,
                                  action: Flexible(
                                    fit: FlexFit.loose,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                                borderRadius: BorderRadius.circular(12),
                                                splashColor: Colors.white.withOpacity(0.8),
                                                onTap: () {
                                                  controller.transaction.menus!.removeAt(index);
                                                  controller.insertGrandTotal();
                                                  controller.insertSubTotal();
                                                  controller.update();
                                                  Get.back();
                                                  if (controller.transaction.menus!.isEmpty) {
                                                    Get.back(result: true);
                                                  }
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: Text(
                                                    "Ya",
                                                    style: Get.textTheme.labelMedium,
                                                  ),
                                                ))),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                                borderRadius: BorderRadius.circular(12),
                                                splashColor: Colors.white.withOpacity(0.8),
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: Text(
                                                    "Tidak",
                                                    style: Get.textTheme.labelMedium,
                                                  ),
                                                ))),
                                      ],
                                    ),
                                  ),
                                ));
                              }
                            : null,
                        discount: controller.transaction.menus![index].promo?.nominal,
                        discountType: controller.transaction.menus![index].promo?.nominalTypeName,
                        images: controller.transaction.menus![index].downloadLink!,
                        price: controller.transaction.menus![index].price!.price!,
                        qty: controller.transaction.menus![index].qty!,
                        name: controller.transaction.menus![index].name!),
                  ),
                  itemCount: controller.transaction.menus?.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Divider(
              thickness: 1,
              color: Get.theme.primaryColor,
            ),
          ),
          FutureBuilder<List<PromotionModel>?>(
              future: _promotionController.getPromotion(
                  merchantId: _merchantController.merchant.id!,
                  locationId: _merchantController.branch.id!,
                  forTransaction: true,
                  minimumTransaction: _transactionController.getSubTotal(),
                  currentTime: DateTime.now()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  log(snapshot.hasData.toString());
                  return Expanded(
                    flex: 4,
                    child: GetBuilder<TransactionController>(
                      init: Get.find<TransactionController>(),
                      builder: (controller) => Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Total Pemesanan",
                                          style: Get.textTheme.bodyLarge!
                                              .copyWith(fontWeight: FontWeight.w700)),
                                      Text(_formatCurrency(controller.getSubTotal()),
                                          style: Get.textTheme.bodyLarge)
                                    ],
                                  ),
                                  snapshot.hasData
                                      ? Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Diskon",
                                              style: Get.textTheme.bodyLarge!
                                                  .copyWith(fontWeight: FontWeight.w700)),
                                        )
                                      : const SizedBox(),
                                  snapshot.hasData
                                      ? Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _promotionController
                                                    .findBestPromo(
                                                        promo:
                                                            _promotionController.listAvailablePromo,
                                                        totalPrice: controller.getSubTotal())
                                                    .name!,
                                                style: Get.textTheme.bodyLarge,
                                              ),
                                              Text(
                                                  _promotionController
                                                              .findBestPromo(
                                                                  promo: _promotionController
                                                                      .listAvailablePromo,
                                                                  totalPrice:
                                                                      controller.getSubTotal())
                                                              .nominalTypeName ==
                                                          NominalTypeEnum.NOMINAL
                                                      ? _formatCurrency(_promotionController
                                                          .findBestPromo(
                                                              promo: _promotionController
                                                                  .listAvailablePromo,
                                                              totalPrice: controller.getSubTotal())
                                                          .nominal!)
                                                      : _formatPercent(_promotionController
                                                          .findBestPromo(
                                                              promo: _promotionController
                                                                  .listAvailablePromo,
                                                              totalPrice: controller.getSubTotal())
                                                          .nominal!),
                                                  style: Get.textTheme.bodyLarge)
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                                  snapshot.hasData
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Total Pembayaran",
                                                style: Get.textTheme.bodyLarge!
                                                    .copyWith(fontWeight: FontWeight.w700)),
                                            Text(
                                                _formatCurrency(_getTotalPayment(
                                                    controller.getSubTotal(),
                                                    _promotionController.findBestPromo(
                                                        promo:
                                                            _promotionController.listAvailablePromo,
                                                        totalPrice: controller.getSubTotal()))),
                                                style: Get.textTheme.bodyLarge)
                                          ],
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          if (!widget.isFromReport) ...{
                            Container(
                                height: Get.height * 0.085,
                                width: Get.width,
                                color: Get.theme.colorScheme.background,
                                child: Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ButtonMain(
                                      height: Get.height,
                                      width: Get.width,
                                      onTap: () {
                                        _transactionController.transaction.promos = [];
                                        if (_promotionController.listAvailablePromo.isNotEmpty) {
                                          _transactionController.transaction.subTotal =
                                              _getTotalPayment(
                                                  controller.getSubTotal(),
                                                  _promotionController.findBestPromo(
                                                      promo:
                                                          _promotionController.listAvailablePromo,
                                                      totalPrice: controller.getSubTotal()));
                                          _transactionController.transaction.promos!.assign(
                                              _promotionController.findBestPromo(
                                                  promo: _promotionController.listAvailablePromo,
                                                  totalPrice: controller.getSubTotal()));
                                          _transactionController.update();
                                        }
                                        Get.to(() => const Payment())?.then((value) {
                                          if (value != null) {
                                            if (value) {
                                              Get.back(result: true);
                                            }
                                          }
                                        });
                                      },
                                      color: Get.theme.primaryColor,
                                      background: Get.theme.colorScheme.primary,
                                      style: Get.textTheme.labelLarge,
                                      label: "Konfirmasi Pembayaran",
                                    ),
                                  ),
                                ))
                          }
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      height: Get.height * 0.085,
                      width: Get.width,
                      color: Get.theme.colorScheme.background,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ));
                } else {
                  return const Text("Error");
                }
              })
        ],
      )),
    );
  }

  double _getTotalPayment(double total, PromotionModel promo) {
    double pay;
    if (promo.nominalTypeName == NominalTypeEnum.PERCENT) {
      pay = total - (total * promo.nominal!);
    } else {
      pay = total - promo.nominal!;
    }
    return pay;
  }

  Widget _popUpMenu(int index) {
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
                      _transactionController.transaction.menus![index].downloadLink!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 4),
            child: Text(_transactionController.transaction.menus![index].name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              _formatCurrency(_transactionController.transaction.menus![index].price?.price ?? 0),
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
                _transactionController.transaction.menus![index].qty =
                    _transactionController.menuQty;
                // _transactionController.transaction.menus ??= [];
                // // var promo = await _menuController.getMenuPromo(data: selectedMenu);
                // // log(promo.toString());
                // if (!_transactionController.transaction.menus!
                //     .any((e) => e.id == _transactionController.transaction.menus![index].id)) {
                //   // var buyingPrice;
                //   // if (promo != PromotionModel()) {
                //   //   switch (promo.nominalTypeName) {
                //   //     case NominalTypeEnum.NOMINAL:
                //   //       buyingPrice = selectedMenu.price!.price! - promo.nominal!;
                //   //       break;
                //   //     case NominalTypeEnum.PERCENT:
                //   //       buyingPrice = selectedMenu.price!.price! -
                //   //           (selectedMenu.price!.price! * promo.nominal!);
                //   //       break;
                //   //     default:
                //   //       buyingPrice = selectedMenu.price!.price!;
                //   //   }
                //   // } else {
                //   //   buyingPrice = selectedMenu.price!.price!;
                //   // }
                //   _transactionController.transaction.menus!
                //       .add(selectedMenu.copyWith(qty: _transactionController.menuQty));
                //   log(_transactionController.transaction.menus.toString());
                // } else {
                //   var idx = _transactionController.transaction.menus!
                //       .indexWhere((e) => e.id == selectedMenu.id);
                //   _transactionController.transaction.menus![idx].qty =
                //       _transactionController.transaction.menus![idx].qty! +
                //           _transactionController.menuQty;
                // }
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
}
