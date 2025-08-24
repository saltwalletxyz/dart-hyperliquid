import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class OrderRequest with _$OrderRequest {
  const factory OrderRequest({
    required String coin,
    required bool isBuy,
    required double sz,
    required double limitPx,
    required OrderType orderType,
    required bool reduceOnly,
    String? cloid,
  }) = _OrderRequest;

  factory OrderRequest.fromJson(Map<String, dynamic> json) => _$OrderRequestFromJson(json);
}

@freezed
class OrderType with _$OrderType {
  const factory OrderType.limit(LimitOrderType limit) = _LimitOrderType;
  const factory OrderType.trigger(TriggerOrderType trigger) = _TriggerOrderType;

  factory OrderType.fromJson(Map<String, dynamic> json) => _$OrderTypeFromJson(json);
}

@freezed
class LimitOrderType with _$LimitOrderType {
  const factory LimitOrderType({
    required String tif,
  }) = _LimitOrderTypeData;

  factory LimitOrderType.fromJson(Map<String, dynamic> json) => _$LimitOrderTypeFromJson(json);
}

@freezed
class TriggerOrderType with _$TriggerOrderType {
  const factory TriggerOrderType({
    required bool isMarket,
    required double triggerPx,
    required String tpsl,
  }) = _TriggerOrderTypeData;

  factory TriggerOrderType.fromJson(Map<String, dynamic> json) => _$TriggerOrderTypeFromJson(json);
}
