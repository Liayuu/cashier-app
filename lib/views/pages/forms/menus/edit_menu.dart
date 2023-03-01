import 'package:cashier_app/views/components/image_picker_popup.dart';
import 'package:cashier_app/views/components/profile_textfield.dart';
import 'package:cashier_app/views/pages/forms/menus/add_category.dart';
import 'package:cashier_app/views/pages/forms/menus/add_topping.dart';
import 'package:cashier_app/views/pages/forms/menus/add_variant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class EditMenu extends StatefulWidget {
  EditMenu({super.key});

  @override
  State<EditMenu> createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.background,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () {
                // Get.dialog(widget)
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
                          ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(70),
                              child: Hero(
                                tag: "Test",
                                child: Image.network(
                                  "https://upload.wikimedia.org/wikipedia/commons/7/7e/Borat_in_Cologne.jpg",
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
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
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Get.theme.unselectedWidgetColor, width: 4),
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
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
                      child: Column(
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
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                  child: _sectionMenu(
                                      title: "Kategori Produk",
                                      onTap: () {
                                        Get.to(() => const AddCategory());
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
                          ProfileTextfield(
                            hintText: "Harga",
                            keyboardType: TextInputType.number,
                            title: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 4),
                              child: Text(
                                "Harga",
                                style: Get.textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
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
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                    child: _sectionMenu(
                                        title: "Tambahkan Topping Produk",
                                        onTap: () {
                                          Get.to(() => const AddTopping());
                                        }))),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
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
        setState(() {});
      });
    } else {
      await ImagePicker()
          .pickImage(source: ImageSource.gallery, maxHeight: 600, maxWidth: 600, imageQuality: 75)
          .then((value) {
        setState(() {});
      });
    }
  }
}
