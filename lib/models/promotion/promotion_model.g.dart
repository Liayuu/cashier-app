// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionModel _$PromotionModelFromJson(Map<String, dynamic> json) =>
    PromotionModel(
      appliedAt: (json['appliedAt'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: _parseTimestamp(json['createdAt']),
      currency: json['currency'] as String?,
      endTime: _parseTimestamp(json['endTime']),
      excludedItems: (json['excludedItems'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      includedItems: (json['includedItems'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      minQty: json['minQty'] as int?,
      maxQty: json['maxQty'] as int?,
      maximumNominal: (json['maximumNominal'] as num?)?.toDouble(),
      merchantId: json['merchantId'] as String?,
      minimumTransaction: (json['minimumTransaction'] as num?)?.toDouble(),
      multipleReward: json['multipleReward'] as bool? ?? false,
      name: json['name'] as String?,
      nominal: (json['nominal'] as num?)?.toDouble(),
      nominalTypeName: $enumDecodeNullable(
          _$NominalTypeEnumEnumMap, json['nominalTypeName']),
      nominalType: json['nominalType'] as int?,
      promoTypeName: $enumDecodeNullable(
          _$PromotionTypeEnumEnumMap, json['promoTypeName']),
      promoType: json['promoType'] as int?,
      rewardItem: json['rewardItem'] as String?,
      startTime: _parseTimestamp(json['startTime']),
      status: $enumDecodeNullable(_$StatusEnumEnumMap, json['status']),
      updatedAt: _parseTimestamp(json['updatedAt']),
      usingWithOtherPromo: json['usingWithOtherPromo'] as bool? ?? false,
    );

Map<String, dynamic> _$PromotionModelToJson(PromotionModel instance) =>
    <String, dynamic>{
      'appliedAt': instance.appliedAt,
      'createdAt': _parseDateTime(instance.createdAt),
      'currency': instance.currency,
      'endTime': _parseDateTime(instance.endTime),
      'excludedItems': instance.excludedItems,
      'includedItems': instance.includedItems,
      'minQty': instance.minQty,
      'maxQty': instance.maxQty,
      'maximumNominal': instance.maximumNominal,
      'merchantId': instance.merchantId,
      'minimumTransaction': instance.minimumTransaction,
      'multipleReward': instance.multipleReward,
      'name': instance.name,
      'nominal': instance.nominal,
      'nominalTypeName': _$NominalTypeEnumEnumMap[instance.nominalTypeName],
      'nominalType': instance.nominalType,
      'promoTypeName': _$PromotionTypeEnumEnumMap[instance.promoTypeName],
      'promoType': instance.promoType,
      'rewardItem': instance.rewardItem,
      'startTime': _parseDateTime(instance.startTime),
      'status': _$StatusEnumEnumMap[instance.status],
      'updatedAt': _parseDateTime(instance.updatedAt),
      'usingWithOtherPromo': instance.usingWithOtherPromo,
    };

const _$NominalTypeEnumEnumMap = {
  NominalTypeEnum.UNKNOWN: 'UNKNOWN',
  NominalTypeEnum.NOMINAL: 'NOMINAL',
  NominalTypeEnum.PERCENT: 'PERCENT',
};

const _$PromotionTypeEnumEnumMap = {
  PromotionTypeEnum.UNKNOWN: 'UNKNOWN',
  PromotionTypeEnum.DISCOUNT: 'DISCOUNT',
  PromotionTypeEnum.FREE_ADD: 'FREE_ADD',
  PromotionTypeEnum.GIFT: 'GIFT',
  PromotionTypeEnum.FREE: 'FREE',
};

const _$StatusEnumEnumMap = {
  StatusEnum.DEACTIVATED: 'DEACTIVATED',
  StatusEnum.ACTIVE: 'ACTIVE',
};
