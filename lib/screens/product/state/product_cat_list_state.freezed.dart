// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_cat_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductCategoryListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            ProductCategoryModelData data, bool status, int statusCode)
        loaded,
    required TResult Function(String error) error,
    required TResult Function() noInternet,
    required TResult Function(List<DashboardModelFastResult> items) reachedEnd,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            ProductCategoryModelData data, bool status, int statusCode)?
        loaded,
    TResult? Function(String error)? error,
    TResult? Function()? noInternet,
    TResult? Function(List<DashboardModelFastResult> items)? reachedEnd,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            ProductCategoryModelData data, bool status, int statusCode)?
        loaded,
    TResult Function(String error)? error,
    TResult Function()? noInternet,
    TResult Function(List<DashboardModelFastResult> items)? reachedEnd,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_ReachedEnd value) reachedEnd,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_ReachedEnd value)? reachedEnd,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_ReachedEnd value)? reachedEnd,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCategoryListStateCopyWith<$Res> {
  factory $ProductCategoryListStateCopyWith(ProductCategoryListState value,
          $Res Function(ProductCategoryListState) then) =
      _$ProductCategoryListStateCopyWithImpl<$Res, ProductCategoryListState>;
}

/// @nodoc
class _$ProductCategoryListStateCopyWithImpl<$Res,
        $Val extends ProductCategoryListState>
    implements $ProductCategoryListStateCopyWith<$Res> {
  _$ProductCategoryListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductCategoryListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ProductCategoryListStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductCategoryListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ProductCategoryListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            ProductCategoryModelData data, bool status, int statusCode)
        loaded,
    required TResult Function(String error) error,
    required TResult Function() noInternet,
    required TResult Function(List<DashboardModelFastResult> items) reachedEnd,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            ProductCategoryModelData data, bool status, int statusCode)?
        loaded,
    TResult? Function(String error)? error,
    TResult? Function()? noInternet,
    TResult? Function(List<DashboardModelFastResult> items)? reachedEnd,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            ProductCategoryModelData data, bool status, int statusCode)?
        loaded,
    TResult Function(String error)? error,
    TResult Function()? noInternet,
    TResult Function(List<DashboardModelFastResult> items)? reachedEnd,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_ReachedEnd value) reachedEnd,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_ReachedEnd value)? reachedEnd,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_ReachedEnd value)? reachedEnd,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ProductCategoryListState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProductCategoryModelData data, bool status, int statusCode});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ProductCategoryListStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductCategoryListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? status = null,
    Object? statusCode = null,
  }) {
    return _then(_$LoadedImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ProductCategoryModelData,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required this.data, required this.status, required this.statusCode});

  @override
  final ProductCategoryModelData data;
  @override
  final bool status;
  @override
  final int statusCode;

  @override
  String toString() {
    return 'ProductCategoryListState.loaded(data: $data, status: $status, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, status, statusCode);

  /// Create a copy of ProductCategoryListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            ProductCategoryModelData data, bool status, int statusCode)
        loaded,
    required TResult Function(String error) error,
    required TResult Function() noInternet,
    required TResult Function(List<DashboardModelFastResult> items) reachedEnd,
  }) {
    return loaded(data, status, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            ProductCategoryModelData data, bool status, int statusCode)?
        loaded,
    TResult? Function(String error)? error,
    TResult? Function()? noInternet,
    TResult? Function(List<DashboardModelFastResult> items)? reachedEnd,
  }) {
    return loaded?.call(data, status, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            ProductCategoryModelData data, bool status, int statusCode)?
        loaded,
    TResult Function(String error)? error,
    TResult Function()? noInternet,
    TResult Function(List<DashboardModelFastResult> items)? reachedEnd,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(data, status, statusCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_ReachedEnd value) reachedEnd,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_ReachedEnd value)? reachedEnd,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_ReachedEnd value)? reachedEnd,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ProductCategoryListState {
  const factory _Loaded(
      {required final ProductCategoryModelData data,
      required final bool status,
      required final int statusCode}) = _$LoadedImpl;

  ProductCategoryModelData get data;
  bool get status;
  int get statusCode;

  /// Create a copy of ProductCategoryListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
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
    extends _$ProductCategoryListStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductCategoryListState
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

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'ProductCategoryListState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of ProductCategoryListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            ProductCategoryModelData data, bool status, int statusCode)
        loaded,
    required TResult Function(String error) error,
    required TResult Function() noInternet,
    required TResult Function(List<DashboardModelFastResult> items) reachedEnd,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            ProductCategoryModelData data, bool status, int statusCode)?
        loaded,
    TResult? Function(String error)? error,
    TResult? Function()? noInternet,
    TResult? Function(List<DashboardModelFastResult> items)? reachedEnd,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            ProductCategoryModelData data, bool status, int statusCode)?
        loaded,
    TResult Function(String error)? error,
    TResult Function()? noInternet,
    TResult Function(List<DashboardModelFastResult> items)? reachedEnd,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_ReachedEnd value) reachedEnd,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_ReachedEnd value)? reachedEnd,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_ReachedEnd value)? reachedEnd,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ProductCategoryListState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of ProductCategoryListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoInternetImplCopyWith<$Res> {
  factory _$$NoInternetImplCopyWith(
          _$NoInternetImpl value, $Res Function(_$NoInternetImpl) then) =
      __$$NoInternetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoInternetImplCopyWithImpl<$Res>
    extends _$ProductCategoryListStateCopyWithImpl<$Res, _$NoInternetImpl>
    implements _$$NoInternetImplCopyWith<$Res> {
  __$$NoInternetImplCopyWithImpl(
      _$NoInternetImpl _value, $Res Function(_$NoInternetImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductCategoryListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NoInternetImpl implements _NoInternet {
  const _$NoInternetImpl();

  @override
  String toString() {
    return 'ProductCategoryListState.noInternet()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoInternetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            ProductCategoryModelData data, bool status, int statusCode)
        loaded,
    required TResult Function(String error) error,
    required TResult Function() noInternet,
    required TResult Function(List<DashboardModelFastResult> items) reachedEnd,
  }) {
    return noInternet();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            ProductCategoryModelData data, bool status, int statusCode)?
        loaded,
    TResult? Function(String error)? error,
    TResult? Function()? noInternet,
    TResult? Function(List<DashboardModelFastResult> items)? reachedEnd,
  }) {
    return noInternet?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            ProductCategoryModelData data, bool status, int statusCode)?
        loaded,
    TResult Function(String error)? error,
    TResult Function()? noInternet,
    TResult Function(List<DashboardModelFastResult> items)? reachedEnd,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_ReachedEnd value) reachedEnd,
  }) {
    return noInternet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_ReachedEnd value)? reachedEnd,
  }) {
    return noInternet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_ReachedEnd value)? reachedEnd,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet(this);
    }
    return orElse();
  }
}

