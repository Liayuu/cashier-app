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
      position: $enumDecodeNullable(_$PositionEnumMap, json['position']),
      positionName: json['positionName'] as String?,
      profilePict: json['profilePict'] as String?,
      status: $enumDecodeNullable(_$StatusEnumEnumMap, json['status']),
      updateAt: _parseTimestamp(json['updateAt']),
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
      'position': _$PositionEnumMap[instance.position],
      'positionName': instance.positionName,
      'profilePict': instance.profilePict,
      'status': _$StatusEnumEnumMap[instance.status],
      'updateAt': _parseDateTime(instance.updateAt),
    };

const _$PositionEnumMap = {
  Position.left: 'left',
  Position.right: 'right',
};

const _$StatusEnumEnumMap = {
  StatusEnum.DEACTIVATED: 'DEACTIVATED',
  StatusEnum.ACTIVE: 'ACTIVE',
};
