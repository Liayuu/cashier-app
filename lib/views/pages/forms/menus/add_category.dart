import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cashier_app/controllers/menu_controller.dart';
import 'package:cashier_app/views/components/button_main.dart';
import 'package:cashier_app/views/components/checkbox.dart';
import 'package:cashier_app/views/components/profile_textfield.dart';

class AddCategory extends StatelessWidget {
  final String merchantId;
  final String locationId;
  AddCategory({
    Key? key,
    required this.merchantId,
    required this.locationId,
  }) : super(key: key);
  final _menuController = Get.find<MenusController>();
  final _categoryController = TextEditingController();

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
          "Kategori Produk",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Get.textTheme.headlineSmall,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: () async {
            await Get.bottomSheet(
                backgroundColor: Get.theme.colorScheme.background,
                elevation: 5,
                isScrollControlled: true,
                SizedBox(
                  width: Get.width,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextFormField(
                            controller: _categoryController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(labelText: "Kategori"),
                          ),
                        ),
                        ButtonMain(
                          width: Get.width,
                          onTap: () async {
                            await _menuController
                                .addNewCategory(
                                    merchantId: merchantId,
                                    locationId: locationId,
                                    categoryName: _categoryController.text)
                                .then((value) {
                              Get.back();
                            });
                          },
                          color: Get.theme.primaryColor,
                          background: Get.theme.colorScheme.primary,
                          style: Get.textTheme.labelLarge,
                          label: "Simpan",
                        ),
                      ],
                    ),
                  ),
                ));
          },
          backgroundColor: Get.theme.primaryColor,
          child: const Icon(Icons.add),
        ),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: GetBuilder<MenusController>(builder: (controller) {
                  return ListView.builder(
                    itemCount: _menuController.listCategory.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CheckboxButton(
                            onTap: () {
                              for (var i = 0; i < _menuController.listCategory.length; i++) {
                                _menuController.listCategory[i].isChoosed = false;
                              }
                              _menuController.listCategory[index].isChoosed = true;
                              _menuController.update();
                            },
                            isSelected: _menuController.listCategory[index].isChoosed,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _menuController.listCategory[index].name!,
                            style: Get.textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
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
                      onTap: () {
                        if (!_menuController.listCategory.any((element) => element.isChoosed)) {
                          Get.snackbar(
                              "Hmm ada yang salah", "Mohon untuk memilih salah satu kategori");
                        } else {
                          Get.back(
                              result: _menuController.listCategory
                                  .firstWhere((element) => element.isChoosed));
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
    ));
  }
}
