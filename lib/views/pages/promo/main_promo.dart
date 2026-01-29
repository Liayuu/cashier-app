import 'dart:developer';

import 'package:cashier_app/controllers/enums/promotion_type_enum.dart';
import 'package:cashier_app/controllers/merchant_controller.dart';
import 'package:cashier_app/controllers/promotion_controller.dart';
import 'package:cashier_app/models/promotion/promotion_model.dart';
import 'package:cashier_app/views/pages/promo/edit_promo.dart';
import 'package:cashier_app/views/pages/promo/promo_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPromo extends StatefulWidget {
  const MainPromo({super.key});

  @override
  State<MainPromo> createState() => _MainPromoState();
}

class _MainPromoState extends State<MainPromo> {
  final _promotionController = Get.find<PromotionController>();

  final MerchantController _merchantController = Get.find<MerchantController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Get.to(() => const EditPromo())?.then((value) {
              setState(() {});
            });
          },
          backgroundColor: Get.theme.primaryColor,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Get.theme.colorScheme.surface,
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
            "Promosi",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.headlineSmall,
          ),
        ),
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: FutureBuilder<List<PromotionModel>?>(
              future: _promotionController.getPromotion(
                  merchantId: _merchantController.merchant.id!,
                  locationId: _merchantController.branch.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  log(snapshot.data.toString());
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) => PromoCard(
                          onTap: () async {
                            _promotionController.promotionModel = snapshot.data![index];
                            await Get.to(() => const EditPromo())!.then((value) {
                              setState(() {});
                            });
                          },
                          idPromo: snapshot.data?[index].id ?? "Unknown",
                          startTime: snapshot.data?[index].startTime ?? DateTime.now(),
                          endTime: snapshot.data?[index].endTime ?? DateTime.now(),
                          name: snapshot.data?[index].name ?? "Unknown",
                          nominal: snapshot.data?[index].nominal ?? 0,
                          minimumNominal: snapshot.data?[index].minimumTransaction,
                          maximumNominal: snapshot.data?[index].maximumNominal,
                          nominalType:
                              snapshot.data?[index].nominalTypeName ?? NominalTypeEnum.NOMINAL),
                      itemCount: snapshot.data?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    );
                  }
                }
                return const SizedBox();
              },
            ),
          )),
        ),
      ),
    );
  }
}
