import 'package:freezed_annotation/freezed_annotation.dart';

part 'info.freezed.dart';
part 'info.g.dart';

@freezed
class Meta with _$Meta {
  const factory Meta({
    required List<Asset> universe,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

@freezed
class Asset with _$Asset {
  const factory Asset({
    required String name,
    required int szDecimals,
    required int maxLeverage,
    required bool onlyIsolated,
  }) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
}
