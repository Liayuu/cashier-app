
// Removed Cloud Firestore dependency — using local JSON storage instead
import 'package:json_annotation/json_annotation.dart';

import 'package:cashier_app/controllers/enums/status_enum.dart';

part 'customization_group_model.g.dart';

@JsonSerializable()
class CustomizationGroupModel {
  String? id;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? createdAt;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? updatedAt;
  @JsonKey(name: 'default')
  bool? initValue;
  String? name;
  StatusEnum? status;
  CustomizationGroupModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.initValue,
    this.name,
    this.status,
  });

  CustomizationGroupModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? initValue,
    String? name,
    StatusEnum? status,
  }) {
    return CustomizationGroupModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      initValue: initValue ?? this.initValue,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() => _$CustomizationGroupModelToJson(this);

  factory CustomizationGroupModel.fromJson(Map<String, dynamic> json) =>
      _$CustomizationGroupModelFromJson(json);

  @override
  String toString() {
    return 'CustomizationGroupModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, initValue: $initValue, name: $name, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomizationGroupModel &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.initValue == initValue &&
        other.name == name &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        initValue.hashCode ^
        name.hashCode ^
        status.hashCode;
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
