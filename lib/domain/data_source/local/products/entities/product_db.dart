import 'package:objectbox/objectbox.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/packing_db.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/unit_element_db.dart';

@Entity()
class ProductDB {
  @Id()
  int? dbId;

  final int? id;
  final String? name;

  @Unique(onConflict: ConflictStrategy.replace)
  final String? code;

  final String? alias;
  final String? secondaryName;
  final String? remarks;
  final String? tax;

  @Backlink('product')
  final ToMany<PackingDB> packings = ToMany();

  @Backlink('product')
  final ToMany<UnitElementDB> units = ToMany();

  ProductDB({
    this.dbId = 0,
    this.id,
    this.name,
    this.code,
    this.alias,
    this.secondaryName,
    this.remarks,
    this.tax
  });


}
