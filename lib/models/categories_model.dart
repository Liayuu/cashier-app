import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cashier_app/controllers/enums/status_enum.dart';
import 'package:cashier_app/models/menu/menus_model.dart';

part 'categories_model.g.dart';

@JsonSerializable()
class CategoriesModel {
  String? id;
  List<String>? appliedAt;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? createdAt;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? updatedAt;
  List<String>? items;
  String? logo;
  String? merchantId;
  String? name;
  StatusEnum? status;
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<MenuModel>? menus;
  @JsonKey(includeToJson: false, includeFromJson: false)
  bool isChoosed;
  CategoriesModel({
    this.id,
    this.appliedAt,
    this.createdAt,
    this.updatedAt,
    this.items,
    this.logo,
    this.merchantId,
    this.name,
    this.status,
    this.menus,
    this.isChoosed = false,
  });

  CategoriesModel copyWith({
    String? id,
    List<String>? appliedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? items,
    String? logo,
    String? merchantId,
    String? name,
    StatusEnum? status,
    List<MenuModel>? menus,
    bool? isChoosed,
  }) {
    return CategoriesModel(
      id: id ?? this.id,
      appliedAt: appliedAt ?? this.appliedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
      logo: logo ?? this.logo,
      merchantId: merchantId ?? this.merchantId,
      name: name ?? this.name,
      status: status ?? this.status,
      menus: menus ?? this.menus,
      isChoosed: isChoosed ?? this.isChoosed,
    );
  }

  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);

  factory CategoriesModel.fromJson(String id, Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json)..id = id;

  @override
  String toString() {
    return 'CategoriesModel(id: $id, appliedAt: $appliedAt, createdAt: $createdAt, updatedAt: $updatedAt, items: $items, logo: $logo, merchantId: $merchantId, name: $name, status: $status, menus: $menus, isChoosed: $isChoosed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoriesModel &&
        other.id == id &&
        listEquals(other.appliedAt, appliedAt) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.items, items) &&
        other.logo == logo &&
        other.merchantId == merchantId &&
        other.name == name &&
        other.status == status &&
        listEquals(other.menus, menus) &&
        other.isChoosed == isChoosed;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        appliedAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        items.hashCode ^
        logo.hashCode ^
        merchantId.hashCode ^
        name.hashCode ^
        status.hashCode ^
        menus.hashCode ^
        isChoosed.hashCode;
  }
}

DateTime _parseTimestamp(_) {
  return DateTime.parse(_.toDate().toString());
}

Timestamp _parseDateTime(_) {
  return Timestamp.fromMicrosecondsSinceEpoch(_.microsecondsSinceEpoch);
}
