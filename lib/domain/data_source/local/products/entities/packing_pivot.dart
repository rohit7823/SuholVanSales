
import 'package:objectbox/objectbox.dart';

@Entity()
class PackingPivotDB {

  @Id()
  int? id;

  final int? productId;

  final int? packingId;

  PackingPivotDB({
    this.id = 0,
    this.productId,
    this.packingId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'productId': this.productId,
      'packingId': this.packingId,
    };
  }

  factory PackingPivotDB.fromMap(Map<String, dynamic> map) {
    return PackingPivotDB(
      id: map['id'] as int,
      productId: map['productId'] as int,
      packingId: map['packingId'] as int,
    );
  }
}