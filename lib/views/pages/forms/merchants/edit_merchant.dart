import 'package:cashier_app/views/components/button_main.dart';
import 'package:cashier_app/views/components/profile_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditMerchant extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  EditMerchant({super.key});

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
                            // color: Get.theme.primaryColor,
                            margin: const EdgeInsets.only(bottom: 75),
                            child: Image.network(
                                "https://akcdn.detik.net.id/visual/2020/11/04/borat-1_169.png?w=650",
                                fit: BoxFit.cover),
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
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(48),
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
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Nama Merchant",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              ProfileTextfield(
                                hintText: "Nama Pemilik",
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Nama Pemilik",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              ProfileTextfield(
                                hintText: "Email",
                                keyboardType: TextInputType.emailAddress,
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Email",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
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
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Negara Merchant",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              ProfileTextfield(
                                hintText: "Provinsi",
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Provinsi",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              ProfileTextfield(
                                hintText: "Kabupaten/Kota",
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Kabupaten",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              ProfileTextfield(
                                hintText: "Kecamatan",
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Kecamatan",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              ProfileTextfield(
                                hintText: "Alamat",
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Alamat",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              ProfileTextfield(
                                hintText: "Kode Pos",
                                keyboardType: TextInputType.number,
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                                  child: Text(
                                    "Kode Pos",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
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
                        onTap: () {},
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
}
