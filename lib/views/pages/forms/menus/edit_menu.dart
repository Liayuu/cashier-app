import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class EditMenu extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  EditMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.background,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
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
      ),
    ));
  }
}
