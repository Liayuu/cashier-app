import 'package:cashier_app/views/components/button_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class AddTopping extends StatelessWidget {
  const AddTopping({super.key});

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
          "Topping Produk",
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: ListView.builder(
                itemCount: 30,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (data) {},
                                shape: const CircleBorder(),
                                checkColor: Get.theme.colorScheme.outline,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Telur Goreng",
                                    style: Get.textTheme.bodyLarge!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Rp. 5.000",
                                    style: Get.textTheme.bodyMedium,
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue[400],
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.delete_rounded, color: Colors.red)),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 0,
                        height: 1,
                      )
                    ],
                  ),
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
    ));
  }
}
