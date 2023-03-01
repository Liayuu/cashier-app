import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cashier_app/controllers/enums/status_enum.dart';
import 'package:cashier_app/models/menu/customization_group_model.dart';

part 'customization_model.g.dart';

@JsonSerializable()
class CustomizationModel {
  String? id;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? createdAt;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? updatedAt;
  bool? isCheckboxes;
  String? name;
  StatusEnum? status;
  List<CustomizationGroupModel>? customs;
  CustomizationModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isCheckboxes,
    this.name,
    this.status,
    this.customs,
  });

  CustomizationModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isCheckboxes,
    String? name,
    StatusEnum? status,
    List<CustomizationGroupModel>? customs,
  }) {
    return CustomizationModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isCheckboxes: isCheckboxes ?? this.isCheckboxes,
      name: name ?? this.name,
      status: status ?? this.status,
      customs: customs ?? this.customs,
    );
  }

  Map<String, dynamic> toJson() => _$CustomizationModelToJson(this);

  factory CustomizationModel.fromJson(Map<String, dynamic> json) =>
      _$CustomizationModelFromJson(json);

  @override
  String toString() {
    return 'CustomizationModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, isCheckboxes: $isCheckboxes, name: $name, status: $status, customs: $customs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomizationModel &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.isCheckboxes == isCheckboxes &&
        other.name == name &&
        other.status == status &&
        listEquals(other.customs, customs);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        isCheckboxes.hashCode ^
        name.hashCode ^
        status.hashCode ^
        customs.hashCode;
  }
}

DateTime _parseTimestamp(_) {
  return DateTime.parse(_.toDate().toString());
}

Timestamp _parseDateTime(_) {
  return Timestamp.fromMicrosecondsSinceEpoch(_.microsecondsSinceEpoch);
}
