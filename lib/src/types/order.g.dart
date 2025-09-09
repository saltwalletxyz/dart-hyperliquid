// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) => OrderRequest(
      coin: json['coin'] as String,
      isBuy: json['isBuy'] as bool,
      sz: (json['sz'] as num).toDouble(),
      limitPx: (json['limitPx'] as num).toDouble(),
      orderType: OrderType.fromJson(json['orderType'] as Map<String, dynamic>),
      reduceOnly: json['reduceOnly'] as bool,
      cloid: json['cloid'] as String?,
    );

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) =>
    <String, dynamic>{
      'coin': instance.coin,
      'isBuy': instance.isBuy,
      'sz': instance.sz,
      'limitPx': instance.limitPx,
      'orderType': instance.orderType,
      'reduceOnly': instance.reduceOnly,
      'cloid': instance.cloid,
    };

OrderType _$OrderTypeFromJson(Map<String, dynamic> json) => OrderType(
      type: json['type'] as String,
      limit: json['limit'] == null
          ? null
          : LimitOrderType.fromJson(json['limit'] as Map<String, dynamic>),
      trigger: json['trigger'] == null
          ? null
          : TriggerOrderType.fromJson(json['trigger'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderTypeToJson(OrderType instance) => <String, dynamic>{
      'type': instance.type,
      'limit': instance.limit,
      'trigger': instance.trigger,
    };

LimitOrderType _$LimitOrderTypeFromJson(Map<String, dynamic> json) =>
    LimitOrderType(
      tif: json['tif'] as String,
    );

Map<String, dynamic> _$LimitOrderTypeToJson(LimitOrderType instance) =>
    <String, dynamic>{
      'tif': instance.tif,
    };

TriggerOrderType _$TriggerOrderTypeFromJson(Map<String, dynamic> json) =>
    TriggerOrderType(
      isMarket: json['isMarket'] as bool,
      triggerPx: (json['triggerPx'] as num).toDouble(),
      tpsl: json['tpsl'] as String,
    );

Map<String, dynamic> _$TriggerOrderTypeToJson(TriggerOrderType instance) =>
    <String, dynamic>{
      'isMarket': instance.isMarket,
      'triggerPx': instance.triggerPx,
      'tpsl': instance.tpsl,
    };
