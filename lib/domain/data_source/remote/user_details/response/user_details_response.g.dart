// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsResponse _$UserDetailsResponseFromJson(Map<String, dynamic> json) =>
    UserDetailsResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      userName: json['user_name'] as String?,
      customerId: json['customer_id'],
      locationId: json['location_id'],
      chooseCust: (json['choose_cust'] as num?)?.toInt(),
      isActive: (json['is_active'] as num?)?.toInt(),
      parentMasterId: json['parent_master_id'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserDetailsResponseToJson(
        UserDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'user_name': instance.userName,
      'customer_id': instance.customerId,
      'location_id': instance.locationId,
      'choose_cust': instance.chooseCust,
      'is_active': instance.isActive,
      'parent_master_id': instance.parentMasterId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
