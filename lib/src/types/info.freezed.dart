// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Meta _$MetaFromJson(Map<String, dynamic> json) {
  return _Meta.fromJson(json);
}

/// @nodoc
mixin _$Meta {
  List<Asset> get universe => throw _privateConstructorUsedError;

  /// Serializes this Meta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MetaCopyWith<Meta> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetaCopyWith<$Res> {
  factory $MetaCopyWith(Meta value, $Res Function(Meta) then) =
      _$MetaCopyWithImpl<$Res, Meta>;
  @useResult
  $Res call({List<Asset> universe});
}

/// @nodoc
class _$MetaCopyWithImpl<$Res, $Val extends Meta>
    implements $MetaCopyWith<$Res> {
  _$MetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? universe = null,
  }) {
    return _then(_value.copyWith(
      universe: null == universe
          ? _value.universe
          : universe // ignore: cast_nullable_to_non_nullable
              as List<Asset>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MetaImplCopyWith<$Res> implements $MetaCopyWith<$Res> {
  factory _$$MetaImplCopyWith(
          _$MetaImpl value, $Res Function(_$MetaImpl) then) =
      __$$MetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Asset> universe});
}

/// @nodoc
class __$$MetaImplCopyWithImpl<$Res>
    extends _$MetaCopyWithImpl<$Res, _$MetaImpl>
    implements _$$MetaImplCopyWith<$Res> {
  __$$MetaImplCopyWithImpl(_$MetaImpl _value, $Res Function(_$MetaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? universe = null,
  }) {
    return _then(_$MetaImpl(
      universe: null == universe
          ? _value._universe
          : universe // ignore: cast_nullable_to_non_nullable
              as List<Asset>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MetaImpl implements _Meta {
  const _$MetaImpl({required final List<Asset> universe})
      : _universe = universe;

  factory _$MetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$MetaImplFromJson(json);

  final List<Asset> _universe;
  @override
  List<Asset> get universe {
    if (_universe is EqualUnmodifiableListView) return _universe;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_universe);
  }

  @override
  String toString() {
    return 'Meta(universe: $universe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetaImpl &&
            const DeepCollectionEquality().equals(other._universe, _universe));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_universe));

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MetaImplCopyWith<_$MetaImpl> get copyWith =>
      __$$MetaImplCopyWithImpl<_$MetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MetaImplToJson(
      this,
    );
  }
}

abstract class _Meta implements Meta {
  const factory _Meta({required final List<Asset> universe}) = _$MetaImpl;

  factory _Meta.fromJson(Map<String, dynamic> json) = _$MetaImpl.fromJson;

  @override
  List<Asset> get universe;

  /// Create a copy of Meta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MetaImplCopyWith<_$MetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Asset _$AssetFromJson(Map<String, dynamic> json) {
  return _Asset.fromJson(json);
}

/// @nodoc
mixin _$Asset {
  String get name => throw _privateConstructorUsedError;
  int get szDecimals => throw _privateConstructorUsedError;
  int get maxLeverage => throw _privateConstructorUsedError;
  bool get onlyIsolated => throw _privateConstructorUsedError;

  /// Serializes this Asset to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssetCopyWith<Asset> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetCopyWith<$Res> {
  factory $AssetCopyWith(Asset value, $Res Function(Asset) then) =
      _$AssetCopyWithImpl<$Res, Asset>;
  @useResult
  $Res call({String name, int szDecimals, int maxLeverage, bool onlyIsolated});
}

/// @nodoc
class _$AssetCopyWithImpl<$Res, $Val extends Asset>
    implements $AssetCopyWith<$Res> {
  _$AssetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? szDecimals = null,
    Object? maxLeverage = null,
    Object? onlyIsolated = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      szDecimals: null == szDecimals
          ? _value.szDecimals
          : szDecimals // ignore: cast_nullable_to_non_nullable
              as int,
      maxLeverage: null == maxLeverage
          ? _value.maxLeverage
          : maxLeverage // ignore: cast_nullable_to_non_nullable
              as int,
      onlyIsolated: null == onlyIsolated
          ? _value.onlyIsolated
          : onlyIsolated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssetImplCopyWith<$Res> implements $AssetCopyWith<$Res> {
  factory _$$AssetImplCopyWith(
          _$AssetImpl value, $Res Function(_$AssetImpl) then) =
      __$$AssetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int szDecimals, int maxLeverage, bool onlyIsolated});
}

/// @nodoc
class __$$AssetImplCopyWithImpl<$Res>
    extends _$AssetCopyWithImpl<$Res, _$AssetImpl>
    implements _$$AssetImplCopyWith<$Res> {
  __$$AssetImplCopyWithImpl(
      _$AssetImpl _value, $Res Function(_$AssetImpl) _then)
      : super(_value, _then);

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? szDecimals = null,
    Object? maxLeverage = null,
    Object? onlyIsolated = null,
  }) {
    return _then(_$AssetImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      szDecimals: null == szDecimals
          ? _value.szDecimals
          : szDecimals // ignore: cast_nullable_to_non_nullable
              as int,
      maxLeverage: null == maxLeverage
          ? _value.maxLeverage
          : maxLeverage // ignore: cast_nullable_to_non_nullable
              as int,
      onlyIsolated: null == onlyIsolated
          ? _value.onlyIsolated
          : onlyIsolated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssetImpl implements _Asset {
  const _$AssetImpl(
      {required this.name,
      required this.szDecimals,
      required this.maxLeverage,
      required this.onlyIsolated});

  factory _$AssetImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssetImplFromJson(json);

  @override
  final String name;
  @override
  final int szDecimals;
  @override
  final int maxLeverage;
  @override
  final bool onlyIsolated;

  @override
  String toString() {
    return 'Asset(name: $name, szDecimals: $szDecimals, maxLeverage: $maxLeverage, onlyIsolated: $onlyIsolated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.szDecimals, szDecimals) ||
                other.szDecimals == szDecimals) &&
            (identical(other.maxLeverage, maxLeverage) ||
                other.maxLeverage == maxLeverage) &&
            (identical(other.onlyIsolated, onlyIsolated) ||
                other.onlyIsolated == onlyIsolated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, szDecimals, maxLeverage, onlyIsolated);

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetImplCopyWith<_$AssetImpl> get copyWith =>
      __$$AssetImplCopyWithImpl<_$AssetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssetImplToJson(
      this,
    );
  }
}

abstract class _Asset implements Asset {
  const factory _Asset(
      {required final String name,
      required final int szDecimals,
      required final int maxLeverage,
      required final bool onlyIsolated}) = _$AssetImpl;

  factory _Asset.fromJson(Map<String, dynamic> json) = _$AssetImpl.fromJson;

  @override
  String get name;
  @override
  int get szDecimals;
  @override
  int get maxLeverage;
  @override
  bool get onlyIsolated;

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssetImplCopyWith<_$AssetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
