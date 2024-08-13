

import 'package:json_annotation/json_annotation.dart';

part 'app_icon.g.dart';

@JsonSerializable()
class AppIcon {
  @JsonKey(name: "key")
  final String? id;
  @JsonKey(name: "icon")
  final String? icon;
  @JsonKey(name: "color")
  final String? color;

  const AppIcon({
    this.id,
    this.icon,
    this.color,
  });

  AppIcon copyWith({
    String? id,
    String? icon,
    String? color,
  }) {
    return AppIcon(
      icon: icon ?? this.icon,
      color: color ?? this.color,
      id: id ?? this.id
    );
  }

  factory AppIcon.fromJson(Map<String, dynamic> json) => _$AppIconFromJson(json);

  	Map<String, dynamic> toJson() => _$AppIconToJson(this);
}