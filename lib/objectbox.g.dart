// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'domain/data_source/local/customers/database/entities/customer_db.dart';
import 'domain/data_source/local/customers/database/entities/location_db.dart';
import 'domain/data_source/local/user_onboarding/entities/user_onboarding.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 5041284436545111150),
      name: 'UserOnboardingDB',
      lastPropertyId: const obx_int.IdUid(5, 5255707488209083901),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 6848720784125357198),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 7050663894963723718),
            name: 'type',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 4203414942558065778),
            name: 'email',
            type: 9,
            flags: 2080,
            indexId: const obx_int.IdUid(1, 8925096414687129722)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 3742195171834776398),
            name: 'password',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 5255707488209083901),
            name: 'name',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(2, 6131967375078645504),
      name: 'CustomerDB',
      lastPropertyId: const obx_int.IdUid(11, 627490010596632961),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 3388843248533614679),
            name: 'dbId',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 5379432188985337398),
            name: 'id',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 464977096738435218),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 363815866886794073),
            name: 'customerCode',
            type: 9,
            flags: 34848,
            indexId: const obx_int.IdUid(2, 5305971489603994781)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 4880848964137733132),
            name: 'address',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 3813630779558720209),
            name: 'location',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 659075066386520487),
            name: 'mobileNumber',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 7885872711388023320),
            name: 'email',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(9, 5282529735638178440),
            name: 'contactPerson',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(10, 8911894758372651432),
            name: 'status',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(11, 627490010596632961),
            name: 'productLastUpdate',
            type: 6,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[
        obx_int.ModelBacklink(
            name: 'locations', srcEntity: 'LocationDB', srcField: 'customer')
      ]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(3, 233472042212897484),
      name: 'LocationDB',
      lastPropertyId: const obx_int.IdUid(12, 5267495067861839092),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 1008075127447574168),
            name: 'dbId',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 5229870451099884409),
            name: 'id',
            type: 6,
            flags: 32808,
            indexId: const obx_int.IdUid(3, 7161433149071085946)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 6010496149995391873),
            name: 'location',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 1102073677338724232),
            name: 'companyName',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 9190247011588409803),
            name: 'addressOne',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 6106021439434567653),
            name: 'addressTwo',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 8214121007520038174),
            name: 'phoneNo',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 3719461189916877829),
            name: 'vatIdentificationNumbers',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(9, 6446416009597254274),
            name: 'productLastUpdate',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(10, 6415828049400270089),
            name: 'productLink',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(11, 1386037284121318976),
            name: 'taxPercentage',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(12, 5267495067861839092),
            name: 'customerId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(4, 2245628043200504319),
            relationTarget: 'CustomerDB')
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(3, 233472042212897484),
      lastIndexId: const obx_int.IdUid(4, 2245628043200504319),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    UserOnboardingDB: obx_int.EntityDefinition<UserOnboardingDB>(
        model: _entities[0],
        toOneRelations: (UserOnboardingDB object) => [],
        toManyRelations: (UserOnboardingDB object) => {},
        getId: (UserOnboardingDB object) => object.id,
        setId: (UserOnboardingDB object, int id) {
          object.id = id;
        },
        objectToFB: (UserOnboardingDB object, fb.Builder fbb) {
          final typeOffset =
              object.type == null ? null : fbb.writeString(object.type!);
          final emailOffset =
              object.email == null ? null : fbb.writeString(object.email!);
          final passwordOffset = object.password == null
              ? null
              : fbb.writeString(object.password!);
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, typeOffset);
          fbb.addOffset(2, emailOffset);
          fbb.addOffset(3, passwordOffset);
          fbb.addOffset(4, nameOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 12);
          final emailParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final passwordParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 10);
          final typeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final object = UserOnboardingDB(
              id: idParam,
              name: nameParam,
              email: emailParam,
              password: passwordParam,
              type: typeParam);

          return object;
        }),
    CustomerDB: obx_int.EntityDefinition<CustomerDB>(
        model: _entities[1],
        toOneRelations: (CustomerDB object) => [],
        toManyRelations: (CustomerDB object) => {
              obx_int.RelInfo<LocationDB>.toOneBacklink(12, object.dbId!,
                      (LocationDB srcObject) => srcObject.customer):
                  object.locations
            },
        getId: (CustomerDB object) => object.dbId,
        setId: (CustomerDB object, int id) {
          object.dbId = id;
        },
        objectToFB: (CustomerDB object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final customerCodeOffset = object.customerCode == null
              ? null
              : fbb.writeString(object.customerCode!);
          final addressOffset =
              object.address == null ? null : fbb.writeString(object.address!);
          final locationOffset = object.location == null
              ? null
              : fbb.writeString(object.location!);
          final mobileNumberOffset = object.mobileNumber == null
              ? null
              : fbb.writeString(object.mobileNumber!);
          final emailOffset =
              object.email == null ? null : fbb.writeString(object.email!);
          final contactPersonOffset = object.contactPerson == null
              ? null
              : fbb.writeString(object.contactPerson!);
          fbb.startTable(12);
          fbb.addInt64(0, object.dbId ?? 0);
          fbb.addInt64(1, object.id);
          fbb.addOffset(2, nameOffset);
          fbb.addOffset(3, customerCodeOffset);
          fbb.addOffset(4, addressOffset);
          fbb.addOffset(5, locationOffset);
          fbb.addOffset(6, mobileNumberOffset);
          fbb.addOffset(7, emailOffset);
          fbb.addOffset(8, contactPersonOffset);
          fbb.addInt64(9, object.status);
          fbb.addInt64(10, object.productLastUpdate);
          fbb.finish(fbb.endTable());
          return object.dbId ?? 0;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final dbIdParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);
          final idParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 6);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final customerCodeParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10);
          final addressParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 12);
          final locationParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 14);
          final mobileNumberParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 16);
          final emailParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 18);
          final contactPersonParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 20);
          final statusParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 22);
          final productLastUpdateParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 24);
          final object = CustomerDB(
              dbId: dbIdParam,
              id: idParam,
              name: nameParam,
              customerCode: customerCodeParam,
              address: addressParam,
              location: locationParam,
              mobileNumber: mobileNumberParam,
              email: emailParam,
              contactPerson: contactPersonParam,
              status: statusParam,
              productLastUpdate: productLastUpdateParam);
          obx_int.InternalToManyAccess.setRelInfo<CustomerDB>(
              object.locations,
              store,
              obx_int.RelInfo<LocationDB>.toOneBacklink(12, object.dbId!,
                  (LocationDB srcObject) => srcObject.customer));
          return object;
        }),
    LocationDB: obx_int.EntityDefinition<LocationDB>(
        model: _entities[2],
        toOneRelations: (LocationDB object) => [object.customer],
        toManyRelations: (LocationDB object) => {},
        getId: (LocationDB object) => object.dbId,
        setId: (LocationDB object, int id) {
          object.dbId = id;
        },
        objectToFB: (LocationDB object, fb.Builder fbb) {
          final locationOffset = object.location == null
              ? null
              : fbb.writeString(object.location!);
          final companyNameOffset = object.companyName == null
              ? null
              : fbb.writeString(object.companyName!);
          final addressOneOffset = object.addressOne == null
              ? null
              : fbb.writeString(object.addressOne!);
          final addressTwoOffset = object.addressTwo == null
              ? null
              : fbb.writeString(object.addressTwo!);
          final phoneNoOffset =
              object.phoneNo == null ? null : fbb.writeString(object.phoneNo!);
          final vatIdentificationNumbersOffset =
              object.vatIdentificationNumbers == null
                  ? null
                  : fbb.writeString(object.vatIdentificationNumbers!);
          final productLinkOffset = object.productLink == null
              ? null
              : fbb.writeString(object.productLink!);
          final taxPercentageOffset = object.taxPercentage == null
              ? null
              : fbb.writeString(object.taxPercentage!);
          fbb.startTable(13);
          fbb.addInt64(0, object.dbId ?? 0);
          fbb.addInt64(1, object.id);
          fbb.addOffset(2, locationOffset);
          fbb.addOffset(3, companyNameOffset);
          fbb.addOffset(4, addressOneOffset);
          fbb.addOffset(5, addressTwoOffset);
          fbb.addOffset(6, phoneNoOffset);
          fbb.addOffset(7, vatIdentificationNumbersOffset);
          fbb.addInt64(8, object.productLastUpdate);
          fbb.addOffset(9, productLinkOffset);
          fbb.addOffset(10, taxPercentageOffset);
          fbb.addInt64(11, object.customer.targetId);
          fbb.finish(fbb.endTable());
          return object.dbId ?? 0;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final dbIdParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);
          final idParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 6);
          final locationParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final companyNameParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10);
          final addressOneParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 12);
          final addressTwoParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 14);
          final phoneNoParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 16);
          final vatIdentificationNumbersParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 18);
          final productLastUpdateParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 20);
          final productLinkParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 22);
          final taxPercentageParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 24);
          final object = LocationDB(
              dbId: dbIdParam,
              id: idParam,
              location: locationParam,
              companyName: companyNameParam,
              addressOne: addressOneParam,
              addressTwo: addressTwoParam,
              phoneNo: phoneNoParam,
              vatIdentificationNumbers: vatIdentificationNumbersParam,
              productLastUpdate: productLastUpdateParam,
              productLink: productLinkParam,
              taxPercentage: taxPercentageParam);
          object.customer.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 26, 0);
          object.customer.attach(store);
          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [UserOnboardingDB] entity fields to define ObjectBox queries.