abstract class _NoInternet implements ProductCategoryListState {
  const factory _NoInternet() = _$NoInternetImpl;
}

/// @nodoc
abstract class _$$ReachedEndImplCopyWith<$Res> {
  factory _$$ReachedEndImplCopyWith(
          _$ReachedEndImpl value, $Res Function(_$ReachedEndImpl) then) =
      __$$ReachedEndImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<DashboardModelFastResult> items});
}

/// @nodoc
class __$$ReachedEndImplCopyWithImpl<$Res>
    extends _$ProductCategoryListStateCopyWithImpl<$Res, _$ReachedEndImpl>
    implements _$$ReachedEndImplCopyWith<$Res> {
  __$$ReachedEndImplCopyWithImpl(
      _$ReachedEndImpl _value, $Res Function(_$ReachedEndImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductCategoryListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$ReachedEndImpl(
      null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<DashboardModelFastResult>,
    ));
  }
}

/// @nodoc

class _$ReachedEndImpl implements _ReachedEnd {
  const _$ReachedEndImpl(final List<DashboardModelFastResult> items)
      : _items = items;

  final List<DashboardModelFastResult> _items;
  @override
  List<DashboardModelFastResult> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'ProductCategoryListState.reachedEnd(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReachedEndImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  /// Create a copy of ProductCategoryListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReachedEndImplCopyWith<_$ReachedEndImpl> get copyWith =>
      __$$ReachedEndImplCopyWithImpl<_$ReachedEndImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            ProductCategoryModelData data, bool status, int statusCode)
        loaded,
    required TResult Function(String error) error,
    required TResult Function() noInternet,
    required TResult Function(List<DashboardModelFastResult> items) reachedEnd,
  }) {
    return reachedEnd(items);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            ProductCategoryModelData data, bool status, int statusCode)?
        loaded,
    TResult? Function(String error)? error,
    TResult? Function()? noInternet,
    TResult? Function(List<DashboardModelFastResult> items)? reachedEnd,
  }) {
    return reachedEnd?.call(items);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            ProductCategoryModelData data, bool status, int statusCode)?
        loaded,
    TResult Function(String error)? error,
    TResult Function()? noInternet,
    TResult Function(List<DashboardModelFastResult> items)? reachedEnd,
    required TResult orElse(),
  }) {
    if (reachedEnd != null) {
      return reachedEnd(items);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_NoInternet value) noInternet,
    required TResult Function(_ReachedEnd value) reachedEnd,
  }) {
    return reachedEnd(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_NoInternet value)? noInternet,
    TResult? Function(_ReachedEnd value)? reachedEnd,
  }) {
    return reachedEnd?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_NoInternet value)? noInternet,
    TResult Function(_ReachedEnd value)? reachedEnd,
    required TResult orElse(),
  }) {
    if (reachedEnd != null) {
      return reachedEnd(this);
    }
    return orElse();
  }
}

abstract class _ReachedEnd implements ProductCategoryListState {
  const factory _ReachedEnd(final List<DashboardModelFastResult> items) =
      _$ReachedEndImpl;

  List<DashboardModelFastResult> get items;

  /// Create a copy of ProductCategoryListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReachedEndImplCopyWith<_$ReachedEndImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
