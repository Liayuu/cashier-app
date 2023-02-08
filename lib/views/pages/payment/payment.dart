import 'package:cashier_app/configs/language_config.dart';
import 'package:cashier_app/themes/color_pallete.dart';
import 'package:cashier_app/views/components/bordered_input_text.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/views/components/button_main.dart';
import 'package:get/get.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child:
                        Text(lang().payment.capitalizeFirst!, style: Get.textTheme.headlineSmall),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      lang().paymentMethodAvailability(1),
                      style: Get.textTheme.bodyLarge,
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(lang().paymentMethod, style: Get.textTheme.titleLarge),
                  ),
                  SizedBox(
                    height: 95,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      itemCount: 2,
                      itemBuilder: (context, index) => AspectRatio(
                        aspectRatio: 1.5 / 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        index == 0 ? Get.theme.primaryColor : Pallete.transparent),
                                borderRadius: BorderRadius.circular(10),
                                color: index == 0
                                    ? Get.theme.unselectedWidgetColor
                                    : Get.theme.cardColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wallet,
                                  size: 24,
                                  color: index == 0
                                      ? Get.theme.colorScheme.primary
                                      : Get.theme.colorScheme.outline,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(lang().paymentType("CASH").capitalize!,
                                    style: index == 0
                                        ? Get.textTheme.bodyMedium!
                                            .copyWith(color: Get.theme.primaryColor)
                                        : Get.textTheme.bodyMedium),
                              ],
                            ),
                          ),
                        ),
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _payForm(title: lang().subTotal, formText: "\$ 6.69", readOnly: true),
                          _payForm(title: lang().cash, formText: "\$ 7.00"),
                          _payForm(title: lang().change, formText: "\$ 0.31")
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child:
                        Divider(height: 1, color: Get.theme.colorScheme.outline.withOpacity(0.7)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                    child: Text(
                      lang().orderType,
                      style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: DropdownButtonFormField(
                      value: 2,
                      onChanged: (value) {},
                      items: [
                        DropdownMenuItem(
                          child: Text("Test1"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("Test2"),
                          value: 2,
                        )
                      ],
                      decoration: InputDecoration(
                          enabledBorder: Get.theme.inputDecorationTheme.enabledBorder,
                          focusedBorder: Get.theme.inputDecorationTheme.focusedBorder),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: _payForm(title: lang().custEmail, formText: "yuliacan@gmail.com"),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: Get.height * 0.085,
            width: Get.width,
            color: Get.theme.colorScheme.background,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonMain(
                      height: Get.height,
                      width: Get.width,
                      onTap: () {},
                      color: Get.theme.primaryColor,
                      background: Get.theme.colorScheme.background,
                      style: Get.textTheme.labelLarge,
                      label: "Cancel",
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonMain(
                      height: Get.height,
                      width: Get.width,
                      onTap: () {},
                      color: Get.theme.primaryColor,
                      background: Get.theme.colorScheme.primary,
                      style: Get.textTheme.labelLarge,
                      label: "Konfirmasi Pembayaran",
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget _payForm(
      {required String title,
      required String formText,
      String? hintText,
      bool readOnly = false,
      String? Function(String?)? validator,
      dynamic Function(dynamic)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              title,
              style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          FormField(
            validator: validator,
            builder: (field) => BorderedInputText(
              addSuffix: false,
              readOnly: readOnly,
              textEditingController: TextEditingController(text: formText),
              hint: hintText,
              data: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
