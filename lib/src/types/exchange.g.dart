// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderResponseImpl _$$OrderResponseImplFromJson(Map<String, dynamic> json) =>
    _$OrderResponseImpl(
      status: json['status'] as String,
      response:
          OrderInnerResponse.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OrderResponseImplToJson(_$OrderResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'response': instance.response,
    };

_$OrderInnerResponseImpl _$$OrderInnerResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderInnerResponseImpl(
      type: json['type'] as String,
      data: DataResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OrderInnerResponseImplToJson(
        _$OrderInnerResponseImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };

_$DataResponseImpl _$$DataResponseImplFromJson(Map<String, dynamic> json) =>
    _$DataResponseImpl(
      statuses: (json['statuses'] as List<dynamic>)
          .map((e) => StatusResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DataResponseImplToJson(_$DataResponseImpl instance) =>
    <String, dynamic>{
      'statuses': instance.statuses,
    };

_$RestingImpl _$$RestingImplFromJson(Map<String, dynamic> json) =>
    _$RestingImpl(
      RestingStatus.fromJson(json['resting'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RestingImplToJson(_$RestingImpl instance) =>
    <String, dynamic>{
      'resting': instance.resting,
      'runtimeType': instance.$type,
    };

_$FilledImpl _$$FilledImplFromJson(Map<String, dynamic> json) => _$FilledImpl(
      FilledStatus.fromJson(json['filled'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FilledImplToJson(_$FilledImpl instance) =>
    <String, dynamic>{
      'filled': instance.filled,
      'runtimeType': instance.$type,
    };

_$ErrorImpl _$$ErrorImplFromJson(Map<String, dynamic> json) => _$ErrorImpl(
      json['error'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ErrorImplToJson(_$ErrorImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'runtimeType': instance.$type,
    };

_$StatusImpl _$$StatusImplFromJson(Map<String, dynamic> json) => _$StatusImpl(
      json['status'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$StatusImplToJson(_$StatusImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'runtimeType': instance.$type,
    };

_$RestingStatusImpl _$$RestingStatusImplFromJson(Map<String, dynamic> json) =>
    _$RestingStatusImpl(
      oid: (json['oid'] as num).toInt(),
      cloid: json['cloid'] as String?,
    );

Map<String, dynamic> _$$RestingStatusImplToJson(_$RestingStatusImpl instance) =>
    <String, dynamic>{
      'oid': instance.oid,
      'cloid': instance.cloid,
    };

_$FilledStatusImpl _$$FilledStatusImplFromJson(Map<String, dynamic> json) =>
    _$FilledStatusImpl(
      oid: (json['oid'] as num).toInt(),
      avgPx: (json['avgPx'] as num).toDouble(),
      totalSz: (json['totalSz'] as num).toDouble(),
      cloid: json['cloid'] as String?,
    );

Map<String, dynamic> _$$FilledStatusImplToJson(_$FilledStatusImpl instance) =>
    <String, dynamic>{
      'oid': instance.oid,
      'avgPx': instance.avgPx,
      'totalSz': instance.totalSz,
      'cloid': instance.cloid,
    };

_$CancelRequestImpl _$$CancelRequestImplFromJson(Map<String, dynamic> json) =>
    _$CancelRequestImpl(
      oid: (json['oid'] as num).toInt(),
      coin: (json['coin'] as num).toInt(),
    );

Map<String, dynamic> _$$CancelRequestImplToJson(_$CancelRequestImpl instance) =>
    <String, dynamic>{
      'oid': instance.oid,
      'coin': instance.coin,
    };
