import 'package:objectbox/objectbox.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/packing_pivot.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/product_db.dart';

@Entity()
class PackingDB {
  @Id()
  int? dbId;

  final int? id;
  final String? packing;
  final int? isActive;

  @Property(type: PropertyType.date)
  final DateTime? createdAt;

  @Property(type: PropertyType.date)
  final DateTime? updatedAt;

  final String? deletedAt;

  final PackingPivotDB? pivot;

  final ToOne<ProductDB> product = ToOne();

  PackingDB({
    this.dbId = 0,
    this.id,
    this.packing,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });
}