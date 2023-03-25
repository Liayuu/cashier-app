import 'dart:developer';
import 'dart:io';

import 'package:cashier_app/controllers/menu_controller.dart';
import 'package:cashier_app/models/categories_model.dart';
import 'package:cashier_app/models/menu/menus_model.dart';
import 'package:cashier_app/views/components/button_main.dart';
import 'package:cashier_app/views/components/confirmation_popup.dart';
import 'package:cashier_app/views/components/image_picker_popup.dart';
import 'package:cashier_app/views/components/profile_textfield.dart';
import 'package:cashier_app/views/pages/forms/menus/add_category.dart';
import 'package:cashier_app/views/pages/forms/menus/add_topping.dart';
import 'package:cashier_app/views/pages/forms/menus/add_variant.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/views/components/price_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';

class EditMenu extends StatefulWidget {
  final String merchantId;
  final String locationId;
  const EditMenu({super.key, required this.merchantId, required this.locationId});

  @override
  State<EditMenu> createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  final _formKey = GlobalKey<FormState>();
  final _menuController = Get.find<MenusController>();

  String _formatNumber(String s) => NumberFormat.decimalPattern('id').format(double.parse(s));
  var _priceEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log(widget.merchantId, name: "Merchant ID");
    log(widget.locationId, name: "Location ID");
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.background,
        elevation: 1,
        actions: _menuController.menu.id == null
            ? null
            : [
                IconButton(
                    onPressed: () {
                      Get.dialog(ConfirmationPopup(
                        title: Text(
                          "Hapus Menu",
                          style: Get.textTheme.titleMedium,
                        ),
                        content: Center(
                          child: Text(
                            "Apakah anda yakin ingin menghapus menu ini?",
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
                                      onTap: () {},
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
                    icon: Icon(
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
          "Ubah Menu",
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
                  SizedBox(
                    width: Get.width,
                    height: Get.height / 4,
                    child: Center(
                      child: Stack(
                        children: [
                          GetBuilder<MenusController>(
                              init: Get.find<MenusController>(),
                              builder: (controller) {
                                if (controller.newImage != null) {
                                  return ClipOval(
                                    child: SizedBox.fromSize(
                                        size: const Size.fromRadius(70),
                                        child: Hero(
                                          tag: "Test",
                                          child: kIsWeb
                                              ? Image.network(
                                                  controller.newImage!.path,
                                                  fit: BoxFit.cover,
                                                  alignment: Alignment.topCenter,
                                                )
                                              : Image.file(
                                                  File(controller.newImage!.path),
                                                  fit: BoxFit.cover,
                                                  alignment: Alignment.topCenter,
                                                ),
                                        )),
                                  );
                                }
                                return ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(70),
                                    child: controller.menu.downloadLink != null
                                        ? Hero(
                                            tag: "Test",
                                            child: Image.network(
                                              controller.menu.downloadLink!,
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                            ))
                                        : const Icon(
                                            Icons.fastfood_rounded,
                                            size: 24,
                                          ),
                                  ),
                                );
                              }),
                          Positioned(
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                if (kIsWeb) {
                                  _imagePickerCommand(1);
                                } else {
                                  await Get.dialog(
                                          ImagePickerPopUp(
                                              width: Get.width * 0.8,
                                              title: Text("Ambil gambar menggunakan",
                                                  style: Get.textTheme.titleLarge!)),
                                          useSafeArea: true)
                                      .then((value) async {
                                    if (value != null) {
                                      _imagePickerCommand(value);
                                    }
                                  });
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Get.theme.unselectedWidgetColor, width: 4),
                                    shape: BoxShape.circle,
                                    color: Get.theme.primaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Get.theme.shadowColor,
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                          spreadRadius: 4)
                                    ]),
                                child: ClipOval(
                                  child: SizedBox.fromSize(
                                      size: const Size.fromRadius(40),
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Get.theme.colorScheme.background,
                                        size: 24,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GetBuilder<MenusController>(
                          init: Get.find<MenusController>(),
                          builder: (controller) {
                            return Column(
                              children: [
                                Text(
                                  "Menu",
                                  style: Get.textTheme.titleLarge,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Divider(
                                    thickness: 2,
                                    color: Get.theme.unselectedWidgetColor,
                                  ),
                                ),
                                ProfileTextfield(
                                  hintText: "Nama Menu",
                                  initialValue: controller.menu.name,
                                  onSaved: (value) {
                                    _menuController.menu.name = value;
                                  },
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                                    child: Text(
                                      "Nama Menu",
                                      style: Get.textTheme.titleMedium!
                                          .copyWith(fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                ProfileTextfield(
                                  hintText: "Deskripsi Produk",
                                  initialValue: controller.menu.description,
                                  onSaved: (value) {
                                    _menuController.menu.description = value;
                                  },
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                                    child: Text(
                                      "Deskripsi Produk",
                                      style: Get.textTheme.titleMedium!
                                          .copyWith(fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                ProfileTextfield(
                                  hintText: "Barcode",
                                  initialValue: controller.menu.barcode,
                                  onSaved: (value) {
                                    _menuController.menu.barcode = value;
                                  },
                                  keyboardType: TextInputType.number,
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                                    child: Text(
                                      "Barcode",
                                      style: Get.textTheme.titleMedium!
                                          .copyWith(fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                ProfileTextfield(
                                  hintText: "SKU",
                                  initialValue: controller.menu.sku,
                                  onSaved: (value) {
                                    _menuController.menu.sku = value;
                                  },
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                                    child: Text(
                                      "SKU",
                                      style: Get.textTheme.titleMedium!
                                          .copyWith(fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Get.theme.primaryColor),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                        child: _sectionMenu(
                                            title: "Kategori Produk",
                                            subtitleText: controller.listCategory
                                                .firstWhere(
                                                  (element) => element.isChoosed,
                                                  orElse: () => CategoriesModel(),
                                                )
                                                .name,
                                            onTap: () async {
                                              if (_menuController.listCategory.isEmpty) {
                                                await _menuController.fetchCategories(
                                                    widget.merchantId, widget.locationId);
                                              }
                                              await Get.to(() => AddCategory(
                                                    locationId: widget.locationId,
                                                    merchantId: widget.merchantId,
                                                  ))?.then((value) {
                                                if (value != null) {
                                                  _menuController.currentCategory = value;
                                                }
                                              });
                                            }),
                                      )),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Harga Produk",
                                  style: Get.textTheme.titleLarge,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Divider(
                                    thickness: 2,
                                    color: Get.theme.unselectedWidgetColor,
                                  ),
                                ),
                                PriceTextfield(
                                  currency: NumberFormat.currency(locale: 'id', symbol: 'Rp.'),
                                  hintText: "Harga Produk",
                                  onChanged: (value) {
                                    var val = _formatNumber(value.replaceAll('.', ''));
                                    if (value != null && value != "") {
                                      _menuController.newPrice = double.parse(value);
                                    } else {
                                      _menuController.newPrice = 0;
                                    }
                                    _priceEditingController.value = TextEditingValue(
                                        selection: TextSelection.collapsed(offset: val.length),
                                        text: val);
                                    _menuController.update();
                                  },
                                  controller: _priceEditingController,
                                  keyboardType: TextInputType.number,
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                                    child: Text(
                                      "Harga",
                                      style: Get.textTheme.titleMedium!
                                          .copyWith(fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    if (double.parse(value) < 0) {
                                      _menuController.newPrice = 0;
                                    } else {
                                      _menuController.newPrice = value;
                                    }
                                  },
                                ),
                                // ProfileTextfield(
                                //   hintText: "Harga",
                                //   initialValue: controller.menu.price?.price != null
                                //       ? controller.menu.price!.price!.toString()
                                //       : null,
                                //   keyboardType: TextInputType.number,
                                //   onSaved: (value) {
                                //     _menuController.newPrice = double.parse(value);
                                //   },
                                //   title: Padding(
                                //     padding: const EdgeInsets.only(top: 8, bottom: 4),
                                //     child: Text(
                                //       "Harga",
                                //       style: Get.textTheme.titleMedium!
                                //           .copyWith(fontWeight: FontWeight.w700),
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Get.theme.primaryColor),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                        child: _sectionMenu(
                                            title: "Buat variasi produk",
                                            onTap: () {
                                              Get.to(() => const AddVariant());
                                            }),
                                      )),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Get.theme.primaryColor),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 4),
                                          child: _sectionMenu(
                                              title: "Tambahkan Topping Produk",
                                              onTap: () {
                                                Get.to(() => const AddTopping());
                                              }))),
                                ),
                              ],
                            );
                          }),
                    ),
                  )
                ],
              ),
            )),
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
                        await _menuController
                            .addOrUpdateMenu(
                                locationId: widget.locationId, merchantId: widget.merchantId)
                            .then((value) {
                          _menuController.menu = MenuModel();
                          _menuController.newImage = null;
                          _menuController.newPrice = null;
                          _menuController.currentCategory = CategoriesModel();
                          Get.back();
                        }).then((value) {
                          Get.back();
                        });
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
    ));
  }

  Widget _sectionMenu(
      {required String title, Function()? onTap, Widget? icon, String? subtitleText}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Get.theme.primaryColor.withAlpha(45)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: icon,
                    ),
                  )
                : SizedBox(),
            Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Get.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                      ),
                      subtitleText != null && subtitleText.isNotEmpty && !subtitleText.isBlank!
                          ? Text(
                              subtitleText,
                              style: Get.textTheme.titleSmall!,
                            )
                          : const SizedBox(),
                    ],
                  ),
                )),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Get.theme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  void _imagePickerCommand(int value) async {
    if (value == 0) {
      await ImagePicker()
          .pickImage(source: ImageSource.camera, maxHeight: 600, maxWidth: 600, imageQuality: 75)
          .then((value) {
        setState(() {
          _menuController.newImage = value;
          _menuController.update();
        });
      });
    } else {
      await ImagePicker()
          .pickImage(source: ImageSource.gallery, maxHeight: 600, maxWidth: 600, imageQuality: 75)
          .then((value) {
        setState(() {
          log(value!.path.toString(), name: "gambar");
          _menuController.newImage = value;
          _menuController.update();
        });
      });
    }
  }
}
