import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:cashier_app/controllers/enums/branch_type_enum.dart';
import 'package:cashier_app/controllers/enums/status_enum.dart';

part 'branch_model.g.dart';

@JsonSerializable()
class BranchModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;
  String? address;
  BranchType? branchType;
  String? country;
  String? disctrict;
  @JsonKey(includeIfNull: true)
  String? logo;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? logoUrl;
  @JsonKey(includeIfNull: true)
  String? background;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? backgroundUrl;
  @JsonKey(includeIfNull: false)
  dynamic map;
  String? posCode;
  String? province;
  double? rating;
  String? regency;
  StatusEnum? status;
  BranchModel({
    this.id,
    this.address,
    this.branchType,
    this.country,
    this.disctrict,
    this.logo,
    this.logoUrl,
    this.background,
    this.backgroundUrl,
    this.map,
    this.posCode,
    this.province,
    this.rating,
    this.regency,
    this.status,
  });

  BranchModel copyWith({
    String? id,
    String? address,
    BranchType? branchType,
    String? country,
    String? disctrict,
    String? logo,
    String? logoUrl,
    String? background,
    String? backgroundUrl,
    dynamic map,
    String? posCode,
    String? province,
    double? rating,
    String? regency,
    StatusEnum? status,
  }) {
    return BranchModel(
      id: id ?? this.id,
      address: address ?? this.address,
      branchType: branchType ?? this.branchType,
      country: country ?? this.country,
      disctrict: disctrict ?? this.disctrict,
      logo: logo ?? this.logo,
      logoUrl: logoUrl ?? this.logoUrl,
      background: background ?? this.background,
      backgroundUrl: backgroundUrl ?? this.backgroundUrl,
      map: map ?? this.map,
      posCode: posCode ?? this.posCode,
      province: province ?? this.province,
      rating: rating ?? this.rating,
      regency: regency ?? this.regency,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() => _$BranchModelToJson(this);

  factory BranchModel.fromJson(String id, Map<String, dynamic> json) =>
      _$BranchModelFromJson(json)..id = id;

  @override
  String toString() {
    return 'BranchModel(id: $id, address: $address, branchType: $branchType, country: $country, disctrict: $disctrict, logo: $logo, logoUrl: $logoUrl, background: $background, backgroundUrl: $backgroundUrl, map: $map, posCode: $posCode, province: $province, rating: $rating, regency: $regency, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BranchModel &&
        other.id == id &&
        other.address == address &&
        other.branchType == branchType &&
        other.country == country &&
        other.disctrict == disctrict &&
        other.logo == logo &&
        other.logoUrl == logoUrl &&
        other.background == background &&
        other.backgroundUrl == backgroundUrl &&
        other.map == map &&
        other.posCode == posCode &&
        other.province == province &&
        other.rating == rating &&
        other.regency == regency &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        address.hashCode ^
        branchType.hashCode ^
        country.hashCode ^
        disctrict.hashCode ^
        logo.hashCode ^
        logoUrl.hashCode ^
        background.hashCode ^
        backgroundUrl.hashCode ^
        map.hashCode ^
        posCode.hashCode ^
        province.hashCode ^
        rating.hashCode ^
        regency.hashCode ^
        status.hashCode;
  }
}
