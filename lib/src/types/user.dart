import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    required double withdrawable,
    required double crossMaintenanceMarginUsed,
    required List<AssetPosition> assetPositions,
    required MarginSummary crossMarginSummary,
    required MarginSummary marginSummary,
    required int time,
  }) = _UserState;

  factory UserState.fromJson(Map<String, dynamic> json) => _$UserStateFromJson(json);
}

@freezed
class AssetPosition with _$AssetPosition {
  const factory AssetPosition({
    required Position position,
    required String type,
  }) = _AssetPosition;

  factory AssetPosition.fromJson(Map<String, dynamic> json) => _$AssetPositionFromJson(json);
}

@freezed
class Position with _$Position {
  const factory Position({
    required String coin,
    required double entryPx,
    required Leverage leverage,
    required double liquidationPx,
    required double marginUsed,
    required double positionValue,
    required double returnOnEquity,
    required double szi,
    required double unrealizedPnl,
    required int maxLeverage,
    required CumFunding cumFunding,
  }) = _Position;

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);
}

@freezed
class Leverage with _$Leverage {
  const factory Leverage({
    required String type,
    required int value,
  }) = _Leverage;

  factory Leverage.fromJson(Map<String, dynamic> json) => _$LeverageFromJson(json);
}

@freezed
class CumFunding with _$CumFunding {
  const factory CumFunding({
    required double allTime,
    required double sinceOpen,
    required double sinceChange,
  }) = _CumFunding;

  factory CumFunding.fromJson(Map<String, dynamic> json) => _$CumFundingFromJson(json);
}

@freezed
class MarginSummary with _$MarginSummary {
  const factory MarginSummary({
    required double accountValue,
    required double totalMarginUsed,
    required double totalNtlPos,
    required double totalRawUsd,
  }) = _MarginSummary;

  factory MarginSummary.fromJson(Map<String, dynamic> json) => _$MarginSummaryFromJson(json);
}
