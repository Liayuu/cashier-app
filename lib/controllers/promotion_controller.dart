import 'dart:developer';

import 'package:cashier_app/controllers/enums/document_name.dart';
import 'package:cashier_app/controllers/enums/promotion_type_enum.dart';
import 'package:cashier_app/controllers/enums/status_enum.dart';
import 'package:cashier_app/models/promotion/promotion_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PromotionController extends GetxController {
  final _promotionController =
      FirebaseFirestore.instance.collection(DocumentName.PROMOTION.name.toLowerCase());
  PromotionModel promotionModel = PromotionModel();
  List<PromotionModel> listAvailablePromo = [];

  Future<List<PromotionModel>> getPromotion(
      {required String merchantId,
      required String locationId,
      DateTime? currentTime,
      double? minimumTransaction,
      List<String>? includedItems,
      List<String>? excludeItems,
      bool forTransaction = false}) async {
    log(merchantId);
    var query = _promotionController
        .where('merchantId', isEqualTo: merchantId)
        .where('appliedAt', arrayContains: locationId);
    if (currentTime != null) {
      query = query.where('endTime', isGreaterThanOrEqualTo: currentTime);
    }
    if (includedItems != null) {
      query = query.where('includedItems', arrayContainsAny: includedItems);
    }
    if (excludeItems != null) {
      query = query.where('excludedItems', arrayContainsAny: excludeItems);
    }
    // if (minimumTransaction != null) {
    //   query = query.where('minimumTransaction', isLessThanOrEqualTo: minimumTransaction);
    // }

    return await query
        .withConverter<PromotionModel>(
          fromFirestore: (snapshot, options) {
            return PromotionModel.fromJson(snapshot.id, snapshot.data()!);
          },
          toFirestore: (value, options) => {},
        )
        .get()
        .then((value) {
      var data = value.docs.map((e) => e.data()).toList();
      if (currentTime != null) {
        data = data.where((e) => e.startTime!.isBefore(currentTime)).toList();
      }
      listAvailablePromo.assignAll(data);
      // if (!forTransaction) {
      //   listAvailablePromo.assignAll(data);

      // } else {
      //   listAvailablePromo.assignAll(data.where((element) => false));
      // }
      update();
      return listAvailablePromo;
    });
  }

  PromotionModel findBestPromo({required double totalPrice, required List<PromotionModel> promo}) {
    PromotionModel bestDiscount = promo.first;
    for (var e in promo) {
      if (bestDiscount.nominalTypeName == NominalTypeEnum.PERCENT) {
        if (e.nominalTypeName == NominalTypeEnum.PERCENT) {
          if (e.nominal! * totalPrice > bestDiscount.nominal! * totalPrice) bestDiscount = e;
        } else {
          if (e.nominal! > bestDiscount.nominal! * totalPrice) bestDiscount = e;
        }
      } else {
        if (e.nominalTypeName == NominalTypeEnum.PERCENT) {
          if (e.nominal! * totalPrice > bestDiscount.nominal!) bestDiscount = e;
        } else {
          if (e.nominal! > bestDiscount.nominal!) bestDiscount = e;
        }
      }
    }
    return bestDiscount;
  }

  Future<void> addOrUpdatePromotion(
      {required String merchantId, required String locationId}) async {
    if (promotionModel.id != null) {
      await _promotionController
          .doc(promotionModel.id)
          .update(promotionModel.copyWith(updatedAt: DateTime.now()).toJson());
    } else {
      await _promotionController.add(promotionModel.copyWith(
          appliedAt: [locationId],
          createdAt: DateTime.now(),
          currency: 'id_ID',
          merchantId: merchantId,
          multipleReward: false,
          status: StatusEnum.ACTIVE,
          updatedAt: DateTime.now(),
          usingWithOtherPromo: true).toJson());
    }
  }

  Future<void> deletePromo() async {
    await _promotionController.doc(promotionModel.id).delete();
  }
}
