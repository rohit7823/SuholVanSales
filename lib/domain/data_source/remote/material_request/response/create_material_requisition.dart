import 'package:json_annotation/json_annotation.dart';

part 'create_material_requisition.g.dart';

@JsonSerializable()
class CreateMaterialRequisitionResponse {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final List<Map<String, dynamic>>? data;
  @JsonKey(name: "error")
  final String? error;

  CreateMaterialRequisitionResponse({
    this.success,
    this.message,
    this.data,
    this.error
  });



  factory CreateMaterialRequisitionResponse.fromJson(Map<String, dynamic> json) => _$CreateMaterialRequisitionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMaterialRequisitionResponseToJson(this);

  CreateMaterialRequisitionResponse copyWith({
    bool? success,
    String? message,
    List<Map<String, dynamic>>? data,
    String? error,
  }) {
    return CreateMaterialRequisitionResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}