class UserOnboardingDB_ {
  /// See [UserOnboardingDB.id].
  static final id =
      obx.QueryIntegerProperty<UserOnboardingDB>(_entities[0].properties[0]);

  /// See [UserOnboardingDB.type].
  static final type =
      obx.QueryStringProperty<UserOnboardingDB>(_entities[0].properties[1]);

  /// See [UserOnboardingDB.email].
  static final email =
      obx.QueryStringProperty<UserOnboardingDB>(_entities[0].properties[2]);

  /// See [UserOnboardingDB.password].
  static final password =
      obx.QueryStringProperty<UserOnboardingDB>(_entities[0].properties[3]);

  /// See [UserOnboardingDB.name].
  static final name =
      obx.QueryStringProperty<UserOnboardingDB>(_entities[0].properties[4]);
}

/// [CustomerDB] entity fields to define ObjectBox queries.
class CustomerDB_ {
  /// See [CustomerDB.dbId].
  static final dbId =
      obx.QueryIntegerProperty<CustomerDB>(_entities[1].properties[0]);

  /// See [CustomerDB.id].
  static final id =
      obx.QueryIntegerProperty<CustomerDB>(_entities[1].properties[1]);

  /// See [CustomerDB.name].
  static final name =
      obx.QueryStringProperty<CustomerDB>(_entities[1].properties[2]);

