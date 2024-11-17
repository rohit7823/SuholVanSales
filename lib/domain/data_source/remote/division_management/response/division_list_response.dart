// To parse this JSON data, do
//
//     final divisionListResponse = divisionListResponseFromJson(jsonString);

import 'dart:convert';

DivisionListResponse deserializeDivisionListResponse(
        Map<String, dynamic> str) =>
    DivisionListResponse.fromJson(str);

String divisionListResponseToJson(DivisionListResponse data) =>
    json.encode(data.toJson());

class DivisionListResponse {
  final bool? success;
  final String? message;
  final List<Division>? data;

  DivisionListResponse({
    this.success,
    this.message,
    this.data,
  });

  DivisionListResponse copyWith({
    bool? success,
    String? message,
    List<Division>? data,
  }) =>
      DivisionListResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory DivisionListResponse.fromJson(Map<String, dynamic> json) =>
      DivisionListResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Division>.from(
                json["data"]!.map((x) => Division.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}

class Division {
  final int? id;
  final int? companyMasterId;
  final String? divisionName;
  final String? divisionErpCode;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Division({
    this.id,
    this.companyMasterId,
    this.divisionName,
    this.divisionErpCode,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Division copyWith({
    int? id,
    int? companyMasterId,
    String? divisionName,
    String? divisionErpCode,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      Division(
        id: id ?? this.id,
        companyMasterId: companyMasterId ?? this.companyMasterId,
        divisionName: divisionName ?? this.divisionName,
        divisionErpCode: divisionErpCode ?? this.divisionErpCode,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Division.fromJson(Map<String, dynamic> json) => Division(
        id: json["id"],
        companyMasterId: json["company_master_id"],
        divisionName: json["division_name"],
        divisionErpCode: json["division_erp_code"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_master_id": companyMasterId,
        "division_name": divisionName,
        "division_erp_code": divisionErpCode,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
