import 'dart:io';

import 'package:cashier_app/controllers/user_controller.dart';
import 'package:cashier_app/views/components/button_main.dart';
import 'package:cashier_app/views/components/image_picker_popup.dart';
import 'package:cashier_app/views/components/profile_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashier_app/controllers/merchant_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';

class EditMerchant extends StatefulWidget {
  const EditMerchant({super.key});

  @override
  State<EditMerchant> createState() => _EditMerchantState();
}

class _EditMerchantState extends State<EditMerchant> {
  final MerchantController _merchantController = Get.find<MerchantController>();
  final UserController _userController = Get.find<UserController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.colorScheme.background,
          elevation: 1,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                color: Get.theme.colorScheme.outline,
                size: 24,
              )),
          centerTitle: true,
          title: Text(
            "Ubah Profil",
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
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            width: Get.width,
                            height: Get.height / 4,
                            margin: const EdgeInsets.only(bottom: 75),
                            child: GetBuilder<MerchantController>(
                                init: Get.find<MerchantController>(),
                                builder: (controller) {
                                  if (controller.newBackground != null) {
                                    return Hero(
                                      tag: "Test",
                                      child: kIsWeb
                                          ? Image.network(
                                              controller.newBackground!.path,
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                            )
                                          : Image.file(
                                              File(controller.newBackground!.path),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                            ),
                                    );
                                  }
                                  return controller.branch.background != null
                                      ? Hero(
                                          tag: "Test",
                                          child: Image.network(
                                            controller.branch.background!,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter,
                                          ))
                                      : const Icon(
                                          Icons.fastfood_rounded,
                                          size: 24,
                                        );
                                }),
                            // child: Image.network(
                            //     "https://akcdn.detik.net.id/visual/2020/11/04/borat-1_169.png?w=650",
                            //     fit: BoxFit.cover),
                          ),
                          Positioned(
                            top: (Get.height / 4) - 75,
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Get.theme.colorScheme.onBackground, width: 8),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Get.theme.shadowColor,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                        spreadRadius: 4)
                                  ]),
                              child: Stack(
                                children: [
                                  GetBuilder<MerchantController>(
                                      init: Get.find<MerchantController>(),
                                      builder: (controller) {
                                        if (controller.newLogo != null) {
                                          return ClipOval(
                                            child: SizedBox.fromSize(
                                                size: const Size.fromRadius(70),
                                                child: Hero(
                                                  tag: "Test",
                                                  child: kIsWeb
                                                      ? Image.network(
                                                          controller.newLogo!.path,
                                                          fit: BoxFit.cover,
                                                          alignment: Alignment.topCenter,
                                                        )
                                                      : Image.file(
                                                          File(controller.newLogo!.path),
                                                          fit: BoxFit.cover,
                                                          alignment: Alignment.topCenter,
                                                        ),
                                                )),
                                          );
                                        }
                                        return ClipOval(
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(70),
                                            child: controller.branch.logo != null
                                                ? Hero(
                                                    tag: "Test",
                                                    child: Image.network(
                                                      controller.branch.logo!,
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
                                          _imagePickerCommand(1, true);
                                        } else {
                                          await Get.dialog(
                                                  ImagePickerPopUp(
                                                      width: Get.width * 0.8,
                                                      title: Text("Ambil gambar menggunakan",
                                                          style: Get.textTheme.titleLarge!)),
                                                  useSafeArea: true)
                                              .then((value) async {
                                            if (value != null) {
                                              _imagePickerCommand(value, true);
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
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "Merchant Profil",
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
                                hintText: "Nama Merchant",
                                initialValue: _merchantController.merchant.name,
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Nama Merchant",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                onSaved: (value) {
                                  _merchantController.merchant.name = value;
                                },
                              ),
                              ProfileTextfield(
                                hintText: "Nama Pemilik",
                                initialValue: _userController.userModel.name,
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Nama Pemilik",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                onSaved: (value) {
                                  _userController.userModel.name = value;
                                },
                              ),
                              ProfileTextfield(
                                hintText: "Email",
                                keyboardType: TextInputType.emailAddress,
                                initialValue: _userController.userModel.email,
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Email",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                onSaved: (value) {
                                  _userController.userModel.email = value;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Lokasi Merchant",
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
                                hintText: "Negara",
                                initialValue: _merchantController.branch.country,
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Negara Merchant",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                onSaved: (value) {
                                  _merchantController.branch.country = value;
                                },
                              ),
                              ProfileTextfield(
                                hintText: "Provinsi",
                                initialValue: _merchantController.branch.province,
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Provinsi",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                onSaved: (value) {
                                  _merchantController.branch.province = value;
                                },
                              ),
                              ProfileTextfield(
                                hintText: "Kabupaten/Kota",
                                initialValue: _merchantController.branch.regency,
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Kabupaten",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                onSaved: (value) {
                                  _merchantController.branch.regency = value;
                                },
                              ),
                              ProfileTextfield(
                                hintText: "Kecamatan",
                                initialValue: _merchantController.branch.disctrict,
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Kecamatan",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                onSaved: (value) {
                                  _merchantController.branch.disctrict = value;
                                },
                              ),
                              ProfileTextfield(
                                hintText: "Alamat",
                                initialValue: _merchantController.branch.address,
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Alamat",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                onSaved: (value) {
                                  _merchantController.branch.address = value;
                                },
                              ),
                              ProfileTextfield(
                                hintText: "Kode Pos",
                                initialValue: _merchantController.branch.posCode,
                                keyboardType: TextInputType.number,
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Kode Pos",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                onSaved: (value) {
                                  _merchantController.branch.posCode = value;
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Material(
                elevation: 10,
                shadowColor: Get.theme.shadowColor,
                child: Container(
                  height: 60,
                  width: Get.width,
                  color: Get.theme.colorScheme.background,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ButtonMain(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await Get.dialog(
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

                            Future.wait([
                              _merchantController.addOrUpdateMerchant(),
                              _userController.addOrUpdateUser()
                            ]).then((value) {
                              Get.back(result: 1);
                            }).catchError((e) {
                              Get.back(result: 0);
                            });
                          }
                        },
                        label: "Simpan",
                        width: Get.width,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _imagePickerCommand(int value, bool isLogo) async {
    if (value == 0) {
      await ImagePicker()
          .pickImage(source: ImageSource.camera, maxHeight: 600, maxWidth: 600, imageQuality: 75)
          .then((value) {
        setState(() {
          if (isLogo) {
            _merchantController.newLogo = value;
          } else {
            _merchantController.newBackground = value;
          }
          _merchantController.update();
        });
      });
    } else {
      await ImagePicker()
          .pickImage(source: ImageSource.gallery, maxHeight: 600, maxWidth: 600, imageQuality: 75)
          .then((value) {
        setState(() {
          if (isLogo) {
            _merchantController.newLogo = value;
          } else {
            _merchantController.newBackground = value;
          }
          _merchantController.update();
        });
      });
    }
  }
}
