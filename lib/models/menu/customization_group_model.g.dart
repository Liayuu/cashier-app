// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customization_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomizationGroupModel _$CustomizationGroupModelFromJson(
        Map<String, dynamic> json) =>
    CustomizationGroupModel(
      id: json['id'] as String?,
      createdAt: _parseTimestamp(json['createdAt']),
      updatedAt: _parseTimestamp(json['updatedAt']),
      initValue: json['default'] as bool?,
      name: json['name'] as String?,
      status: $enumDecodeNullable(_$StatusEnumEnumMap, json['status']),
    );

Map<String, dynamic> _$CustomizationGroupModelToJson(
        CustomizationGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': _parseDateTime(instance.createdAt),
      'updatedAt': _parseDateTime(instance.updatedAt),
      'default': instance.initValue,
      'name': instance.name,
      'status': _$StatusEnumEnumMap[instance.status],
    };

const _$StatusEnumEnumMap = {
  StatusEnum.DEACTIVATED: 'DEACTIVATED',
  StatusEnum.ACTIVE: 'ACTIVE',
};
