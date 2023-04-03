import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cashier_app/controllers/enums/promotion_type_enum.dart';
import 'package:cashier_app/controllers/enums/status_enum.dart';

part 'promotion_model.g.dart';

@JsonSerializable()
class PromotionModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;
  List<String>? appliedAt;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? createdAt;
  String? currency;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? endTime;
  List<String>? excludedItems;
  List<String>? includedItems;
  double? maximumNominal;
  String? merchantId;
  double? minimumTransaction;
  bool? multipleReward;
  String? name;
  double? nominal;
  NominalTypeEnum? nominalTypeName;
  int? nominalType;
  PromotionTypeEnum? promoTypeName;
  int? promoType;
  String? rewardItem;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? startTime;
  StatusEnum? status;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? updatedAt;
  bool? usingWithOtherPromo;
  PromotionModel({
    this.id,
    this.appliedAt,
    this.createdAt,
    this.currency,
    this.endTime,
    this.excludedItems,
    this.includedItems,
    this.maximumNominal,
    this.merchantId,
    this.minimumTransaction,
    this.multipleReward = false,
    this.name,
    this.nominal,
    this.nominalTypeName,
    this.nominalType,
    this.promoTypeName,
    this.promoType,
    this.rewardItem,
    this.startTime,
    this.status,
    this.updatedAt,
    this.usingWithOtherPromo = false,
  });

  PromotionModel copyWith({
    String? id,
    List<String>? appliedAt,
    DateTime? createdAt,
    String? currency,
    DateTime? endTime,
    List<String>? excludedItems,
    List<String>? includedItems,
    double? maximumNominal,
    String? merchantId,
    double? minimumTransaction,
    bool? multipleReward,
    String? name,
    double? nominal,
    NominalTypeEnum? nominalTypeName,
    int? nominalType,
    PromotionTypeEnum? promoTypeName,
    int? promoType,
    String? rewardItem,
    DateTime? startTime,
    StatusEnum? status,
    DateTime? updatedAt,
    bool? usingWithOtherPromo,
  }) {
    return PromotionModel(
      id: id ?? this.id,
      appliedAt: appliedAt ?? this.appliedAt,
      createdAt: createdAt ?? this.createdAt,
      currency: currency ?? this.currency,
      endTime: endTime ?? this.endTime,
      excludedItems: excludedItems ?? this.excludedItems,
      includedItems: includedItems ?? this.includedItems,
      maximumNominal: maximumNominal ?? this.maximumNominal,
      merchantId: merchantId ?? this.merchantId,
      minimumTransaction: minimumTransaction ?? this.minimumTransaction,
      multipleReward: multipleReward ?? this.multipleReward,
      name: name ?? this.name,
      nominal: nominal ?? this.nominal,
      nominalTypeName: nominalTypeName ?? this.nominalTypeName,
      nominalType: nominalType ?? this.nominalType,
      promoTypeName: promoTypeName ?? this.promoTypeName,
      promoType: promoType ?? this.promoType,
      rewardItem: rewardItem ?? this.rewardItem,
      startTime: startTime ?? this.startTime,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      usingWithOtherPromo: usingWithOtherPromo ?? this.usingWithOtherPromo,
    );
  }

  Map<String, dynamic> toJson() => _$PromotionModelToJson(this);

  factory PromotionModel.fromJson(String id, Map<String, dynamic> json) =>
      _$PromotionModelFromJson(json)..id = id;

  @override
  String toString() {
    return 'PromotionModel(id: $id, appliedAt: $appliedAt, createdAt: $createdAt, currency: $currency, endTime: $endTime, excludedItems: $excludedItems, includedItems: $includedItems, maximumNominal: $maximumNominal, merchantId: $merchantId, minimumTransaction: $minimumTransaction, multipleReward: $multipleReward, name: $name, nominal: $nominal, nominalTypeName: $nominalTypeName, nominalType: $nominalType, promoTypeName: $promoTypeName, promoType: $promoType, rewardItem: $rewardItem, startTime: $startTime, status: $status, updatedAt: $updatedAt, usingWithOtherPromo: $usingWithOtherPromo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PromotionModel &&
        other.id == id &&
        listEquals(other.appliedAt, appliedAt) &&
        other.createdAt == createdAt &&
        other.currency == currency &&
        other.endTime == endTime &&
        listEquals(other.excludedItems, excludedItems) &&
        listEquals(other.includedItems, includedItems) &&
        other.maximumNominal == maximumNominal &&
        other.merchantId == merchantId &&
        other.minimumTransaction == minimumTransaction &&
        other.multipleReward == multipleReward &&
        other.name == name &&
        other.nominal == nominal &&
        other.nominalTypeName == nominalTypeName &&
        other.nominalType == nominalType &&
        other.promoTypeName == promoTypeName &&
        other.promoType == promoType &&
        other.rewardItem == rewardItem &&
        other.startTime == startTime &&
        other.status == status &&
        other.updatedAt == updatedAt &&
        other.usingWithOtherPromo == usingWithOtherPromo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        appliedAt.hashCode ^
        createdAt.hashCode ^
        currency.hashCode ^
        endTime.hashCode ^
        excludedItems.hashCode ^
        includedItems.hashCode ^
        maximumNominal.hashCode ^
        merchantId.hashCode ^
        minimumTransaction.hashCode ^
        multipleReward.hashCode ^
        name.hashCode ^
        nominal.hashCode ^
        nominalTypeName.hashCode ^
        nominalType.hashCode ^
        promoTypeName.hashCode ^
        promoType.hashCode ^
        rewardItem.hashCode ^
        startTime.hashCode ^
        status.hashCode ^
        updatedAt.hashCode ^
        usingWithOtherPromo.hashCode;
  }
}

DateTime _parseTimestamp(_) {
  return DateTime.parse(_.toDate().toString());
}

Timestamp _parseDateTime(_) {
  return Timestamp.fromMicrosecondsSinceEpoch(_.microsecondsSinceEpoch);
}
