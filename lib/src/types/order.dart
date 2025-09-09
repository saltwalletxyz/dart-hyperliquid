import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderRequest {
  final String coin;
  final bool isBuy;
  final double sz;
  final double limitPx;
  final OrderType orderType;
  final bool reduceOnly;
  final String? cloid;

  const OrderRequest({
    required this.coin,
    required this.isBuy,
    required this.sz,
    required this.limitPx,
    required this.orderType,
    required this.reduceOnly,
    this.cloid,
  });

  factory OrderRequest.fromJson(Map<String, dynamic> json) => _$OrderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);
}

@JsonSerializable()
class OrderType {
  final String type;
  final LimitOrderType? limit;
  final TriggerOrderType? trigger;

  const OrderType({
    required this.type,
    this.limit,
    this.trigger,
  });

  factory OrderType.limit(LimitOrderType limit) => OrderType(
        type: 'limit',
        limit: limit,
      );

  factory OrderType.trigger(TriggerOrderType trigger) => OrderType(
        type: 'trigger',
        trigger: trigger,
      );

  factory OrderType.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    switch (type) {
      case 'limit':
        return OrderType.limit(
          LimitOrderType.fromJson(json['limit'] as Map<String, dynamic>),
        );
      case 'trigger':
        return OrderType.trigger(
          TriggerOrderType.fromJson(json['trigger'] as Map<String, dynamic>),
        );
      default:
        throw ArgumentError('Unknown OrderType type: $type');
    }
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{'type': type};
    switch (type) {
      case 'limit':
        json['limit'] = limit!.toJson();
        break;
      case 'trigger':
        json['trigger'] = trigger!.toJson();
        break;
    }
    return json;
  }
}

@JsonSerializable()
class LimitOrderType {
  final String tif;

  const LimitOrderType({
    required this.tif,
  });

  factory LimitOrderType.fromJson(Map<String, dynamic> json) => _$LimitOrderTypeFromJson(json);
  Map<String, dynamic> toJson() => _$LimitOrderTypeToJson(this);
}

@JsonSerializable()
class TriggerOrderType {
  final bool isMarket;
  final double triggerPx;
  final String tpsl;

  const TriggerOrderType({
    required this.isMarket,
    required this.triggerPx,
    required this.tpsl,
  });

  factory TriggerOrderType.fromJson(Map<String, dynamic> json) => _$TriggerOrderTypeFromJson(json);
  Map<String, dynamic> toJson() => _$TriggerOrderTypeToJson(this);
}
