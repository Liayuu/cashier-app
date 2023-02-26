import 'package:cashier_app/views/pages/forms/menus/components/variant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class AddVariant extends StatelessWidget {
  const AddVariant({super.key});

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
          "Variasi Menu",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Get.textTheme.headlineSmall,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Get.theme.primaryColor,
        child: const Icon(Icons.add),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: VariantCard(title: "Variant $index"),
          ),
        ),
      ),
    ));
  }
}
