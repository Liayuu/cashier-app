import 'dart:developer';

import 'package:cashier_app/controllers/enums/document_name.dart';
import 'package:cashier_app/controllers/enums/promotion_type_enum.dart';
import 'package:cashier_app/controllers/enums/status_enum.dart';
import 'package:cashier_app/models/promotion/promotion_model.dart';
import 'package:cashier_app/services/local_database.dart';
import 'package:get/get.dart';

class PromotionController extends GetxController {
  final _collectionName = DocumentName.PROMOTION.name.toLowerCase();
  PromotionModel promotionModel = PromotionModel();
  List<PromotionModel> listAvailablePromo = [];

  Future<List<PromotionModel>?> getPromotion(
      {required String merchantId,
      required String locationId,
      DateTime? currentTime,
      double? minimumTransaction,
      List<String>? includedItems,
      List<String>? excludeItems,
      bool forTransaction = false}) async {
    // fetch promotions from local DB and filter in memory
    var data = await LocalDatabase.instance
        .whereEquals(_collectionName, 'merchantId', merchantId);
    data = data
        .where((e) => (e['appliedAt'] as List?)?.contains(locationId) ?? false)
        .toList();
    if (currentTime != null) {
      data = data.where((e) {
        final t = e['endTime'];
        if (t == null) return false;
        final dt = DateTime.tryParse(t.toString()) ??
            DateTime.fromMillisecondsSinceEpoch(0);
        return dt.isAfter(currentTime) || dt.isAtSameMomentAs(currentTime);
      }).toList();
    }
    if (includedItems != null) {
      data = data
          .where((e) =>
              (e['includedItems'] as List?)
                  ?.any((i) => includedItems.contains(i)) ??
              false)
          .toList();
    }
    if (excludeItems != null) {
      data = data
          .where((e) =>
              (e['excludedItems'] as List?)
                  ?.any((i) => excludeItems.contains(i)) ??
              false)
          .toList();
    }

    log(data.toString());
    if (data.isNotEmpty) {
      final promos =
          data.map((e) => PromotionModel.fromJson(e['id'], e)).toList();
      if (currentTime != null) {
        final filtered = promos
            .where((e) =>
                e.startTime != null && e.startTime!.isBefore(currentTime))
            .toList();
        if (filtered.isNotEmpty) {
          listAvailablePromo.assignAll(filtered);
          update();
          return listAvailablePromo;
        }
        return null;
      }
      listAvailablePromo.assignAll(promos);
      update();
      return listAvailablePromo;
    }
    return null;
  }

  PromotionModel findBestPromo(
      {required double totalPrice, required List<PromotionModel> promo}) {
    PromotionModel bestDiscount = promo.first;
    for (var e in promo) {
      if (bestDiscount.nominalTypeName == NominalTypeEnum.PERCENT) {
        if (e.nominalTypeName == NominalTypeEnum.PERCENT) {
          if (e.nominal! * totalPrice > bestDiscount.nominal! * totalPrice) {
            bestDiscount = e;
          }
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
    final now = DateTime.now();
    if (promotionModel.id != null) {
      await LocalDatabase.instance.updateDocument(_collectionName,
          promotionModel.id!, promotionModel.copyWith(updatedAt: now).toJson());
    } else {
      final data = promotionModel.copyWith(
          appliedAt: [locationId],
          createdAt: now,
          currency: 'id_ID',
          merchantId: merchantId,
          multipleReward: false,
          status: StatusEnum.ACTIVE,
          updatedAt: now,
          usingWithOtherPromo: true).toJson();
      await LocalDatabase.instance.addDocument(_collectionName, data);
    }
  }

  Future<void> deletePromo() async {
    if (promotionModel.id != null) {
      await LocalDatabase.instance
          .deleteDocument(_collectionName, promotionModel.id!);
    }
  }
}
