import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cashier_app/controllers/enums/merchant_type_enum.dart';
import 'package:cashier_app/controllers/enums/status_enum.dart';

part 'merchant_model.g.dart';

@JsonSerializable()
class MerchantModel {
  String? id;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? createdAt;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? updatedAt;
  String? name;
  StatusEnum? status;
  MerchantType? type;
  MerchantModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.status,
    this.type,
  });

  MerchantModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    StatusEnum? status,
    MerchantType? type,
  }) {
    return MerchantModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      status: status ?? this.status,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() => _$MerchantModelToJson(this);

  factory MerchantModel.fromJson(Map<String, dynamic> json) => _$MerchantModelFromJson(json);

  @override
  String toString() {
    return 'MerchantModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, status: $status, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MerchantModel &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.name == name &&
        other.status == status &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        name.hashCode ^
        status.hashCode ^
        type.hashCode;
  }
}

DateTime _parseTimestamp(_) {
  return DateTime.parse(_.toDate().toString());
}

Timestamp _parseDateTime(_) {
  return Timestamp.fromMicrosecondsSinceEpoch(_.microsecondsSinceEpoch);
}
