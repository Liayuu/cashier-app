import 'dart:convert';

// Removed Cloud Firestore dependency — using local JSON storage instead
import 'package:json_annotation/json_annotation.dart';

part 'sold_model.g.dart';

@JsonSerializable()
class SoldModel {
  String? id;
  String? image;
  String? name;
  double? price;
  int? qty;
  String? transactionId;
  @JsonKey(fromJson: _parseTimestamp, toJson: _parseDateTime)
  DateTime? createdAt;
  SoldModel({
    this.id,
    this.image,
    this.name,
    this.price,
    this.qty,
    this.transactionId,
  });

  SoldModel copyWith({
    String? id,
    String? image,
    String? name,
    double? price,
    int? qty,
    String? transactionId,
  }) {
    return SoldModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      qty: qty ?? this.qty,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'price': price,
      'qty': qty,
      'transactionId': transactionId,
    };
  }

  factory SoldModel.fromMap(Map<String, dynamic> map) {
    return SoldModel(
      id: map['id'],
      image: map['image'],
      name: map['name'],
      price: map['price']?.toDouble(),
      qty: map['qty']?.toInt(),
      transactionId: map['transactionId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SoldModel.fromJson(String source) => SoldModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SoldModel(id: $id, image: $image, name: $name, price: $price, qty: $qty, transactionId: $transactionId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SoldModel &&
        other.id == id &&
        other.image == image &&
        other.name == name &&
        other.price == price &&
        other.qty == qty &&
        other.transactionId == transactionId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        name.hashCode ^
        price.hashCode ^
        qty.hashCode ^
        transactionId.hashCode;
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