  /// See [CustomerDB.customerCode].
  static final customerCode =
      obx.QueryStringProperty<CustomerDB>(_entities[1].properties[3]);

  /// See [CustomerDB.address].
  static final address =
      obx.QueryStringProperty<CustomerDB>(_entities[1].properties[4]);

  /// See [CustomerDB.location].
  static final location =
      obx.QueryStringProperty<CustomerDB>(_entities[1].properties[5]);

  /// See [CustomerDB.mobileNumber].
  static final mobileNumber =
      obx.QueryStringProperty<CustomerDB>(_entities[1].properties[6]);

  /// See [CustomerDB.email].
  static final email =
      obx.QueryStringProperty<CustomerDB>(_entities[1].properties[7]);

  /// See [CustomerDB.contactPerson].
  static final contactPerson =
      obx.QueryStringProperty<CustomerDB>(_entities[1].properties[8]);

  /// See [CustomerDB.status].
  static final status =
      obx.QueryIntegerProperty<CustomerDB>(_entities[1].properties[9]);

  /// See [CustomerDB.productLastUpdate].
  static final productLastUpdate =
      obx.QueryIntegerProperty<CustomerDB>(_entities[1].properties[10]);

  /// see [CustomerDB.locations]
  static final locations =
      obx.QueryBacklinkToMany<LocationDB, CustomerDB>(LocationDB_.customer);
}

/// [LocationDB] entity fields to define ObjectBox queries.
class LocationDB_ {
  /// See [LocationDB.dbId].
  static final dbId =
      obx.QueryIntegerProperty<LocationDB>(_entities[2].properties[0]);

  /// See [LocationDB.id].
  static final id =
      obx.QueryIntegerProperty<LocationDB>(_entities[2].properties[1]);

  /// See [LocationDB.location].
  static final location =
      obx.QueryStringProperty<LocationDB>(_entities[2].properties[2]);

  /// See [LocationDB.companyName].
  static final companyName =
      obx.QueryStringProperty<LocationDB>(_entities[2].properties[3]);

  /// See [LocationDB.addressOne].
  static final addressOne =
      obx.QueryStringProperty<LocationDB>(_entities[2].properties[4]);

  /// See [LocationDB.addressTwo].
  static final addressTwo =
      obx.QueryStringProperty<LocationDB>(_entities[2].properties[5]);

  /// See [LocationDB.phoneNo].
  static final phoneNo =
      obx.QueryStringProperty<LocationDB>(_entities[2].properties[6]);

  /// See [LocationDB.vatIdentificationNumbers].
  static final vatIdentificationNumbers =
      obx.QueryStringProperty<LocationDB>(_entities[2].properties[7]);

  /// See [LocationDB.productLastUpdate].
  static final productLastUpdate =
      obx.QueryIntegerProperty<LocationDB>(_entities[2].properties[8]);

  /// See [LocationDB.productLink].
  static final productLink =
      obx.QueryStringProperty<LocationDB>(_entities[2].properties[9]);

  /// See [LocationDB.taxPercentage].
  static final taxPercentage =
      obx.QueryStringProperty<LocationDB>(_entities[2].properties[10]);

  /// See [LocationDB.customer].
  static final customer = obx.QueryRelationToOne<LocationDB, CustomerDB>(
      _entities[2].properties[11]);
}
