// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserState _$UserStateFromJson(Map<String, dynamic> json) {
  return _UserState.fromJson(json);
}

/// @nodoc
mixin _$UserState {
  double get withdrawable => throw _privateConstructorUsedError;
  double get crossMaintenanceMarginUsed => throw _privateConstructorUsedError;
  List<AssetPosition> get assetPositions => throw _privateConstructorUsedError;
  MarginSummary get crossMarginSummary => throw _privateConstructorUsedError;
  MarginSummary get marginSummary => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;

  /// Serializes this UserState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStateCopyWith<UserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res, UserState>;
  @useResult
  $Res call(
      {double withdrawable,
      double crossMaintenanceMarginUsed,
      List<AssetPosition> assetPositions,
      MarginSummary crossMarginSummary,
      MarginSummary marginSummary,
      int time});

  $MarginSummaryCopyWith<$Res> get crossMarginSummary;
  $MarginSummaryCopyWith<$Res> get marginSummary;
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res, $Val extends UserState>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? withdrawable = null,
    Object? crossMaintenanceMarginUsed = null,
    Object? assetPositions = null,
    Object? crossMarginSummary = null,
    Object? marginSummary = null,
    Object? time = null,
  }) {
    return _then(_value.copyWith(
      withdrawable: null == withdrawable
          ? _value.withdrawable
          : withdrawable // ignore: cast_nullable_to_non_nullable
              as double,
      crossMaintenanceMarginUsed: null == crossMaintenanceMarginUsed
          ? _value.crossMaintenanceMarginUsed
          : crossMaintenanceMarginUsed // ignore: cast_nullable_to_non_nullable
              as double,
      assetPositions: null == assetPositions
          ? _value.assetPositions
          : assetPositions // ignore: cast_nullable_to_non_nullable
              as List<AssetPosition>,
      crossMarginSummary: null == crossMarginSummary
          ? _value.crossMarginSummary
          : crossMarginSummary // ignore: cast_nullable_to_non_nullable
              as MarginSummary,
      marginSummary: null == marginSummary
          ? _value.marginSummary
          : marginSummary // ignore: cast_nullable_to_non_nullable
              as MarginSummary,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MarginSummaryCopyWith<$Res> get crossMarginSummary {
    return $MarginSummaryCopyWith<$Res>(_value.crossMarginSummary, (value) {
      return _then(_value.copyWith(crossMarginSummary: value) as $Val);
    });
  }

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MarginSummaryCopyWith<$Res> get marginSummary {
    return $MarginSummaryCopyWith<$Res>(_value.marginSummary, (value) {
      return _then(_value.copyWith(marginSummary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserStateImplCopyWith<$Res>
    implements $UserStateCopyWith<$Res> {
  factory _$$UserStateImplCopyWith(
          _$UserStateImpl value, $Res Function(_$UserStateImpl) then) =
      __$$UserStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double withdrawable,
      double crossMaintenanceMarginUsed,
      List<AssetPosition> assetPositions,
      MarginSummary crossMarginSummary,
      MarginSummary marginSummary,
      int time});

  @override
  $MarginSummaryCopyWith<$Res> get crossMarginSummary;
  @override
  $MarginSummaryCopyWith<$Res> get marginSummary;
}

/// @nodoc
class __$$UserStateImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$UserStateImpl>
    implements _$$UserStateImplCopyWith<$Res> {
  __$$UserStateImplCopyWithImpl(
      _$UserStateImpl _value, $Res Function(_$UserStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? withdrawable = null,
    Object? crossMaintenanceMarginUsed = null,
    Object? assetPositions = null,
    Object? crossMarginSummary = null,
    Object? marginSummary = null,
    Object? time = null,
  }) {
    return _then(_$UserStateImpl(
      withdrawable: null == withdrawable
          ? _value.withdrawable
          : withdrawable // ignore: cast_nullable_to_non_nullable
              as double,
      crossMaintenanceMarginUsed: null == crossMaintenanceMarginUsed
          ? _value.crossMaintenanceMarginUsed
          : crossMaintenanceMarginUsed // ignore: cast_nullable_to_non_nullable
              as double,
      assetPositions: null == assetPositions
          ? _value._assetPositions
          : assetPositions // ignore: cast_nullable_to_non_nullable
              as List<AssetPosition>,
      crossMarginSummary: null == crossMarginSummary
          ? _value.crossMarginSummary
          : crossMarginSummary // ignore: cast_nullable_to_non_nullable
              as MarginSummary,
      marginSummary: null == marginSummary
          ? _value.marginSummary
          : marginSummary // ignore: cast_nullable_to_non_nullable
              as MarginSummary,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserStateImpl implements _UserState {
  const _$UserStateImpl(
      {required this.withdrawable,
      required this.crossMaintenanceMarginUsed,
      required final List<AssetPosition> assetPositions,
      required this.crossMarginSummary,
      required this.marginSummary,
      required this.time})
      : _assetPositions = assetPositions;

  factory _$UserStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStateImplFromJson(json);

  @override
  final double withdrawable;
  @override
  final double crossMaintenanceMarginUsed;
  final List<AssetPosition> _assetPositions;
  @override
  List<AssetPosition> get assetPositions {
    if (_assetPositions is EqualUnmodifiableListView) return _assetPositions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assetPositions);
  }

  @override
  final MarginSummary crossMarginSummary;
  @override
  final MarginSummary marginSummary;
  @override
  final int time;

  @override
  String toString() {
    return 'UserState(withdrawable: $withdrawable, crossMaintenanceMarginUsed: $crossMaintenanceMarginUsed, assetPositions: $assetPositions, crossMarginSummary: $crossMarginSummary, marginSummary: $marginSummary, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStateImpl &&
            (identical(other.withdrawable, withdrawable) ||
                other.withdrawable == withdrawable) &&
            (identical(other.crossMaintenanceMarginUsed,
                    crossMaintenanceMarginUsed) ||
                other.crossMaintenanceMarginUsed ==
                    crossMaintenanceMarginUsed) &&
            const DeepCollectionEquality()
                .equals(other._assetPositions, _assetPositions) &&
            (identical(other.crossMarginSummary, crossMarginSummary) ||
                other.crossMarginSummary == crossMarginSummary) &&
            (identical(other.marginSummary, marginSummary) ||
                other.marginSummary == marginSummary) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      withdrawable,
      crossMaintenanceMarginUsed,
      const DeepCollectionEquality().hash(_assetPositions),
      crossMarginSummary,
      marginSummary,
      time);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStateImplCopyWith<_$UserStateImpl> get copyWith =>
      __$$UserStateImplCopyWithImpl<_$UserStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserStateImplToJson(
      this,
    );
  }
}

abstract class _UserState implements UserState {
  const factory _UserState(
      {required final double withdrawable,
      required final double crossMaintenanceMarginUsed,
      required final List<AssetPosition> assetPositions,
      required final MarginSummary crossMarginSummary,
      required final MarginSummary marginSummary,
      required final int time}) = _$UserStateImpl;

  factory _UserState.fromJson(Map<String, dynamic> json) =
      _$UserStateImpl.fromJson;

  @override
  double get withdrawable;
  @override
  double get crossMaintenanceMarginUsed;
  @override
  List<AssetPosition> get assetPositions;
  @override
  MarginSummary get crossMarginSummary;
  @override
  MarginSummary get marginSummary;
  @override
  int get time;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStateImplCopyWith<_$UserStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssetPosition _$AssetPositionFromJson(Map<String, dynamic> json) {
  return _AssetPosition.fromJson(json);
}

/// @nodoc
mixin _$AssetPosition {
  Position get position => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this AssetPosition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssetPosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssetPositionCopyWith<AssetPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetPositionCopyWith<$Res> {
  factory $AssetPositionCopyWith(
          AssetPosition value, $Res Function(AssetPosition) then) =
      _$AssetPositionCopyWithImpl<$Res, AssetPosition>;
  @useResult
  $Res call({Position position, String type});

  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class _$AssetPositionCopyWithImpl<$Res, $Val extends AssetPosition>
    implements $AssetPositionCopyWith<$Res> {
  _$AssetPositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssetPosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of AssetPosition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PositionCopyWith<$Res> get position {
    return $PositionCopyWith<$Res>(_value.position, (value) {
      return _then(_value.copyWith(position: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AssetPositionImplCopyWith<$Res>
    implements $AssetPositionCopyWith<$Res> {
  factory _$$AssetPositionImplCopyWith(
          _$AssetPositionImpl value, $Res Function(_$AssetPositionImpl) then) =
      __$$AssetPositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Position position, String type});

  @override
  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class __$$AssetPositionImplCopyWithImpl<$Res>
    extends _$AssetPositionCopyWithImpl<$Res, _$AssetPositionImpl>
    implements _$$AssetPositionImplCopyWith<$Res> {
  __$$AssetPositionImplCopyWithImpl(
      _$AssetPositionImpl _value, $Res Function(_$AssetPositionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AssetPosition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? type = null,
  }) {
    return _then(_$AssetPositionImpl(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssetPositionImpl implements _AssetPosition {
  const _$AssetPositionImpl({required this.position, required this.type});

  factory _$AssetPositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssetPositionImplFromJson(json);

  @override
  final Position position;
  @override
  final String type;

  @override
  String toString() {
    return 'AssetPosition(position: $position, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetPositionImpl &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, position, type);

  /// Create a copy of AssetPosition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetPositionImplCopyWith<_$AssetPositionImpl> get copyWith =>
      __$$AssetPositionImplCopyWithImpl<_$AssetPositionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssetPositionImplToJson(
      this,
    );
  }
}

abstract class _AssetPosition implements AssetPosition {
  const factory _AssetPosition(
      {required final Position position,
      required final String type}) = _$AssetPositionImpl;

  factory _AssetPosition.fromJson(Map<String, dynamic> json) =
      _$AssetPositionImpl.fromJson;

  @override
  Position get position;
  @override
  String get type;

  /// Create a copy of AssetPosition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssetPositionImplCopyWith<_$AssetPositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Position _$PositionFromJson(Map<String, dynamic> json) {
  return _Position.fromJson(json);
}

/// @nodoc
mixin _$Position {
  String get coin => throw _privateConstructorUsedError;
  double get entryPx => throw _privateConstructorUsedError;
  Leverage get leverage => throw _privateConstructorUsedError;
  double get liquidationPx => throw _privateConstructorUsedError;
  double get marginUsed => throw _privateConstructorUsedError;
  double get positionValue => throw _privateConstructorUsedError;
  double get returnOnEquity => throw _privateConstructorUsedError;
  double get szi => throw _privateConstructorUsedError;
  double get unrealizedPnl => throw _privateConstructorUsedError;
  int get maxLeverage => throw _privateConstructorUsedError;
  CumFunding get cumFunding => throw _privateConstructorUsedError;

  /// Serializes this Position to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PositionCopyWith<Position> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PositionCopyWith<$Res> {
  factory $PositionCopyWith(Position value, $Res Function(Position) then) =
      _$PositionCopyWithImpl<$Res, Position>;
  @useResult
  $Res call(
      {String coin,
      double entryPx,
      Leverage leverage,
      double liquidationPx,
      double marginUsed,
      double positionValue,
      double returnOnEquity,
      double szi,
      double unrealizedPnl,
      int maxLeverage,
      CumFunding cumFunding});

  $LeverageCopyWith<$Res> get leverage;
  $CumFundingCopyWith<$Res> get cumFunding;
}

/// @nodoc
class _$PositionCopyWithImpl<$Res, $Val extends Position>
    implements $PositionCopyWith<$Res> {
  _$PositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coin = null,
    Object? entryPx = null,
    Object? leverage = null,
    Object? liquidationPx = null,
    Object? marginUsed = null,
    Object? positionValue = null,
    Object? returnOnEquity = null,
    Object? szi = null,
    Object? unrealizedPnl = null,
    Object? maxLeverage = null,
    Object? cumFunding = null,
  }) {
    return _then(_value.copyWith(
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as String,
      entryPx: null == entryPx
          ? _value.entryPx
          : entryPx // ignore: cast_nullable_to_non_nullable
              as double,
      leverage: null == leverage
          ? _value.leverage
          : leverage // ignore: cast_nullable_to_non_nullable
              as Leverage,
      liquidationPx: null == liquidationPx
          ? _value.liquidationPx
          : liquidationPx // ignore: cast_nullable_to_non_nullable
              as double,
      marginUsed: null == marginUsed
          ? _value.marginUsed
          : marginUsed // ignore: cast_nullable_to_non_nullable
              as double,
      positionValue: null == positionValue
          ? _value.positionValue
          : positionValue // ignore: cast_nullable_to_non_nullable
              as double,
      returnOnEquity: null == returnOnEquity
          ? _value.returnOnEquity
          : returnOnEquity // ignore: cast_nullable_to_non_nullable
              as double,
      szi: null == szi
          ? _value.szi
          : szi // ignore: cast_nullable_to_non_nullable
              as double,
      unrealizedPnl: null == unrealizedPnl
          ? _value.unrealizedPnl
          : unrealizedPnl // ignore: cast_nullable_to_non_nullable
              as double,
      maxLeverage: null == maxLeverage
          ? _value.maxLeverage
          : maxLeverage // ignore: cast_nullable_to_non_nullable
              as int,
      cumFunding: null == cumFunding
          ? _value.cumFunding
          : cumFunding // ignore: cast_nullable_to_non_nullable
              as CumFunding,
    ) as $Val);
  }

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LeverageCopyWith<$Res> get leverage {
    return $LeverageCopyWith<$Res>(_value.leverage, (value) {
      return _then(_value.copyWith(leverage: value) as $Val);
    });
  }

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CumFundingCopyWith<$Res> get cumFunding {
    return $CumFundingCopyWith<$Res>(_value.cumFunding, (value) {
      return _then(_value.copyWith(cumFunding: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PositionImplCopyWith<$Res>
    implements $PositionCopyWith<$Res> {
  factory _$$PositionImplCopyWith(
          _$PositionImpl value, $Res Function(_$PositionImpl) then) =
      __$$PositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String coin,
      double entryPx,
      Leverage leverage,
      double liquidationPx,
      double marginUsed,
      double positionValue,
      double returnOnEquity,
      double szi,
      double unrealizedPnl,
      int maxLeverage,
      CumFunding cumFunding});

  @override
  $LeverageCopyWith<$Res> get leverage;
  @override
  $CumFundingCopyWith<$Res> get cumFunding;
}

/// @nodoc
class __$$PositionImplCopyWithImpl<$Res>
    extends _$PositionCopyWithImpl<$Res, _$PositionImpl>
    implements _$$PositionImplCopyWith<$Res> {
  __$$PositionImplCopyWithImpl(
      _$PositionImpl _value, $Res Function(_$PositionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coin = null,
    Object? entryPx = null,
    Object? leverage = null,
    Object? liquidationPx = null,
    Object? marginUsed = null,
    Object? positionValue = null,
    Object? returnOnEquity = null,
    Object? szi = null,
    Object? unrealizedPnl = null,
    Object? maxLeverage = null,
    Object? cumFunding = null,
  }) {
    return _then(_$PositionImpl(
      coin: null == coin
          ? _value.coin
          : coin // ignore: cast_nullable_to_non_nullable
              as String,
      entryPx: null == entryPx
          ? _value.entryPx
          : entryPx // ignore: cast_nullable_to_non_nullable
              as double,
      leverage: null == leverage
          ? _value.leverage
          : leverage // ignore: cast_nullable_to_non_nullable
              as Leverage,
      liquidationPx: null == liquidationPx
          ? _value.liquidationPx
          : liquidationPx // ignore: cast_nullable_to_non_nullable
              as double,
      marginUsed: null == marginUsed
          ? _value.marginUsed
          : marginUsed // ignore: cast_nullable_to_non_nullable
              as double,
      positionValue: null == positionValue
          ? _value.positionValue
          : positionValue // ignore: cast_nullable_to_non_nullable
              as double,
      returnOnEquity: null == returnOnEquity
          ? _value.returnOnEquity
          : returnOnEquity // ignore: cast_nullable_to_non_nullable
              as double,
      szi: null == szi
          ? _value.szi
          : szi // ignore: cast_nullable_to_non_nullable
              as double,
      unrealizedPnl: null == unrealizedPnl
          ? _value.unrealizedPnl
          : unrealizedPnl // ignore: cast_nullable_to_non_nullable
              as double,
      maxLeverage: null == maxLeverage
          ? _value.maxLeverage
          : maxLeverage // ignore: cast_nullable_to_non_nullable
              as int,
      cumFunding: null == cumFunding
          ? _value.cumFunding
          : cumFunding // ignore: cast_nullable_to_non_nullable
              as CumFunding,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PositionImpl implements _Position {
  const _$PositionImpl(
      {required this.coin,
      required this.entryPx,
      required this.leverage,
      required this.liquidationPx,
      required this.marginUsed,
      required this.positionValue,
      required this.returnOnEquity,
      required this.szi,
      required this.unrealizedPnl,
      required this.maxLeverage,
      required this.cumFunding});

  factory _$PositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PositionImplFromJson(json);

  @override
  final String coin;
  @override
  final double entryPx;
  @override
  final Leverage leverage;
  @override
  final double liquidationPx;
  @override
  final double marginUsed;
  @override
  final double positionValue;
  @override
  final double returnOnEquity;
  @override
  final double szi;
  @override
  final double unrealizedPnl;
  @override
  final int maxLeverage;
  @override
  final CumFunding cumFunding;

  @override
  String toString() {
    return 'Position(coin: $coin, entryPx: $entryPx, leverage: $leverage, liquidationPx: $liquidationPx, marginUsed: $marginUsed, positionValue: $positionValue, returnOnEquity: $returnOnEquity, szi: $szi, unrealizedPnl: $unrealizedPnl, maxLeverage: $maxLeverage, cumFunding: $cumFunding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PositionImpl &&
            (identical(other.coin, coin) || other.coin == coin) &&
            (identical(other.entryPx, entryPx) || other.entryPx == entryPx) &&
            (identical(other.leverage, leverage) ||
                other.leverage == leverage) &&
            (identical(other.liquidationPx, liquidationPx) ||
                other.liquidationPx == liquidationPx) &&
            (identical(other.marginUsed, marginUsed) ||
                other.marginUsed == marginUsed) &&
            (identical(other.positionValue, positionValue) ||
                other.positionValue == positionValue) &&
            (identical(other.returnOnEquity, returnOnEquity) ||
                other.returnOnEquity == returnOnEquity) &&
            (identical(other.szi, szi) || other.szi == szi) &&
            (identical(other.unrealizedPnl, unrealizedPnl) ||
                other.unrealizedPnl == unrealizedPnl) &&
            (identical(other.maxLeverage, maxLeverage) ||
                other.maxLeverage == maxLeverage) &&
            (identical(other.cumFunding, cumFunding) ||
                other.cumFunding == cumFunding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      coin,
      entryPx,
      leverage,
      liquidationPx,
      marginUsed,
      positionValue,
      returnOnEquity,
      szi,
      unrealizedPnl,
      maxLeverage,
      cumFunding);

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PositionImplCopyWith<_$PositionImpl> get copyWith =>
      __$$PositionImplCopyWithImpl<_$PositionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PositionImplToJson(
      this,
    );
  }
}

abstract class _Position implements Position {
  const factory _Position(
      {required final String coin,
      required final double entryPx,
      required final Leverage leverage,
      required final double liquidationPx,
      required final double marginUsed,
      required final double positionValue,
      required final double returnOnEquity,
      required final double szi,
      required final double unrealizedPnl,
      required final int maxLeverage,
      required final CumFunding cumFunding}) = _$PositionImpl;

  factory _Position.fromJson(Map<String, dynamic> json) =
      _$PositionImpl.fromJson;

  @override
  String get coin;
  @override
  double get entryPx;
  @override
  Leverage get leverage;
  @override
  double get liquidationPx;
  @override
  double get marginUsed;
  @override
  double get positionValue;
  @override
  double get returnOnEquity;
  @override
  double get szi;
  @override
  double get unrealizedPnl;
  @override
  int get maxLeverage;
  @override
  CumFunding get cumFunding;

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PositionImplCopyWith<_$PositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Leverage _$LeverageFromJson(Map<String, dynamic> json) {
  return _Leverage.fromJson(json);
}

/// @nodoc
mixin _$Leverage {
  String get type => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;

  /// Serializes this Leverage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Leverage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeverageCopyWith<Leverage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeverageCopyWith<$Res> {
  factory $LeverageCopyWith(Leverage value, $Res Function(Leverage) then) =
      _$LeverageCopyWithImpl<$Res, Leverage>;
  @useResult
  $Res call({String type, int value});
}

/// @nodoc
class _$LeverageCopyWithImpl<$Res, $Val extends Leverage>
    implements $LeverageCopyWith<$Res> {
  _$LeverageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Leverage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeverageImplCopyWith<$Res>
    implements $LeverageCopyWith<$Res> {
  factory _$$LeverageImplCopyWith(
          _$LeverageImpl value, $Res Function(_$LeverageImpl) then) =
      __$$LeverageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, int value});
}

/// @nodoc
class __$$LeverageImplCopyWithImpl<$Res>
    extends _$LeverageCopyWithImpl<$Res, _$LeverageImpl>
    implements _$$LeverageImplCopyWith<$Res> {
  __$$LeverageImplCopyWithImpl(
      _$LeverageImpl _value, $Res Function(_$LeverageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Leverage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = null,
  }) {
    return _then(_$LeverageImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeverageImpl implements _Leverage {
  const _$LeverageImpl({required this.type, required this.value});

  factory _$LeverageImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeverageImplFromJson(json);

  @override
  final String type;
  @override
  final int value;

  @override
  String toString() {
    return 'Leverage(type: $type, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeverageImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, value);

  /// Create a copy of Leverage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeverageImplCopyWith<_$LeverageImpl> get copyWith =>
      __$$LeverageImplCopyWithImpl<_$LeverageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeverageImplToJson(
      this,
    );
  }
}

abstract class _Leverage implements Leverage {
  const factory _Leverage(
      {required final String type, required final int value}) = _$LeverageImpl;

  factory _Leverage.fromJson(Map<String, dynamic> json) =
      _$LeverageImpl.fromJson;

  @override
  String get type;
  @override
  int get value;

  /// Create a copy of Leverage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeverageImplCopyWith<_$LeverageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CumFunding _$CumFundingFromJson(Map<String, dynamic> json) {
  return _CumFunding.fromJson(json);
}

/// @nodoc
mixin _$CumFunding {
  double get allTime => throw _privateConstructorUsedError;
  double get sinceOpen => throw _privateConstructorUsedError;
  double get sinceChange => throw _privateConstructorUsedError;

  /// Serializes this CumFunding to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CumFunding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CumFundingCopyWith<CumFunding> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CumFundingCopyWith<$Res> {
  factory $CumFundingCopyWith(
          CumFunding value, $Res Function(CumFunding) then) =
      _$CumFundingCopyWithImpl<$Res, CumFunding>;
  @useResult
  $Res call({double allTime, double sinceOpen, double sinceChange});
}

/// @nodoc
class _$CumFundingCopyWithImpl<$Res, $Val extends CumFunding>
    implements $CumFundingCopyWith<$Res> {
  _$CumFundingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CumFunding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allTime = null,
    Object? sinceOpen = null,
    Object? sinceChange = null,
  }) {
    return _then(_value.copyWith(
      allTime: null == allTime
          ? _value.allTime
          : allTime // ignore: cast_nullable_to_non_nullable
              as double,
      sinceOpen: null == sinceOpen
          ? _value.sinceOpen
          : sinceOpen // ignore: cast_nullable_to_non_nullable
              as double,
      sinceChange: null == sinceChange
          ? _value.sinceChange
          : sinceChange // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CumFundingImplCopyWith<$Res>
    implements $CumFundingCopyWith<$Res> {
  factory _$$CumFundingImplCopyWith(
          _$CumFundingImpl value, $Res Function(_$CumFundingImpl) then) =
      __$$CumFundingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double allTime, double sinceOpen, double sinceChange});
}

/// @nodoc
class __$$CumFundingImplCopyWithImpl<$Res>
    extends _$CumFundingCopyWithImpl<$Res, _$CumFundingImpl>
    implements _$$CumFundingImplCopyWith<$Res> {
  __$$CumFundingImplCopyWithImpl(
      _$CumFundingImpl _value, $Res Function(_$CumFundingImpl) _then)
      : super(_value, _then);

  /// Create a copy of CumFunding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allTime = null,
    Object? sinceOpen = null,
    Object? sinceChange = null,
  }) {
    return _then(_$CumFundingImpl(
      allTime: null == allTime
          ? _value.allTime
          : allTime // ignore: cast_nullable_to_non_nullable
              as double,
      sinceOpen: null == sinceOpen
          ? _value.sinceOpen
          : sinceOpen // ignore: cast_nullable_to_non_nullable
              as double,
      sinceChange: null == sinceChange
          ? _value.sinceChange
          : sinceChange // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CumFundingImpl implements _CumFunding {
  const _$CumFundingImpl(
      {required this.allTime,
      required this.sinceOpen,
      required this.sinceChange});

  factory _$CumFundingImpl.fromJson(Map<String, dynamic> json) =>
      _$$CumFundingImplFromJson(json);

  @override
  final double allTime;
  @override
  final double sinceOpen;
  @override
  final double sinceChange;

  @override
  String toString() {
    return 'CumFunding(allTime: $allTime, sinceOpen: $sinceOpen, sinceChange: $sinceChange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CumFundingImpl &&
            (identical(other.allTime, allTime) || other.allTime == allTime) &&
            (identical(other.sinceOpen, sinceOpen) ||
                other.sinceOpen == sinceOpen) &&
            (identical(other.sinceChange, sinceChange) ||
                other.sinceChange == sinceChange));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, allTime, sinceOpen, sinceChange);

  /// Create a copy of CumFunding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CumFundingImplCopyWith<_$CumFundingImpl> get copyWith =>
      __$$CumFundingImplCopyWithImpl<_$CumFundingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CumFundingImplToJson(
      this,
    );
  }
}

abstract class _CumFunding implements CumFunding {
  const factory _CumFunding(
      {required final double allTime,
      required final double sinceOpen,
      required final double sinceChange}) = _$CumFundingImpl;

  factory _CumFunding.fromJson(Map<String, dynamic> json) =
      _$CumFundingImpl.fromJson;

  @override
  double get allTime;
  @override
  double get sinceOpen;
  @override
  double get sinceChange;

  /// Create a copy of CumFunding
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CumFundingImplCopyWith<_$CumFundingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MarginSummary _$MarginSummaryFromJson(Map<String, dynamic> json) {
  return _MarginSummary.fromJson(json);
}

/// @nodoc
mixin _$MarginSummary {
  double get accountValue => throw _privateConstructorUsedError;
  double get totalMarginUsed => throw _privateConstructorUsedError;
  double get totalNtlPos => throw _privateConstructorUsedError;
  double get totalRawUsd => throw _privateConstructorUsedError;

  /// Serializes this MarginSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarginSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarginSummaryCopyWith<MarginSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarginSummaryCopyWith<$Res> {
  factory $MarginSummaryCopyWith(
          MarginSummary value, $Res Function(MarginSummary) then) =
      _$MarginSummaryCopyWithImpl<$Res, MarginSummary>;
  @useResult
  $Res call(
      {double accountValue,
      double totalMarginUsed,
      double totalNtlPos,
      double totalRawUsd});
}

/// @nodoc
class _$MarginSummaryCopyWithImpl<$Res, $Val extends MarginSummary>
    implements $MarginSummaryCopyWith<$Res> {
  _$MarginSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarginSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountValue = null,
    Object? totalMarginUsed = null,
    Object? totalNtlPos = null,
    Object? totalRawUsd = null,
  }) {
    return _then(_value.copyWith(
      accountValue: null == accountValue
          ? _value.accountValue
          : accountValue // ignore: cast_nullable_to_non_nullable
              as double,
      totalMarginUsed: null == totalMarginUsed
          ? _value.totalMarginUsed
          : totalMarginUsed // ignore: cast_nullable_to_non_nullable
              as double,
      totalNtlPos: null == totalNtlPos
          ? _value.totalNtlPos
          : totalNtlPos // ignore: cast_nullable_to_non_nullable
              as double,
      totalRawUsd: null == totalRawUsd
          ? _value.totalRawUsd
          : totalRawUsd // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MarginSummaryImplCopyWith<$Res>
    implements $MarginSummaryCopyWith<$Res> {
  factory _$$MarginSummaryImplCopyWith(
          _$MarginSummaryImpl value, $Res Function(_$MarginSummaryImpl) then) =
      __$$MarginSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double accountValue,
      double totalMarginUsed,
      double totalNtlPos,
      double totalRawUsd});
}

/// @nodoc
class __$$MarginSummaryImplCopyWithImpl<$Res>
    extends _$MarginSummaryCopyWithImpl<$Res, _$MarginSummaryImpl>
    implements _$$MarginSummaryImplCopyWith<$Res> {
  __$$MarginSummaryImplCopyWithImpl(
      _$MarginSummaryImpl _value, $Res Function(_$MarginSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of MarginSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountValue = null,
    Object? totalMarginUsed = null,
    Object? totalNtlPos = null,
    Object? totalRawUsd = null,
  }) {
    return _then(_$MarginSummaryImpl(
      accountValue: null == accountValue
          ? _value.accountValue
          : accountValue // ignore: cast_nullable_to_non_nullable
              as double,
      totalMarginUsed: null == totalMarginUsed
          ? _value.totalMarginUsed
          : totalMarginUsed // ignore: cast_nullable_to_non_nullable
              as double,
      totalNtlPos: null == totalNtlPos
          ? _value.totalNtlPos
          : totalNtlPos // ignore: cast_nullable_to_non_nullable
              as double,
      totalRawUsd: null == totalRawUsd
          ? _value.totalRawUsd
          : totalRawUsd // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MarginSummaryImpl implements _MarginSummary {
  const _$MarginSummaryImpl(
      {required this.accountValue,
      required this.totalMarginUsed,
      required this.totalNtlPos,
      required this.totalRawUsd});

  factory _$MarginSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarginSummaryImplFromJson(json);

  @override
  final double accountValue;
  @override
  final double totalMarginUsed;
  @override
  final double totalNtlPos;
  @override
  final double totalRawUsd;

  @override
  String toString() {
    return 'MarginSummary(accountValue: $accountValue, totalMarginUsed: $totalMarginUsed, totalNtlPos: $totalNtlPos, totalRawUsd: $totalRawUsd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarginSummaryImpl &&
            (identical(other.accountValue, accountValue) ||
                other.accountValue == accountValue) &&
            (identical(other.totalMarginUsed, totalMarginUsed) ||
                other.totalMarginUsed == totalMarginUsed) &&
            (identical(other.totalNtlPos, totalNtlPos) ||
                other.totalNtlPos == totalNtlPos) &&
            (identical(other.totalRawUsd, totalRawUsd) ||
                other.totalRawUsd == totalRawUsd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, accountValue, totalMarginUsed, totalNtlPos, totalRawUsd);

  /// Create a copy of MarginSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarginSummaryImplCopyWith<_$MarginSummaryImpl> get copyWith =>
      __$$MarginSummaryImplCopyWithImpl<_$MarginSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarginSummaryImplToJson(
      this,
    );
  }
}

abstract class _MarginSummary implements MarginSummary {
  const factory _MarginSummary(
      {required final double accountValue,
      required final double totalMarginUsed,
      required final double totalNtlPos,
      required final double totalRawUsd}) = _$MarginSummaryImpl;

  factory _MarginSummary.fromJson(Map<String, dynamic> json) =
      _$MarginSummaryImpl.fromJson;

  @override
  double get accountValue;
  @override
  double get totalMarginUsed;
  @override
  double get totalNtlPos;
  @override
  double get totalRawUsd;

  /// Create a copy of MarginSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarginSummaryImplCopyWith<_$MarginSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
