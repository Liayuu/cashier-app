import 'package:cashier_app/views/components/button_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

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
          onPressed: () {
            // Add your onPressed code here!
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
                fit: FlexFit.loose,
                child: ListView.builder(
                  itemCount: 30,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (data) {},
                        shape: CircleBorder(),
                        checkColor: Get.theme.colorScheme.outline,
                      ),
                      Text(
                        "Minyak Ikan Mentah",
                        style: Get.textTheme.bodyLarge,
                      ),
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
                      onTap: () {},
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
