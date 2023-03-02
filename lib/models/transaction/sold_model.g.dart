// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sold_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SoldModel _$SoldModelFromJson(Map<String, dynamic> json) => SoldModel(
      id: json['id'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      qty: json['qty'] as int?,
      transactionId: json['transactionId'] as String?,
    )..createdAt = _parseTimestamp(json['createdAt']);

Map<String, dynamic> _$SoldModelToJson(SoldModel instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'price': instance.price,
      'qty': instance.qty,
      'transactionId': instance.transactionId,
      'createdAt': _parseDateTime(instance.createdAt),
    };
