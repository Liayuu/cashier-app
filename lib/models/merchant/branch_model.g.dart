// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
      address: json['address'] as String?,
      branchType: $enumDecodeNullable(_$BranchTypeEnumMap, json['branchType']),
      country: json['country'] as String?,
      disctrict: json['disctrict'] as String?,
      logo: json['logo'] as String?,
      map: json['map'],
      posCode: json['posCode'] as String?,
      province: json['province'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      regency: json['regency'] as String?,
      status: $enumDecodeNullable(_$StatusEnumEnumMap, json['status']),
    );

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'branchType': _$BranchTypeEnumMap[instance.branchType],
      'country': instance.country,
      'disctrict': instance.disctrict,
      'logo': instance.logo,
      'map': instance.map,
      'posCode': instance.posCode,
      'province': instance.province,
      'rating': instance.rating,
      'regency': instance.regency,
      'status': _$StatusEnumEnumMap[instance.status],
    };

const _$BranchTypeEnumMap = {
  BranchType.UNKNOWN: 'UNKNOWN',
  BranchType.MAIN_BRANCH: 'MAIN_BRANCH',
};

const _$StatusEnumEnumMap = {
  StatusEnum.DEACTIVATED: 'DEACTIVATED',
  StatusEnum.ACTIVE: 'ACTIVE',
};
