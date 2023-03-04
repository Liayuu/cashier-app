import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cashier_app/controllers/enums/status_enum.dart';

part 'additional_model.g.dart';

@JsonSerializable()
class AdditonalModel {
  String? id;
  @JsonKey(name: "additionalPrice")
  double? price;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? createdAt;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? updatedAt;
  String? currency;
  String? name;
  StatusEnum? status;
  AdditonalModel({
    this.id,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.currency,
    this.name,
    this.status,
  });

  AdditonalModel copyWith({
    String? id,
    double? price,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? currency,
    String? name,
    StatusEnum? status,
  }) {
    return AdditonalModel(
      id: id ?? this.id,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      currency: currency ?? this.currency,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() => _$AdditonalModelToJson(this);

  factory AdditonalModel.fromJson(Map<String, dynamic> json) => _$AdditonalModelFromJson(json);

  @override
  String toString() {
    return 'AdditonalModel(id: $id, price: $price, createdAt: $createdAt, updatedAt: $updatedAt, currency: $currency, name: $name, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AdditonalModel &&
        other.id == id &&
        other.price == price &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.currency == currency &&
        other.name == name &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        price.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        currency.hashCode ^
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
