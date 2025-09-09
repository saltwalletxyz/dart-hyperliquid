import 'package:json_annotation/json_annotation.dart';

part 'general.g.dart';

@JsonSerializable()
class AllMids {
  final Map<String, String> mids;

  const AllMids({
    required this.mids,
  });

  factory AllMids.fromJson(Map<String, dynamic> json) => _$AllMidsFromJson(json);
  Map<String, dynamic> toJson() => _$AllMidsToJson(this);
}

@JsonSerializable()
class UserOpenOrders {
  final List<UserOpenOrder> orders;

  const UserOpenOrders({
    required this.orders,
  });

  factory UserOpenOrders.fromJson(Map<String, dynamic> json) => _$UserOpenOrdersFromJson(json);
  Map<String, dynamic> toJson() => _$UserOpenOrdersToJson(this);
}

@JsonSerializable()
class UserOpenOrder {
  final String coin;
  final String side;
  final double limitPx;
  final double sz;
  final int oid;
  final int timestamp;
  final String origSz;

  const UserOpenOrder({
    required this.coin,
    required this.side,
    required this.limitPx,
    required this.sz,
    required this.oid,
    required this.timestamp,
    required this.origSz,
  });

  factory UserOpenOrder.fromJson(Map<String, dynamic> json) => _$UserOpenOrderFromJson(json);
  Map<String, dynamic> toJson() => _$UserOpenOrderToJson(this);
}

@JsonSerializable()
class FrontendOpenOrders {
  final List<FrontendOpenOrder> orders;

  const FrontendOpenOrders({
    required this.orders,
  });

  factory FrontendOpenOrders.fromJson(Map<String, dynamic> json) => _$FrontendOpenOrdersFromJson(json);
  Map<String, dynamic> toJson() => _$FrontendOpenOrdersToJson(this);
}

@JsonSerializable()
class FrontendOpenOrder {
  final String coin;
  final bool isPositionTpsl;
  final bool isTrigger;
  final String limitPx;
  final int oid;
  final String orderType;
  final String origSz;
  final bool reduceOnly;
  final String side;
  final String sz;
  final int timestamp;
  final String triggerCondition;
  final String triggerPx;

  const FrontendOpenOrder({
    required this.coin,
    required this.isPositionTpsl,
    required this.isTrigger,
    required this.limitPx,
    required this.oid,
    required this.orderType,
    required this.origSz,
    required this.reduceOnly,
    required this.side,
    required this.sz,
    required this.timestamp,
    required this.triggerCondition,
    required this.triggerPx,
  });

  factory FrontendOpenOrder.fromJson(Map<String, dynamic> json) => _$FrontendOpenOrderFromJson(json);
  Map<String, dynamic> toJson() => _$FrontendOpenOrderToJson(this);
}

@JsonSerializable()
class UserFills {
  final List<UserFill> fills;

  const UserFills({
    required this.fills,
  });

  factory UserFills.fromJson(Map<String, dynamic> json) => _$UserFillsFromJson(json);
  Map<String, dynamic> toJson() => _$UserFillsToJson(this);
}

@JsonSerializable()
class UserFill {
  final String coin;
  final double px;
  final double sz;
  final String side;
  final int time;
  final String startPosition;
  final String dir;
  final double closedPnl;
  final String hash;
  final int oid;
  final bool crossed;
  final double fee;
  final int tid;

  const UserFill({
    required this.coin,
    required this.px,
    required this.sz,
    required this.side,
    required this.time,
    required this.startPosition,
    required this.dir,
    required this.closedPnl,
    required this.hash,
    required this.oid,
    required this.crossed,
    required this.fee,
    required this.tid,
  });

  factory UserFill.fromJson(Map<String, dynamic> json) => _$UserFillFromJson(json);
  Map<String, dynamic> toJson() => _$UserFillToJson(this);
}

@JsonSerializable()
class UserRateLimit {
  final int nRequestsUsed;
  final int nRequestsCap;
  final double cumVlm;

  const UserRateLimit({
    required this.nRequestsUsed,
    required this.nRequestsCap,
    required this.cumVlm,
  });

  factory UserRateLimit.fromJson(Map<String, dynamic> json) => _$UserRateLimitFromJson(json);
  Map<String, dynamic> toJson() => _$UserRateLimitToJson(this);
}

@JsonSerializable()
class OrderStatus {
  final String status;
  final Order order;

  const OrderStatus({
    required this.status,
    required this.order,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) => _$OrderStatusFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStatusToJson(this);
}

@JsonSerializable()
class Order {
  final String coin;
  final String side;
  final double limitPx;
  final double sz;
  final int oid;
  final int timestamp;
  final String origSz;
  final bool reduceOnly;
  final String orderType;
  final bool isTrigger;
  final double triggerPx;
  final String triggerCondition;
  final bool isPositionTpsl;
  final List<dynamic> children;

  const Order({
    required this.coin,
    required this.side,
    required this.limitPx,
    required this.sz,
    required this.oid,
    required this.timestamp,
    required this.origSz,
    required this.reduceOnly,
    required this.orderType,
    required this.isTrigger,
    required this.triggerPx,
    required this.triggerCondition,
    required this.isPositionTpsl,
    required this.children,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class L2Book {
  final String coin;
  final int time;
  final List<List<L2BookLevel>> levels;

  const L2Book({
    required this.coin,
    required this.time,
    required this.levels,
  });

  factory L2Book.fromJson(Map<String, dynamic> json) => _$L2BookFromJson(json);
  Map<String, dynamic> toJson() => _$L2BookToJson(this);
}

@JsonSerializable()
class L2BookLevel {
  final double px;
  final double sz;
  final int n;

  const L2BookLevel({
    required this.px,
    required this.sz,
    required this.n,
  });

  factory L2BookLevel.fromJson(Map<String, dynamic> json) => _$L2BookLevelFromJson(json);
  Map<String, dynamic> toJson() => _$L2BookLevelToJson(this);
}

@JsonSerializable()
class CandleSnapshot {
  final List<Candle> candles;

  const CandleSnapshot({
    required this.candles,
  });

  factory CandleSnapshot.fromJson(Map<String, dynamic> json) => _$CandleSnapshotFromJson(json);
  Map<String, dynamic> toJson() => _$CandleSnapshotToJson(this);
}

@JsonSerializable()
class Candle {
  final int t;
  final int T;
  final String s;
  final String i;
  final double o;
  final double c;
  final double h;
  final double l;
  final double v;
  final int n;

  const Candle({
    required this.t,
    required this.T,
    required this.s,
    required this.i,
    required this.o,
    required this.c,
    required this.h,
    required this.l,
    required this.v,
    required this.n,
  });

  factory Candle.fromJson(Map<String, dynamic> json) => _$CandleFromJson(json);
  Map<String, dynamic> toJson() => _$CandleToJson(this);
}
