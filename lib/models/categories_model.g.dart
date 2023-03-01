// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesModel _$CategoriesModelFromJson(Map<String, dynamic> json) =>
    CategoriesModel(
      id: json['id'] as String?,
      appliedAt: (json['appliedAt'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: _parseTimestamp(json['createdAt']),
      updatedAt: _parseTimestamp(json['updatedAt']),
      items:
          (json['items'] as List<dynamic>?)?.map((e) => e as String).toList(),
      logo: json['logo'] as String?,
      merchantId: json['merchantId'] as String?,
      name: json['name'] as String?,
      status: $enumDecodeNullable(_$StatusEnumEnumMap, json['status']),
    );

Map<String, dynamic> _$CategoriesModelToJson(CategoriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appliedAt': instance.appliedAt,
      'createdAt': _parseDateTime(instance.createdAt),
      'updatedAt': _parseDateTime(instance.updatedAt),
      'items': instance.items,
      'logo': instance.logo,
      'merchantId': instance.merchantId,
      'name': instance.name,
      'status': _$StatusEnumEnumMap[instance.status],
    };

const _$StatusEnumEnumMap = {
  StatusEnum.DEACTIVATED: 'DEACTIVATED',
  StatusEnum.ACTIVE: 'ACTIVE',
};
