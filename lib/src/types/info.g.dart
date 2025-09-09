// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      universe: (json['universe'] as List<dynamic>)
          .map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'universe': instance.universe,
    };

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset(
      name: json['name'] as String,
      szDecimals: (json['szDecimals'] as num).toInt(),
      maxLeverage: (json['maxLeverage'] as num).toInt(),
      onlyIsolated: json['onlyIsolated'] as bool,
    );

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'name': instance.name,
      'szDecimals': instance.szDecimals,
      'maxLeverage': instance.maxLeverage,
      'onlyIsolated': instance.onlyIsolated,
    };
