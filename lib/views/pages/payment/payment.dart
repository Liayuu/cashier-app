import 'dart:developer';

import 'package:cashier_app/configs/language_config.dart';
import 'package:cashier_app/controllers/enums/order_type_enum.dart';
import 'package:cashier_app/controllers/merchant_controller.dart';
import 'package:cashier_app/controllers/transaction_controller.dart';
import 'package:cashier_app/controllers/user_controller.dart';
import 'package:cashier_app/themes/color_pallete.dart';
import 'package:cashier_app/views/components/bordered_input_text.dart';
import 'package:cashier_app/views/components/confirmation_popup.dart';
import 'package:cashier_app/views/components/price_textfield.dart';
import 'package:cashier_app/views/pages/payment/complete_payment.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/views/components/button_main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final _formKey = GlobalKey<FormState>();
  final _merchantController = Get.find<MerchantController>();
  final _userController = Get.find<UserController>();
  final _cashTextCon = TextEditingController();
  String _formatNumber(String s) => NumberFormat.decimalPattern('id').format(double.parse(s));

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
            child: SingleChildScrollView(
              child: GetBuilder<TransactionController>(
                  init: Get.find<TransactionController>(),
                  builder: (controller) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Text(lang().payment.capitalizeFirst!,
                              style: Get.textTheme.headlineSmall),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            lang().paymentMethodAvailability(1),
                            style: Get.textTheme.bodyLarge,
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                          indent: 15,
                          endIndent: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Text(lang().paymentMethod, style: Get.textTheme.titleLarge),
                        ),
                        SizedBox(
                          height: 95,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            itemCount: 1,
                            itemBuilder: (context, index) => AspectRatio(
                              aspectRatio: 1.5 / 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: index == 0
                                              ? Get.theme.primaryColor
                                              : Pallete.transparent),
                                      borderRadius: BorderRadius.circular(10),
                                      color: index == 0
                                          ? Get.theme.unselectedWidgetColor
                                          : Get.theme.cardColor),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.wallet,
                                        size: 24,
                                        color: index == 0
                                            ? Get.theme.colorScheme.primary
                                            : Get.theme.colorScheme.outline,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(lang().paymentType("CASH").capitalize!,
                                          style: index == 0
                                              ? Get.textTheme.bodyMedium!
                                                  .copyWith(color: Get.theme.primaryColor)
                                              : Get.textTheme.bodyMedium),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PriceTextfield(
                                  currency: NumberFormat.currency(locale: 'id', symbol: 'Rp. '),
                                  hintText: "Total Harga",
                                  initialValue:
                                      _formatNumber(controller.transaction.subTotal.toString()),
                                  enabled: false,
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                                    child: Text(
                                      lang().subTotal,
                                      style: Get.textTheme.titleMedium!
                                          .copyWith(fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                PriceTextfield(
                                  currency: NumberFormat.currency(locale: 'id', symbol: 'Rp. '),
                                  hintText: lang().cash,
                                  onChanged: (value) async {
                                    var val = '${_formatNumber(value.replaceAll('.', ''))}';
                                    if (value != null && value != "") {
                                      controller.transaction.cash =
                                          double.parse(value.replaceAll('.', ''));
                                      controller.transaction.change =
                                          double.parse(value.replaceAll('.', '')) -
                                              controller.transaction.subTotal!;
                                    } else {
                                      controller.transaction.cash = 0;
                                      controller.transaction.change = null;
                                    }
                                    log(value);
                                    _cashTextCon.value = TextEditingValue(
                                        selection: TextSelection.collapsed(offset: val.length),
                                        text: val);

                                    controller.update();
                                  },
                                  controller: _cashTextCon,
                                  keyboardType: TextInputType.number,
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                                    child: Text(
                                      lang().cash,
                                      style: Get.textTheme.titleMedium!
                                          .copyWith(fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                PriceTextfield(
                                  currency: NumberFormat.currency(locale: 'id', symbol: 'Rp. '),
                                  hintText: lang().change,
                                  controller: TextEditingController(
                                      text: controller.transaction.change != null
                                          ? _formatNumber(controller.transaction.change!.toString())
                                          : null),
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                                    child: Text(
                                      lang().change,
                                      style: Get.textTheme.titleMedium!
                                          .copyWith(fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Divider(
                              height: 1, color: Get.theme.colorScheme.outline.withOpacity(0.7)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                          child: Text(
                            lang().orderType,
                            style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: DropdownButtonFormField<OrderType>(
                            value: controller.transaction.orderType ?? OrderType.DINE_IN,
                            onChanged: (value) {
                              controller.transaction.orderType = value;
                              controller.update();
                            },
                            items: [
                              DropdownMenuItem(
                                value: OrderType.DINE_IN,
                                child: Text(
                                  "Dine In",
                                  style: Get.textTheme.bodyMedium,
                                ),
                              ),
                              DropdownMenuItem(
                                value: OrderType.TAKE_AWAY,
                                child: Text("Take Away", style: Get.textTheme.bodyMedium),
                              )
                            ],
                            decoration: InputDecoration(
                                enabledBorder: Get.theme.inputDecorationTheme.enabledBorder,
                                focusedBorder: Get.theme.inputDecorationTheme.focusedBorder),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(16),
                        //   child: _payForm(title: lang().custEmail, formText: "yuliacan@gmail.com"),
                        // )
                      ],
                    );
                  }),
            ),
          ),
          Container(
            height: Get.height * 0.085,
            width: Get.width,
            color: Get.theme.colorScheme.background,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonMain(
                      height: Get.height,
                      width: Get.width,
                      onTap: () {
                        Get.back(result: false);
                      },
                      color: Get.theme.primaryColor,
                      background: Get.theme.colorScheme.background,
                      style: Get.textTheme.labelLarge,
                      label: "Cancel",
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GetBuilder<TransactionController>(builder: (controller) {
                      return ButtonMain(
                        height: Get.height,
                        width: Get.width,
                        onTap: () async {
                          Get.dialog(ConfirmationPopup(
                            title: Text(
                              "Membuat Pesanan",
                              style: Get.textTheme.titleMedium,
                            ),
                            content: const Center(child: CircularProgressIndicator()),
                            width: Get.width * 0.8,
                          ));
                          await controller
                              .uploadTransaction(
                                  userId: _userController.userModel.id!,
                                  locationId: _merchantController.branch.id!,
                                  merchantId: _merchantController.merchant.id!)
                              .then((value) {
                            Get.back();
                            return value;
                          }).then((value) => Get.to(() => const CompletePayment())?.then((value) {
                                    Get.back(result: true);
                                  }));
                        },
                        color: Get.theme.primaryColor,
                        background: Get.theme.colorScheme.primary,
                        style: Get.textTheme.labelLarge,
                        label: "Konfirmasi Pembayaran",
                      );
                    }),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget _payForm(
      {required String title,
      String? formText,
      String? hintText,
      bool readOnly = false,
      String? Function(String?)? validator,
      dynamic Function(dynamic)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              title,
              style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          FormField(
            validator: validator,
            builder: (field) => BorderedInputText(
              addSuffix: false,
              readOnly: readOnly,
              textEditingController: TextEditingController(text: formText),
              hint: hintText,
              data: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
