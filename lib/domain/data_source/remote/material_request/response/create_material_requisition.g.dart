// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_material_requisition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMaterialRequisitionResponse _$CreateMaterialRequisitionResponseFromJson(
        Map<String, dynamic> json) =>
    CreateMaterialRequisitionResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$CreateMaterialRequisitionResponseToJson(
        CreateMaterialRequisitionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'error': instance.error,
    };
