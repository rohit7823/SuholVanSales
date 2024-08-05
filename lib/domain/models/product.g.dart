// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      code: json['code'] as String?,
      alias: json['alias'] as String?,
      secondaryName: json['secondary_name'] as String?,
      remarks: json['remarks'] as String?,
      tax: json['tax'] as String?,
      packings: (json['packings'] as List<dynamic>?)
          ?.map((e) => Packing.fromJson(e as Map<String, dynamic>))
          .toList(),
      units: (json['units'] as List<dynamic>?)
          ?.map((e) => UnitElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'alias': instance.alias,
      'secondary_name': instance.secondaryName,
      'remarks': instance.remarks,
      'tax': instance.tax,
      'packings': instance.packings,
      'units': instance.units,
    };

Packing _$PackingFromJson(Map<String, dynamic> json) => Packing(
      id: (json['id'] as num?)?.toInt(),
      packing: json['packing'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] as String?,
      pivot: json['pivot'] == null
          ? null
          : PackingPivot.fromJson(json['pivot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PackingToJson(Packing instance) => <String, dynamic>{
      'id': instance.id,
      'packing': instance.packing,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'deleted_at': instance.deletedAt,
      'pivot': instance.pivot,
    };

PackingPivot _$PackingPivotFromJson(Map<String, dynamic> json) => PackingPivot(
      productId: (json['product_id'] as num?)?.toInt(),
      packingId: (json['packing_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PackingPivotToJson(PackingPivot instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'packing_id': instance.packingId,
    };

UnitElement _$UnitElementFromJson(Map<String, dynamic> json) => UnitElement(
      id: (json['id'] as num?)?.toInt(),
      name: $enumDecodeNullable(_$NameEnumMap, json['name']),
      unit: $enumDecodeNullable(_$UnitEnumEnumMap, json['unit']),
      unitCode: $enumDecodeNullable(_$UnitEnumEnumMap, json['unit_code']),
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] as String?,
      pivot: json['pivot'] == null
          ? null
          : UnitPivot.fromJson(json['pivot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UnitElementToJson(UnitElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': _$NameEnumMap[instance.name],
      'unit': _$UnitEnumEnumMap[instance.unit],
      'unit_code': _$UnitEnumEnumMap[instance.unitCode],
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'deleted_at': instance.deletedAt,
      'pivot': instance.pivot,
    };

const _$NameEnumMap = {
  Name.BAG: 'Bag',
  Name.BUCKET: 'Bucket',
  Name.BUNDLE: 'Bundle',
  Name.CARTON: 'Carton',
  Name.KILOGRAM: 'Kilogram',
  Name.NET: 'Net',
  Name.PACKET: 'Packet',
  Name.PIECE: 'Piece',
  Name.TRAY: 'Tray',
};

const _$UnitEnumEnumMap = {
  UnitEnum.BAG: 'BAG',
  UnitEnum.BUCKET: 'BUCKET',
  UnitEnum.BUNDLE: 'BUNDLE',
  UnitEnum.CTN: 'CTN',
  UnitEnum.KG: 'KG',
  UnitEnum.NET: 'NET',
  UnitEnum.PCS: 'PCS',
  UnitEnum.PKT: 'PKT',
  UnitEnum.TRAY: 'TRAY',
};

UnitPivot _$UnitPivotFromJson(Map<String, dynamic> json) => UnitPivot(
      productId: (json['product_id'] as num?)?.toInt(),
      unitOfMeasurementId: (json['unit_of_measurement_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UnitPivotToJson(UnitPivot instance) => <String, dynamic>{
      'product_id': instance.productId,
      'unit_of_measurement_id': instance.unitOfMeasurementId,
    };
