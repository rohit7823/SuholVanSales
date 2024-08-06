import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/product_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/unit_pivot_db.dart';

import '../../../../models/product.dart';

@Entity()
class UnitElementDB {
  @Id()
  int? dbID;

  final int? id;

  @Transient()
  Name? name;

  @Transient()
  UnitEnum? unit;

  @Transient()
  UnitEnum? unitCode;

  final int? isActive;

  @Property(type: PropertyType.date)
  final DateTime? createdAt;

  @Property(type: PropertyType.date)
  final DateTime? updatedAt;

  final String? deletedAt;

  @Transient()
  UnitPivotDB? pivot;

  final ToOne<ProductDB> product = ToOne();

  int? get dbName {
    return name?.index;
  }

  set dbName(int? value) {
    if (value == null) {
      name = null;
    } else {
      name =
          value >= 0 && value < Name.values.length ? Name.values[value] : null;
    }
  }

  int? get dbUnit {
    return unit?.index;
  }

  set dbUnit(int? value) {
    if (value == null) {
      unit = null;
    } else {
      unit = value >= 0 && value < UnitEnum.values.length
          ? UnitEnum.values[value]
          : null;
    }
  }

  int? get dbUnitCode {
    return unit?.index;
  }

  set dbUnitCode(int? value) {
    if (value == null) {
      unitCode = null;
    } else {
      unitCode = value >= 0 && value < UnitEnum.values.length
          ? UnitEnum.values[value]
          : null;
    }
  }

  String? get dbPivot => json.encode(pivot?.toMap());

  set dbPivot(String? jsonStr) {
    if (jsonStr == null) {
      pivot = null;
    } else {
      pivot = UnitPivotDB.fromMap(json.decode(jsonStr));
    }
  }

  UnitElementDB({
    this.dbID,
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
}
