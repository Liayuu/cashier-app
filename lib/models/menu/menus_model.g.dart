// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuModel _$MenuModelFromJson(Map<String, dynamic> json) => MenuModel(
      id: json['id'] as String?,
      barcode: json['barcode'] as String?,
      createdAt: _parseTimestamp(json['createdAt']),
      description: json['description'] as String?,
      menuAt: json['menuAt'] as String?,
      name: json['name'] as String?,
      sku: json['sku'] as String?,
      specifiedAt: (json['specifiedAt'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: $enumDecodeNullable(_$StatusEnumEnumMap, json['status']),
      updatedAt: _parseTimestamp(json['updatedAt']),
    );

Map<String, dynamic> _$MenuModelToJson(MenuModel instance) => <String, dynamic>{
      'id': instance.id,
      'barcode': instance.barcode,
      'createdAt': _parseDateTime(instance.createdAt),
      'description': instance.description,
      'menuAt': instance.menuAt,
      'name': instance.name,
      'sku': instance.sku,
      'specifiedAt': instance.specifiedAt,
      'status': _$StatusEnumEnumMap[instance.status],
      'updatedAt': _parseDateTime(instance.updatedAt),
    };

const _$StatusEnumEnumMap = {
  StatusEnum.DEACTIVATED: 'DEACTIVATED',
  StatusEnum.ACTIVE: 'ACTIVE',
};
