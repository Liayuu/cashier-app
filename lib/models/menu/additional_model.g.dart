// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditonalModel _$AdditonalModelFromJson(Map<String, dynamic> json) =>
    AdditonalModel(
      id: json['id'] as String?,
      price: (json['additionalPrice'] as num?)?.toDouble(),
      createdAt: _parseTimestamp(json['createdAt']),
      updatedAt: _parseTimestamp(json['updatedAt']),
      currency: json['currency'] as String?,
      name: json['name'] as String?,
      status: $enumDecodeNullable(_$StatusEnumEnumMap, json['status']),
    );

Map<String, dynamic> _$AdditonalModelToJson(AdditonalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'additionalPrice': instance.price,
      'createdAt': _parseDateTime(instance.createdAt),
      'updatedAt': _parseDateTime(instance.updatedAt),
      'currency': instance.currency,
      'name': instance.name,
      'status': _$StatusEnumEnumMap[instance.status],
    };

const _$StatusEnumEnumMap = {
  StatusEnum.DEACTIVATED: 'DEACTIVATED',
  StatusEnum.ACTIVE: 'ACTIVE',
};
