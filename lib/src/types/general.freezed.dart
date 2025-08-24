// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'general.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllMids _$AllMidsFromJson(Map<String, dynamic> json) {
  return _AllMids.fromJson(json);
}

/// @nodoc
mixin _$AllMids {
  Map<String, String> get mids => throw _privateConstructorUsedError;

  /// Serializes this AllMids to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AllMids
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllMidsCopyWith<AllMids> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllMidsCopyWith<$Res> {
  factory $AllMidsCopyWith(AllMids value, $Res Function(AllMids) then) =
      _$AllMidsCopyWithImpl<$Res, AllMids>;
  @useResult
  $Res call({Map<String, String> mids});
}

/// @nodoc
class _$AllMidsCopyWithImpl<$Res, $Val extends AllMids>
    implements $AllMidsCopyWith<$Res> {
  _$AllMidsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllMids
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mids = null,
  }) {
    return _then(_value.copyWith(
      mids: null == mids
          ? _value.mids
          : mids // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllMidsImplCopyWith<$Res> implements $AllMidsCopyWith<$Res> {
  factory _$$AllMidsImplCopyWith(
          _$AllMidsImpl value, $Res Function(_$AllMidsImpl) then) =
      __$$AllMidsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, String> mids});
}

/// @nodoc
class __$$AllMidsImplCopyWithImpl<$Res>
    extends _$AllMidsCopyWithImpl<$Res, _$AllMidsImpl>
    implements _$$AllMidsImplCopyWith<$Res> {
  __$$AllMidsImplCopyWithImpl(
      _$AllMidsImpl _value, $Res Function(_$AllMidsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllMids
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mids = null,
  }) {
    return _then(_$AllMidsImpl(
      mids: null == mids
          ? _value._mids
          : mids // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllMidsImpl implements _AllMids {
  const _$AllMidsImpl({required final Map<String, String> mids}) : _mids = mids;

  factory _$AllMidsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllMidsImplFromJson(json);

  final Map<String, String> _mids;
  @override
  Map<String, String> get mids {
    if (_mids is EqualUnmodifiableMapView) return _mids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_mids);
  }

  @override
  String toString() {
    return 'AllMids(mids: $mids)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllMidsImpl &&
            const DeepCollectionEquality().equals(other._mids, _mids));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_mids));

  /// Create a copy of AllMids
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllMidsImplCopyWith<_$AllMidsImpl> get copyWith =>
      __$$AllMidsImplCopyWithImpl<_$AllMidsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllMidsImplToJson(
      this,
    );
  }
}

abstract class _AllMids implements AllMids {
  const factory _AllMids({required final Map<String, String> mids}) =
      _$AllMidsImpl;

  factory _AllMids.fromJson(Map<String, dynamic> json) = _$AllMidsImpl.fromJson;

  @override
  Map<String, String> get mids;

