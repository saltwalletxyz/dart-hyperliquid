// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exchange.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) {
  return _OrderResponse.fromJson(json);
}

/// @nodoc
mixin _$OrderResponse {
  String get status => throw _privateConstructorUsedError;
  OrderInnerResponse get response => throw _privateConstructorUsedError;

  /// Serializes this OrderResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderResponseCopyWith<OrderResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderResponseCopyWith<$Res> {
  factory $OrderResponseCopyWith(
          OrderResponse value, $Res Function(OrderResponse) then) =
      _$OrderResponseCopyWithImpl<$Res, OrderResponse>;
  @useResult
  $Res call({String status, OrderInnerResponse response});

  $OrderInnerResponseCopyWith<$Res> get response;
}

/// @nodoc
class _$OrderResponseCopyWithImpl<$Res, $Val extends OrderResponse>
    implements $OrderResponseCopyWith<$Res> {
  _$OrderResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? response = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as OrderInnerResponse,
    ) as $Val);
  }

  /// Create a copy of OrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderInnerResponseCopyWith<$Res> get response {
    return $OrderInnerResponseCopyWith<$Res>(_value.response, (value) {
      return _then(_value.copyWith(response: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderResponseImplCopyWith<$Res>
    implements $OrderResponseCopyWith<$Res> {
  factory _$$OrderResponseImplCopyWith(
          _$OrderResponseImpl value, $Res Function(_$OrderResponseImpl) then) =
      __$$OrderResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, OrderInnerResponse response});

  @override
  $OrderInnerResponseCopyWith<$Res> get response;
}

/// @nodoc
class __$$OrderResponseImplCopyWithImpl<$Res>
    extends _$OrderResponseCopyWithImpl<$Res, _$OrderResponseImpl>
    implements _$$OrderResponseImplCopyWith<$Res> {
  __$$OrderResponseImplCopyWithImpl(
      _$OrderResponseImpl _value, $Res Function(_$OrderResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? response = null,
  }) {
    return _then(_$OrderResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as OrderInnerResponse,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderResponseImpl implements _OrderResponse {
  const _$OrderResponseImpl({required this.status, required this.response});

  factory _$OrderResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderResponseImplFromJson(json);

  @override
  final String status;
  @override
  final OrderInnerResponse response;

  @override
  String toString() {
    return 'OrderResponse(status: $status, response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, response);

  /// Create a copy of OrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderResponseImplCopyWith<_$OrderResponseImpl> get copyWith =>
      __$$OrderResponseImplCopyWithImpl<_$OrderResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderResponseImplToJson(
      this,
    );
  }
}

abstract class _OrderResponse implements OrderResponse {
  const factory _OrderResponse(
      {required final String status,
      required final OrderInnerResponse response}) = _$OrderResponseImpl;

  factory _OrderResponse.fromJson(Map<String, dynamic> json) =
      _$OrderResponseImpl.fromJson;

  @override
  String get status;
  @override
  OrderInnerResponse get response;

  /// Create a copy of OrderResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderResponseImplCopyWith<_$OrderResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderInnerResponse _$OrderInnerResponseFromJson(Map<String, dynamic> json) {
  return _OrderInnerResponse.fromJson(json);
}

/// @nodoc
mixin _$OrderInnerResponse {
  String get type => throw _privateConstructorUsedError;
  DataResponse get data => throw _privateConstructorUsedError;

  /// Serializes this OrderInnerResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderInnerResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderInnerResponseCopyWith<OrderInnerResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderInnerResponseCopyWith<$Res> {
  factory $OrderInnerResponseCopyWith(
          OrderInnerResponse value, $Res Function(OrderInnerResponse) then) =
      _$OrderInnerResponseCopyWithImpl<$Res, OrderInnerResponse>;
  @useResult
  $Res call({String type, DataResponse data});

  $DataResponseCopyWith<$Res> get data;
}

/// @nodoc
class _$OrderInnerResponseCopyWithImpl<$Res, $Val extends OrderInnerResponse>
    implements $OrderInnerResponseCopyWith<$Res> {
  _$OrderInnerResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderInnerResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DataResponse,
    ) as $Val);
  }

  /// Create a copy of OrderInnerResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DataResponseCopyWith<$Res> get data {
    return $DataResponseCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderInnerResponseImplCopyWith<$Res>
    implements $OrderInnerResponseCopyWith<$Res> {
  factory _$$OrderInnerResponseImplCopyWith(_$OrderInnerResponseImpl value,
          $Res Function(_$OrderInnerResponseImpl) then) =
      __$$OrderInnerResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, DataResponse data});

  @override
  $DataResponseCopyWith<$Res> get data;
}

/// @nodoc
class __$$OrderInnerResponseImplCopyWithImpl<$Res>
    extends _$OrderInnerResponseCopyWithImpl<$Res, _$OrderInnerResponseImpl>
    implements _$$OrderInnerResponseImplCopyWith<$Res> {
  __$$OrderInnerResponseImplCopyWithImpl(_$OrderInnerResponseImpl _value,
      $Res Function(_$OrderInnerResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderInnerResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? data = null,
  }) {
    return _then(_$OrderInnerResponseImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DataResponse,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderInnerResponseImpl implements _OrderInnerResponse {
  const _$OrderInnerResponseImpl({required this.type, required this.data});

  factory _$OrderInnerResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderInnerResponseImplFromJson(json);

  @override
  final String type;
  @override
  final DataResponse data;

  @override
  String toString() {
    return 'OrderInnerResponse(type: $type, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderInnerResponseImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, data);

  /// Create a copy of OrderInnerResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderInnerResponseImplCopyWith<_$OrderInnerResponseImpl> get copyWith =>
      __$$OrderInnerResponseImplCopyWithImpl<_$OrderInnerResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderInnerResponseImplToJson(
      this,
    );
  }
}

abstract class _OrderInnerResponse implements OrderInnerResponse {
  const factory _OrderInnerResponse(
      {required final String type,
      required final DataResponse data}) = _$OrderInnerResponseImpl;

  factory _OrderInnerResponse.fromJson(Map<String, dynamic> json) =
      _$OrderInnerResponseImpl.fromJson;

  @override
  String get type;
  @override
  DataResponse get data;

  /// Create a copy of OrderInnerResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderInnerResponseImplCopyWith<_$OrderInnerResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DataResponse _$DataResponseFromJson(Map<String, dynamic> json) {
  return _DataResponse.fromJson(json);
}

/// @nodoc
mixin _$DataResponse {
  List<StatusResponse> get statuses => throw _privateConstructorUsedError;

  /// Serializes this DataResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DataResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DataResponseCopyWith<DataResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataResponseCopyWith<$Res> {
  factory $DataResponseCopyWith(
          DataResponse value, $Res Function(DataResponse) then) =
      _$DataResponseCopyWithImpl<$Res, DataResponse>;
  @useResult
  $Res call({List<StatusResponse> statuses});
}

/// @nodoc
class _$DataResponseCopyWithImpl<$Res, $Val extends DataResponse>
    implements $DataResponseCopyWith<$Res> {
  _$DataResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DataResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statuses = null,
  }) {
    return _then(_value.copyWith(
      statuses: null == statuses
          ? _value.statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as List<StatusResponse>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataResponseImplCopyWith<$Res>
    implements $DataResponseCopyWith<$Res> {
  factory _$$DataResponseImplCopyWith(
          _$DataResponseImpl value, $Res Function(_$DataResponseImpl) then) =
      __$$DataResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<StatusResponse> statuses});
}

/// @nodoc
class __$$DataResponseImplCopyWithImpl<$Res>
    extends _$DataResponseCopyWithImpl<$Res, _$DataResponseImpl>
    implements _$$DataResponseImplCopyWith<$Res> {
  __$$DataResponseImplCopyWithImpl(
      _$DataResponseImpl _value, $Res Function(_$DataResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DataResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statuses = null,
  }) {
    return _then(_$DataResponseImpl(
      statuses: null == statuses
          ? _value._statuses
          : statuses // ignore: cast_nullable_to_non_nullable
              as List<StatusResponse>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataResponseImpl implements _DataResponse {
  const _$DataResponseImpl({required final List<StatusResponse> statuses})
      : _statuses = statuses;

  factory _$DataResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataResponseImplFromJson(json);

  final List<StatusResponse> _statuses;
  @override
  List<StatusResponse> get statuses {
    if (_statuses is EqualUnmodifiableListView) return _statuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_statuses);
  }

  @override
  String toString() {
    return 'DataResponse(statuses: $statuses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataResponseImpl &&
            const DeepCollectionEquality().equals(other._statuses, _statuses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_statuses));

  /// Create a copy of DataResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataResponseImplCopyWith<_$DataResponseImpl> get copyWith =>
      __$$DataResponseImplCopyWithImpl<_$DataResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataResponseImplToJson(
      this,
    );
  }
}

abstract class _DataResponse implements DataResponse {
  const factory _DataResponse({required final List<StatusResponse> statuses}) =
      _$DataResponseImpl;

  factory _DataResponse.fromJson(Map<String, dynamic> json) =
      _$DataResponseImpl.fromJson;

  @override
  List<StatusResponse> get statuses;

  /// Create a copy of DataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataResponseImplCopyWith<_$DataResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatusResponse _$StatusResponseFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'resting':
      return _Resting.fromJson(json);
    case 'filled':
      return _Filled.fromJson(json);
    case 'error':
      return _Error.fromJson(json);
    case 'status':
      return _Status.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'StatusResponse',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$StatusResponse {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RestingStatus resting) resting,
    required TResult Function(FilledStatus filled) filled,
    required TResult Function(String error) error,
    required TResult Function(String status) status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RestingStatus resting)? resting,
    TResult? Function(FilledStatus filled)? filled,
    TResult? Function(String error)? error,
    TResult? Function(String status)? status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RestingStatus resting)? resting,
    TResult Function(FilledStatus filled)? filled,
    TResult Function(String error)? error,
    TResult Function(String status)? status,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Resting value) resting,
    required TResult Function(_Filled value) filled,
    required TResult Function(_Error value) error,
    required TResult Function(_Status value) status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Resting value)? resting,
    TResult? Function(_Filled value)? filled,
    TResult? Function(_Error value)? error,
    TResult? Function(_Status value)? status,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Resting value)? resting,
    TResult Function(_Filled value)? filled,
    TResult Function(_Error value)? error,
    TResult Function(_Status value)? status,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this StatusResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusResponseCopyWith<$Res> {
  factory $StatusResponseCopyWith(
          StatusResponse value, $Res Function(StatusResponse) then) =
      _$StatusResponseCopyWithImpl<$Res, StatusResponse>;
}

/// @nodoc
class _$StatusResponseCopyWithImpl<$Res, $Val extends StatusResponse>
    implements $StatusResponseCopyWith<$Res> {
  _$StatusResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RestingImplCopyWith<$Res> {
  factory _$$RestingImplCopyWith(
          _$RestingImpl value, $Res Function(_$RestingImpl) then) =
      __$$RestingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({RestingStatus resting});

  $RestingStatusCopyWith<$Res> get resting;
}

/// @nodoc
class __$$RestingImplCopyWithImpl<$Res>
    extends _$StatusResponseCopyWithImpl<$Res, _$RestingImpl>
    implements _$$RestingImplCopyWith<$Res> {
  __$$RestingImplCopyWithImpl(
      _$RestingImpl _value, $Res Function(_$RestingImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resting = null,
  }) {
    return _then(_$RestingImpl(
      null == resting
          ? _value.resting
          : resting // ignore: cast_nullable_to_non_nullable
              as RestingStatus,
    ));
  }

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RestingStatusCopyWith<$Res> get resting {
    return $RestingStatusCopyWith<$Res>(_value.resting, (value) {
      return _then(_value.copyWith(resting: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$RestingImpl implements _Resting {
  const _$RestingImpl(this.resting, {final String? $type})
      : $type = $type ?? 'resting';

  factory _$RestingImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestingImplFromJson(json);

  @override
  final RestingStatus resting;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'StatusResponse.resting(resting: $resting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestingImpl &&
            (identical(other.resting, resting) || other.resting == resting));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, resting);

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestingImplCopyWith<_$RestingImpl> get copyWith =>
      __$$RestingImplCopyWithImpl<_$RestingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RestingStatus resting) resting,
    required TResult Function(FilledStatus filled) filled,
    required TResult Function(String error) error,
    required TResult Function(String status) status,
  }) {
    return resting(this.resting);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RestingStatus resting)? resting,
    TResult? Function(FilledStatus filled)? filled,
    TResult? Function(String error)? error,
    TResult? Function(String status)? status,
  }) {
    return resting?.call(this.resting);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RestingStatus resting)? resting,
    TResult Function(FilledStatus filled)? filled,
    TResult Function(String error)? error,
    TResult Function(String status)? status,
    required TResult orElse(),
  }) {
    if (resting != null) {
      return resting(this.resting);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Resting value) resting,
    required TResult Function(_Filled value) filled,
    required TResult Function(_Error value) error,
    required TResult Function(_Status value) status,
  }) {
    return resting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Resting value)? resting,
    TResult? Function(_Filled value)? filled,
    TResult? Function(_Error value)? error,
    TResult? Function(_Status value)? status,
  }) {
    return resting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Resting value)? resting,
    TResult Function(_Filled value)? filled,
    TResult Function(_Error value)? error,
    TResult Function(_Status value)? status,
    required TResult orElse(),
  }) {
    if (resting != null) {
      return resting(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RestingImplToJson(
      this,
    );
  }
}

abstract class _Resting implements StatusResponse {
  const factory _Resting(final RestingStatus resting) = _$RestingImpl;

  factory _Resting.fromJson(Map<String, dynamic> json) = _$RestingImpl.fromJson;

  RestingStatus get resting;

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestingImplCopyWith<_$RestingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FilledImplCopyWith<$Res> {
  factory _$$FilledImplCopyWith(
          _$FilledImpl value, $Res Function(_$FilledImpl) then) =
      __$$FilledImplCopyWithImpl<$Res>;
  @useResult
  $Res call({FilledStatus filled});

  $FilledStatusCopyWith<$Res> get filled;
}

/// @nodoc
class __$$FilledImplCopyWithImpl<$Res>
    extends _$StatusResponseCopyWithImpl<$Res, _$FilledImpl>
    implements _$$FilledImplCopyWith<$Res> {
  __$$FilledImplCopyWithImpl(
      _$FilledImpl _value, $Res Function(_$FilledImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filled = null,
  }) {
    return _then(_$FilledImpl(
      null == filled
          ? _value.filled
          : filled // ignore: cast_nullable_to_non_nullable
              as FilledStatus,
    ));
  }

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FilledStatusCopyWith<$Res> get filled {
    return $FilledStatusCopyWith<$Res>(_value.filled, (value) {
      return _then(_value.copyWith(filled: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$FilledImpl implements _Filled {
  const _$FilledImpl(this.filled, {final String? $type})
      : $type = $type ?? 'filled';

  factory _$FilledImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilledImplFromJson(json);

  @override
  final FilledStatus filled;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'StatusResponse.filled(filled: $filled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilledImpl &&
            (identical(other.filled, filled) || other.filled == filled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, filled);

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilledImplCopyWith<_$FilledImpl> get copyWith =>
      __$$FilledImplCopyWithImpl<_$FilledImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RestingStatus resting) resting,
    required TResult Function(FilledStatus filled) filled,
    required TResult Function(String error) error,
    required TResult Function(String status) status,
  }) {
    return filled(this.filled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RestingStatus resting)? resting,
    TResult? Function(FilledStatus filled)? filled,
    TResult? Function(String error)? error,
    TResult? Function(String status)? status,
  }) {
    return filled?.call(this.filled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RestingStatus resting)? resting,
    TResult Function(FilledStatus filled)? filled,
    TResult Function(String error)? error,
    TResult Function(String status)? status,
    required TResult orElse(),
  }) {
    if (filled != null) {
      return filled(this.filled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Resting value) resting,
    required TResult Function(_Filled value) filled,
    required TResult Function(_Error value) error,
    required TResult Function(_Status value) status,
  }) {
    return filled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Resting value)? resting,
    TResult? Function(_Filled value)? filled,
    TResult? Function(_Error value)? error,
    TResult? Function(_Status value)? status,
  }) {
    return filled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Resting value)? resting,
    TResult Function(_Filled value)? filled,
    TResult Function(_Error value)? error,
    TResult Function(_Status value)? status,
    required TResult orElse(),
  }) {
    if (filled != null) {
      return filled(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FilledImplToJson(
      this,
    );
  }
}

abstract class _Filled implements StatusResponse {
  const factory _Filled(final FilledStatus filled) = _$FilledImpl;

  factory _Filled.fromJson(Map<String, dynamic> json) = _$FilledImpl.fromJson;

  FilledStatus get filled;

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilledImplCopyWith<_$FilledImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$StatusResponseCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.error, {final String? $type})
      : $type = $type ?? 'error';

  factory _$ErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorImplFromJson(json);

  @override
  final String error;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'StatusResponse.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RestingStatus resting) resting,
    required TResult Function(FilledStatus filled) filled,
    required TResult Function(String error) error,
    required TResult Function(String status) status,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RestingStatus resting)? resting,
    TResult? Function(FilledStatus filled)? filled,
    TResult? Function(String error)? error,
    TResult? Function(String status)? status,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RestingStatus resting)? resting,
    TResult Function(FilledStatus filled)? filled,
    TResult Function(String error)? error,
    TResult Function(String status)? status,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Resting value) resting,
    required TResult Function(_Filled value) filled,
    required TResult Function(_Error value) error,
    required TResult Function(_Status value) status,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Resting value)? resting,
    TResult? Function(_Filled value)? filled,
    TResult? Function(_Error value)? error,
    TResult? Function(_Status value)? status,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Resting value)? resting,
    TResult Function(_Filled value)? filled,
    TResult Function(_Error value)? error,
    TResult Function(_Status value)? status,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorImplToJson(
      this,
    );
  }
}

