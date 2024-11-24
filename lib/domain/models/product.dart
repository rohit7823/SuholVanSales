import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "code")
  final String? code;
  @JsonKey(name: "alias")
  final String? alias;
  @JsonKey(name: "secondary_name")
  final String? secondaryName;
  @JsonKey(name: "remarks")
  final String? remarks;
  @JsonKey(name: "tax")
  final String? tax;
  @JsonKey(name: "packings")
  final List<Packing>? packings;
  @JsonKey(name: "units")
  final List<UnitElement>? units;

  Product({
    this.id,
    this.name,
    this.code,
    this.alias,
    this.secondaryName,
    this.remarks,
    this.tax,
    this.packings,
    this.units,
  });

  Product copyWith({
    int? id,
    String? name,
    String? code,
    String? alias,
    String? secondaryName,
    String? remarks,
    String? tax,
    List<Packing>? packings,
    List<UnitElement>? units,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        alias: alias ?? this.alias,
        secondaryName: secondaryName ?? this.secondaryName,
        remarks: remarks ?? this.remarks,
        tax: tax ?? this.tax,
        packings: packings ?? this.packings,
        units: units ?? this.units,
      );

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Packing {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "packing")
  final String? packing;
  @JsonKey(name: "is_active")
  final int? isActive;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  @JsonKey(name: "deleted_at")
  final String? deletedAt;
  @JsonKey(name: "pivot")
  final PackingPivot? pivot;

  Packing({
    this.id,
    this.packing,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });

  Packing copyWith({
    int? id,
    String? packing,
    int? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? deletedAt,
    PackingPivot? pivot,
  }) =>
      Packing(
        id: id ?? this.id,
        packing: packing ?? this.packing,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        pivot: pivot ?? this.pivot,
      );

  factory Packing.fromJson(Map<String, dynamic> json) =>
      _$PackingFromJson(json);

  Map<String, dynamic> toJson() => _$PackingToJson(this);
}

@JsonSerializable()
class PackingPivot {
  @JsonKey(name: "product_id")
  final int? productId;
  @JsonKey(name: "packing_id")
  final int? packingId;

  PackingPivot({
    this.productId,
    this.packingId,
  });

  PackingPivot copyWith({
    int? productId,
    int? packingId,
  }) =>
      PackingPivot(
        productId: productId ?? this.productId,
        packingId: packingId ?? this.packingId,
      );

  factory PackingPivot.fromJson(Map<String, dynamic> json) =>
      _$PackingPivotFromJson(json);

  Map<String, dynamic> toJson() => _$PackingPivotToJson(this);
}

@JsonSerializable()
class UnitElement {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final Name? name;
  @JsonKey(name: "unit")
  final UnitEnum? unit;
  @JsonKey(name: "unit_code")
  final UnitEnum? unitCode;
  @JsonKey(name: "is_active")
  final int? isActive;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  @JsonKey(name: "deleted_at")
  final String? deletedAt;
  @JsonKey(name: "pivot")
  final UnitPivot? pivot;

  UnitElement({
    this.id,
    this.name,
    this.unit,
    this.unitCode,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });

  UnitElement copyWith({
    int? id,
    Name? name,
    UnitEnum? unit,
    UnitEnum? unitCode,
    int? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? deletedAt,
    UnitPivot? pivot,
  }) =>
      UnitElement(
        id: id ?? this.id,
        name: name ?? this.name,
        unit: unit ?? this.unit,
        unitCode: unitCode ?? this.unitCode,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        pivot: pivot ?? this.pivot,
      );

  factory UnitElement.fromJson(Map<String, dynamic> json) =>
      _$UnitElementFromJson(json);

  Map<String, dynamic> toJson() => _$UnitElementToJson(this);
}

enum Name {
  @JsonValue("Bag")
  BAG,
  @JsonValue("Bucket")
  BUCKET,
  @JsonValue("Bundle")
  BUNDLE,
  @JsonValue("Carton")
  CARTON,
  @JsonValue("Kilogram")
  KILOGRAM,
  @JsonValue("Net")
  NET,
  @JsonValue("Packet")
  PACKET,
  @JsonValue("Piece")
  PIECE,
  @JsonValue("Tray")
  TRAY,
  @JsonValue("Set")
  SET
}

final nameValues = EnumValues({
  "Bag": Name.BAG,
  "Bucket": Name.BUCKET,
  "Bundle": Name.BUNDLE,
  "Carton": Name.CARTON,
  "Kilogram": Name.KILOGRAM,
  "Net": Name.NET,
  "Packet": Name.PACKET,
  "Piece": Name.PIECE,
  "Tray": Name.TRAY,
  "Set": Name.SET
});

@JsonSerializable()
class UnitPivot {
  @JsonKey(name: "product_id")
  final int? productId;
  @JsonKey(name: "unit_of_measurement_id")
  final int? unitOfMeasurementId;

  UnitPivot({
    this.productId,
    this.unitOfMeasurementId,
  });

  UnitPivot copyWith({
    int? productId,
    int? unitOfMeasurementId,
  }) =>
      UnitPivot(
        productId: productId ?? this.productId,
        unitOfMeasurementId: unitOfMeasurementId ?? this.unitOfMeasurementId,
      );

  factory UnitPivot.fromJson(Map<String, dynamic> json) =>
      _$UnitPivotFromJson(json);

  Map<String, dynamic> toJson() => _$UnitPivotToJson(this);
}

enum UnitEnum {
  @JsonValue("BAG")
  BAG,
  @JsonValue("BUCKET")
  BUCKET,
  @JsonValue("BUNDLE")
  BUNDLE,
  @JsonValue("CTN")
  CTN,
  @JsonValue("KG")
  KG,
  @JsonValue("NET")
  NET,
  @JsonValue("PCS")
  PCS,
  @JsonValue("PKT")
  PKT,
  @JsonValue("TRAY")
  TRAY,
  @JsonValue("SET")
  SET
}

final unitEnumValues = EnumValues({
  "BAG": UnitEnum.BAG,
  "BUCKET": UnitEnum.BUCKET,
  "BUNDLE": UnitEnum.BUNDLE,
  "CTN": UnitEnum.CTN,
  "KG": UnitEnum.KG,
  "NET": UnitEnum.NET,
  "PCS": UnitEnum.PCS,
  "PKT": UnitEnum.PKT,
  "TRAY": UnitEnum.TRAY,
  "SET": UnitEnum.SET
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
