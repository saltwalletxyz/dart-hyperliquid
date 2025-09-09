// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserState _$UserStateFromJson(Map<String, dynamic> json) => UserState(
      withdrawable: (json['withdrawable'] as num).toDouble(),
      crossMaintenanceMarginUsed:
          (json['crossMaintenanceMarginUsed'] as num).toDouble(),
      assetPositions: (json['assetPositions'] as List<dynamic>)
          .map((e) => AssetPosition.fromJson(e as Map<String, dynamic>))
          .toList(),
      crossMarginSummary: MarginSummary.fromJson(
          json['crossMarginSummary'] as Map<String, dynamic>),
      marginSummary:
          MarginSummary.fromJson(json['marginSummary'] as Map<String, dynamic>),
      time: (json['time'] as num).toInt(),
    );

Map<String, dynamic> _$UserStateToJson(UserState instance) => <String, dynamic>{
      'withdrawable': instance.withdrawable,
      'crossMaintenanceMarginUsed': instance.crossMaintenanceMarginUsed,
      'assetPositions': instance.assetPositions,
      'crossMarginSummary': instance.crossMarginSummary,
      'marginSummary': instance.marginSummary,
      'time': instance.time,
    };

AssetPosition _$AssetPositionFromJson(Map<String, dynamic> json) =>
    AssetPosition(
      position: Position.fromJson(json['position'] as Map<String, dynamic>),
      type: json['type'] as String,
    );

Map<String, dynamic> _$AssetPositionToJson(AssetPosition instance) =>
    <String, dynamic>{
      'position': instance.position,
      'type': instance.type,
    };

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      coin: json['coin'] as String,
      entryPx: (json['entryPx'] as num).toDouble(),
      leverage: Leverage.fromJson(json['leverage'] as Map<String, dynamic>),
      liquidationPx: (json['liquidationPx'] as num).toDouble(),
      marginUsed: (json['marginUsed'] as num).toDouble(),
      positionValue: (json['positionValue'] as num).toDouble(),
      returnOnEquity: (json['returnOnEquity'] as num).toDouble(),
      szi: (json['szi'] as num).toDouble(),
      unrealizedPnl: (json['unrealizedPnl'] as num).toDouble(),
      maxLeverage: (json['maxLeverage'] as num).toInt(),
      cumFunding:
          CumFunding.fromJson(json['cumFunding'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'coin': instance.coin,
      'entryPx': instance.entryPx,
      'leverage': instance.leverage,
      'liquidationPx': instance.liquidationPx,
      'marginUsed': instance.marginUsed,
      'positionValue': instance.positionValue,
      'returnOnEquity': instance.returnOnEquity,
      'szi': instance.szi,
      'unrealizedPnl': instance.unrealizedPnl,
      'maxLeverage': instance.maxLeverage,
      'cumFunding': instance.cumFunding,
    };

Leverage _$LeverageFromJson(Map<String, dynamic> json) => Leverage(
      type: json['type'] as String,
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$LeverageToJson(Leverage instance) => <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };

CumFunding _$CumFundingFromJson(Map<String, dynamic> json) => CumFunding(
      allTime: (json['allTime'] as num).toDouble(),
      sinceOpen: (json['sinceOpen'] as num).toDouble(),
      sinceChange: (json['sinceChange'] as num).toDouble(),
    );

Map<String, dynamic> _$CumFundingToJson(CumFunding instance) =>
    <String, dynamic>{
      'allTime': instance.allTime,
      'sinceOpen': instance.sinceOpen,
      'sinceChange': instance.sinceChange,
    };

MarginSummary _$MarginSummaryFromJson(Map<String, dynamic> json) =>
    MarginSummary(
      accountValue: (json['accountValue'] as num).toDouble(),
      totalMarginUsed: (json['totalMarginUsed'] as num).toDouble(),
      totalNtlPos: (json['totalNtlPos'] as num).toDouble(),
      totalRawUsd: (json['totalRawUsd'] as num).toDouble(),
    );

Map<String, dynamic> _$MarginSummaryToJson(MarginSummary instance) =>
    <String, dynamic>{
      'accountValue': instance.accountValue,
      'totalMarginUsed': instance.totalMarginUsed,
      'totalNtlPos': instance.totalNtlPos,
      'totalRawUsd': instance.totalRawUsd,
    };
