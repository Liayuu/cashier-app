// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) =>
    EmployeeModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      employeeAt: json['employeeAt'] as String?,
      uuid: json['firebaseUID'] as String?,
      lastSignIn: _parseTimestamp(json['lastSignIn']),
      manageAt: (json['manageAt'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      position: $enumDecodeNullable(_$PositionEnumEnumMap, json['position']),
      positionName: json['positionName'] as String?,
      profilePict: json['profilePict'] as String?,
      status: $enumDecodeNullable(_$StatusEnumEnumMap, json['status']),
      updatedAt: _parseTimestamp(json['updatedAt']),
    );

Map<String, dynamic> _$EmployeeModelToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'employeeAt': instance.employeeAt,
      'firebaseUID': instance.uuid,
      'lastSignIn': _parseDateTime(instance.lastSignIn),
      'manageAt': instance.manageAt,
      'name': instance.name,
      'phone': instance.phone,
      'position': _$PositionEnumEnumMap[instance.position],
      'positionName': instance.positionName,
      'profilePict': instance.profilePict,
      'status': _$StatusEnumEnumMap[instance.status],
      'updatedAt': _parseDateTime(instance.updatedAt),
    };

const _$PositionEnumEnumMap = {
  PositionEnum.UNKNOWN: 'UNKNOWN',
  PositionEnum.OWNER: 'OWNER',
};

const _$StatusEnumEnumMap = {
  StatusEnum.DEACTIVATED: 'DEACTIVATED',
  StatusEnum.ACTIVE: 'ACTIVE',
};
