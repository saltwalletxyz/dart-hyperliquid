import 'package:json_annotation/json_annotation.dart';
// import 'order.dart';

part 'exchange.g.dart';

@JsonSerializable()
class OrderResponse {
  final String status;
  final OrderInnerResponse response;

  const OrderResponse({
    required this.status,
    required this.response,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => _$OrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}

@JsonSerializable()
class OrderInnerResponse {
  final String type;
  final DataResponse data;

  const OrderInnerResponse({
    required this.type,
    required this.data,
  });

  factory OrderInnerResponse.fromJson(Map<String, dynamic> json) => _$OrderInnerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderInnerResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  final List<StatusResponse> statuses;

  const DataResponse({
    required this.statuses,
  });

  factory DataResponse.fromJson(Map<String, dynamic> json) => _$DataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}

@JsonSerializable()
class StatusResponse {
  final String type;
  final RestingStatus? resting;
  final FilledStatus? filled;
  final String? error;
  final String? status;

  const StatusResponse({
    required this.type,
    this.resting,
    this.filled,
    this.error,
    this.status,
  });

  factory StatusResponse.resting(RestingStatus resting) => StatusResponse(
        type: 'resting',
        resting: resting,
      );

  factory StatusResponse.filled(FilledStatus filled) => StatusResponse(
        type: 'filled',
        filled: filled,
      );

  factory StatusResponse.error(String error) => StatusResponse(
        type: 'error',
        error: error,
      );

  factory StatusResponse.status(String status) => StatusResponse(
        type: 'status',
        status: status,
      );

  factory StatusResponse.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    switch (type) {
      case 'resting':
        return StatusResponse.resting(
          RestingStatus.fromJson(json['resting'] as Map<String, dynamic>),
        );
      case 'filled':
        return StatusResponse.filled(
          FilledStatus.fromJson(json['filled'] as Map<String, dynamic>),
        );
      case 'error':
        return StatusResponse.error(json['error'] as String);
      case 'status':
        return StatusResponse.status(json['status'] as String);
      default:
        throw ArgumentError('Unknown StatusResponse type: $type');
    }
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{'type': type};
    switch (type) {
      case 'resting':
        json['resting'] = resting!.toJson();
        break;
      case 'filled':
        json['filled'] = filled!.toJson();
        break;
      case 'error':
        json['error'] = error;
        break;
      case 'status':
        json['status'] = status;
        break;
    }
    return json;
  }
}

@JsonSerializable()
class RestingStatus {
  final int oid;
  final String? cloid;

  const RestingStatus({
    required this.oid,
    this.cloid,
  });

  factory RestingStatus.fromJson(Map<String, dynamic> json) => _$RestingStatusFromJson(json);
  Map<String, dynamic> toJson() => _$RestingStatusToJson(this);
}

@JsonSerializable()
class FilledStatus {
  final int oid;
  final double avgPx;
  final double totalSz;
  final String? cloid;

  const FilledStatus({
    required this.oid,
    required this.avgPx,
    required this.totalSz,
    this.cloid,
  });

  factory FilledStatus.fromJson(Map<String, dynamic> json) => _$FilledStatusFromJson(json);
  Map<String, dynamic> toJson() => _$FilledStatusToJson(this);
}

@JsonSerializable()
class CancelRequest {
  final int oid;
  final int coin;

  const CancelRequest({
    required this.oid,
    required this.coin,
  });

  factory CancelRequest.fromJson(Map<String, dynamic> json) => _$CancelRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CancelRequestToJson(this);
}