  /// Create a copy of AllMids
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllMidsImplCopyWith<_$AllMidsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserOpenOrders _$UserOpenOrdersFromJson(Map<String, dynamic> json) {
  return _UserOpenOrders.fromJson(json);
}

/// @nodoc
mixin _$UserOpenOrders {
  List<UserOpenOrder> get orders => throw _privateConstructorUsedError;

  /// Serializes this UserOpenOrders to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserOpenOrders
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserOpenOrdersCopyWith<UserOpenOrders> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserOpenOrdersCopyWith<$Res> {
  factory $UserOpenOrdersCopyWith(
          UserOpenOrders value, $Res Function(UserOpenOrders) then) =
      _$UserOpenOrdersCopyWithImpl<$Res, UserOpenOrders>;
  @useResult
  $Res call({List<UserOpenOrder> orders});
}

/// @nodoc
class _$UserOpenOrdersCopyWithImpl<$Res, $Val extends UserOpenOrders>
    implements $UserOpenOrdersCopyWith<$Res> {
  _$UserOpenOrdersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserOpenOrders
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
  }) {
    return _then(_value.copyWith(
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<UserOpenOrder>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserOpenOrdersImplCopyWith<$Res>
    implements $UserOpenOrdersCopyWith<$Res> {
  factory _$$UserOpenOrdersImplCopyWith(_$UserOpenOrdersImpl value,
          $Res Function(_$UserOpenOrdersImpl) then) =
      __$$UserOpenOrdersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UserOpenOrder> orders});
}

/// @nodoc
class __$$UserOpenOrdersImplCopyWithImpl<$Res>
    extends _$UserOpenOrdersCopyWithImpl<$Res, _$UserOpenOrdersImpl>
    implements _$$UserOpenOrdersImplCopyWith<$Res> {
  __$$UserOpenOrdersImplCopyWithImpl(
      _$UserOpenOrdersImpl _value, $Res Function(_$UserOpenOrdersImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserOpenOrders
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
  }) {
    return _then(_$UserOpenOrdersImpl(
      orders: null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<UserOpenOrder>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserOpenOrdersImpl implements _UserOpenOrders {
  const _$UserOpenOrdersImpl({required final List<UserOpenOrder> orders})
      : _orders = orders;

  factory _$UserOpenOrdersImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserOpenOrdersImplFromJson(json);

  final List<UserOpenOrder> _orders;
  @override
  List<UserOpenOrder> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  String toString() {
    return 'UserOpenOrders(orders: $orders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserOpenOrdersImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orders));

  /// Create a copy of UserOpenOrders
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserOpenOrdersImplCopyWith<_$UserOpenOrdersImpl> get copyWith =>
      __$$UserOpenOrdersImplCopyWithImpl<_$UserOpenOrdersImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserOpenOrdersImplToJson(
      this,
    );
  }
}

abstract class _UserOpenOrders implements UserOpenOrders {
  const factory _UserOpenOrders({required final List<UserOpenOrder> orders}) =
      _$UserOpenOrdersImpl;

  factory _UserOpenOrders.fromJson(Map<String, dynamic> json) =
      _$UserOpenOrdersImpl.fromJson;

  @override
  List<UserOpenOrder> get orders;

  /// Create a copy of UserOpenOrders
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserOpenOrdersImplCopyWith<_$UserOpenOrdersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserOpenOrder _$UserOpenOrderFromJson(Map<String, dynamic> json) {
  return _UserOpenOrder.fromJson(json);
}

/// @nodoc
mixin _$UserOpenOrder {
  String get coin => throw _privateConstructorUsedError;
  String get side => throw _privateConstructorUsedError;
  double get limitPx => throw _privateConstructorUsedError;
  double get sz => throw _privateConstructorUsedError;
  int get oid => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  String get origSz => throw _privateConstructorUsedError;

  /// Serializes this UserOpenOrder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserOpenOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserOpenOrderCopyWith<UserOpenOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserOpenOrderCopyWith<$Res> {
  factory $UserOpenOrderCopyWith(
          UserOpenOrder value, $Res Function(UserOpenOrder) then) =
      _$UserOpenOrderCopyWithImpl<$Res, UserOpenOrder>;
  @useResult
  $Res call(
      {String coin,
      String side,
      double limitPx,
      double sz,
      int oid,
      int timestamp,
      String origSz});
}

/// @nodoc
class _$UserOpenOrderCopyWithImpl<$Res, $Val extends UserOpenOrder>
    implements $UserOpenOrderCopyWith<$Res> {
  _$UserOpenOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserOpenOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coin = null,
    Object? side = null,
    Object? limitPx = null,
    Object? sz = null,
    Object? oid = null,
    Object? timestamp = null,
    Object? origSz = null,
  }) {
    return _then(_value.copyWith(
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as String,
      side: null == side
          ? _value.side
          : side // ignore: cast_nullable_to_non_nullable
              as String,
      limitPx: null == limitPx
          ? _value.limitPx
          : limitPx // ignore: cast_nullable_to_non_nullable
              as double,
      sz: null == sz
          ? _value.sz
          : sz // ignore: cast_nullable_to_non_nullable
              as double,
      oid: null == oid
          ? _value.oid
          : oid // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      origSz: null == origSz
          ? _value.origSz
          : origSz // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserOpenOrderImplCopyWith<$Res>
    implements $UserOpenOrderCopyWith<$Res> {
  factory _$$UserOpenOrderImplCopyWith(
          _$UserOpenOrderImpl value, $Res Function(_$UserOpenOrderImpl) then) =
      __$$UserOpenOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String coin,
      String side,
      double limitPx,
      double sz,
      int oid,
      int timestamp,
      String origSz});
}

/// @nodoc
class __$$UserOpenOrderImplCopyWithImpl<$Res>
    extends _$UserOpenOrderCopyWithImpl<$Res, _$UserOpenOrderImpl>
    implements _$$UserOpenOrderImplCopyWith<$Res> {
  __$$UserOpenOrderImplCopyWithImpl(
      _$UserOpenOrderImpl _value, $Res Function(_$UserOpenOrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserOpenOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coin = null,
    Object? side = null,
    Object? limitPx = null,
    Object? sz = null,
    Object? oid = null,
    Object? timestamp = null,
    Object? origSz = null,
  }) {
    return _then(_$UserOpenOrderImpl(
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as String,
      side: null == side
          ? _value.side
          : side // ignore: cast_nullable_to_non_nullable
              as String,
      limitPx: null == limitPx
          ? _value.limitPx
          : limitPx // ignore: cast_nullable_to_non_nullable
              as double,
      sz: null == sz
          ? _value.sz
          : sz // ignore: cast_nullable_to_non_nullable
              as double,
      oid: null == oid
          ? _value.oid
          : oid // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      origSz: null == origSz
          ? _value.origSz
          : origSz // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserOpenOrderImpl implements _UserOpenOrder {
  const _$UserOpenOrderImpl(
      {required this.coin,
      required this.side,
      required this.limitPx,
      required this.sz,
      required this.oid,
      required this.timestamp,
      required this.origSz});

  factory _$UserOpenOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserOpenOrderImplFromJson(json);

  @override
  final String coin;
  @override
  final String side;
  @override
  final double limitPx;
  @override
  final double sz;
  @override
  final int oid;
  @override
  final int timestamp;
  @override
  final String origSz;

  @override
  String toString() {
    return 'UserOpenOrder(coin: $coin, side: $side, limitPx: $limitPx, sz: $sz, oid: $oid, timestamp: $timestamp, origSz: $origSz)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserOpenOrderImpl &&
            (identical(other.coin, coin) || other.coin == coin) &&
            (identical(other.side, side) || other.side == side) &&
            (identical(other.limitPx, limitPx) || other.limitPx == limitPx) &&
            (identical(other.sz, sz) || other.sz == sz) &&
            (identical(other.oid, oid) || other.oid == oid) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.origSz, origSz) || other.origSz == origSz));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, coin, side, limitPx, sz, oid, timestamp, origSz);

  /// Create a copy of UserOpenOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserOpenOrderImplCopyWith<_$UserOpenOrderImpl> get copyWith =>
      __$$UserOpenOrderImplCopyWithImpl<_$UserOpenOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserOpenOrderImplToJson(
      this,
    );
  }
}

abstract class _UserOpenOrder implements UserOpenOrder {
  const factory _UserOpenOrder(
      {required final String coin,
      required final String side,
      required final double limitPx,
      required final double sz,
      required final int oid,
      required final int timestamp,
      required final String origSz}) = _$UserOpenOrderImpl;

  factory _UserOpenOrder.fromJson(Map<String, dynamic> json) =
      _$UserOpenOrderImpl.fromJson;

  @override
  String get coin;
  @override
  String get side;
  @override
  double get limitPx;
  @override
  double get sz;
  @override
  int get oid;
  @override
  int get timestamp;
  @override
  String get origSz;

  /// Create a copy of UserOpenOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserOpenOrderImplCopyWith<_$UserOpenOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FrontendOpenOrders _$FrontendOpenOrdersFromJson(Map<String, dynamic> json) {
  return _FrontendOpenOrders.fromJson(json);
}

/// @nodoc
mixin _$FrontendOpenOrders {
  List<FrontendOpenOrder> get orders => throw _privateConstructorUsedError;

  /// Serializes this FrontendOpenOrders to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FrontendOpenOrders
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FrontendOpenOrdersCopyWith<FrontendOpenOrders> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrontendOpenOrdersCopyWith<$Res> {
  factory $FrontendOpenOrdersCopyWith(
          FrontendOpenOrders value, $Res Function(FrontendOpenOrders) then) =
      _$FrontendOpenOrdersCopyWithImpl<$Res, FrontendOpenOrders>;
  @useResult
  $Res call({List<FrontendOpenOrder> orders});
}

/// @nodoc
class _$FrontendOpenOrdersCopyWithImpl<$Res, $Val extends FrontendOpenOrders>
    implements $FrontendOpenOrdersCopyWith<$Res> {
  _$FrontendOpenOrdersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FrontendOpenOrders
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
  }) {
    return _then(_value.copyWith(
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<FrontendOpenOrder>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FrontendOpenOrdersImplCopyWith<$Res>
    implements $FrontendOpenOrdersCopyWith<$Res> {
  factory _$$FrontendOpenOrdersImplCopyWith(_$FrontendOpenOrdersImpl value,
          $Res Function(_$FrontendOpenOrdersImpl) then) =
      __$$FrontendOpenOrdersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FrontendOpenOrder> orders});
}

/// @nodoc
class __$$FrontendOpenOrdersImplCopyWithImpl<$Res>
    extends _$FrontendOpenOrdersCopyWithImpl<$Res, _$FrontendOpenOrdersImpl>
    implements _$$FrontendOpenOrdersImplCopyWith<$Res> {
  __$$FrontendOpenOrdersImplCopyWithImpl(_$FrontendOpenOrdersImpl _value,
      $Res Function(_$FrontendOpenOrdersImpl) _then)
      : super(_value, _then);

  /// Create a copy of FrontendOpenOrders
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
  }) {
    return _then(_$FrontendOpenOrdersImpl(
      orders: null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<FrontendOpenOrder>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FrontendOpenOrdersImpl implements _FrontendOpenOrders {
  const _$FrontendOpenOrdersImpl(
      {required final List<FrontendOpenOrder> orders})
      : _orders = orders;

  factory _$FrontendOpenOrdersImpl.fromJson(Map<String, dynamic> json) =>
      _$$FrontendOpenOrdersImplFromJson(json);

  final List<FrontendOpenOrder> _orders;
  @override
  List<FrontendOpenOrder> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  String toString() {
    return 'FrontendOpenOrders(orders: $orders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FrontendOpenOrdersImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orders));

  /// Create a copy of FrontendOpenOrders
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FrontendOpenOrdersImplCopyWith<_$FrontendOpenOrdersImpl> get copyWith =>
      __$$FrontendOpenOrdersImplCopyWithImpl<_$FrontendOpenOrdersImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FrontendOpenOrdersImplToJson(
      this,
    );
  }
}

abstract class _FrontendOpenOrders implements FrontendOpenOrders {
  const factory _FrontendOpenOrders(
          {required final List<FrontendOpenOrder> orders}) =
      _$FrontendOpenOrdersImpl;

  factory _FrontendOpenOrders.fromJson(Map<String, dynamic> json) =
      _$FrontendOpenOrdersImpl.fromJson;

  @override
  List<FrontendOpenOrder> get orders;

  /// Create a copy of FrontendOpenOrders
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FrontendOpenOrdersImplCopyWith<_$FrontendOpenOrdersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FrontendOpenOrder _$FrontendOpenOrderFromJson(Map<String, dynamic> json) {
  return _FrontendOpenOrder.fromJson(json);
}

/// @nodoc
mixin _$FrontendOpenOrder {
  String get coin => throw _privateConstructorUsedError;
  bool get isPositionTpsl => throw _privateConstructorUsedError;
  bool get isTrigger => throw _privateConstructorUsedError;
  String get limitPx => throw _privateConstructorUsedError;
  int get oid => throw _privateConstructorUsedError;
  String get orderType => throw _privateConstructorUsedError;
  String get origSz => throw _privateConstructorUsedError;
  bool get reduceOnly => throw _privateConstructorUsedError;
  String get side => throw _privateConstructorUsedError;
  String get sz => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  String get triggerCondition => throw _privateConstructorUsedError;
  String get triggerPx => throw _privateConstructorUsedError;

  /// Serializes this FrontendOpenOrder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FrontendOpenOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FrontendOpenOrderCopyWith<FrontendOpenOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrontendOpenOrderCopyWith<$Res> {
  factory $FrontendOpenOrderCopyWith(
          FrontendOpenOrder value, $Res Function(FrontendOpenOrder) then) =
      _$FrontendOpenOrderCopyWithImpl<$Res, FrontendOpenOrder>;
  @useResult
  $Res call(
      {String coin,
      bool isPositionTpsl,
      bool isTrigger,
      String limitPx,
      int oid,
      String orderType,
      String origSz,
      bool reduceOnly,
      String side,
      String sz,
      int timestamp,
      String triggerCondition,
      String triggerPx});
}

/// @nodoc
class _$FrontendOpenOrderCopyWithImpl<$Res, $Val extends FrontendOpenOrder>
    implements $FrontendOpenOrderCopyWith<$Res> {
  _$FrontendOpenOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FrontendOpenOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coin = null,
    Object? isPositionTpsl = null,
    Object? isTrigger = null,
    Object? limitPx = null,
    Object? oid = null,
    Object? orderType = null,
    Object? origSz = null,
    Object? reduceOnly = null,
    Object? side = null,
    Object? sz = null,
    Object? timestamp = null,
    Object? triggerCondition = null,
    Object? triggerPx = null,
  }) {
    return _then(_value.copyWith(
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as String,
      isPositionTpsl: null == isPositionTpsl
          ? _value.isPositionTpsl
          : isPositionTpsl // ignore: cast_nullable_to_non_nullable
              as bool,
      isTrigger: null == isTrigger
          ? _value.isTrigger
          : isTrigger // ignore: cast_nullable_to_non_nullable
              as bool,
      limitPx: null == limitPx
          ? _value.limitPx
          : limitPx // ignore: cast_nullable_to_non_nullable
              as String,
      oid: null == oid
          ? _value.oid
          : oid // ignore: cast_nullable_to_non_nullable
              as int,
      orderType: null == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as String,
      origSz: null == origSz
          ? _value.origSz
          : origSz // ignore: cast_nullable_to_non_nullable
              as String,
      reduceOnly: null == reduceOnly
          ? _value.reduceOnly
          : reduceOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      side: null == side
          ? _value.side
          : side // ignore: cast_nullable_to_non_nullable
              as String,
      sz: null == sz
          ? _value.sz
          : sz // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      triggerCondition: null == triggerCondition
          ? _value.triggerCondition
          : triggerCondition // ignore: cast_nullable_to_non_nullable
              as String,
      triggerPx: null == triggerPx
          ? _value.triggerPx
          : triggerPx // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FrontendOpenOrderImplCopyWith<$Res>
    implements $FrontendOpenOrderCopyWith<$Res> {
  factory _$$FrontendOpenOrderImplCopyWith(_$FrontendOpenOrderImpl value,
          $Res Function(_$FrontendOpenOrderImpl) then) =
      __$$FrontendOpenOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String coin,
      bool isPositionTpsl,
      bool isTrigger,
      String limitPx,
      int oid,
      String orderType,
      String origSz,
      bool reduceOnly,
      String side,
      String sz,
      int timestamp,
      String triggerCondition,
      String triggerPx});
}

/// @nodoc
class __$$FrontendOpenOrderImplCopyWithImpl<$Res>
    extends _$FrontendOpenOrderCopyWithImpl<$Res, _$FrontendOpenOrderImpl>
    implements _$$FrontendOpenOrderImplCopyWith<$Res> {
  __$$FrontendOpenOrderImplCopyWithImpl(_$FrontendOpenOrderImpl _value,
      $Res Function(_$FrontendOpenOrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of FrontendOpenOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coin = null,
    Object? isPositionTpsl = null,
    Object? isTrigger = null,
    Object? limitPx = null,
    Object? oid = null,
    Object? orderType = null,
    Object? origSz = null,
    Object? reduceOnly = null,
    Object? side = null,
    Object? sz = null,
    Object? timestamp = null,
    Object? triggerCondition = null,
    Object? triggerPx = null,
  }) {
    return _then(_$FrontendOpenOrderImpl(
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as String,
      isPositionTpsl: null == isPositionTpsl
          ? _value.isPositionTpsl
          : isPositionTpsl // ignore: cast_nullable_to_non_nullable
              as bool,
      isTrigger: null == isTrigger
          ? _value.isTrigger
          : isTrigger // ignore: cast_nullable_to_non_nullable
              as bool,
      limitPx: null == limitPx
          ? _value.limitPx
          : limitPx // ignore: cast_nullable_to_non_nullable
              as String,
      oid: null == oid
          ? _value.oid
          : oid // ignore: cast_nullable_to_non_nullable
              as int,
      orderType: null == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as String,
      origSz: null == origSz
          ? _value.origSz
          : origSz // ignore: cast_nullable_to_non_nullable
              as String,
      reduceOnly: null == reduceOnly
          ? _value.reduceOnly
          : reduceOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      side: null == side
          ? _value.side
          : side // ignore: cast_nullable_to_non_nullable
              as String,
      sz: null == sz
          ? _value.sz
          : sz // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      triggerCondition: null == triggerCondition
          ? _value.triggerCondition
          : triggerCondition // ignore: cast_nullable_to_non_nullable
              as String,
      triggerPx: null == triggerPx
          ? _value.triggerPx
          : triggerPx // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FrontendOpenOrderImpl implements _FrontendOpenOrder {
  const _$FrontendOpenOrderImpl(
      {required this.coin,
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
      required this.triggerPx});

  factory _$FrontendOpenOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$FrontendOpenOrderImplFromJson(json);

  @override
  final String coin;
  @override
  final bool isPositionTpsl;
  @override
  final bool isTrigger;
  @override
  final String limitPx;
  @override
  final int oid;
  @override
  final String orderType;
  @override
  final String origSz;
  @override
  final bool reduceOnly;
  @override
  final String side;
  @override
  final String sz;
  @override
  final int timestamp;
  @override
  final String triggerCondition;
  @override
  final String triggerPx;

  @override
  String toString() {
    return 'FrontendOpenOrder(coin: $coin, isPositionTpsl: $isPositionTpsl, isTrigger: $isTrigger, limitPx: $limitPx, oid: $oid, orderType: $orderType, origSz: $origSz, reduceOnly: $reduceOnly, side: $side, sz: $sz, timestamp: $timestamp, triggerCondition: $triggerCondition, triggerPx: $triggerPx)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FrontendOpenOrderImpl &&
            (identical(other.coin, coin) || other.coin == coin) &&
            (identical(other.isPositionTpsl, isPositionTpsl) ||
                other.isPositionTpsl == isPositionTpsl) &&
            (identical(other.isTrigger, isTrigger) ||
                other.isTrigger == isTrigger) &&
            (identical(other.limitPx, limitPx) || other.limitPx == limitPx) &&
            (identical(other.oid, oid) || other.oid == oid) &&
            (identical(other.orderType, orderType) ||
                other.orderType == orderType) &&
            (identical(other.origSz, origSz) || other.origSz == origSz) &&
            (identical(other.reduceOnly, reduceOnly) ||
                other.reduceOnly == reduceOnly) &&
            (identical(other.side, side) || other.side == side) &&
            (identical(other.sz, sz) || other.sz == sz) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.triggerCondition, triggerCondition) ||
                other.triggerCondition == triggerCondition) &&
            (identical(other.triggerPx, triggerPx) ||
                other.triggerPx == triggerPx));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      coin,
      isPositionTpsl,
      isTrigger,
      limitPx,
      oid,
      orderType,
      origSz,
      reduceOnly,
      side,
      sz,
      timestamp,
      triggerCondition,
      triggerPx);

  /// Create a copy of FrontendOpenOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FrontendOpenOrderImplCopyWith<_$FrontendOpenOrderImpl> get copyWith =>
      __$$FrontendOpenOrderImplCopyWithImpl<_$FrontendOpenOrderImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FrontendOpenOrderImplToJson(
      this,
    );
  }
}

abstract class _FrontendOpenOrder implements FrontendOpenOrder {
  const factory _FrontendOpenOrder(
      {required final String coin,
      required final bool isPositionTpsl,
      required final bool isTrigger,
      required final String limitPx,
      required final int oid,
      required final String orderType,
      required final String origSz,
      required final bool reduceOnly,
      required final String side,
      required final String sz,
      required final int timestamp,
      required final String triggerCondition,
      required final String triggerPx}) = _$FrontendOpenOrderImpl;

  factory _FrontendOpenOrder.fromJson(Map<String, dynamic> json) =
      _$FrontendOpenOrderImpl.fromJson;

  @override
  String get coin;
  @override
  bool get isPositionTpsl;
  @override
  bool get isTrigger;
  @override
  String get limitPx;
  @override
  int get oid;
  @override
  String get orderType;
  @override
  String get origSz;
  @override
  bool get reduceOnly;
  @override
  String get side;
  @override
  String get sz;
  @override
  int get timestamp;
  @override
  String get triggerCondition;
  @override
  String get triggerPx;

  /// Create a copy of FrontendOpenOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FrontendOpenOrderImplCopyWith<_$FrontendOpenOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserFills _$UserFillsFromJson(Map<String, dynamic> json) {
  return _UserFills.fromJson(json);
}

/// @nodoc
mixin _$UserFills {
  List<UserFill> get fills => throw _privateConstructorUsedError;

  /// Serializes this UserFills to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserFills
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserFillsCopyWith<UserFills> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserFillsCopyWith<$Res> {
  factory $UserFillsCopyWith(UserFills value, $Res Function(UserFills) then) =
      _$UserFillsCopyWithImpl<$Res, UserFills>;
  @useResult
  $Res call({List<UserFill> fills});
}

/// @nodoc
class _$UserFillsCopyWithImpl<$Res, $Val extends UserFills>
    implements $UserFillsCopyWith<$Res> {
  _$UserFillsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserFills
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fills = null,
  }) {
    return _then(_value.copyWith(
      fills: null == fills
          ? _value.fills
          : fills // ignore: cast_nullable_to_non_nullable
              as List<UserFill>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserFillsImplCopyWith<$Res>
    implements $UserFillsCopyWith<$Res> {
  factory _$$UserFillsImplCopyWith(
          _$UserFillsImpl value, $Res Function(_$UserFillsImpl) then) =
      __$$UserFillsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UserFill> fills});
}

/// @nodoc
class __$$UserFillsImplCopyWithImpl<$Res>
    extends _$UserFillsCopyWithImpl<$Res, _$UserFillsImpl>
    implements _$$UserFillsImplCopyWith<$Res> {
  __$$UserFillsImplCopyWithImpl(
      _$UserFillsImpl _value, $Res Function(_$UserFillsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserFills
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fills = null,
  }) {
    return _then(_$UserFillsImpl(
      fills: null == fills
          ? _value._fills
          : fills // ignore: cast_nullable_to_non_nullable
              as List<UserFill>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserFillsImpl implements _UserFills {
  const _$UserFillsImpl({required final List<UserFill> fills}) : _fills = fills;

  factory _$UserFillsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserFillsImplFromJson(json);

  final List<UserFill> _fills;
  @override
  List<UserFill> get fills {
    if (_fills is EqualUnmodifiableListView) return _fills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fills);
  }

  @override
  String toString() {
    return 'UserFills(fills: $fills)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserFillsImpl &&
            const DeepCollectionEquality().equals(other._fills, _fills));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_fills));

  /// Create a copy of UserFills
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserFillsImplCopyWith<_$UserFillsImpl> get copyWith =>
      __$$UserFillsImplCopyWithImpl<_$UserFillsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserFillsImplToJson(
      this,
    );
  }
}

abstract class _UserFills implements UserFills {
  const factory _UserFills({required final List<UserFill> fills}) =
      _$UserFillsImpl;

  factory _UserFills.fromJson(Map<String, dynamic> json) =
      _$UserFillsImpl.fromJson;

  @override
  List<UserFill> get fills;

  /// Create a copy of UserFills
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserFillsImplCopyWith<_$UserFillsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserFill _$UserFillFromJson(Map<String, dynamic> json) {
  return _UserFill.fromJson(json);
}

/// @nodoc
mixin _$UserFill {
  String get coin => throw _privateConstructorUsedError;
  double get px => throw _privateConstructorUsedError;
  double get sz => throw _privateConstructorUsedError;
  String get side => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;
  String get startPosition => throw _privateConstructorUsedError;
  String get dir => throw _privateConstructorUsedError;
  double get closedPnl => throw _privateConstructorUsedError;
  String get hash => throw _privateConstructorUsedError;
  int get oid => throw _privateConstructorUsedError;
  bool get crossed => throw _privateConstructorUsedError;
  double get fee => throw _privateConstructorUsedError;
  int get tid => throw _privateConstructorUsedError;

  /// Serializes this UserFill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserFill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserFillCopyWith<UserFill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserFillCopyWith<$Res> {
  factory $UserFillCopyWith(UserFill value, $Res Function(UserFill) then) =
      _$UserFillCopyWithImpl<$Res, UserFill>;
  @useResult
  $Res call(
      {String coin,
      double px,
      double sz,
      String side,
      int time,
      String startPosition,
      String dir,
      double closedPnl,
      String hash,
      int oid,
      bool crossed,
      double fee,
      int tid});
}

/// @nodoc
class _$UserFillCopyWithImpl<$Res, $Val extends UserFill>
    implements $UserFillCopyWith<$Res> {
  _$UserFillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserFill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coin = null,
    Object? px = null,
    Object? sz = null,
    Object? side = null,
    Object? time = null,
    Object? startPosition = null,
    Object? dir = null,
    Object? closedPnl = null,
    Object? hash = null,
    Object? oid = null,
    Object? crossed = null,
    Object? fee = null,
    Object? tid = null,
  }) {
    return _then(_value.copyWith(
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as String,
      px: null == px
          ? _value.px
          : px // ignore: cast_nullable_to_non_nullable
              as double,
      sz: null == sz
          ? _value.sz
          : sz // ignore: cast_nullable_to_non_nullable
              as double,
      side: null == side
          ? _value.side
          : side // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      startPosition: null == startPosition
          ? _value.startPosition
          : startPosition // ignore: cast_nullable_to_non_nullable
              as String,
      dir: null == dir
          ? _value.dir
          : dir // ignore: cast_nullable_to_non_nullable
              as String,
      closedPnl: null == closedPnl
          ? _value.closedPnl
          : closedPnl // ignore: cast_nullable_to_non_nullable
              as double,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      oid: null == oid
          ? _value.oid
          : oid // ignore: cast_nullable_to_non_nullable
              as int,
      crossed: null == crossed
          ? _value.crossed
          : crossed // ignore: cast_nullable_to_non_nullable
              as bool,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
      tid: null == tid
          ? _value.tid
          : tid // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserFillImplCopyWith<$Res>
    implements $UserFillCopyWith<$Res> {
  factory _$$UserFillImplCopyWith(
          _$UserFillImpl value, $Res Function(_$UserFillImpl) then) =
      __$$UserFillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String coin,
      double px,
      double sz,
      String side,
      int time,
      String startPosition,
      String dir,
      double closedPnl,
      String hash,
      int oid,
      bool crossed,
      double fee,
      int tid});
}

/// @nodoc
class __$$UserFillImplCopyWithImpl<$Res>
    extends _$UserFillCopyWithImpl<$Res, _$UserFillImpl>
    implements _$$UserFillImplCopyWith<$Res> {
  __$$UserFillImplCopyWithImpl(
      _$UserFillImpl _value, $Res Function(_$UserFillImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserFill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coin = null,
    Object? px = null,
    Object? sz = null,
    Object? side = null,
    Object? time = null,
    Object? startPosition = null,
    Object? dir = null,
    Object? closedPnl = null,
    Object? hash = null,
    Object? oid = null,
    Object? crossed = null,
    Object? fee = null,
    Object? tid = null,
  }) {
    return _then(_$UserFillImpl(
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as String,
      px: null == px
          ? _value.px
          : px // ignore: cast_nullable_to_non_nullable
              as double,
      sz: null == sz
          ? _value.sz
          : sz // ignore: cast_nullable_to_non_nullable
              as double,
      side: null == side
          ? _value.side
          : side // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      startPosition: null == startPosition
          ? _value.startPosition
          : startPosition // ignore: cast_nullable_to_non_nullable
              as String,
      dir: null == dir
          ? _value.dir
          : dir // ignore: cast_nullable_to_non_nullable
              as String,
      closedPnl: null == closedPnl
          ? _value.closedPnl
          : closedPnl // ignore: cast_nullable_to_non_nullable
              as double,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      oid: null == oid
          ? _value.oid
          : oid // ignore: cast_nullable_to_non_nullable
              as int,
      crossed: null == crossed
          ? _value.crossed
          : crossed // ignore: cast_nullable_to_non_nullable
              as bool,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
      tid: null == tid
          ? _value.tid
          : tid // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserFillImpl implements _UserFill {
  const _$UserFillImpl(
      {required this.coin,
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
      required this.tid});

  factory _$UserFillImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserFillImplFromJson(json);

  @override
  final String coin;
  @override
  final double px;
  @override
  final double sz;
  @override
  final String side;
  @override
  final int time;
  @override
  final String startPosition;
  @override
  final String dir;
  @override
  final double closedPnl;
  @override
  final String hash;
  @override
  final int oid;
  @override
  final bool crossed;
  @override
  final double fee;
  @override
  final int tid;

  @override
  String toString() {
    return 'UserFill(coin: $coin, px: $px, sz: $sz, side: $side, time: $time, startPosition: $startPosition, dir: $dir, closedPnl: $closedPnl, hash: $hash, oid: $oid, crossed: $crossed, fee: $fee, tid: $tid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserFillImpl &&
            (identical(other.coin, coin) || other.coin == coin) &&
            (identical(other.px, px) || other.px == px) &&
            (identical(other.sz, sz) || other.sz == sz) &&
            (identical(other.side, side) || other.side == side) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.startPosition, startPosition) ||
                other.startPosition == startPosition) &&
            (identical(other.dir, dir) || other.dir == dir) &&
            (identical(other.closedPnl, closedPnl) ||
                other.closedPnl == closedPnl) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.oid, oid) || other.oid == oid) &&
            (identical(other.crossed, crossed) || other.crossed == crossed) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.tid, tid) || other.tid == tid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, coin, px, sz, side, time,
      startPosition, dir, closedPnl, hash, oid, crossed, fee, tid);

  /// Create a copy of UserFill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserFillImplCopyWith<_$UserFillImpl> get copyWith =>
      __$$UserFillImplCopyWithImpl<_$UserFillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserFillImplToJson(
      this,
    );
  }
}

abstract class _UserFill implements UserFill {
  const factory _UserFill(
      {required final String coin,
      required final double px,
      required final double sz,
      required final String side,
      required final int time,
      required final String startPosition,
      required final String dir,
      required final double closedPnl,
      required final String hash,
      required final int oid,
      required final bool crossed,
      required final double fee,
      required final int tid}) = _$UserFillImpl;

  factory _UserFill.fromJson(Map<String, dynamic> json) =
      _$UserFillImpl.fromJson;

  @override
  String get coin;
  @override
  double get px;
  @override
  double get sz;
  @override
  String get side;
  @override
  int get time;
  @override
  String get startPosition;
  @override
  String get dir;
  @override
  double get closedPnl;
  @override
  String get hash;
  @override
  int get oid;
  @override
  bool get crossed;
  @override
  double get fee;
  @override
  int get tid;

  /// Create a copy of UserFill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserFillImplCopyWith<_$UserFillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserRateLimit _$UserRateLimitFromJson(Map<String, dynamic> json) {
  return _UserRateLimit.fromJson(json);
}

/// @nodoc
mixin _$UserRateLimit {
  int get nRequestsUsed => throw _privateConstructorUsedError;
  int get nRequestsCap => throw _privateConstructorUsedError;
  double get cumVlm => throw _privateConstructorUsedError;

  /// Serializes this UserRateLimit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserRateLimit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserRateLimitCopyWith<UserRateLimit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRateLimitCopyWith<$Res> {
  factory $UserRateLimitCopyWith(
          UserRateLimit value, $Res Function(UserRateLimit) then) =
      _$UserRateLimitCopyWithImpl<$Res, UserRateLimit>;
  @useResult
  $Res call({int nRequestsUsed, int nRequestsCap, double cumVlm});
}

/// @nodoc
class _$UserRateLimitCopyWithImpl<$Res, $Val extends UserRateLimit>
    implements $UserRateLimitCopyWith<$Res> {
  _$UserRateLimitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserRateLimit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nRequestsUsed = null,
    Object? nRequestsCap = null,
    Object? cumVlm = null,
  }) {
    return _then(_value.copyWith(
      nRequestsUsed: null == nRequestsUsed
          ? _value.nRequestsUsed
          : nRequestsUsed // ignore: cast_nullable_to_non_nullable
              as int,
      nRequestsCap: null == nRequestsCap
          ? _value.nRequestsCap
          : nRequestsCap // ignore: cast_nullable_to_non_nullable
              as int,
      cumVlm: null == cumVlm
          ? _value.cumVlm
          : cumVlm // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserRateLimitImplCopyWith<$Res>
    implements $UserRateLimitCopyWith<$Res> {
  factory _$$UserRateLimitImplCopyWith(
          _$UserRateLimitImpl value, $Res Function(_$UserRateLimitImpl) then) =
      __$$UserRateLimitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int nRequestsUsed, int nRequestsCap, double cumVlm});
}

/// @nodoc
class __$$UserRateLimitImplCopyWithImpl<$Res>
    extends _$UserRateLimitCopyWithImpl<$Res, _$UserRateLimitImpl>
    implements _$$UserRateLimitImplCopyWith<$Res> {
  __$$UserRateLimitImplCopyWithImpl(
      _$UserRateLimitImpl _value, $Res Function(_$UserRateLimitImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRateLimit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nRequestsUsed = null,
    Object? nRequestsCap = null,
    Object? cumVlm = null,
  }) {
    return _then(_$UserRateLimitImpl(
      nRequestsUsed: null == nRequestsUsed
          ? _value.nRequestsUsed
          : nRequestsUsed // ignore: cast_nullable_to_non_nullable
              as int,
      nRequestsCap: null == nRequestsCap
          ? _value.nRequestsCap
          : nRequestsCap // ignore: cast_nullable_to_non_nullable
              as int,
      cumVlm: null == cumVlm
          ? _value.cumVlm
          : cumVlm // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserRateLimitImpl implements _UserRateLimit {
  const _$UserRateLimitImpl(
      {required this.nRequestsUsed,
      required this.nRequestsCap,
      required this.cumVlm});

  factory _$UserRateLimitImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserRateLimitImplFromJson(json);

  @override
  final int nRequestsUsed;
  @override
  final int nRequestsCap;
  @override
  final double cumVlm;

  @override
  String toString() {
    return 'UserRateLimit(nRequestsUsed: $nRequestsUsed, nRequestsCap: $nRequestsCap, cumVlm: $cumVlm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRateLimitImpl &&
            (identical(other.nRequestsUsed, nRequestsUsed) ||
                other.nRequestsUsed == nRequestsUsed) &&
            (identical(other.nRequestsCap, nRequestsCap) ||
                other.nRequestsCap == nRequestsCap) &&
            (identical(other.cumVlm, cumVlm) || other.cumVlm == cumVlm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nRequestsUsed, nRequestsCap, cumVlm);

  /// Create a copy of UserRateLimit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserRateLimitImplCopyWith<_$UserRateLimitImpl> get copyWith =>
      __$$UserRateLimitImplCopyWithImpl<_$UserRateLimitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserRateLimitImplToJson(
      this,
    );
  }
}

abstract class _UserRateLimit implements UserRateLimit {
  const factory _UserRateLimit(
      {required final int nRequestsUsed,
      required final int nRequestsCap,
      required final double cumVlm}) = _$UserRateLimitImpl;

  factory _UserRateLimit.fromJson(Map<String, dynamic> json) =
      _$UserRateLimitImpl.fromJson;

  @override
  int get nRequestsUsed;
  @override
  int get nRequestsCap;
  @override
  double get cumVlm;

  /// Create a copy of UserRateLimit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserRateLimitImplCopyWith<_$UserRateLimitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderStatus _$OrderStatusFromJson(Map<String, dynamic> json) {
  return _OrderStatus.fromJson(json);
}

/// @nodoc
mixin _$OrderStatus {
  String get status => throw _privateConstructorUsedError;
  Order get order => throw _privateConstructorUsedError;

  /// Serializes this OrderStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderStatusCopyWith<OrderStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusCopyWith<$Res> {
  factory $OrderStatusCopyWith(
          OrderStatus value, $Res Function(OrderStatus) then) =
      _$OrderStatusCopyWithImpl<$Res, OrderStatus>;
  @useResult
  $Res call({String status, Order order});

  $OrderCopyWith<$Res> get order;
}

/// @nodoc
class _$OrderStatusCopyWithImpl<$Res, $Val extends OrderStatus>
    implements $OrderStatusCopyWith<$Res> {
  _$OrderStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? order = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as Order,
    ) as $Val);
  }

  /// Create a copy of OrderStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderCopyWith<$Res> get order {
    return $OrderCopyWith<$Res>(_value.order, (value) {
      return _then(_value.copyWith(order: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderStatusImplCopyWith<$Res>
    implements $OrderStatusCopyWith<$Res> {
  factory _$$OrderStatusImplCopyWith(
          _$OrderStatusImpl value, $Res Function(_$OrderStatusImpl) then) =
      __$$OrderStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, Order order});

  @override
  $OrderCopyWith<$Res> get order;
}

/// @nodoc
class __$$OrderStatusImplCopyWithImpl<$Res>
    extends _$OrderStatusCopyWithImpl<$Res, _$OrderStatusImpl>
    implements _$$OrderStatusImplCopyWith<$Res> {
  __$$OrderStatusImplCopyWithImpl(
      _$OrderStatusImpl _value, $Res Function(_$OrderStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? order = null,
  }) {
    return _then(_$OrderStatusImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as Order,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderStatusImpl implements _OrderStatus {
  const _$OrderStatusImpl({required this.status, required this.order});

  factory _$OrderStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderStatusImplFromJson(json);

  @override
  final String status;
  @override
  final Order order;

  @override
  String toString() {
    return 'OrderStatus(status: $status, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStatusImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, order);

  /// Create a copy of OrderStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStatusImplCopyWith<_$OrderStatusImpl> get copyWith =>
      __$$OrderStatusImplCopyWithImpl<_$OrderStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderStatusImplToJson(
      this,
    );
  }
}

abstract class _OrderStatus implements OrderStatus {
  const factory _OrderStatus(
      {required final String status,
      required final Order order}) = _$OrderStatusImpl;

  factory _OrderStatus.fromJson(Map<String, dynamic> json) =
      _$OrderStatusImpl.fromJson;

  @override
  String get status;
  @override
  Order get order;

  /// Create a copy of OrderStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderStatusImplCopyWith<_$OrderStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  String get coin => throw _privateConstructorUsedError;
  String get side => throw _privateConstructorUsedError;
  double get limitPx => throw _privateConstructorUsedError;
  double get sz => throw _privateConstructorUsedError;
  int get oid => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  String get origSz => throw _privateConstructorUsedError;
  bool get reduceOnly => throw _privateConstructorUsedError;
  String get orderType => throw _privateConstructorUsedError;
  bool get isTrigger => throw _privateConstructorUsedError;
  double get triggerPx => throw _privateConstructorUsedError;
  String get triggerCondition => throw _privateConstructorUsedError;
  bool get isPositionTpsl => throw _privateConstructorUsedError;
  List<dynamic> get children => throw _privateConstructorUsedError;

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call(
      {String coin,
      String side,
      double limitPx,
      double sz,
      int oid,
      int timestamp,
      String origSz,
      bool reduceOnly,
      String orderType,
      bool isTrigger,
      double triggerPx,
      String triggerCondition,
      bool isPositionTpsl,
      List<dynamic> children});
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coin = null,
    Object? side = null,
    Object? limitPx = null,
    Object? sz = null,
    Object? oid = null,
    Object? timestamp = null,
    Object? origSz = null,
    Object? reduceOnly = null,
    Object? orderType = null,
    Object? isTrigger = null,
    Object? triggerPx = null,
    Object? triggerCondition = null,
    Object? isPositionTpsl = null,
    Object? children = null,
  }) {
    return _then(_value.copyWith(
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as String,
      side: null == side
          ? _value.side
          : side // ignore: cast_nullable_to_non_nullable
              as String,
      limitPx: null == limitPx
          ? _value.limitPx
          : limitPx // ignore: cast_nullable_to_non_nullable
              as double,
      sz: null == sz
          ? _value.sz
          : sz // ignore: cast_nullable_to_non_nullable
              as double,
      oid: null == oid
          ? _value.oid
          : oid // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      origSz: null == origSz
          ? _value.origSz
          : origSz // ignore: cast_nullable_to_non_nullable
              as String,
      reduceOnly: null == reduceOnly
          ? _value.reduceOnly
          : reduceOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      orderType: null == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as String,
      isTrigger: null == isTrigger
          ? _value.isTrigger
          : isTrigger // ignore: cast_nullable_to_non_nullable
              as bool,
      triggerPx: null == triggerPx
          ? _value.triggerPx
          : triggerPx // ignore: cast_nullable_to_non_nullable
              as double,
      triggerCondition: null == triggerCondition
          ? _value.triggerCondition
          : triggerCondition // ignore: cast_nullable_to_non_nullable
              as String,
      isPositionTpsl: null == isPositionTpsl
          ? _value.isPositionTpsl
          : isPositionTpsl // ignore: cast_nullable_to_non_nullable
              as bool,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
          _$OrderImpl value, $Res Function(_$OrderImpl) then) =
      __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String coin,
      String side,
      double limitPx,
      double sz,
      int oid,
      int timestamp,
      String origSz,
      bool reduceOnly,
      String orderType,
      bool isTrigger,
      double triggerPx,
      String triggerCondition,
      bool isPositionTpsl,
      List<dynamic> children});
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
      _$OrderImpl _value, $Res Function(_$OrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coin = null,
    Object? side = null,
    Object? limitPx = null,
    Object? sz = null,
    Object? oid = null,
    Object? timestamp = null,
    Object? origSz = null,
    Object? reduceOnly = null,
    Object? orderType = null,
    Object? isTrigger = null,
    Object? triggerPx = null,
    Object? triggerCondition = null,
    Object? isPositionTpsl = null,
    Object? children = null,
  }) {
    return _then(_$OrderImpl(
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as String,
      side: null == side
          ? _value.side
          : side // ignore: cast_nullable_to_non_nullable
              as String,
      limitPx: null == limitPx
          ? _value.limitPx
          : limitPx // ignore: cast_nullable_to_non_nullable
              as double,
      sz: null == sz
          ? _value.sz
          : sz // ignore: cast_nullable_to_non_nullable
              as double,
      oid: null == oid
          ? _value.oid
          : oid // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      origSz: null == origSz
          ? _value.origSz
          : origSz // ignore: cast_nullable_to_non_nullable
              as String,
      reduceOnly: null == reduceOnly
          ? _value.reduceOnly
          : reduceOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      orderType: null == orderType
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as String,
      isTrigger: null == isTrigger
          ? _value.isTrigger
          : isTrigger // ignore: cast_nullable_to_non_nullable
              as bool,
      triggerPx: null == triggerPx
          ? _value.triggerPx
          : triggerPx // ignore: cast_nullable_to_non_nullable
              as double,
      triggerCondition: null == triggerCondition
          ? _value.triggerCondition
          : triggerCondition // ignore: cast_nullable_to_non_nullable
              as String,
      isPositionTpsl: null == isPositionTpsl
          ? _value.isPositionTpsl
          : isPositionTpsl // ignore: cast_nullable_to_non_nullable
              as bool,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl(
      {required this.coin,
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
      required final List<dynamic> children})
      : _children = children;

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final String coin;
  @override
  final String side;
  @override
  final double limitPx;
  @override
  final double sz;
  @override
  final int oid;
  @override
  final int timestamp;
  @override
  final String origSz;
  @override
  final bool reduceOnly;
  @override
  final String orderType;
  @override
  final bool isTrigger;
  @override
  final double triggerPx;
  @override
  final String triggerCondition;
  @override
  final bool isPositionTpsl;
  final List<dynamic> _children;
  @override
  List<dynamic> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  String toString() {
    return 'Order(coin: $coin, side: $side, limitPx: $limitPx, sz: $sz, oid: $oid, timestamp: $timestamp, origSz: $origSz, reduceOnly: $reduceOnly, orderType: $orderType, isTrigger: $isTrigger, triggerPx: $triggerPx, triggerCondition: $triggerCondition, isPositionTpsl: $isPositionTpsl, children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.coin, coin) || other.coin == coin) &&
            (identical(other.side, side) || other.side == side) &&
            (identical(other.limitPx, limitPx) || other.limitPx == limitPx) &&
            (identical(other.sz, sz) || other.sz == sz) &&
            (identical(other.oid, oid) || other.oid == oid) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.origSz, origSz) || other.origSz == origSz) &&
            (identical(other.reduceOnly, reduceOnly) ||
                other.reduceOnly == reduceOnly) &&
            (identical(other.orderType, orderType) ||
                other.orderType == orderType) &&
            (identical(other.isTrigger, isTrigger) ||
                other.isTrigger == isTrigger) &&
            (identical(other.triggerPx, triggerPx) ||
                other.triggerPx == triggerPx) &&
            (identical(other.triggerCondition, triggerCondition) ||
                other.triggerCondition == triggerCondition) &&
            (identical(other.isPositionTpsl, isPositionTpsl) ||
                other.isPositionTpsl == isPositionTpsl) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      coin,
      side,
      limitPx,
      sz,
      oid,
      timestamp,
      origSz,
      reduceOnly,
      orderType,
      isTrigger,
      triggerPx,
      triggerCondition,
      isPositionTpsl,
      const DeepCollectionEquality().hash(_children));

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(
      this,
    );
  }
}

abstract class _Order implements Order {
  const factory _Order(
      {required final String coin,
      required final String side,
      required final double limitPx,
      required final double sz,
      required final int oid,
      required final int timestamp,
      required final String origSz,
      required final bool reduceOnly,
      required final String orderType,
      required final bool isTrigger,
      required final double triggerPx,
      required final String triggerCondition,
      required final bool isPositionTpsl,
      required final List<dynamic> children}) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  String get coin;
  @override
  String get side;
  @override
  double get limitPx;
  @override
  double get sz;
  @override
  int get oid;
  @override
  int get timestamp;
  @override
  String get origSz;
  @override
  bool get reduceOnly;
  @override
  String get orderType;
  @override
  bool get isTrigger;
  @override
  double get triggerPx;
  @override
  String get triggerCondition;
  @override
  bool get isPositionTpsl;
  @override
  List<dynamic> get children;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

L2Book _$L2BookFromJson(Map<String, dynamic> json) {
  return _L2Book.fromJson(json);
}

/// @nodoc
mixin _$L2Book {
  String get coin => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;
  List<List<L2BookLevel>> get levels => throw _privateConstructorUsedError;

  /// Serializes this L2Book to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of L2Book
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $L2BookCopyWith<L2Book> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $L2BookCopyWith<$Res> {
  factory $L2BookCopyWith(L2Book value, $Res Function(L2Book) then) =
      _$L2BookCopyWithImpl<$Res, L2Book>;
  @useResult
  $Res call({String coin, int time, List<List<L2BookLevel>> levels});
}

/// @nodoc
class _$L2BookCopyWithImpl<$Res, $Val extends L2Book>
    implements $L2BookCopyWith<$Res> {
  _$L2BookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of L2Book
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coin = null,
    Object? time = null,
    Object? levels = null,
  }) {
    return _then(_value.copyWith(
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      levels: null == levels
          ? _value.levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<List<L2BookLevel>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$L2BookImplCopyWith<$Res> implements $L2BookCopyWith<$Res> {
  factory _$$L2BookImplCopyWith(
          _$L2BookImpl value, $Res Function(_$L2BookImpl) then) =
      __$$L2BookImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String coin, int time, List<List<L2BookLevel>> levels});
}

/// @nodoc
class __$$L2BookImplCopyWithImpl<$Res>
    extends _$L2BookCopyWithImpl<$Res, _$L2BookImpl>
    implements _$$L2BookImplCopyWith<$Res> {
  __$$L2BookImplCopyWithImpl(
      _$L2BookImpl _value, $Res Function(_$L2BookImpl) _then)
      : super(_value, _then);

  /// Create a copy of L2Book
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coin = null,
    Object? time = null,
    Object? levels = null,
  }) {
    return _then(_$L2BookImpl(
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      levels: null == levels
          ? _value._levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<List<L2BookLevel>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$L2BookImpl implements _L2Book {
  const _$L2BookImpl(
      {required this.coin,
      required this.time,
      required final List<List<L2BookLevel>> levels})
      : _levels = levels;

  factory _$L2BookImpl.fromJson(Map<String, dynamic> json) =>
      _$$L2BookImplFromJson(json);

  @override
  final String coin;
  @override
  final int time;
  final List<List<L2BookLevel>> _levels;
  @override
  List<List<L2BookLevel>> get levels {
    if (_levels is EqualUnmodifiableListView) return _levels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_levels);
  }

  @override
  String toString() {
    return 'L2Book(coin: $coin, time: $time, levels: $levels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$L2BookImpl &&
            (identical(other.coin, coin) || other.coin == coin) &&
            (identical(other.time, time) || other.time == time) &&
            const DeepCollectionEquality().equals(other._levels, _levels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, coin, time, const DeepCollectionEquality().hash(_levels));

  /// Create a copy of L2Book
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$L2BookImplCopyWith<_$L2BookImpl> get copyWith =>
      __$$L2BookImplCopyWithImpl<_$L2BookImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$L2BookImplToJson(
      this,
    );
  }
}

abstract class _L2Book implements L2Book {
  const factory _L2Book(
      {required final String coin,
      required final int time,
      required final List<List<L2BookLevel>> levels}) = _$L2BookImpl;

  factory _L2Book.fromJson(Map<String, dynamic> json) = _$L2BookImpl.fromJson;

  @override
  String get coin;
  @override
  int get time;
  @override
  List<List<L2BookLevel>> get levels;

  /// Create a copy of L2Book
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$L2BookImplCopyWith<_$L2BookImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

L2BookLevel _$L2BookLevelFromJson(Map<String, dynamic> json) {
  return _L2BookLevel.fromJson(json);
}

/// @nodoc
mixin _$L2BookLevel {
  double get px => throw _privateConstructorUsedError;
  double get sz => throw _privateConstructorUsedError;
  int get n => throw _privateConstructorUsedError;

  /// Serializes this L2BookLevel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of L2BookLevel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $L2BookLevelCopyWith<L2BookLevel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $L2BookLevelCopyWith<$Res> {
  factory $L2BookLevelCopyWith(
          L2BookLevel value, $Res Function(L2BookLevel) then) =
      _$L2BookLevelCopyWithImpl<$Res, L2BookLevel>;
  @useResult
  $Res call({double px, double sz, int n});
}

/// @nodoc
class _$L2BookLevelCopyWithImpl<$Res, $Val extends L2BookLevel>
    implements $L2BookLevelCopyWith<$Res> {
  _$L2BookLevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of L2BookLevel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? px = null,
    Object? sz = null,
    Object? n = null,
  }) {
    return _then(_value.copyWith(
      px: null == px
          ? _value.px
          : px // ignore: cast_nullable_to_non_nullable
              as double,
      sz: null == sz
          ? _value.sz
          : sz // ignore: cast_nullable_to_non_nullable
              as double,
      n: null == n
          ? _value.n
          : n // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$L2BookLevelImplCopyWith<$Res>
    implements $L2BookLevelCopyWith<$Res> {
  factory _$$L2BookLevelImplCopyWith(
          _$L2BookLevelImpl value, $Res Function(_$L2BookLevelImpl) then) =
      __$$L2BookLevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double px, double sz, int n});
}

/// @nodoc
class __$$L2BookLevelImplCopyWithImpl<$Res>
    extends _$L2BookLevelCopyWithImpl<$Res, _$L2BookLevelImpl>
    implements _$$L2BookLevelImplCopyWith<$Res> {
  __$$L2BookLevelImplCopyWithImpl(
      _$L2BookLevelImpl _value, $Res Function(_$L2BookLevelImpl) _then)
      : super(_value, _then);

  /// Create a copy of L2BookLevel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? px = null,
    Object? sz = null,
    Object? n = null,
  }) {
    return _then(_$L2BookLevelImpl(
      px: null == px
          ? _value.px
          : px // ignore: cast_nullable_to_non_nullable
              as double,
      sz: null == sz
          ? _value.sz
          : sz // ignore: cast_nullable_to_non_nullable
              as double,
      n: null == n
          ? _value.n
          : n // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$L2BookLevelImpl implements _L2BookLevel {
  const _$L2BookLevelImpl(
      {required this.px, required this.sz, required this.n});

  factory _$L2BookLevelImpl.fromJson(Map<String, dynamic> json) =>
      _$$L2BookLevelImplFromJson(json);

  @override
  final double px;
  @override
  final double sz;
  @override
  final int n;

  @override
  String toString() {
    return 'L2BookLevel(px: $px, sz: $sz, n: $n)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$L2BookLevelImpl &&
            (identical(other.px, px) || other.px == px) &&
            (identical(other.sz, sz) || other.sz == sz) &&
            (identical(other.n, n) || other.n == n));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, px, sz, n);

  /// Create a copy of L2BookLevel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$L2BookLevelImplCopyWith<_$L2BookLevelImpl> get copyWith =>
      __$$L2BookLevelImplCopyWithImpl<_$L2BookLevelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$L2BookLevelImplToJson(
      this,
    );
  }
}

abstract class _L2BookLevel implements L2BookLevel {
  const factory _L2BookLevel(
      {required final double px,
      required final double sz,
      required final int n}) = _$L2BookLevelImpl;

  factory _L2BookLevel.fromJson(Map<String, dynamic> json) =
      _$L2BookLevelImpl.fromJson;

  @override
  double get px;
  @override
  double get sz;
  @override
  int get n;

  /// Create a copy of L2BookLevel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$L2BookLevelImplCopyWith<_$L2BookLevelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CandleSnapshot _$CandleSnapshotFromJson(Map<String, dynamic> json) {
  return _CandleSnapshot.fromJson(json);
}

/// @nodoc
mixin _$CandleSnapshot {
  List<Candle> get candles => throw _privateConstructorUsedError;

  /// Serializes this CandleSnapshot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CandleSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CandleSnapshotCopyWith<CandleSnapshot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CandleSnapshotCopyWith<$Res> {
  factory $CandleSnapshotCopyWith(
          CandleSnapshot value, $Res Function(CandleSnapshot) then) =
      _$CandleSnapshotCopyWithImpl<$Res, CandleSnapshot>;
  @useResult
  $Res call({List<Candle> candles});
}

/// @nodoc
class _$CandleSnapshotCopyWithImpl<$Res, $Val extends CandleSnapshot>
    implements $CandleSnapshotCopyWith<$Res> {
  _$CandleSnapshotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CandleSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? candles = null,
  }) {
    return _then(_value.copyWith(
      candles: null == candles
          ? _value.candles
          : candles // ignore: cast_nullable_to_non_nullable
              as List<Candle>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CandleSnapshotImplCopyWith<$Res>
    implements $CandleSnapshotCopyWith<$Res> {
  factory _$$CandleSnapshotImplCopyWith(_$CandleSnapshotImpl value,
          $Res Function(_$CandleSnapshotImpl) then) =
      __$$CandleSnapshotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Candle> candles});
}

/// @nodoc
class __$$CandleSnapshotImplCopyWithImpl<$Res>
    extends _$CandleSnapshotCopyWithImpl<$Res, _$CandleSnapshotImpl>
    implements _$$CandleSnapshotImplCopyWith<$Res> {
  __$$CandleSnapshotImplCopyWithImpl(
      _$CandleSnapshotImpl _value, $Res Function(_$CandleSnapshotImpl) _then)
      : super(_value, _then);

  /// Create a copy of CandleSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? candles = null,
  }) {
    return _then(_$CandleSnapshotImpl(
      candles: null == candles
          ? _value._candles
          : candles // ignore: cast_nullable_to_non_nullable
              as List<Candle>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CandleSnapshotImpl implements _CandleSnapshot {
  const _$CandleSnapshotImpl({required final List<Candle> candles})
      : _candles = candles;

  factory _$CandleSnapshotImpl.fromJson(Map<String, dynamic> json) =>
      _$$CandleSnapshotImplFromJson(json);

  final List<Candle> _candles;
  @override
  List<Candle> get candles {
    if (_candles is EqualUnmodifiableListView) return _candles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_candles);
  }

  @override
  String toString() {
    return 'CandleSnapshot(candles: $candles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CandleSnapshotImpl &&
            const DeepCollectionEquality().equals(other._candles, _candles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_candles));

  /// Create a copy of CandleSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CandleSnapshotImplCopyWith<_$CandleSnapshotImpl> get copyWith =>
      __$$CandleSnapshotImplCopyWithImpl<_$CandleSnapshotImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CandleSnapshotImplToJson(
      this,
    );
  }
}

abstract class _CandleSnapshot implements CandleSnapshot {
  const factory _CandleSnapshot({required final List<Candle> candles}) =
      _$CandleSnapshotImpl;

  factory _CandleSnapshot.fromJson(Map<String, dynamic> json) =
      _$CandleSnapshotImpl.fromJson;

  @override
  List<Candle> get candles;

  /// Create a copy of CandleSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CandleSnapshotImplCopyWith<_$CandleSnapshotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Candle _$CandleFromJson(Map<String, dynamic> json) {
  return _Candle.fromJson(json);
}

/// @nodoc
mixin _$Candle {
  int get t => throw _privateConstructorUsedError;
  int get T => throw _privateConstructorUsedError;
  String get s => throw _privateConstructorUsedError;
  String get i => throw _privateConstructorUsedError;
  double get o => throw _privateConstructorUsedError;
  double get c => throw _privateConstructorUsedError;
  double get h => throw _privateConstructorUsedError;
  double get l => throw _privateConstructorUsedError;
  double get v => throw _privateConstructorUsedError;
  int get n => throw _privateConstructorUsedError;

  /// Serializes this Candle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Candle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CandleCopyWith<Candle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CandleCopyWith<$Res> {
  factory $CandleCopyWith(Candle value, $Res Function(Candle) then) =
      _$CandleCopyWithImpl<$Res, Candle>;
  @useResult
  $Res call(
      {int t,
      int T,
      String s,
      String i,
      double o,
      double c,
      double h,
      double l,
      double v,
      int n});
}

/// @nodoc
class _$CandleCopyWithImpl<$Res, $Val extends Candle>
    implements $CandleCopyWith<$Res> {
  _$CandleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Candle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? t = null,
    Object? T = null,
    Object? s = null,
    Object? i = null,
    Object? o = null,
    Object? c = null,
    Object? h = null,
    Object? l = null,
    Object? v = null,
    Object? n = null,
  }) {
    return _then(_value.copyWith(
      t: null == t
          ? _value.t
          : t // ignore: cast_nullable_to_non_nullable
              as int,
      T: null == T
          ? _value.T
          : T // ignore: cast_nullable_to_non_nullable
              as int,
      s: null == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as String,
      i: null == i
          ? _value.i
          : i // ignore: cast_nullable_to_non_nullable
              as String,
      o: null == o
          ? _value.o
          : o // ignore: cast_nullable_to_non_nullable
              as double,
      c: null == c
          ? _value.c
          : c // ignore: cast_nullable_to_non_nullable
              as double,
      h: null == h
          ? _value.h
          : h // ignore: cast_nullable_to_non_nullable
              as double,
      l: null == l
          ? _value.l
          : l // ignore: cast_nullable_to_non_nullable
              as double,
      v: null == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as double,
      n: null == n
          ? _value.n
          : n // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CandleImplCopyWith<$Res> implements $CandleCopyWith<$Res> {
  factory _$$CandleImplCopyWith(
          _$CandleImpl value, $Res Function(_$CandleImpl) then) =
      __$$CandleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int t,
      int T,
      String s,
      String i,
      double o,
      double c,
      double h,
      double l,
      double v,
      int n});
}

/// @nodoc
class __$$CandleImplCopyWithImpl<$Res>
    extends _$CandleCopyWithImpl<$Res, _$CandleImpl>
    implements _$$CandleImplCopyWith<$Res> {
  __$$CandleImplCopyWithImpl(
      _$CandleImpl _value, $Res Function(_$CandleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Candle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? t = null,
    Object? T = null,
    Object? s = null,
    Object? i = null,
    Object? o = null,
    Object? c = null,
    Object? h = null,
    Object? l = null,
    Object? v = null,
    Object? n = null,
  }) {
    return _then(_$CandleImpl(
      t: null == t
          ? _value.t
          : t // ignore: cast_nullable_to_non_nullable
              as int,
      T: null == T
          ? _value.T
          : T // ignore: cast_nullable_to_non_nullable
              as int,
      s: null == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as String,
      i: null == i
          ? _value.i
          : i // ignore: cast_nullable_to_non_nullable
              as String,
      o: null == o
          ? _value.o
          : o // ignore: cast_nullable_to_non_nullable
              as double,
      c: null == c
          ? _value.c
          : c // ignore: cast_nullable_to_non_nullable
              as double,
      h: null == h
          ? _value.h
          : h // ignore: cast_nullable_to_non_nullable
              as double,
      l: null == l
          ? _value.l
          : l // ignore: cast_nullable_to_non_nullable
              as double,
      v: null == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as double,
      n: null == n
          ? _value.n
          : n // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CandleImpl implements _Candle {
  const _$CandleImpl(
      {required this.t,
      required this.T,
      required this.s,
      required this.i,
      required this.o,
      required this.c,
      required this.h,
      required this.l,
      required this.v,
      required this.n});

  factory _$CandleImpl.fromJson(Map<String, dynamic> json) =>
      _$$CandleImplFromJson(json);

  @override
  final int t;
  @override
  final int T;
  @override
  final String s;
  @override
  final String i;
  @override
  final double o;
  @override
  final double c;
  @override
  final double h;
  @override
  final double l;
  @override
  final double v;
  @override
  final int n;

  @override
  String toString() {
    return 'Candle(t: $t, T: $T, s: $s, i: $i, o: $o, c: $c, h: $h, l: $l, v: $v, n: $n)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CandleImpl &&
            (identical(other.t, t) || other.t == t) &&
            (identical(other.T, T) || other.T == T) &&
            (identical(other.s, s) || other.s == s) &&
            (identical(other.i, i) || other.i == i) &&
            (identical(other.o, o) || other.o == o) &&
            (identical(other.c, c) || other.c == c) &&
            (identical(other.h, h) || other.h == h) &&
            (identical(other.l, l) || other.l == l) &&
            (identical(other.v, v) || other.v == v) &&
            (identical(other.n, n) || other.n == n));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, t, T, s, i, o, c, h, l, v, n);

  /// Create a copy of Candle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CandleImplCopyWith<_$CandleImpl> get copyWith =>
      __$$CandleImplCopyWithImpl<_$CandleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CandleImplToJson(
      this,
    );
  }
}

abstract class _Candle implements Candle {
  const factory _Candle(
      {required final int t,
      required final int T,
      required final String s,
      required final String i,
      required final double o,
      required final double c,
      required final double h,
      required final double l,
      required final double v,
      required final int n}) = _$CandleImpl;

  factory _Candle.fromJson(Map<String, dynamic> json) = _$CandleImpl.fromJson;

  @override
  int get t;
  @override
  int get T;
  @override
  String get s;
  @override
  String get i;
  @override
  double get o;
  @override
  double get c;
  @override
  double get h;
  @override
  double get l;
  @override
  double get v;
  @override
  int get n;

  /// Create a copy of Candle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CandleImplCopyWith<_$CandleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
