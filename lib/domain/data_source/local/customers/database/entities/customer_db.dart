
import 'package:objectbox/objectbox.dart';

import 'location_db.dart';

@Entity()
class CustomerDB {

  @Id()
  int? dbId;

  final int? id;

  final String? name;

  @Unique(onConflict: ConflictStrategy.replace)
  final String? customerCode;

  final String? address;

  final String? location;

  final String? mobileNumber;

  final String? email;

  final String? contactPerson;

  final int? status;

  final int? productLastUpdate;

  @Backlink('customer')
  final ToMany<LocationDB> locations = ToMany();

  CustomerDB({
     this.dbId = 0,
    this.id,
    this.name,
    this.customerCode,
    this.address,
    this.location,
    this.mobileNumber,
    this.email,
    this.contactPerson,
    this.status,
    this.productLastUpdate,
  });

  CustomerDB copyWith({
    int? dbId,
    int? id,
    String? name,
    String? customerCode,
    String? address,
    String? location,
    String? mobileNumber,
    String? email,
    String? contactPerson,
    int? status,
    int? productLastUpdate,
    List<LocationDB>? locations,
  }) {
    return CustomerDB(
      dbId: dbId ?? this.dbId,
      id: id ?? this.id,
      name: name ?? this.name,
      customerCode: customerCode ?? this.customerCode,
      address: address ?? this.address,
      location: location ?? this.location,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      contactPerson: contactPerson ?? this.contactPerson,
      status: status ?? this.status,
      productLastUpdate: productLastUpdate ?? this.productLastUpdate,
    );
  }
}