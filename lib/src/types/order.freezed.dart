// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) {
  return _OrderRequest.fromJson(json);
}

/// @nodoc
mixin _$OrderRequest {
  String get coin => throw _privateConstructorUsedError;
  bool get isBuy => throw _privateConstructorUsedError;
  double get sz => throw _privateConstructorUsedError;
  double get limitPx => throw _privateConstructorUsedError;
  OrderType get orderType => throw _privateConstructorUsedError;
  bool get reduceOnly => throw _privateConstructorUsedError;
  String? get cloid => throw _privateConstructorUsedError;

  /// Serializes this OrderRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderRequestCopyWith<OrderRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderRequestCopyWith<$Res> {
  factory $OrderRequestCopyWith(
          OrderRequest value, $Res Function(OrderRequest) then) =
      _$OrderRequestCopyWithImpl<$Res, OrderRequest>;
  @useResult
  $Res call(
      {String coin,
      bool isBuy,
      double sz,
      double limitPx,
      OrderType orderType,
      bool reduceOnly,
      String? cloid});

  $OrderTypeCopyWith<$Res> get orderType;
}

/// @nodoc
class _$OrderRequestCopyWithImpl<$Res, $Val extends OrderRequest>
    implements $OrderRequestCopyWith<$Res> {
  _$OrderRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coin = null,
    Object? isBuy = null,
    Object? sz = null,
    Object? limitPx = null,
    Object? orderType = null,
    Object? reduceOnly = null,
    Object? cloid = freezed,
  }) {
    return _then(_value.copyWith(
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as String,
      isBuy: null == isBuy
          ? _value.isBuy
          : isBuy // ignore: cast_nullable_to_non_nullable
              as bool,
      sz: null == sz
          ? _value.sz
          : sz // ignore: cast_nullable_to_non_nullable
              as double,
      limitPx: null == limitPx
          ? _value.limitPx
          : limitPx // ignore: cast_nullable_to_non_nullable
              as double,
      orderType: null == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as OrderType,
      reduceOnly: null == reduceOnly
          ? _value.reduceOnly
          : reduceOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      cloid: freezed == cloid
          ? _value.cloid
          : cloid // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of OrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderTypeCopyWith<$Res> get orderType {
    return $OrderTypeCopyWith<$Res>(_value.orderType, (value) {
      return _then(_value.copyWith(orderType: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderRequestImplCopyWith<$Res>
    implements $OrderRequestCopyWith<$Res> {
  factory _$$OrderRequestImplCopyWith(
          _$OrderRequestImpl value, $Res Function(_$OrderRequestImpl) then) =
      __$$OrderRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String coin,
      bool isBuy,
      double sz,
      double limitPx,
      OrderType orderType,
      bool reduceOnly,
      String? cloid});

  @override
  $OrderTypeCopyWith<$Res> get orderType;
}

/// @nodoc
class __$$OrderRequestImplCopyWithImpl<$Res>
    extends _$OrderRequestCopyWithImpl<$Res, _$OrderRequestImpl>
    implements _$$OrderRequestImplCopyWith<$Res> {
  __$$OrderRequestImplCopyWithImpl(
      _$OrderRequestImpl _value, $Res Function(_$OrderRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coin = null,
    Object? isBuy = null,
    Object? sz = null,
    Object? limitPx = null,
    Object? orderType = null,
    Object? reduceOnly = null,
    Object? cloid = freezed,
  }) {
    return _then(_$OrderRequestImpl(
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as String,
      isBuy: null == isBuy
          ? _value.isBuy
          : isBuy // ignore: cast_nullable_to_non_nullable
              as bool,
      sz: null == sz
          ? _value.sz
          : sz // ignore: cast_nullable_to_non_nullable
              as double,
      limitPx: null == limitPx
          ? _value.limitPx
          : limitPx // ignore: cast_nullable_to_non_nullable
              as double,
      orderType: null == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as OrderType,
      reduceOnly: null == reduceOnly
          ? _value.reduceOnly
          : reduceOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      cloid: freezed == cloid
          ? _value.cloid
          : cloid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderRequestImpl implements _OrderRequest {
  const _$OrderRequestImpl(
      {required this.coin,
      required this.isBuy,
      required this.sz,
      required this.limitPx,
      required this.orderType,
      required this.reduceOnly,
      this.cloid});

  factory _$OrderRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderRequestImplFromJson(json);

  @override
  final String coin;
  @override
  final bool isBuy;
  @override
  final double sz;
  @override
  final double limitPx;
  @override
  final OrderType orderType;
  @override
  final bool reduceOnly;
  @override
  final String? cloid;

  @override
  String toString() {
    return 'OrderRequest(coin: $coin, isBuy: $isBuy, sz: $sz, limitPx: $limitPx, orderType: $orderType, reduceOnly: $reduceOnly, cloid: $cloid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderRequestImpl &&
            (identical(other.coin, coin) || other.coin == coin) &&
            (identical(other.isBuy, isBuy) || other.isBuy == isBuy) &&
            (identical(other.sz, sz) || other.sz == sz) &&
            (identical(other.limitPx, limitPx) || other.limitPx == limitPx) &&
            (identical(other.orderType, orderType) ||
                other.orderType == orderType) &&
            (identical(other.reduceOnly, reduceOnly) ||
                other.reduceOnly == reduceOnly) &&
            (identical(other.cloid, cloid) || other.cloid == cloid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, coin, isBuy, sz, limitPx, orderType, reduceOnly, cloid);

  /// Create a copy of OrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderRequestImplCopyWith<_$OrderRequestImpl> get copyWith =>
      __$$OrderRequestImplCopyWithImpl<_$OrderRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderRequestImplToJson(
      this,
    );
  }
}

abstract class _OrderRequest implements OrderRequest {
  const factory _OrderRequest(
      {required final String coin,
      required final bool isBuy,
      required final double sz,
      required final double limitPx,
      required final OrderType orderType,
      required final bool reduceOnly,
      final String? cloid}) = _$OrderRequestImpl;

  factory _OrderRequest.fromJson(Map<String, dynamic> json) =
      _$OrderRequestImpl.fromJson;

  @override
  String get coin;
  @override
  bool get isBuy;
  @override
  double get sz;
  @override
  double get limitPx;
  @override
  OrderType get orderType;
  @override
  bool get reduceOnly;
  @override
  String? get cloid;

  /// Create a copy of OrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderRequestImplCopyWith<_$OrderRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderType _$OrderTypeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'limit':
      return _LimitOrderType.fromJson(json);
    case 'trigger':
      return _TriggerOrderType.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'OrderType',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$OrderType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LimitOrderType limit) limit,
    required TResult Function(TriggerOrderType trigger) trigger,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LimitOrderType limit)? limit,
    TResult? Function(TriggerOrderType trigger)? trigger,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LimitOrderType limit)? limit,
    TResult Function(TriggerOrderType trigger)? trigger,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LimitOrderType value) limit,
    required TResult Function(_TriggerOrderType value) trigger,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LimitOrderType value)? limit,
    TResult? Function(_TriggerOrderType value)? trigger,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LimitOrderType value)? limit,
    TResult Function(_TriggerOrderType value)? trigger,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this OrderType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderTypeCopyWith<$Res> {
  factory $OrderTypeCopyWith(OrderType value, $Res Function(OrderType) then) =
      _$OrderTypeCopyWithImpl<$Res, OrderType>;
}

/// @nodoc
class _$OrderTypeCopyWithImpl<$Res, $Val extends OrderType>
    implements $OrderTypeCopyWith<$Res> {
  _$OrderTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderType
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LimitOrderTypeImplCopyWith<$Res> {
  factory _$$LimitOrderTypeImplCopyWith(_$LimitOrderTypeImpl value,
          $Res Function(_$LimitOrderTypeImpl) then) =
      __$$LimitOrderTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LimitOrderType limit});

  $LimitOrderTypeCopyWith<$Res> get limit;
}

/// @nodoc
class __$$LimitOrderTypeImplCopyWithImpl<$Res>
    extends _$OrderTypeCopyWithImpl<$Res, _$LimitOrderTypeImpl>
    implements _$$LimitOrderTypeImplCopyWith<$Res> {
  __$$LimitOrderTypeImplCopyWithImpl(
      _$LimitOrderTypeImpl _value, $Res Function(_$LimitOrderTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = null,
  }) {
    return _then(_$LimitOrderTypeImpl(
      null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as LimitOrderType,
    ));
  }

  /// Create a copy of OrderType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LimitOrderTypeCopyWith<$Res> get limit {
    return $LimitOrderTypeCopyWith<$Res>(_value.limit, (value) {
      return _then(_value.copyWith(limit: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$LimitOrderTypeImpl implements _LimitOrderType {
  const _$LimitOrderTypeImpl(this.limit, {final String? $type})
      : $type = $type ?? 'limit';

  factory _$LimitOrderTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$LimitOrderTypeImplFromJson(json);

  @override
  final LimitOrderType limit;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'OrderType.limit(limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LimitOrderTypeImpl &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, limit);

  /// Create a copy of OrderType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LimitOrderTypeImplCopyWith<_$LimitOrderTypeImpl> get copyWith =>
      __$$LimitOrderTypeImplCopyWithImpl<_$LimitOrderTypeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LimitOrderType limit) limit,
    required TResult Function(TriggerOrderType trigger) trigger,
  }) {
    return limit(this.limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LimitOrderType limit)? limit,
    TResult? Function(TriggerOrderType trigger)? trigger,
  }) {
    return limit?.call(this.limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LimitOrderType limit)? limit,
    TResult Function(TriggerOrderType trigger)? trigger,
    required TResult orElse(),
  }) {
    if (limit != null) {
      return limit(this.limit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LimitOrderType value) limit,
    required TResult Function(_TriggerOrderType value) trigger,
  }) {
    return limit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LimitOrderType value)? limit,
    TResult? Function(_TriggerOrderType value)? trigger,
  }) {
    return limit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LimitOrderType value)? limit,
    TResult Function(_TriggerOrderType value)? trigger,
    required TResult orElse(),
  }) {
    if (limit != null) {
      return limit(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LimitOrderTypeImplToJson(
      this,
    );
  }
}

abstract class _LimitOrderType implements OrderType {
  const factory _LimitOrderType(final LimitOrderType limit) =
      _$LimitOrderTypeImpl;

  factory _LimitOrderType.fromJson(Map<String, dynamic> json) =
      _$LimitOrderTypeImpl.fromJson;

  LimitOrderType get limit;

  /// Create a copy of OrderType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LimitOrderTypeImplCopyWith<_$LimitOrderTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TriggerOrderTypeImplCopyWith<$Res> {
  factory _$$TriggerOrderTypeImplCopyWith(_$TriggerOrderTypeImpl value,
          $Res Function(_$TriggerOrderTypeImpl) then) =
      __$$TriggerOrderTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TriggerOrderType trigger});

  $TriggerOrderTypeCopyWith<$Res> get trigger;
}

