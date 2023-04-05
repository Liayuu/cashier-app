import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cashier_app/controllers/enums/status_enum.dart';
import 'package:cashier_app/models/menu/price_model.dart';
import 'package:cashier_app/models/promotion/promotion_model.dart';

part 'menus_model.g.dart';

@JsonSerializable()
class MenuModel {
  @JsonKey(includeIfNull: false)
  String? id;
  String? barcode;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? createdAt;
  String? description;
  String? menuAt;
  String? name;
  String? sku;
  @JsonKey(includeIfNull: false)
  int? qty;
  @JsonKey(includeIfNull: false)
  double? buyingPrice;
  String? image;
  List<String>? specifiedAt;
  StatusEnum? status;
  @JsonKey(name: 'price')
  double? singlePrice;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? updatedAt;
  @JsonKey(includeFromJson: false, includeToJson: false)
  PriceModel? price;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? newImage;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? downloadLink;
  @JsonKey(includeIfNull: false)
  String? note;
  @JsonKey(includeFromJson: false, includeToJson: false)
  PromotionModel? promo;
  MenuModel({
    this.id,
    this.barcode,
    this.createdAt,
    this.description,
    this.menuAt,
    this.name,
    this.sku,
    this.qty,
    this.buyingPrice,
    this.image,
    this.specifiedAt,
    this.status,
    this.singlePrice,
    this.updatedAt,
    this.price,
    this.newImage,
    this.downloadLink,
    this.note,
    this.promo,
  });

  MenuModel copyWith({
    String? id,
    String? barcode,
    DateTime? createdAt,
    String? description,
    String? menuAt,
    String? name,
    String? sku,
    int? qty,
    double? buyingPrice,
    String? image,
    List<String>? specifiedAt,
    StatusEnum? status,
    double? singlePrice,
    DateTime? updatedAt,
    PriceModel? price,
    String? newImage,
    String? downloadLink,
    String? note,
    PromotionModel? promo,
  }) {
    return MenuModel(
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      menuAt: menuAt ?? this.menuAt,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      qty: qty ?? this.qty,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      image: image ?? this.image,
      specifiedAt: specifiedAt ?? this.specifiedAt,
      status: status ?? this.status,
      singlePrice: singlePrice ?? this.singlePrice,
      updatedAt: updatedAt ?? this.updatedAt,
      price: price ?? this.price,
      newImage: newImage ?? this.newImage,
      downloadLink: downloadLink ?? this.downloadLink,
      note: note ?? this.note,
      promo: promo ?? this.promo,
    );
  }

  Map<String, dynamic> toJson() => _$MenuModelToJson(this);

  factory MenuModel.fromJson(String id, Map<String, dynamic> json) =>
      _$MenuModelFromJson(json)..id = id;

  @override
  String toString() {
    return 'MenuModel(id: $id, barcode: $barcode, createdAt: $createdAt, description: $description, menuAt: $menuAt, name: $name, sku: $sku, qty: $qty, buyingPrice: $buyingPrice, image: $image, specifiedAt: $specifiedAt, status: $status, singlePrice: $singlePrice, updatedAt: $updatedAt, price: $price, newImage: $newImage, downloadLink: $downloadLink, note: $note, promo: $promo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MenuModel &&
        other.id == id &&
        other.barcode == barcode &&
        other.createdAt == createdAt &&
        other.description == description &&
        other.menuAt == menuAt &&
        other.name == name &&
        other.sku == sku &&
        other.qty == qty &&
        other.buyingPrice == buyingPrice &&
        other.image == image &&
        listEquals(other.specifiedAt, specifiedAt) &&
        other.status == status &&
        other.singlePrice == singlePrice &&
        other.updatedAt == updatedAt &&
        other.price == price &&
        other.newImage == newImage &&
        other.downloadLink == downloadLink &&
        other.note == note &&
        other.promo == promo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        barcode.hashCode ^
        createdAt.hashCode ^
        description.hashCode ^
        menuAt.hashCode ^
        name.hashCode ^
        sku.hashCode ^
        qty.hashCode ^
        buyingPrice.hashCode ^
        image.hashCode ^
        specifiedAt.hashCode ^
        status.hashCode ^
        singlePrice.hashCode ^
        updatedAt.hashCode ^
        price.hashCode ^
        newImage.hashCode ^
        downloadLink.hashCode ^
        note.hashCode ^
        promo.hashCode;
  }
}

DateTime _parseTimestamp(_) {
  return DateTime.parse(_.toDate().toString());
}

Timestamp _parseDateTime(_) {
  return Timestamp.fromMicrosecondsSinceEpoch(_.microsecondsSinceEpoch);
}
