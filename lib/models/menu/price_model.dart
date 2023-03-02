import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cashier_app/controllers/enums/status_enum.dart';

part 'price_model.g.dart';

@JsonSerializable()
class PriceModel {
  String? id;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? createdAt;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? updatedAt;
  String? currency;
  @JsonKey(name: 'appliedAt')
  String? merchantId;
  double? price;
  @JsonKey(name: 'singleAppliedAt')
  List<String>? locationId;
  StatusEnum? status;
  PriceModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.currency,
    this.merchantId,
    this.price,
    this.locationId,
    this.status,
  });

  PriceModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? currency,
    String? merchantId,
    double? price,
    List<String>? locationId,
    StatusEnum? status,
  }) {
    return PriceModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      currency: currency ?? this.currency,
      merchantId: merchantId ?? this.merchantId,
      price: price ?? this.price,
      locationId: locationId ?? this.locationId,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() => _$PriceModelToJson(this);

  factory PriceModel.fromJson(String id, Map<String, dynamic> json) =>
      _$PriceModelFromJson(json)..id = id;

  @override
  String toString() {
    return 'PriceModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, currency: $currency, merchantId: $merchantId, price: $price, locationId: $locationId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriceModel &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.currency == currency &&
        other.merchantId == merchantId &&
        other.price == price &&
        listEquals(other.locationId, locationId) &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        currency.hashCode ^
        merchantId.hashCode ^
        price.hashCode ^
        locationId.hashCode ^
        status.hashCode;
  }
}

DateTime _parseTimestamp(_) {
  return DateTime.parse(_.toDate().toString());
}

Timestamp _parseDateTime(_) {
  return Timestamp.fromMicrosecondsSinceEpoch(_.microsecondsSinceEpoch);
}
