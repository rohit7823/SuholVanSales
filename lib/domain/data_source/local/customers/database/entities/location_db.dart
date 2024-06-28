
import 'package:objectbox/objectbox.dart';
import 'package:suhol_van_sales/domain/data_source/local/customers/database/entities/customer_db.dart';

@Entity()
class LocationDB {

  @Id()
  int? dbId;

  @Unique(onConflict: ConflictStrategy.replace)
  final int? id;

  final String? location;

  final String? companyName;

  final String? addressOne;

  final String? addressTwo;

  final String? phoneNo;

  final String? vatIdentificationNumbers;

  final int? productLastUpdate;

  final String? productLink;

  final String? taxPercentage;

  final ToOne<CustomerDB> customer = ToOne();

  LocationDB({
    this.dbId,
    this.id,
    this.location,
    this.companyName,
    this.addressOne,
    this.addressTwo,
    this.phoneNo,
    this.vatIdentificationNumbers,
    this.productLastUpdate,
    this.productLink,
    this.taxPercentage,
  });

  LocationDB copyWith({
    int? dbId,
    int? id,
    String? location,
    String? companyName,
    String? addressOne,
    String? addressTwo,
    String? phoneNo,
    String? vatIdentificationNumbers,
    int? productLastUpdate,
    String? productLink,
    String? taxPercentage,
  }) {
    return LocationDB(
      dbId: dbId ?? this.dbId,
      id: id ?? this.id,
      location: location ?? this.location,
      companyName: companyName ?? this.companyName,
      addressOne: addressOne ?? this.addressOne,
      addressTwo: addressTwo ?? this.addressTwo,
      phoneNo: phoneNo ?? this.phoneNo,
      vatIdentificationNumbers:
          vatIdentificationNumbers ?? this.vatIdentificationNumbers,
      productLastUpdate: productLastUpdate ?? this.productLastUpdate,
      productLink: productLink ?? this.productLink,
      taxPercentage: taxPercentage ?? this.taxPercentage,
    );
  }
}