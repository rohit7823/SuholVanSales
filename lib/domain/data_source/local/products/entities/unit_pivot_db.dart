import 'package:objectbox/objectbox.dart';


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
      'dbId': dbId,
      'productId': productId,
      'unitOfMeasurementId': unitOfMeasurementId,
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