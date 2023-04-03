// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      cash: (json['cash'] as num?)?.toDouble(),
      change: (json['change'] as num?)?.toDouble(),
      createdAt: _parseTimestamp(json['createdAt']),
      currency: json['currency'] as String?,
      discNominal: (json['discountNominal'] as num?)?.toDouble() ?? 0,
      grandTotal: (json['grandTotal'] as num?)?.toDouble() ?? 0,
      handledBy: json['handledBy'] as String?,
      locationId: json['locationId'] as String?,
      merchantId: json['merchantId'] as String?,
      paymentType:
          $enumDecodeNullable(_$PaymentTypeEnumMap, json['paymentType']),
      promotionUsed: (json['promotionUsed'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: $enumDecodeNullable(_$TransactionStatusEnumMap, json['status']),
      subTotal: (json['subTotal'] as num?)?.toDouble() ?? 0,
      orderType: $enumDecodeNullable(_$OrderTypeEnumMap, json['orderType']) ??
          OrderType.DINE_IN,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'cash': instance.cash,
      'change': instance.change,
      'createdAt': _parseDateTime(instance.createdAt),
      'currency': instance.currency,
      'discountNominal': instance.discNominal,
      'grandTotal': instance.grandTotal,
      'handledBy': instance.handledBy,
      'locationId': instance.locationId,
      'merchantId': instance.merchantId,
      'paymentType': _$PaymentTypeEnumMap[instance.paymentType],
      'promotionUsed': instance.promotionUsed,
      'status': _$TransactionStatusEnumMap[instance.status],
      'subTotal': instance.subTotal,
      'orderType': _$OrderTypeEnumMap[instance.orderType],
    };

const _$PaymentTypeEnumMap = {
  PaymentType.UNKNOWN: 'UNKNOWN',
  PaymentType.CREDIT_CARD: 'CREDIT_CARD',
  PaymentType.CASH: 'CASH',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.UNKNOWN: 'UNKNOWN',
  TransactionStatus.IN_PROGRESS: 'IN_PROGRESS',
  TransactionStatus.DONE: 'DONE',
  TransactionStatus.CANCELED: 'CANCELED',
  TransactionStatus.FAILED: 'FAILED',
};

const _$OrderTypeEnumMap = {
  OrderType.DINE_IN: 'DINE_IN',
  OrderType.TAKE_AWAY: 'TAKE_AWAY',
};
