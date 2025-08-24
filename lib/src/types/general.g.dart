// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllMidsImpl _$$AllMidsImplFromJson(Map<String, dynamic> json) =>
    _$AllMidsImpl(
      mids: Map<String, String>.from(json['mids'] as Map),
    );

Map<String, dynamic> _$$AllMidsImplToJson(_$AllMidsImpl instance) =>
    <String, dynamic>{
      'mids': instance.mids,
    };

_$UserOpenOrdersImpl _$$UserOpenOrdersImplFromJson(Map<String, dynamic> json) =>
    _$UserOpenOrdersImpl(
      orders: (json['orders'] as List<dynamic>)
          .map((e) => UserOpenOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserOpenOrdersImplToJson(
        _$UserOpenOrdersImpl instance) =>
    <String, dynamic>{
      'orders': instance.orders,
    };

_$UserOpenOrderImpl _$$UserOpenOrderImplFromJson(Map<String, dynamic> json) =>
    _$UserOpenOrderImpl(
      coin: json['coin'] as String,
      side: json['side'] as String,
      limitPx: (json['limitPx'] as num).toDouble(),
      sz: (json['sz'] as num).toDouble(),
      oid: (json['oid'] as num).toInt(),
      timestamp: (json['timestamp'] as num).toInt(),
      origSz: json['origSz'] as String,
    );

Map<String, dynamic> _$$UserOpenOrderImplToJson(_$UserOpenOrderImpl instance) =>
    <String, dynamic>{
      'coin': instance.coin,
      'side': instance.side,
      'limitPx': instance.limitPx,
      'sz': instance.sz,
      'oid': instance.oid,
      'timestamp': instance.timestamp,
      'origSz': instance.origSz,
    };

_$FrontendOpenOrdersImpl _$$FrontendOpenOrdersImplFromJson(
        Map<String, dynamic> json) =>
    _$FrontendOpenOrdersImpl(
      orders: (json['orders'] as List<dynamic>)
          .map((e) => FrontendOpenOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FrontendOpenOrdersImplToJson(
        _$FrontendOpenOrdersImpl instance) =>
    <String, dynamic>{
      'orders': instance.orders,
    };

_$FrontendOpenOrderImpl _$$FrontendOpenOrderImplFromJson(
        Map<String, dynamic> json) =>
    _$FrontendOpenOrderImpl(
      coin: json['coin'] as String,
      isPositionTpsl: json['isPositionTpsl'] as bool,
      isTrigger: json['isTrigger'] as bool,
      limitPx: json['limitPx'] as String,
      oid: (json['oid'] as num).toInt(),
      orderType: json['orderType'] as String,
      origSz: json['origSz'] as String,
      reduceOnly: json['reduceOnly'] as bool,
      side: json['side'] as String,
      sz: json['sz'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      triggerCondition: json['triggerCondition'] as String,
      triggerPx: json['triggerPx'] as String,
    );

Map<String, dynamic> _$$FrontendOpenOrderImplToJson(
        _$FrontendOpenOrderImpl instance) =>
    <String, dynamic>{
      'coin': instance.coin,
      'isPositionTpsl': instance.isPositionTpsl,
      'isTrigger': instance.isTrigger,
      'limitPx': instance.limitPx,
      'oid': instance.oid,
      'orderType': instance.orderType,
      'origSz': instance.origSz,
      'reduceOnly': instance.reduceOnly,
      'side': instance.side,
      'sz': instance.sz,
      'timestamp': instance.timestamp,
      'triggerCondition': instance.triggerCondition,
      'triggerPx': instance.triggerPx,
    };

_$UserFillsImpl _$$UserFillsImplFromJson(Map<String, dynamic> json) =>
    _$UserFillsImpl(
      fills: (json['fills'] as List<dynamic>)
          .map((e) => UserFill.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserFillsImplToJson(_$UserFillsImpl instance) =>
    <String, dynamic>{
      'fills': instance.fills,
    };

_$UserFillImpl _$$UserFillImplFromJson(Map<String, dynamic> json) =>
    _$UserFillImpl(
      coin: json['coin'] as String,
      px: (json['px'] as num).toDouble(),
      sz: (json['sz'] as num).toDouble(),
      side: json['side'] as String,
      time: (json['time'] as num).toInt(),
      startPosition: json['startPosition'] as String,
      dir: json['dir'] as String,
      closedPnl: (json['closedPnl'] as num).toDouble(),
      hash: json['hash'] as String,
      oid: (json['oid'] as num).toInt(),
      crossed: json['crossed'] as bool,
      fee: (json['fee'] as num).toDouble(),
      tid: (json['tid'] as num).toInt(),
    );

Map<String, dynamic> _$$UserFillImplToJson(_$UserFillImpl instance) =>
    <String, dynamic>{
      'coin': instance.coin,
      'px': instance.px,
      'sz': instance.sz,
      'side': instance.side,
      'time': instance.time,
      'startPosition': instance.startPosition,
      'dir': instance.dir,
      'closedPnl': instance.closedPnl,
      'hash': instance.hash,
      'oid': instance.oid,
      'crossed': instance.crossed,
      'fee': instance.fee,
      'tid': instance.tid,
    };

_$UserRateLimitImpl _$$UserRateLimitImplFromJson(Map<String, dynamic> json) =>
    _$UserRateLimitImpl(
      nRequestsUsed: (json['nRequestsUsed'] as num).toInt(),
      nRequestsCap: (json['nRequestsCap'] as num).toInt(),
      cumVlm: (json['cumVlm'] as num).toDouble(),
    );

Map<String, dynamic> _$$UserRateLimitImplToJson(_$UserRateLimitImpl instance) =>
    <String, dynamic>{
      'nRequestsUsed': instance.nRequestsUsed,
      'nRequestsCap': instance.nRequestsCap,
      'cumVlm': instance.cumVlm,
    };

_$OrderStatusImpl _$$OrderStatusImplFromJson(Map<String, dynamic> json) =>
    _$OrderStatusImpl(
      status: json['status'] as String,
      order: Order.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OrderStatusImplToJson(_$OrderStatusImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'order': instance.order,
    };

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      coin: json['coin'] as String,
      side: json['side'] as String,
      limitPx: (json['limitPx'] as num).toDouble(),
      sz: (json['sz'] as num).toDouble(),
      oid: (json['oid'] as num).toInt(),
      timestamp: (json['timestamp'] as num).toInt(),
      origSz: json['origSz'] as String,
      reduceOnly: json['reduceOnly'] as bool,
      orderType: json['orderType'] as String,
      isTrigger: json['isTrigger'] as bool,
      triggerPx: (json['triggerPx'] as num).toDouble(),
      triggerCondition: json['triggerCondition'] as String,
      isPositionTpsl: json['isPositionTpsl'] as bool,
      children: json['children'] as List<dynamic>,
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'coin': instance.coin,
      'side': instance.side,
      'limitPx': instance.limitPx,
      'sz': instance.sz,
      'oid': instance.oid,
      'timestamp': instance.timestamp,
      'origSz': instance.origSz,
      'reduceOnly': instance.reduceOnly,
      'orderType': instance.orderType,
      'isTrigger': instance.isTrigger,
      'triggerPx': instance.triggerPx,
      'triggerCondition': instance.triggerCondition,
      'isPositionTpsl': instance.isPositionTpsl,
      'children': instance.children,
    };

_$L2BookImpl _$$L2BookImplFromJson(Map<String, dynamic> json) => _$L2BookImpl(
      coin: json['coin'] as String,
      time: (json['time'] as num).toInt(),
      levels: (json['levels'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => L2BookLevel.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$$L2BookImplToJson(_$L2BookImpl instance) =>
    <String, dynamic>{
      'coin': instance.coin,
      'time': instance.time,
      'levels': instance.levels,
    };

_$L2BookLevelImpl _$$L2BookLevelImplFromJson(Map<String, dynamic> json) =>
    _$L2BookLevelImpl(
      px: (json['px'] as num).toDouble(),
      sz: (json['sz'] as num).toDouble(),
      n: (json['n'] as num).toInt(),
    );

Map<String, dynamic> _$$L2BookLevelImplToJson(_$L2BookLevelImpl instance) =>
    <String, dynamic>{
      'px': instance.px,
      'sz': instance.sz,
      'n': instance.n,
    };

_$CandleSnapshotImpl _$$CandleSnapshotImplFromJson(Map<String, dynamic> json) =>
    _$CandleSnapshotImpl(
      candles: (json['candles'] as List<dynamic>)
          .map((e) => Candle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CandleSnapshotImplToJson(
        _$CandleSnapshotImpl instance) =>
    <String, dynamic>{
      'candles': instance.candles,
    };

_$CandleImpl _$$CandleImplFromJson(Map<String, dynamic> json) => _$CandleImpl(
      t: (json['t'] as num).toInt(),
      T: (json['T'] as num).toInt(),
      s: json['s'] as String,
      i: json['i'] as String,
      o: (json['o'] as num).toDouble(),
      c: (json['c'] as num).toDouble(),
      h: (json['h'] as num).toDouble(),
      l: (json['l'] as num).toDouble(),
      v: (json['v'] as num).toDouble(),
      n: (json['n'] as num).toInt(),
    );

Map<String, dynamic> _$$CandleImplToJson(_$CandleImpl instance) =>
    <String, dynamic>{
      't': instance.t,
      'T': instance.T,
      's': instance.s,
      'i': instance.i,
      'o': instance.o,
      'c': instance.c,
      'h': instance.h,
      'l': instance.l,
      'v': instance.v,
      'n': instance.n,
    };