/// @nodoc
class __$$TriggerOrderTypeImplCopyWithImpl<$Res>
    extends _$OrderTypeCopyWithImpl<$Res, _$TriggerOrderTypeImpl>
    implements _$$TriggerOrderTypeImplCopyWith<$Res> {
  __$$TriggerOrderTypeImplCopyWithImpl(_$TriggerOrderTypeImpl _value,
      $Res Function(_$TriggerOrderTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trigger = null,
  }) {
    return _then(_$TriggerOrderTypeImpl(
      null == trigger
          ? _value.trigger
          : trigger // ignore: cast_nullable_to_non_nullable
              as TriggerOrderType,
    ));
  }

  /// Create a copy of OrderType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TriggerOrderTypeCopyWith<$Res> get trigger {
    return $TriggerOrderTypeCopyWith<$Res>(_value.trigger, (value) {
      return _then(_value.copyWith(trigger: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TriggerOrderTypeImpl implements _TriggerOrderType {
  const _$TriggerOrderTypeImpl(this.trigger, {final String? $type})
      : $type = $type ?? 'trigger';

  factory _$TriggerOrderTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TriggerOrderTypeImplFromJson(json);

  @override
  final TriggerOrderType trigger;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'OrderType.trigger(trigger: $trigger)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TriggerOrderTypeImpl &&
            (identical(other.trigger, trigger) || other.trigger == trigger));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, trigger);

  /// Create a copy of OrderType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TriggerOrderTypeImplCopyWith<_$TriggerOrderTypeImpl> get copyWith =>
      __$$TriggerOrderTypeImplCopyWithImpl<_$TriggerOrderTypeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(LimitOrderType limit) limit,
    required TResult Function(TriggerOrderType trigger) trigger,
  }) {
    return trigger(this.trigger);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(LimitOrderType limit)? limit,
    TResult? Function(TriggerOrderType trigger)? trigger,
  }) {
    return trigger?.call(this.trigger);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(LimitOrderType limit)? limit,
    TResult Function(TriggerOrderType trigger)? trigger,
    required TResult orElse(),
  }) {
    if (trigger != null) {
      return trigger(this.trigger);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LimitOrderType value) limit,
    required TResult Function(_TriggerOrderType value) trigger,
  }) {
    return trigger(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LimitOrderType value)? limit,
    TResult? Function(_TriggerOrderType value)? trigger,
  }) {
    return trigger?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LimitOrderType value)? limit,
    TResult Function(_TriggerOrderType value)? trigger,
    required TResult orElse(),
  }) {
    if (trigger != null) {
      return trigger(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TriggerOrderTypeImplToJson(
      this,
    );
  }
}

abstract class _TriggerOrderType implements OrderType {
  const factory _TriggerOrderType(final TriggerOrderType trigger) =
      _$TriggerOrderTypeImpl;

  factory _TriggerOrderType.fromJson(Map<String, dynamic> json) =
      _$TriggerOrderTypeImpl.fromJson;

  TriggerOrderType get trigger;

  /// Create a copy of OrderType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TriggerOrderTypeImplCopyWith<_$TriggerOrderTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LimitOrderType _$LimitOrderTypeFromJson(Map<String, dynamic> json) {
  return _LimitOrderTypeData.fromJson(json);
}

/// @nodoc
mixin _$LimitOrderType {
  String get tif => throw _privateConstructorUsedError;

  /// Serializes this LimitOrderType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LimitOrderType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LimitOrderTypeCopyWith<LimitOrderType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LimitOrderTypeCopyWith<$Res> {
  factory $LimitOrderTypeCopyWith(
          LimitOrderType value, $Res Function(LimitOrderType) then) =
      _$LimitOrderTypeCopyWithImpl<$Res, LimitOrderType>;
  @useResult
  $Res call({String tif});
}

/// @nodoc
class _$LimitOrderTypeCopyWithImpl<$Res, $Val extends LimitOrderType>
    implements $LimitOrderTypeCopyWith<$Res> {
  _$LimitOrderTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LimitOrderType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tif = null,
  }) {
    return _then(_value.copyWith(
      tif: null == tif
          ? _value.tif
          : tif // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LimitOrderTypeDataImplCopyWith<$Res>
    implements $LimitOrderTypeCopyWith<$Res> {
  factory _$$LimitOrderTypeDataImplCopyWith(_$LimitOrderTypeDataImpl value,
          $Res Function(_$LimitOrderTypeDataImpl) then) =
      __$$LimitOrderTypeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String tif});
}

/// @nodoc
class __$$LimitOrderTypeDataImplCopyWithImpl<$Res>
    extends _$LimitOrderTypeCopyWithImpl<$Res, _$LimitOrderTypeDataImpl>
    implements _$$LimitOrderTypeDataImplCopyWith<$Res> {
  __$$LimitOrderTypeDataImplCopyWithImpl(_$LimitOrderTypeDataImpl _value,
      $Res Function(_$LimitOrderTypeDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of LimitOrderType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tif = null,
  }) {
    return _then(_$LimitOrderTypeDataImpl(
      tif: null == tif
          ? _value.tif
          : tif // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LimitOrderTypeDataImpl implements _LimitOrderTypeData {
  const _$LimitOrderTypeDataImpl({required this.tif});

  factory _$LimitOrderTypeDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LimitOrderTypeDataImplFromJson(json);

  @override
  final String tif;

  @override
  String toString() {
    return 'LimitOrderType(tif: $tif)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LimitOrderTypeDataImpl &&
            (identical(other.tif, tif) || other.tif == tif));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tif);

  /// Create a copy of LimitOrderType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LimitOrderTypeDataImplCopyWith<_$LimitOrderTypeDataImpl> get copyWith =>
      __$$LimitOrderTypeDataImplCopyWithImpl<_$LimitOrderTypeDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LimitOrderTypeDataImplToJson(
      this,
    );
  }
}

abstract class _LimitOrderTypeData implements LimitOrderType {
  const factory _LimitOrderTypeData({required final String tif}) =
      _$LimitOrderTypeDataImpl;

  factory _LimitOrderTypeData.fromJson(Map<String, dynamic> json) =
      _$LimitOrderTypeDataImpl.fromJson;

  @override
  String get tif;

  /// Create a copy of LimitOrderType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LimitOrderTypeDataImplCopyWith<_$LimitOrderTypeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TriggerOrderType _$TriggerOrderTypeFromJson(Map<String, dynamic> json) {
  return _TriggerOrderTypeData.fromJson(json);
}

/// @nodoc
mixin _$TriggerOrderType {
  bool get isMarket => throw _privateConstructorUsedError;
  double get triggerPx => throw _privateConstructorUsedError;
  String get tpsl => throw _privateConstructorUsedError;

  /// Serializes this TriggerOrderType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TriggerOrderType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TriggerOrderTypeCopyWith<TriggerOrderType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TriggerOrderTypeCopyWith<$Res> {
  factory $TriggerOrderTypeCopyWith(
          TriggerOrderType value, $Res Function(TriggerOrderType) then) =
      _$TriggerOrderTypeCopyWithImpl<$Res, TriggerOrderType>;
  @useResult
  $Res call({bool isMarket, double triggerPx, String tpsl});
}

/// @nodoc
class _$TriggerOrderTypeCopyWithImpl<$Res, $Val extends TriggerOrderType>
    implements $TriggerOrderTypeCopyWith<$Res> {
  _$TriggerOrderTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TriggerOrderType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isMarket = null,
    Object? triggerPx = null,
    Object? tpsl = null,
  }) {
    return _then(_value.copyWith(
      isMarket: null == isMarket
          ? _value.isMarket
          : isMarket // ignore: cast_nullable_to_non_nullable
              as bool,
      triggerPx: null == triggerPx
          ? _value.triggerPx
          : triggerPx // ignore: cast_nullable_to_non_nullable
              as double,
      tpsl: null == tpsl
          ? _value.tpsl
          : tpsl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TriggerOrderTypeDataImplCopyWith<$Res>
    implements $TriggerOrderTypeCopyWith<$Res> {
  factory _$$TriggerOrderTypeDataImplCopyWith(_$TriggerOrderTypeDataImpl value,
          $Res Function(_$TriggerOrderTypeDataImpl) then) =
      __$$TriggerOrderTypeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isMarket, double triggerPx, String tpsl});
}

/// @nodoc
class __$$TriggerOrderTypeDataImplCopyWithImpl<$Res>
    extends _$TriggerOrderTypeCopyWithImpl<$Res, _$TriggerOrderTypeDataImpl>
    implements _$$TriggerOrderTypeDataImplCopyWith<$Res> {
  __$$TriggerOrderTypeDataImplCopyWithImpl(_$TriggerOrderTypeDataImpl _value,
      $Res Function(_$TriggerOrderTypeDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TriggerOrderType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isMarket = null,
    Object? triggerPx = null,
    Object? tpsl = null,
  }) {
    return _then(_$TriggerOrderTypeDataImpl(
      isMarket: null == isMarket
          ? _value.isMarket
          : isMarket // ignore: cast_nullable_to_non_nullable
              as bool,
      triggerPx: null == triggerPx
          ? _value.triggerPx
          : triggerPx // ignore: cast_nullable_to_non_nullable
              as double,
      tpsl: null == tpsl
          ? _value.tpsl
          : tpsl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TriggerOrderTypeDataImpl implements _TriggerOrderTypeData {
  const _$TriggerOrderTypeDataImpl(
      {required this.isMarket, required this.triggerPx, required this.tpsl});

  factory _$TriggerOrderTypeDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TriggerOrderTypeDataImplFromJson(json);

  @override
  final bool isMarket;
  @override
  final double triggerPx;
  @override
  final String tpsl;

  @override
  String toString() {
    return 'TriggerOrderType(isMarket: $isMarket, triggerPx: $triggerPx, tpsl: $tpsl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TriggerOrderTypeDataImpl &&
            (identical(other.isMarket, isMarket) ||
                other.isMarket == isMarket) &&
            (identical(other.triggerPx, triggerPx) ||
                other.triggerPx == triggerPx) &&
            (identical(other.tpsl, tpsl) || other.tpsl == tpsl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isMarket, triggerPx, tpsl);

  /// Create a copy of TriggerOrderType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TriggerOrderTypeDataImplCopyWith<_$TriggerOrderTypeDataImpl>
      get copyWith =>
          __$$TriggerOrderTypeDataImplCopyWithImpl<_$TriggerOrderTypeDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TriggerOrderTypeDataImplToJson(
      this,
    );
  }
}

abstract class _TriggerOrderTypeData implements TriggerOrderType {
  const factory _TriggerOrderTypeData(
      {required final bool isMarket,
      required final double triggerPx,
      required final String tpsl}) = _$TriggerOrderTypeDataImpl;

  factory _TriggerOrderTypeData.fromJson(Map<String, dynamic> json) =
      _$TriggerOrderTypeDataImpl.fromJson;

  @override
  bool get isMarket;
  @override
  double get triggerPx;
  @override
  String get tpsl;

  /// Create a copy of TriggerOrderType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TriggerOrderTypeDataImplCopyWith<_$TriggerOrderTypeDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
