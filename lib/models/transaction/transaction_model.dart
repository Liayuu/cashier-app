import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cashier_app/controllers/enums/order_type_enum.dart';
import 'package:cashier_app/controllers/enums/payment_type_enum.dart';
import 'package:cashier_app/controllers/enums/transaction_status_enum.dart';
import 'package:cashier_app/models/menu/menus_model.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;
  double? cash;
  double? change;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? createdAt;
  String? currency;
  @JsonKey(name: 'discountNominal')
  double? discNominal;
  double? grandTotal;
  String? handledBy;
  String? locationId;
  String? merchantId;
  PaymentType? paymentType;
  List<String>? promotionUsed;
  TransactionStatus? status;
  double? subTotal;
  OrderType? orderType;
  @JsonKey(includeFromJson: false)
  List<MenuModel>? menus;
  //TODO: PAJAK BELUM DIBUAT
  TransactionModel({
    this.id,
    this.cash,
    this.change,
    this.createdAt,
    this.currency,
    this.discNominal = 0,
    this.grandTotal = 0,
    this.handledBy,
    this.locationId,
    this.merchantId,
    this.paymentType,
    this.promotionUsed,
    this.status,
    this.subTotal = 0,
    this.orderType = OrderType.DINE_IN,
    this.menus,
  });

  TransactionModel copyWith({
    String? id,
    double? cash,
    double? change,
    DateTime? createdAt,
    String? currency,
    double? discNominal,
    double? grandTotal,
    String? handledBy,
    String? locationId,
    String? merchantId,
    PaymentType? paymentType,
    List<String>? promotionUsed,
    TransactionStatus? status,
    double? subTotal,
    OrderType? orderType,
    List<MenuModel>? menus,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      cash: cash ?? this.cash,
      change: change ?? this.change,
      createdAt: createdAt ?? this.createdAt,
      currency: currency ?? this.currency,
      discNominal: discNominal ?? this.discNominal,
      grandTotal: grandTotal ?? this.grandTotal,
      handledBy: handledBy ?? this.handledBy,
      locationId: locationId ?? this.locationId,
      merchantId: merchantId ?? this.merchantId,
      paymentType: paymentType ?? this.paymentType,
      promotionUsed: promotionUsed ?? this.promotionUsed,
      status: status ?? this.status,
      subTotal: subTotal ?? this.subTotal,
      orderType: orderType ?? this.orderType,
      menus: menus ?? this.menus,
    );
  }

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  factory TransactionModel.fromJson(String id, Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json)..id = id;

  @override
  String toString() {
    return 'TransactionModel(id: $id, cash: $cash, change: $change, createdAt: $createdAt, currency: $currency, discNominal: $discNominal, grandTotal: $grandTotal, handledBy: $handledBy, locationId: $locationId, merchantId: $merchantId, paymentType: $paymentType, promotionUsed: $promotionUsed, status: $status, subTotal: $subTotal, orderType: $orderType, menus: $menus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.id == id &&
        other.cash == cash &&
        other.change == change &&
        other.createdAt == createdAt &&
        other.currency == currency &&
        other.discNominal == discNominal &&
        other.grandTotal == grandTotal &&
        other.handledBy == handledBy &&
        other.locationId == locationId &&
        other.merchantId == merchantId &&
        other.paymentType == paymentType &&
        listEquals(other.promotionUsed, promotionUsed) &&
        other.status == status &&
        other.subTotal == subTotal &&
        other.orderType == orderType &&
        listEquals(other.menus, menus);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cash.hashCode ^
        change.hashCode ^
        createdAt.hashCode ^
        currency.hashCode ^
        discNominal.hashCode ^
        grandTotal.hashCode ^
        handledBy.hashCode ^
        locationId.hashCode ^
        merchantId.hashCode ^
        paymentType.hashCode ^
        promotionUsed.hashCode ^
        status.hashCode ^
        subTotal.hashCode ^
        orderType.hashCode ^
        menus.hashCode;
  }
}

DateTime _parseTimestamp(_) {
  return DateTime.parse(_.toDate().toString());
}

Timestamp _parseDateTime(_) {
  return Timestamp.fromMicrosecondsSinceEpoch(_.microsecondsSinceEpoch);
}
