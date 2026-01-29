
// Removed Cloud Firestore dependency — using local JSON storage instead
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cashier_app/controllers/enums/order_type_enum.dart';
import 'package:cashier_app/controllers/enums/payment_type_enum.dart';
import 'package:cashier_app/controllers/enums/transaction_status_enum.dart';
import 'package:cashier_app/models/menu/menus_model.dart';
import 'package:cashier_app/models/promotion/promotion_model.dart';

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
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<MenuModel>? menus;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<PromotionModel>? promos;
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
    this.promos,
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
    List<PromotionModel>? promos,
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
      promos: promos ?? this.promos,
    );
  }

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  factory TransactionModel.fromJson(String id, Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json)..id = id;

  @override
  String toString() {
    return 'TransactionModel(id: $id, cash: $cash, change: $change, createdAt: $createdAt, currency: $currency, discNominal: $discNominal, grandTotal: $grandTotal, handledBy: $handledBy, locationId: $locationId, merchantId: $merchantId, paymentType: $paymentType, promotionUsed: $promotionUsed, status: $status, subTotal: $subTotal, orderType: $orderType, menus: $menus, promos: $promos)';
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
        listEquals(other.menus, menus) &&
        listEquals(other.promos, promos);
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
        menus.hashCode ^
        promos.hashCode;
  }
}

DateTime _parseTimestamp(dynamic value) {
  if (value == null) return DateTime.fromMillisecondsSinceEpoch(0);
  if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
  if (value is String) return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
  if (value is Map) {
    // handle Firestore-like map {seconds, nanoseconds}
    if (value.containsKey('seconds')) {
      final seconds = value['seconds'] as int? ?? 0;
      final nanos = value['nanoseconds'] as int? ?? 0;
      return DateTime.fromMillisecondsSinceEpoch(seconds * 1000 + (nanos / 1000000).round());
    }
  }
  return DateTime.fromMillisecondsSinceEpoch(0);
}

dynamic _parseDateTime(DateTime? dt) {
  return dt?.toIso8601String();
}
