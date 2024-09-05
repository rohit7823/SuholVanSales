// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_icon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppIcon _$AppIconFromJson(Map<String, dynamic> json) => AppIcon(
      id: json['key'] as String?,
      icon: json['icon'] as String?,
      color: json['color'] as String?,
      size: (json['size'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AppIconToJson(AppIcon instance) => <String, dynamic>{
      'key': instance.id,
      'icon': instance.icon,
      'color': instance.color,
      'size': instance.size,
    };
