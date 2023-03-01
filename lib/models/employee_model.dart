import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:cashier_app/controllers/enums/status_enum.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel {
  String? id;
  String? email;
  String? employeeAt;
  @JsonKey(name: 'firebaseUID')
  String? uuid;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? lastSignIn;
  List<String>? manageAt;
  String? name;
  String? phone;
  Position? position;
  String? positionName;
  String? profilePict;
  StatusEnum? status;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? updateAt;
  EmployeeModel({
    this.id,
    this.email,
    this.employeeAt,
    this.uuid,
    this.lastSignIn,
    this.manageAt,
    this.name,
    this.phone,
    this.position,
    this.positionName,
    this.profilePict,
    this.status,
    this.updateAt,
  });

  EmployeeModel copyWith({
    String? id,
    String? email,
    String? employeeAt,
    String? uuid,
    DateTime? lastSignIn,
    List<String>? manageAt,
    String? name,
    String? phone,
    Position? position,
    String? positionName,
    String? profilePict,
    StatusEnum? status,
    DateTime? updateAt,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      email: email ?? this.email,
      employeeAt: employeeAt ?? this.employeeAt,
      uuid: uuid ?? this.uuid,
      lastSignIn: lastSignIn ?? this.lastSignIn,
      manageAt: manageAt ?? this.manageAt,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      position: position ?? this.position,
      positionName: positionName ?? this.positionName,
      profilePict: profilePict ?? this.profilePict,
      status: status ?? this.status,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => _$EmployeeModelFromJson(json);

  @override
  String toString() {
    return 'EmployeeModel(id: $id, email: $email, employeeAt: $employeeAt, uuid: $uuid, lastSignIn: $lastSignIn, manageAt: $manageAt, name: $name, phone: $phone, position: $position, positionName: $positionName, profilePict: $profilePict, status: $status, updateAt: $updateAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmployeeModel &&
        other.id == id &&
        other.email == email &&
        other.employeeAt == employeeAt &&
        other.uuid == uuid &&
        other.lastSignIn == lastSignIn &&
        listEquals(other.manageAt, manageAt) &&
        other.name == name &&
        other.phone == phone &&
        other.position == position &&
        other.positionName == positionName &&
        other.profilePict == profilePict &&
        other.status == status &&
        other.updateAt == updateAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        employeeAt.hashCode ^
        uuid.hashCode ^
        lastSignIn.hashCode ^
        manageAt.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        position.hashCode ^
        positionName.hashCode ^
        profilePict.hashCode ^
        status.hashCode ^
        updateAt.hashCode;
  }
}

DateTime _parseTimestamp(_) {
  return DateTime.parse(_.toDate().toString());
}

Timestamp _parseDateTime(_) {
  return Timestamp.fromMicrosecondsSinceEpoch(_.microsecondsSinceEpoch);
}
