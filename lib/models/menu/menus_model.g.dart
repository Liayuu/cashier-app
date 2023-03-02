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
      qty: json['qty'] as int?,
      buyingPrice: (json['buyingPrice'] as num?)?.toDouble(),
      image: json['image'] as String?,
      specifiedAt: (json['specifiedAt'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: $enumDecodeNullable(_$StatusEnumEnumMap, json['status']),
      updatedAt: _parseTimestamp(json['updatedAt']),
    );

Map<String, dynamic> _$MenuModelToJson(MenuModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'barcode': instance.barcode,
    'createdAt': _parseDateTime(instance.createdAt),
    'description': instance.description,
    'menuAt': instance.menuAt,
    'name': instance.name,
    'sku': instance.sku,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('qty', instance.qty);
  writeNotNull('buyingPrice', instance.buyingPrice);
  val['image'] = instance.image;
  val['specifiedAt'] = instance.specifiedAt;
  val['status'] = _$StatusEnumEnumMap[instance.status];
  val['updatedAt'] = _parseDateTime(instance.updatedAt);
  return val;
}

const _$StatusEnumEnumMap = {
  StatusEnum.DEACTIVATED: 'DEACTIVATED',
  StatusEnum.ACTIVE: 'ACTIVE',
};
