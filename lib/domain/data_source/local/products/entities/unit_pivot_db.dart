
import 'package:objectbox/objectbox.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/unit_element_db.dart';



@Entity()
class UnitPivotDB {
  @Id()
  int? dbId;

  final int? productId;
  final int? unitOfMeasurementId;


  final ToOne<UnitElementDB> unitElement = ToOne();

  UnitPivotDB({
    this.dbId = 0,
    this.productId,
    this.unitOfMeasurementId,
  });
}