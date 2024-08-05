
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
}