abstract class _Error implements StatusResponse {
  const factory _Error(final String error) = _$ErrorImpl;

  factory _Error.fromJson(Map<String, dynamic> json) = _$ErrorImpl.fromJson;

  String get error;

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StatusImplCopyWith<$Res> {
  factory _$$StatusImplCopyWith(
          _$StatusImpl value, $Res Function(_$StatusImpl) then) =
      __$$StatusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String status});
}

/// @nodoc
class __$$StatusImplCopyWithImpl<$Res>
    extends _$StatusResponseCopyWithImpl<$Res, _$StatusImpl>
    implements _$$StatusImplCopyWith<$Res> {
  __$$StatusImplCopyWithImpl(
      _$StatusImpl _value, $Res Function(_$StatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$StatusImpl(
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusImpl implements _Status {
  const _$StatusImpl(this.status, {final String? $type})
      : $type = $type ?? 'status';

  factory _$StatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusImplFromJson(json);

  @override
  final String status;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'StatusResponse.status(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusImplCopyWith<_$StatusImpl> get copyWith =>
      __$$StatusImplCopyWithImpl<_$StatusImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RestingStatus resting) resting,
    required TResult Function(FilledStatus filled) filled,
    required TResult Function(String error) error,
    required TResult Function(String status) status,
  }) {
    return status(this.status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RestingStatus resting)? resting,
    TResult? Function(FilledStatus filled)? filled,
    TResult? Function(String error)? error,
    TResult? Function(String status)? status,
  }) {
    return status?.call(this.status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RestingStatus resting)? resting,
    TResult Function(FilledStatus filled)? filled,
    TResult Function(String error)? error,
    TResult Function(String status)? status,
    required TResult orElse(),
  }) {
    if (status != null) {
      return status(this.status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Resting value) resting,
    required TResult Function(_Filled value) filled,
    required TResult Function(_Error value) error,
    required TResult Function(_Status value) status,
  }) {
    return status(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Resting value)? resting,
    TResult? Function(_Filled value)? filled,
    TResult? Function(_Error value)? error,
    TResult? Function(_Status value)? status,
  }) {
    return status?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Resting value)? resting,
    TResult Function(_Filled value)? filled,
    TResult Function(_Error value)? error,
    TResult Function(_Status value)? status,
    required TResult orElse(),
  }) {
    if (status != null) {
      return status(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusImplToJson(
      this,
    );
  }
}

abstract class _Status implements StatusResponse {
  const factory _Status(final String status) = _$StatusImpl;

  factory _Status.fromJson(Map<String, dynamic> json) = _$StatusImpl.fromJson;

  String get status;

  /// Create a copy of StatusResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusImplCopyWith<_$StatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RestingStatus _$RestingStatusFromJson(Map<String, dynamic> json) {
  return _RestingStatus.fromJson(json);
}

/// @nodoc
mixin _$RestingStatus {
  int get oid => throw _privateConstructorUsedError;
  String? get cloid => throw _privateConstructorUsedError;

  /// Serializes this RestingStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RestingStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestingStatusCopyWith<RestingStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestingStatusCopyWith<$Res> {
  factory $RestingStatusCopyWith(
          RestingStatus value, $Res Function(RestingStatus) then) =
      _$RestingStatusCopyWithImpl<$Res, RestingStatus>;
  @useResult
  $Res call({int oid, String? cloid});
}

/// @nodoc
class _$RestingStatusCopyWithImpl<$Res, $Val extends RestingStatus>
    implements $RestingStatusCopyWith<$Res> {
  _$RestingStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestingStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oid = null,
    Object? cloid = freezed,
  }) {
    return _then(_value.copyWith(
      oid: null == oid
          ? _value.oid
          : oid // ignore: cast_nullable_to_non_nullable
              as int,
      cloid: freezed == cloid
          ? _value.cloid
          : cloid // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RestingStatusImplCopyWith<$Res>
    implements $RestingStatusCopyWith<$Res> {
  factory _$$RestingStatusImplCopyWith(
          _$RestingStatusImpl value, $Res Function(_$RestingStatusImpl) then) =
      __$$RestingStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int oid, String? cloid});
}

/// @nodoc
class __$$RestingStatusImplCopyWithImpl<$Res>
    extends _$RestingStatusCopyWithImpl<$Res, _$RestingStatusImpl>
    implements _$$RestingStatusImplCopyWith<$Res> {
  __$$RestingStatusImplCopyWithImpl(
      _$RestingStatusImpl _value, $Res Function(_$RestingStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of RestingStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oid = null,
    Object? cloid = freezed,
  }) {
    return _then(_$RestingStatusImpl(
      oid: null == oid
          ? _value.oid
          : oid // ignore: cast_nullable_to_non_nullable
              as int,
      cloid: freezed == cloid
          ? _value.cloid
          : cloid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RestingStatusImpl implements _RestingStatus {
  const _$RestingStatusImpl({required this.oid, this.cloid});

  factory _$RestingStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestingStatusImplFromJson(json);

  @override
  final int oid;
  @override
  final String? cloid;

  @override
  String toString() {
    return 'RestingStatus(oid: $oid, cloid: $cloid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestingStatusImpl &&
            (identical(other.oid, oid) || other.oid == oid) &&
            (identical(other.cloid, cloid) || other.cloid == cloid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, oid, cloid);

  /// Create a copy of RestingStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestingStatusImplCopyWith<_$RestingStatusImpl> get copyWith =>
      __$$RestingStatusImplCopyWithImpl<_$RestingStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestingStatusImplToJson(
      this,
    );
  }
}

abstract class _RestingStatus implements RestingStatus {
  const factory _RestingStatus({required final int oid, final String? cloid}) =
      _$RestingStatusImpl;

  factory _RestingStatus.fromJson(Map<String, dynamic> json) =
      _$RestingStatusImpl.fromJson;

  @override
  int get oid;
  @override
  String? get cloid;

  /// Create a copy of RestingStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestingStatusImplCopyWith<_$RestingStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FilledStatus _$FilledStatusFromJson(Map<String, dynamic> json) {
  return _FilledStatus.fromJson(json);
}

/// @nodoc
mixin _$FilledStatus {
  int get oid => throw _privateConstructorUsedError;
  double get avgPx => throw _privateConstructorUsedError;
  double get totalSz => throw _privateConstructorUsedError;
  String? get cloid => throw _privateConstructorUsedError;

  /// Serializes this FilledStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FilledStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilledStatusCopyWith<FilledStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilledStatusCopyWith<$Res> {
  factory $FilledStatusCopyWith(
          FilledStatus value, $Res Function(FilledStatus) then) =
      _$FilledStatusCopyWithImpl<$Res, FilledStatus>;
  @useResult
  $Res call({int oid, double avgPx, double totalSz, String? cloid});
}

/// @nodoc
class _$FilledStatusCopyWithImpl<$Res, $Val extends FilledStatus>
    implements $FilledStatusCopyWith<$Res> {
  _$FilledStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilledStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oid = null,
    Object? avgPx = null,
    Object? totalSz = null,
    Object? cloid = freezed,
  }) {
    return _then(_value.copyWith(
      oid: null == oid
          ? _value.oid
          : oid // ignore: cast_nullable_to_non_nullable
              as int,
      avgPx: null == avgPx
          ? _value.avgPx
          : avgPx // ignore: cast_nullable_to_non_nullable
              as double,
      totalSz: null == totalSz
          ? _value.totalSz
          : totalSz // ignore: cast_nullable_to_non_nullable
              as double,
      cloid: freezed == cloid
          ? _value.cloid
          : cloid // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilledStatusImplCopyWith<$Res>
    implements $FilledStatusCopyWith<$Res> {
  factory _$$FilledStatusImplCopyWith(
          _$FilledStatusImpl value, $Res Function(_$FilledStatusImpl) then) =
      __$$FilledStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int oid, double avgPx, double totalSz, String? cloid});
}

/// @nodoc
class __$$FilledStatusImplCopyWithImpl<$Res>
    extends _$FilledStatusCopyWithImpl<$Res, _$FilledStatusImpl>
    implements _$$FilledStatusImplCopyWith<$Res> {
  __$$FilledStatusImplCopyWithImpl(
      _$FilledStatusImpl _value, $Res Function(_$FilledStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilledStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oid = null,
    Object? avgPx = null,
    Object? totalSz = null,
    Object? cloid = freezed,
  }) {
    return _then(_$FilledStatusImpl(
      oid: null == oid
          ? _value.oid
          : oid // ignore: cast_nullable_to_non_nullable
              as int,
      avgPx: null == avgPx
          ? _value.avgPx
          : avgPx // ignore: cast_nullable_to_non_nullable
              as double,
      totalSz: null == totalSz
          ? _value.totalSz
          : totalSz // ignore: cast_nullable_to_non_nullable
              as double,
      cloid: freezed == cloid
          ? _value.cloid
          : cloid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FilledStatusImpl implements _FilledStatus {
  const _$FilledStatusImpl(
      {required this.oid,
      required this.avgPx,
      required this.totalSz,
      this.cloid});

  factory _$FilledStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilledStatusImplFromJson(json);

  @override
  final int oid;
  @override
  final double avgPx;
  @override
  final double totalSz;
  @override
  final String? cloid;

  @override
  String toString() {
    return 'FilledStatus(oid: $oid, avgPx: $avgPx, totalSz: $totalSz, cloid: $cloid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilledStatusImpl &&
            (identical(other.oid, oid) || other.oid == oid) &&
            (identical(other.avgPx, avgPx) || other.avgPx == avgPx) &&
            (identical(other.totalSz, totalSz) || other.totalSz == totalSz) &&
            (identical(other.cloid, cloid) || other.cloid == cloid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, oid, avgPx, totalSz, cloid);

  /// Create a copy of FilledStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilledStatusImplCopyWith<_$FilledStatusImpl> get copyWith =>
      __$$FilledStatusImplCopyWithImpl<_$FilledStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilledStatusImplToJson(
      this,
    );
  }
}

abstract class _FilledStatus implements FilledStatus {
  const factory _FilledStatus(
      {required final int oid,
      required final double avgPx,
      required final double totalSz,
      final String? cloid}) = _$FilledStatusImpl;

  factory _FilledStatus.fromJson(Map<String, dynamic> json) =
      _$FilledStatusImpl.fromJson;

  @override
  int get oid;
  @override
  double get avgPx;
  @override
  double get totalSz;
  @override
  String? get cloid;

  /// Create a copy of FilledStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilledStatusImplCopyWith<_$FilledStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CancelRequest _$CancelRequestFromJson(Map<String, dynamic> json) {
  return _CancelRequest.fromJson(json);
}

/// @nodoc
mixin _$CancelRequest {
  int get oid => throw _privateConstructorUsedError;
  int get coin => throw _privateConstructorUsedError;

  /// Serializes this CancelRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CancelRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CancelRequestCopyWith<CancelRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CancelRequestCopyWith<$Res> {
  factory $CancelRequestCopyWith(
          CancelRequest value, $Res Function(CancelRequest) then) =
      _$CancelRequestCopyWithImpl<$Res, CancelRequest>;
  @useResult
  $Res call({int oid, int coin});
}

/// @nodoc
class _$CancelRequestCopyWithImpl<$Res, $Val extends CancelRequest>
    implements $CancelRequestCopyWith<$Res> {
  _$CancelRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CancelRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oid = null,
    Object? coin = null,
  }) {
    return _then(_value.copyWith(
      oid: null == oid
          ? _value.oid
          : oid // ignore: cast_nullable_to_non_nullable
              as int,
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CancelRequestImplCopyWith<$Res>
    implements $CancelRequestCopyWith<$Res> {
  factory _$$CancelRequestImplCopyWith(
          _$CancelRequestImpl value, $Res Function(_$CancelRequestImpl) then) =
      __$$CancelRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int oid, int coin});
}

/// @nodoc
class __$$CancelRequestImplCopyWithImpl<$Res>
    extends _$CancelRequestCopyWithImpl<$Res, _$CancelRequestImpl>
    implements _$$CancelRequestImplCopyWith<$Res> {
  __$$CancelRequestImplCopyWithImpl(
      _$CancelRequestImpl _value, $Res Function(_$CancelRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CancelRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oid = null,
    Object? coin = null,
  }) {
    return _then(_$CancelRequestImpl(
      oid: null == oid
          ? _value.oid
          : oid // ignore: cast_nullable_to_non_nullable
              as int,
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CancelRequestImpl implements _CancelRequest {
  const _$CancelRequestImpl({required this.oid, required this.coin});

  factory _$CancelRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CancelRequestImplFromJson(json);

  @override
  final int oid;
  @override
  final int coin;

  @override
  String toString() {
    return 'CancelRequest(oid: $oid, coin: $coin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelRequestImpl &&
            (identical(other.oid, oid) || other.oid == oid) &&
            (identical(other.coin, coin) || other.coin == coin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, oid, coin);

  /// Create a copy of CancelRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelRequestImplCopyWith<_$CancelRequestImpl> get copyWith =>
      __$$CancelRequestImplCopyWithImpl<_$CancelRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CancelRequestImplToJson(
      this,
    );
  }
}

abstract class _CancelRequest implements CancelRequest {
  const factory _CancelRequest(
      {required final int oid, required final int coin}) = _$CancelRequestImpl;

  factory _CancelRequest.fromJson(Map<String, dynamic> json) =
      _$CancelRequestImpl.fromJson;

  @override
  int get oid;
  @override
  int get coin;

  /// Create a copy of CancelRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CancelRequestImplCopyWith<_$CancelRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
