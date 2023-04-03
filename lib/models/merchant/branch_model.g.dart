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
      background: json['background'] as String?,
      map: json['map'],
      posCode: json['posCode'] as String?,
      province: json['province'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      regency: json['regency'] as String?,
      status: $enumDecodeNullable(_$StatusEnumEnumMap, json['status']),
    );

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) {
  final val = <String, dynamic>{
    'address': instance.address,
    'branchType': _$BranchTypeEnumMap[instance.branchType],
    'country': instance.country,
    'disctrict': instance.disctrict,
    'logo': instance.logo,
    'background': instance.background,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('map', instance.map);
  val['posCode'] = instance.posCode;
  val['province'] = instance.province;
  val['rating'] = instance.rating;
  val['regency'] = instance.regency;
  val['status'] = _$StatusEnumEnumMap[instance.status];
  return val;
}

const _$BranchTypeEnumMap = {
  BranchType.UNKNOWN: 'UNKNOWN',
  BranchType.MAIN_BRANCH: 'MAIN_BRANCH',
};

const _$StatusEnumEnumMap = {
  StatusEnum.DEACTIVATED: 'DEACTIVATED',
  StatusEnum.ACTIVE: 'ACTIVE',
};
