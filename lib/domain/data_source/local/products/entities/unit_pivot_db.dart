import 'package:objectbox/objectbox.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/unit_element_db.dart';


@Entity()
class UnitPivotDB {
  @Id()
  int? dbId;

  final int? productId;

  final int? unitOfMeasurementId;

  UnitPivotDB({
    this.dbId = 0,
    this.productId,
    this.unitOfMeasurementId,
  });

  Map<String, dynamic> toMap() {
    return {
      'dbId': this.dbId,
      'productId': this.productId,
      'unitOfMeasurementId': this.unitOfMeasurementId,
    };
  }

  factory UnitPivotDB.fromMap(Map<String, dynamic> map) {
    return UnitPivotDB(
      dbId: map['dbId'] as int,
      productId: map['productId'] as int,
      unitOfMeasurementId: map['unitOfMeasurementId'] as int,
    );
  }
}