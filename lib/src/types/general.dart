import 'package:freezed_annotation/freezed_annotation.dart';

part 'general.freezed.dart';
part 'general.g.dart';

@freezed
class AllMids with _$AllMids {
  const factory AllMids({
    required Map<String, String> mids,
  }) = _AllMids;

  factory AllMids.fromJson(Map<String, dynamic> json) => _$AllMidsFromJson(json);
}

@freezed
class UserOpenOrders with _$UserOpenOrders {
  const factory UserOpenOrders({
    required List<UserOpenOrder> orders,
  }) = _UserOpenOrders;

  factory UserOpenOrders.fromJson(Map<String, dynamic> json) => _$UserOpenOrdersFromJson(json);
}

@freezed
class UserOpenOrder with _$UserOpenOrder {
  const factory UserOpenOrder({
    required String coin,
    required String side,
    required double limitPx,
    required double sz,
    required int oid,
    required int timestamp,
    required String origSz,
  }) = _UserOpenOrder;

  factory UserOpenOrder.fromJson(Map<String, dynamic> json) => _$UserOpenOrderFromJson(json);
}

@freezed
class FrontendOpenOrders with _$FrontendOpenOrders {
  const factory FrontendOpenOrders({
    required List<FrontendOpenOrder> orders,
  }) = _FrontendOpenOrders;

  factory FrontendOpenOrders.fromJson(Map<String, dynamic> json) => _$FrontendOpenOrdersFromJson(json);
}

@freezed
class FrontendOpenOrder with _$FrontendOpenOrder {
  const factory FrontendOpenOrder({
    required String coin,
    required bool isPositionTpsl,
    required bool isTrigger,
    required String limitPx,
    required int oid,
    required String orderType,
    required String origSz,
    required bool reduceOnly,
    required String side,
    required String sz,
    required int timestamp,
    required String triggerCondition,
    required String triggerPx,
  }) = _FrontendOpenOrder;

  factory FrontendOpenOrder.fromJson(Map<String, dynamic> json) => _$FrontendOpenOrderFromJson(json);
}

@freezed
class UserFills with _$UserFills {
  const factory UserFills({
    required List<UserFill> fills,
  }) = _UserFills;

  factory UserFills.fromJson(Map<String, dynamic> json) => _$UserFillsFromJson(json);
}

@freezed
class UserFill with _$UserFill {
  const factory UserFill({
    required String coin,
    required double px,
    required double sz,
    required String side,
    required int time,
    required String startPosition,
    required String dir,
    required double closedPnl,
    required String hash,
    required int oid,
    required bool crossed,
    required double fee,
    required int tid,
  }) = _UserFill;

  factory UserFill.fromJson(Map<String, dynamic> json) => _$UserFillFromJson(json);
}

@freezed
class UserRateLimit with _$UserRateLimit {
  const factory UserRateLimit({
    required int nRequestsUsed,
    required int nRequestsCap,
    required double cumVlm,
  }) = _UserRateLimit;

  factory UserRateLimit.fromJson(Map<String, dynamic> json) => _$UserRateLimitFromJson(json);
}

@freezed
class OrderStatus with _$OrderStatus {
  const factory OrderStatus({
    required String status,
    required Order order,
  }) = _OrderStatus;

  factory OrderStatus.fromJson(Map<String, dynamic> json) => _$OrderStatusFromJson(json);
}

@freezed
class Order with _$Order {
  const factory Order({
    required String coin,
    required String side,
    required double limitPx,
    required double sz,
    required int oid,
    required int timestamp,
    required String origSz,
    required bool reduceOnly,
    required String orderType,
    required bool isTrigger,
    required double triggerPx,
    required String triggerCondition,
    required bool isPositionTpsl,
    required List<dynamic> children,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
class L2Book with _$L2Book {
  const factory L2Book({
    required String coin,
    required int time,
    required List<List<L2BookLevel>> levels,
  }) = _L2Book;

  factory L2Book.fromJson(Map<String, dynamic> json) => _$L2BookFromJson(json);
}

@freezed
class L2BookLevel with _$L2BookLevel {
  const factory L2BookLevel({
    required double px,
    required double sz,
    required int n,
  }) = _L2BookLevel;

  factory L2BookLevel.fromJson(Map<String, dynamic> json) => _$L2BookLevelFromJson(json);
}

@freezed
class CandleSnapshot with _$CandleSnapshot {
  const factory CandleSnapshot({
    required List<Candle> candles,
  }) = _CandleSnapshot;

  factory CandleSnapshot.fromJson(Map<String, dynamic> json) => _$CandleSnapshotFromJson(json);
}

@freezed
class Candle with _$Candle {
  const factory Candle({
    required int t,
    required int T,
    required String s,
    required String i,
    required double o,
    required double c,
    required double h,
    required double l,
    required double v,
    required int n,
  }) = _Candle;

  factory Candle.fromJson(Map<String, dynamic> json) => _$CandleFromJson(json);
}
