// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomizationModel _$CustomizationModelFromJson(Map<String, dynamic> json) =>
    CustomizationModel(
      id: json['id'] as String?,
      createdAt: _parseTimestamp(json['createdAt']),
      updatedAt: _parseTimestamp(json['updatedAt']),
      isCheckboxes: json['isCheckboxes'] as bool?,
      name: json['name'] as String?,
      status: $enumDecodeNullable(_$StatusEnumEnumMap, json['status']),
      customs: (json['customs'] as List<dynamic>?)
          ?.map((e) =>
              CustomizationGroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomizationModelToJson(CustomizationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': _parseDateTime(instance.createdAt),
      'updatedAt': _parseDateTime(instance.updatedAt),
      'isCheckboxes': instance.isCheckboxes,
      'name': instance.name,
      'status': _$StatusEnumEnumMap[instance.status],
      'customs': instance.customs,
    };

const _$StatusEnumEnumMap = {
  StatusEnum.DEACTIVATED: 'DEACTIVATED',
  StatusEnum.ACTIVE: 'ACTIVE',
};
