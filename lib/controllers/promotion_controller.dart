import 'dart:developer';

import 'package:cashier_app/controllers/enums/document_name.dart';
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
      List<String>? includedItems,
      List<String>? excludeItems,
      bool forTransaction = false}) async {
    log(merchantId);
    var query = _promotionController
        .where('merchantId', isEqualTo: merchantId)
        .where('appliedAt', arrayContains: locationId);
    if (currentTime != null) {
      query = query
          .where('startTime', isGreaterThanOrEqualTo: Timestamp.fromDate(currentTime))
          .where('endTime', isLessThanOrEqualTo: Timestamp.fromDate(currentTime));
    }
    if (includedItems != null) {
      query = query.where('includedItems', arrayContainsAny: includedItems);
    }
    if (excludeItems != null) {
      query = query.where('excludedItems', arrayContainsAny: excludeItems);
    }

    return await query
        .withConverter<PromotionModel>(
          fromFirestore: (snapshot, options) {
            return PromotionModel.fromJson(snapshot.id, snapshot.data()!);
          },
          toFirestore: (value, options) => {},
        )
        .get()
        .then((value) {
      log(value.docs.length.toString());
      if (forTransaction) {
        listAvailablePromo.assignAll(value.docs.map((e) => e.data()).toList());
      }
      return value.docs.map((e) => e.data()).toList();
    });
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
