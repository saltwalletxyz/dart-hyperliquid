import 'package:freezed_annotation/freezed_annotation.dart';
// import 'order.dart';

part 'exchange.freezed.dart';
part 'exchange.g.dart';

@freezed
class OrderResponse with _$OrderResponse {
  const factory OrderResponse({
    required String status,
    required OrderInnerResponse response,
  }) = _OrderResponse;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => _$OrderResponseFromJson(json);
}

@freezed
class OrderInnerResponse with _$OrderInnerResponse {
  const factory OrderInnerResponse({
    required String type,
    required DataResponse data,
  }) = _OrderInnerResponse;

  factory OrderInnerResponse.fromJson(Map<String, dynamic> json) => _$OrderInnerResponseFromJson(json);
}

@freezed
class DataResponse with _$DataResponse {
  const factory DataResponse({
    required List<StatusResponse> statuses,
  }) = _DataResponse;

  factory DataResponse.fromJson(Map<String, dynamic> json) => _$DataResponseFromJson(json);
}

@freezed
class StatusResponse with _$StatusResponse {
  const factory StatusResponse.resting(RestingStatus resting) = _Resting;
  const factory StatusResponse.filled(FilledStatus filled) = _Filled;
  const factory StatusResponse.error(String error) = _Error;
  const factory StatusResponse.status(String status) = _Status;

  factory StatusResponse.fromJson(Map<String, dynamic> json) => _$StatusResponseFromJson(json);
}

@freezed
class RestingStatus with _$RestingStatus {
  const factory RestingStatus({
    required int oid,
    String? cloid,
  }) = _RestingStatus;

  factory RestingStatus.fromJson(Map<String, dynamic> json) => _$RestingStatusFromJson(json);
}

@freezed
class FilledStatus with _$FilledStatus {
  const factory FilledStatus({
    required int oid,
    required double avgPx,
    required double totalSz,
    String? cloid,
  }) = _FilledStatus;

  factory FilledStatus.fromJson(Map<String, dynamic> json) => _$FilledStatusFromJson(json);
}

@freezed
class CancelRequest with _$CancelRequest {
  const factory CancelRequest({
    required int oid,
    required int coin,
  }) = _CancelRequest;

  factory CancelRequest.fromJson(Map<String, dynamic> json) => _$CancelRequestFromJson(json);
}
