import 'package:json_annotation/json_annotation.dart';

part 'user_details_response.g.dart';

@JsonSerializable()
class UserDetailsResponse {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "user_name")
  final String? userName;
  @JsonKey(name: "customer_id")
  final int? customerId;
  @JsonKey(name: "location_id")
  final int? locationId;
  @JsonKey(name: "choose_cust")
  final int? chooseCust;
  @JsonKey(name: "is_active")
  final int? isActive;
  @JsonKey(name: "parent_master_id")
  final int? parentMasterId;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  UserDetailsResponse({
    this.id,
    this.name,
    this.userName,
    this.customerId,
    this.locationId,
    this.chooseCust,
    this.isActive,
    this.parentMasterId,
    this.createdAt,
    this.updatedAt,
  });

  UserDetailsResponse copyWith({
    int? id,
    String? name,
    String? userName,
    int? customerId,
    int? locationId,
    int? chooseCust,
    int? isActive,
    int? parentMasterId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserDetailsResponse(
        id: id ?? this.id,
        name: name ?? this.name,
        userName: userName ?? this.userName,
        customerId: customerId ?? this.customerId,
        locationId: locationId ?? this.locationId,
        chooseCust: chooseCust ?? this.chooseCust,
        isActive: isActive ?? this.isActive,
        parentMasterId: parentMasterId ?? this.parentMasterId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) => _$UserDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsResponseToJson(this);
}
