// To parse this JSON data, do
//
//     final customerDetails = customerDetailsFromJson(jsonString);

class Customer {
  final int? id;
  final String? name;
  final String? customerCode;
  final String? address;
  final String? location;
  final String? mobileNumber;
  final String? email;
  final String? contactPerson;
  final int? status;
  final int? productLastUpdate;
  final int? creditLimit;
  final List<Location>? locations;

  Customer(
      {this.id,
      this.name,
      this.customerCode,
      this.address,
      this.location,
      this.mobileNumber,
      this.email,
      this.contactPerson,
      this.status,
      this.productLastUpdate,
      this.locations,
      this.creditLimit});

  Customer copyWith(
          {int? id,
          String? name,
          String? customerCode,
          String? address,
          String? location,
          String? mobileNumber,
          dynamic email,
          String? contactPerson,
          int? status,
          int? productLastUpdate,
          List<Location>? locations,
          int? creditLimit}) =>
      Customer(
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
          locations: locations ?? this.locations,
          creditLimit: creditLimit ?? this.creditLimit);

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        customerCode: json["customer_code"],
        address: json["address"],
        location: json["location"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        contactPerson: json["contact_person"],
        status: json["status"],
        productLastUpdate: json["product_last_update"],
        creditLimit: json['credit_limit'],
        locations: json["locations"] == null
            ? []
            : List<Location>.from(
                json["locations"]!.map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "customer_code": customerCode,
        "address": address,
        "location": location,
        "mobile_number": mobileNumber,
        "email": email,
        "contact_person": contactPerson,
        "status": status,
        "product_last_update": productLastUpdate,
        "credit_limit": creditLimit,
        "locations": locations == null
            ? []
            : List<dynamic>.from(locations!.map((x) => x.toJson())),
      };
}

class Location {
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

  Location({
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

  Location copyWith({
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
  }) =>
      Location(
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

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        location: json["name"],
        companyName: json["company_name"],
        addressOne: json["address_one"],
        addressTwo: json["address_two"],
        phoneNo: json["phone_no"],
        vatIdentificationNumbers: json["vat_identification_numbers"],
        productLastUpdate: json["product_last_update"],
        productLink: json["product_link"],
        taxPercentage: json["tax_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": location,
        "company_name": companyName,
        "address_one": addressOne,
        "address_two": addressTwo,
        "phone_no": phoneNo,
        "vat_identification_numbers": vatIdentificationNumbers,
        "product_last_update": productLastUpdate,
        "product_link": productLink,
        "tax_percentage": taxPercentage,
      };
}
