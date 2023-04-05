import 'dart:developer';

import 'package:cashier_app/controllers/enums/promotion_type_enum.dart';
import 'package:cashier_app/controllers/merchant_controller.dart';
import 'package:cashier_app/controllers/promotion_controller.dart';
import 'package:cashier_app/models/promotion/promotion_model.dart';
import 'package:cashier_app/views/components/button_main.dart';
import 'package:cashier_app/views/components/confirmation_popup.dart';
import 'package:cashier_app/views/components/price_textfield.dart';
import 'package:cashier_app/views/components/profile_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditPromo extends StatefulWidget {
  const EditPromo({super.key});

  @override
  State<EditPromo> createState() => _EditPromoState();
}

class _EditPromoState extends State<EditPromo> {
  final _formKey = GlobalKey<FormState>();
  final _promotionController = Get.find<PromotionController>();
  final _merchantController = Get.find<MerchantController>();
  String _formatNumber(String s) => NumberFormat.decimalPattern('id').format(double.parse(s));
  final _nominalEditingController = TextEditingController();
  final _minEditingController = TextEditingController();
  final _maxEditingController = TextEditingController();

  @override
  void initState() {
    if (_promotionController.promotionModel.nominal != null)
      _nominalEditingController.text = _promotionController.promotionModel.nominal.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.colorScheme.background,
          elevation: 1,
          actions: _promotionController.promotionModel.id == null
              ? null
              : [
                  IconButton(
                      onPressed: () {
                        Get.dialog(ConfirmationPopup(
                          title: Text(
                            "Hapus Promo",
                            style: Get.textTheme.titleMedium,
                          ),
                          content: Center(
                            child: Text(
                              "Apakah anda yakin ingin menghapus promosi ini?",
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
                                        onTap: () async {
                                          Get.dialog(
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Mohon tunggu",
                                                    style: Get.textTheme.labelMedium,
                                                  ),
                                                  const CircularProgressIndicator()
                                                ],
                                              ),
                                              barrierDismissible: false);
                                          await _promotionController.deletePromo().then((value) {
                                            Get.back();
                                            Get.back();
                                            Get.back();
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            "Ya",
                                            style: Get.textTheme.labelMedium,
                                          ),
                                        ))),
                                Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        splashColor: Colors.white.withOpacity(0.8),
                                        onTap: () {},
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
                      },
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                        size: 24,
                      )),
                ],
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                color: Get.theme.colorScheme.outline,
                size: 24,
              )),
          centerTitle: true,
          title: Text(
            "Ubah Promosi",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.headlineSmall,
          ),
        ),
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: GetBuilder<PromotionController>(
                            init: Get.find<PromotionController>(),
                            builder: (controller) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProfileTextfield(
                                    hintText: "Nama Promo",
                                    initialValue: controller.promotionModel.name,
                                    onSaved: (value) {
                                      controller.promotionModel.name = value;
                                    },
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                                      child: Text(
                                        "Nama Promo",
                                        style: Get.textTheme.titleMedium!
                                            .copyWith(fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  PriceTextfield(
                                    hintText: "Promo Produk",
                                    onChanged: (value) {
                                      var val = _formatNumber(value.replaceAll('.', ''));
                                      if (value != null && value != "") {
                                        controller.promotionModel.nominal = double.parse(value);
                                      } else {
                                        controller.promotionModel.nominal = 0;
                                      }
                                      _nominalEditingController.value = TextEditingValue(
                                          selection: TextSelection.collapsed(offset: val.length),
                                          text: val);
                                      controller.update();
                                    },
                                    controller: _nominalEditingController,
                                    keyboardType: TextInputType.number,
                                    initialValue: controller.promotionModel.nominalTypeName ==
                                            NominalTypeEnum.PERCENT
                                        ? (controller.promotionModel.nominal! * 100).toString()
                                        : controller.promotionModel.nominal.toString(),
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                                      child: Text(
                                        "Promo",
                                        style: Get.textTheme.titleMedium!
                                            .copyWith(fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    onSaved: (value) {
                                      if (double.parse(value) < 0) {
                                        controller.promotionModel.nominal = 0;
                                      } else {
                                        controller.promotionModel.nominal = double.parse(value);
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                                    child: Text(
                                      "Jenis Promo",
                                      style: Get.textTheme.titleMedium!
                                          .copyWith(fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                                    child: DropdownButtonFormField<NominalTypeEnum>(
                                      value: controller.promotionModel.nominalTypeName ??
                                          NominalTypeEnum.NOMINAL,
                                      onChanged: (value) {
                                        controller.promotionModel.nominalTypeName = value;
                                        controller.update();
                                      },
                                      items: [
                                        DropdownMenuItem(
                                          value: NominalTypeEnum.NOMINAL,
                                          child: Text(
                                            "Nominal",
                                            style: Get.textTheme.bodyMedium,
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: NominalTypeEnum.PERCENT,
                                          child: Text("Persen", style: Get.textTheme.bodyMedium),
                                        )
                                      ],
                                      decoration: InputDecoration(
                                          enabledBorder:
                                              Get.theme.inputDecorationTheme.enabledBorder,
                                          focusedBorder:
                                              Get.theme.inputDecorationTheme.focusedBorder),
                                    ),
                                  ),
                                  PriceTextfield(
                                    hintText: "Minimal Pembelanjaan",
                                    initialValue:
                                        controller.promotionModel.minimumTransaction.toString(),
                                    onChanged: (value) {
                                      var val = _formatNumber(value.replaceAll('.', ''));
                                      if (value != null && value != "") {
                                        controller.promotionModel.minimumTransaction =
                                            double.parse(value);
                                      } else {
                                        controller.promotionModel.minimumTransaction = null;
                                      }
                                      _minEditingController.value = TextEditingValue(
                                          selection: TextSelection.collapsed(offset: val.length),
                                          text: val);
                                      controller.update();
                                    },
                                    controller: _minEditingController,
                                    keyboardType: TextInputType.number,
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                                      child: Text(
                                        "Minimal",
                                        style: Get.textTheme.titleMedium!
                                            .copyWith(fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    onSaved: (value) {
                                      if (double.parse(value) < 0) {
                                        controller.promotionModel.minimumTransaction = null;
                                      } else {
                                        controller.promotionModel.minimumTransaction =
                                            double.parse(value);
                                      }
                                    },
                                  ),
                                  PriceTextfield(
                                    hintText: "Diskon Maksimal",
                                    initialValue:
                                        controller.promotionModel.maximumNominal.toString(),
                                    enabled: controller.promotionModel.nominalTypeName ==
                                        NominalTypeEnum.PERCENT,
                                    onChanged: (value) {
                                      var val = _formatNumber(value.replaceAll('.', ''));
                                      if (value != null && value != "") {
                                        controller.promotionModel.maximumNominal =
                                            double.parse(value);
                                      } else {
                                        controller.promotionModel.maximumNominal = null;
                                      }
                                      _maxEditingController.value = TextEditingValue(
                                          selection: TextSelection.collapsed(offset: val.length),
                                          text: val);
                                      controller.update();
                                    },
                                    controller: _maxEditingController,
                                    keyboardType: TextInputType.number,
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                                      child: Text(
                                        "Maksimal",
                                        style: Get.textTheme.titleMedium!
                                            .copyWith(fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    onSaved: (value) {
                                      if (double.parse(value) < 0) {
                                        controller.promotionModel.maximumNominal = null;
                                      } else {
                                        controller.promotionModel.maximumNominal =
                                            double.parse(value);
                                      }
                                    },
                                  ),
                                  _formWithDatePicker(
                                    label: "Berlaku mulai",
                                    hint: "Masukkan tanggal",
                                    initialValue: controller.promotionModel.startTime,
                                    onTap: () {
                                      _selectDate(
                                        context: Get.context!,
                                        initialDate:
                                            controller.promotionModel.startTime ?? DateTime.now(),
                                        onDatePicked: (selectedDate) {
                                          log("selected date: $selectedDate");
                                          setState(() {
                                            controller.promotionModel.startTime = selectedDate;
                                          });
                                        },
                                      );
                                    },
                                  ),
                                  _formWithDatePicker(
                                    label: "Berakhir pada",
                                    hint: "Masukkan tanggal",
                                    initialValue: controller.promotionModel.endTime,
                                    onTap: () {
                                      _selectDate(
                                        context: Get.context!,
                                        initialDate:
                                            controller.promotionModel.endTime ?? DateTime.now(),
                                        onDatePicked: (selectedDate) {
                                          log("selected date: $selectedDate");
                                          setState(() {
                                            controller.promotionModel.endTime = selectedDate;
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  height: Get.height * 0.085,
                  width: Get.width,
                  color: Get.theme.colorScheme.background,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonMain(
                      height: Get.height,
                      width: Get.width,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Get.dialog(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Mohon tunggu",
                                    style: Get.textTheme.labelMedium,
                                  ),
                                  const CircularProgressIndicator()
                                ],
                              ),
                              barrierDismissible: false);
                          if (_promotionController.promotionModel.nominalTypeName ==
                              NominalTypeEnum.PERCENT) {
                            _promotionController.promotionModel.nominal =
                                _promotionController.promotionModel.nominal! / 100.toDouble();
                          }
                          await _promotionController
                              .addOrUpdatePromotion(
                                  merchantId: _merchantController.merchant.id!,
                                  locationId: _merchantController.branch.id!)
                              .then((value) {
                            _promotionController.promotionModel = PromotionModel();
                            Get.back();
                          }).then((value) {
                            Get.back();
                          });
                          // await _menuController
                          //     .addOrUpdateMenu(
                          //         locationId: widget.locationId, merchantId: widget.merchantId)
                          //     .then((value) {
                          //   _menuController.menu = MenuModel();
                          //   _menuController.newImage = null;
                          //   _menuController.newPrice = null;
                          //   _menuController.currentCategory = CategoriesModel();
                          //   Get.back();
                          // }).then((value) {
                          //   Get.back();
                          // });
                        }
                      },
                      color: Get.theme.primaryColor,
                      background: Get.theme.colorScheme.primary,
                      style: Get.textTheme.labelLarge,
                      label: "Simpan",
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _formWithDatePicker(
      {Key? key,
      required String label,
      required String hint,
      DateTime? initialValue,
      Function()? onTap,
      String? Function(Object?)? onValidate}) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: FormField(
        validator: onValidate,
        builder: (field) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    label,
                    style: Get.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: Get.width,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Get.theme.primaryColor, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      initialValue != null
                          ? DateFormat("dd-MM-yyyy").format(initialValue)
                          : "Masukkan Tanggal Lahir",
                      style: Get.textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(
      {required BuildContext context,
      required DateTime initialDate,
      Function(DateTime selectedDate)? onDatePicked}) async {
    await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(1900, 1),
            lastDate: DateTime(9999))
        .then((value) {
      if (value != null) onDatePicked!(value);
    });
  }
}
