import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserState {
  const UserState({
    required this.withdrawable,
    required this.crossMaintenanceMarginUsed,
    required this.assetPositions,
    required this.crossMarginSummary,
    required this.marginSummary,
    required this.time,
  });

  factory UserState.fromJson(Map<String, dynamic> json) => _$UserStateFromJson(json);
  Map<String, dynamic> toJson() => _$UserStateToJson(this);

  final double withdrawable;
  final double crossMaintenanceMarginUsed;
  final List<AssetPosition> assetPositions;
  final MarginSummary crossMarginSummary;
  final MarginSummary marginSummary;
  final int time;
}

@JsonSerializable()
class AssetPosition {
  const AssetPosition({
    required this.position,
    required this.type,
  });

  factory AssetPosition.fromJson(Map<String, dynamic> json) => _$AssetPositionFromJson(json);
  Map<String, dynamic> toJson() => _$AssetPositionToJson(this);

  final Position position;
  final String type;
}

@JsonSerializable()
class Position {
  const Position({
    required this.coin,
    required this.entryPx,
    required this.leverage,
    required this.liquidationPx,
    required this.marginUsed,
    required this.positionValue,
    required this.returnOnEquity,
    required this.szi,
    required this.unrealizedPnl,
    required this.maxLeverage,
    required this.cumFunding,
  });

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);
  Map<String, dynamic> toJson() => _$PositionToJson(this);

  final String coin;
  final double entryPx;
  final Leverage leverage;
  final double liquidationPx;
  final double marginUsed;
  final double positionValue;
  final double returnOnEquity;
  final double szi;
  final double unrealizedPnl;
  final int maxLeverage;
  final CumFunding cumFunding;
}

@JsonSerializable()
class Leverage {
  const Leverage({
    required this.type,
    required this.value,
  });

  factory Leverage.fromJson(Map<String, dynamic> json) => _$LeverageFromJson(json);
  Map<String, dynamic> toJson() => _$LeverageToJson(this);

  final String type;
  final int value;
}

@JsonSerializable()
class CumFunding {
  const CumFunding({
    required this.allTime,
    required this.sinceOpen,
    required this.sinceChange,
  });

  factory CumFunding.fromJson(Map<String, dynamic> json) => _$CumFundingFromJson(json);
  Map<String, dynamic> toJson() => _$CumFundingToJson(this);

  final double allTime;
  final double sinceOpen;
  final double sinceChange;
}

@JsonSerializable()
class MarginSummary {
  const MarginSummary({
    required this.accountValue,
    required this.totalMarginUsed,
    required this.totalNtlPos,
    required this.totalRawUsd,
  });

  factory MarginSummary.fromJson(Map<String, dynamic> json) => _$MarginSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$MarginSummaryToJson(this);

  final double accountValue;
  final double totalMarginUsed;
  final double totalNtlPos;
  final double totalRawUsd;
}
