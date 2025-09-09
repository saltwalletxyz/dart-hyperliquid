import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

@JsonSerializable()
class Meta {
  final List<Asset> universe;

  const Meta({
    required this.universe,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class Asset {
  final String name;
  final int szDecimals;
  final int maxLeverage;
  final bool onlyIsolated;

  const Asset({
    required this.name,
    required this.szDecimals,
    required this.maxLeverage,
    required this.onlyIsolated,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
  Map<String, dynamic> toJson() => _$AssetToJson(this);
}
