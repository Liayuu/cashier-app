
// Removed Cloud Firestore dependency — using local JSON storage instead
import 'package:json_annotation/json_annotation.dart';

import 'package:cashier_app/controllers/enums/merchant_type_enum.dart';
import 'package:cashier_app/controllers/enums/status_enum.dart';

part 'merchant_model.g.dart';

@JsonSerializable()
class MerchantModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? createdAt;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? updatedAt;
  String? name;
  String? logo;
  String? background;
  StatusEnum? status;
  MerchantType? type;
  MerchantModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.logo,
    this.background,
    this.status,
    this.type,
  });

  MerchantModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? logo,
    String? background,
    StatusEnum? status,
    MerchantType? type,
  }) {
    return MerchantModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      background: background ?? this.background,
      status: status ?? this.status,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() => _$MerchantModelToJson(this);

  factory MerchantModel.fromJson(String id, Map<String, dynamic> json) =>
      _$MerchantModelFromJson(json)..id = id;

  @override
  String toString() {
    return 'MerchantModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, logo: $logo, background: $background, status: $status, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MerchantModel &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.name == name &&
        other.logo == logo &&
        other.background == background &&
        other.status == status &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        name.hashCode ^
        logo.hashCode ^
        background.hashCode ^
        status.hashCode ^
        type.hashCode;
  }
}

DateTime _parseTimestamp(dynamic value) {
  if (value == null) return DateTime.fromMillisecondsSinceEpoch(0);
  if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
  if (value is String) return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
  if (value is Map) {
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
