// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) => PriceModel(
      id: json['id'] as String?,
      createdAt: _parseTimestamp(json['createdAt']),
      updatedAt: _parseTimestamp(json['updatedAt']),
      currency: json['currency'] as String?,
      merchantId: json['appliedAt'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      locationId: (json['singleAppliedAt'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: $enumDecodeNullable(_$StatusEnumEnumMap, json['status']),
    );

Map<String, dynamic> _$PriceModelToJson(PriceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': _parseDateTime(instance.createdAt),
      'updatedAt': _parseDateTime(instance.updatedAt),
      'currency': instance.currency,
      'appliedAt': instance.merchantId,
      'price': instance.price,
      'singleAppliedAt': instance.locationId,
      'status': _$StatusEnumEnumMap[instance.status],
    };

const _$StatusEnumEnumMap = {
  StatusEnum.DEACTIVATED: 'DEACTIVATED',
  StatusEnum.ACTIVE: 'ACTIVE',
};
