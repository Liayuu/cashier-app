import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cashier_app/controllers/enums/status_enum.dart';

part 'customization_group_model.g.dart';

@JsonSerializable()
class CustomizationGroupModel {
  String? id;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? createdAt;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? updatedAt;
  @JsonKey(name: 'default')
  bool? initValue;
  String? name;
  StatusEnum? status;
  CustomizationGroupModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.initValue,
    this.name,
    this.status,
  });

  CustomizationGroupModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? initValue,
    String? name,
    StatusEnum? status,
  }) {
    return CustomizationGroupModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      initValue: initValue ?? this.initValue,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() => _$CustomizationGroupModelToJson(this);

  factory CustomizationGroupModel.fromJson(Map<String, dynamic> json) =>
      _$CustomizationGroupModelFromJson(json);

  @override
  String toString() {
    return 'CustomizationGroupModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, initValue: $initValue, name: $name, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomizationGroupModel &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.initValue == initValue &&
        other.name == name &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        initValue.hashCode ^
        name.hashCode ^
        status.hashCode;
  }
}

DateTime _parseTimestamp(_) {
  return DateTime.parse(_.toDate().toString());
}

Timestamp _parseDateTime(_) {
  return Timestamp.fromMicrosecondsSinceEpoch(_.microsecondsSinceEpoch);
}
