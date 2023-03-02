// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantModel _$MerchantModelFromJson(Map<String, dynamic> json) =>
    MerchantModel(
      id: json['id'] as String?,
      createdAt: _parseTimestamp(json['createdAt']),
      updatedAt: _parseTimestamp(json['updatedAt']),
      name: json['name'] as String?,
      logo: json['logo'] as String?,
      background: json['background'] as String?,
      status: $enumDecodeNullable(_$StatusEnumEnumMap, json['status']),
      type: $enumDecodeNullable(_$MerchantTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$MerchantModelToJson(MerchantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updatedAt': _parseDateTime(instance.updatedAt),
      'name': instance.name,
      'logo': instance.logo,
      'background': instance.background,
      'status': _$StatusEnumEnumMap[instance.status],
      'type': _$MerchantTypeEnumMap[instance.type],
    };

const _$StatusEnumEnumMap = {
  StatusEnum.DEACTIVATED: 'DEACTIVATED',
  StatusEnum.ACTIVE: 'ACTIVE',
};

const _$MerchantTypeEnumMap = {
  MerchantType.UNKNOWN: 'UNKNOWN',
  MerchantType.RESTAURANT: 'RESTAURANT',
};
