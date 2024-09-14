import 'package:json_annotation/json_annotation.dart';
import 'package:suhol_van_sales/domain/utils/easy_json.dart';

part 'app_icon.g.dart';

@JsonSerializable()
class AppIcon {
  @JsonKey(name: "key")
  final String? id;
  @JsonKey(name: "icon")
  final String? icon;
  @JsonKey(name: "color")
  final String? color;
  @JsonKey(name: "size")
  final double? size;

  const AppIcon({this.id, this.icon, this.color, this.size});

  AppIcon copyWith({String? id, String? icon, String? color, double? size}) {
    return AppIcon(
        icon: icon ?? this.icon,
        color: color ?? this.color,
        id: id ?? this.id,
        size: size ?? this.size);
  }

  factory AppIcon.fromJson(Map<String, dynamic> json) =>
      EasyJson(const AppIcon(), json)
          .retrieve(
            'key',
            ifString: (value, model) => model.copyWith(id: value),
          )
          .retrieve(
            'icon',
            ifString: (value, model) => model.copyWith(icon: value),
          )
          .retrieve(
            'color',
            ifString: (value, model) => model.copyWith(color: value),
          )
          .retrieve(
            'size',
            ifDouble: (value, model) => model.copyWith(size: value),
            ifInt: (value, model) => model.copyWith(size: value.toDouble()),
          )
          .done();
}
