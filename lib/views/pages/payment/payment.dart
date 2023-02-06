import 'package:cashier_app/configs/language_config.dart';
import 'package:cashier_app/themes/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(lang().payment.capitalizeFirst!, style: Get.textTheme.headlineSmall),
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
                        borderRadius: BorderRadius.circular(10),
                        color: index == 0 ? Get.theme.cardColor : Get.theme.unselectedWidgetColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.wallet),
                        Text(lang().paymentType("CASH").capitalize!,
                            style: Get.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          // SizedBox(
          //   width: Get.width,
          //   height: 80,
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 15, left: 15),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       mainAxisSize: MainAxisSize.max,
          //       children: [
          //         AspectRatio(
          //           aspectRatio: 1,
          //           child: Container(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Icon(Icons.wallet),
          //                 Text("Cash"),
          //               ],
          //             ),
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(10),
          //                 color: Get.theme.primaryColorLight.withOpacity(0.90)),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // Expanded(
          //   child: ListView(
          //     shrinkWrap: true,
          //     children: [
          //       Form(
          //         key: _formKey,
          //         child: SingleChildScrollView(
          //           child: Container(
          //             padding: EdgeInsets.only(top: 20, left: 15, bottom: 15),
          //             child: Column(
          //               children: [
          //                 Row(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text("Sub Total"),
          //                   ],
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: TextFormField(),
          //                 ),
          //                 Row(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text("Cash"),
          //                   ],
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: TextFormField(),
          //                 ),
          //                 Row(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text("Change"),
          //                   ],
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: TextFormField(),
          //                 ),
          //                 ExpansionTile(
          //                   children: const [
          //                     ListTile(title: Text("Dine In")),
          //                     ListTile(title: Text("Take away")),
          //                   ],
          //                   title: const Text("Order Type"),
          //                 ),
          //                 Row(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text("Customer Email"),
          //                   ],
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: TextFormField(),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    ));
  }
}
