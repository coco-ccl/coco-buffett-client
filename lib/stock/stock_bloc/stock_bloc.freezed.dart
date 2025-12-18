// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StockEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StockEvent()';
}


}

/// @nodoc
class $StockEventCopyWith<$Res>  {
$StockEventCopyWith(StockEvent _, $Res Function(StockEvent) __);
}


/// Adds pattern-matching-related methods to [StockEvent].
extension StockEventPatterns on StockEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,}) {final _that = this;
switch (_that) {
case _Started():
return started();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements StockEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StockEvent.started()';
}


}




/// @nodoc
mixin _$StockState {

 StockData get data;
/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockStateCopyWith<StockState> get copyWith => _$StockStateCopyWithImpl<StockState>(this as StockState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockState&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'StockState(data: $data)';
}


}

/// @nodoc
abstract mixin class $StockStateCopyWith<$Res>  {
  factory $StockStateCopyWith(StockState value, $Res Function(StockState) _then) = _$StockStateCopyWithImpl;
@useResult
$Res call({
 StockData data
});


$StockDataCopyWith<$Res> get data;

}
/// @nodoc
class _$StockStateCopyWithImpl<$Res>
    implements $StockStateCopyWith<$Res> {
  _$StockStateCopyWithImpl(this._self, this._then);

  final StockState _self;
  final $Res Function(StockState) _then;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as StockData,
  ));
}
/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockDataCopyWith<$Res> get data {
  
  return $StockDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [StockState].
extension StockStatePatterns on StockState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StockEmpty value)?  empty,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StockEmpty() when empty != null:
return empty(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StockEmpty value)  empty,}){
final _that = this;
switch (_that) {
case StockEmpty():
return empty(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StockEmpty value)?  empty,}){
final _that = this;
switch (_that) {
case StockEmpty() when empty != null:
return empty(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( StockData data)?  empty,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StockEmpty() when empty != null:
return empty(_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( StockData data)  empty,}) {final _that = this;
switch (_that) {
case StockEmpty():
return empty(_that.data);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( StockData data)?  empty,}) {final _that = this;
switch (_that) {
case StockEmpty() when empty != null:
return empty(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class StockEmpty implements StockState {
  const StockEmpty(this.data);
  

@override final  StockData data;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockEmptyCopyWith<StockEmpty> get copyWith => _$StockEmptyCopyWithImpl<StockEmpty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockEmpty&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'StockState.empty(data: $data)';
}


}

/// @nodoc
abstract mixin class $StockEmptyCopyWith<$Res> implements $StockStateCopyWith<$Res> {
  factory $StockEmptyCopyWith(StockEmpty value, $Res Function(StockEmpty) _then) = _$StockEmptyCopyWithImpl;
@override @useResult
$Res call({
 StockData data
});


@override $StockDataCopyWith<$Res> get data;

}
/// @nodoc
class _$StockEmptyCopyWithImpl<$Res>
    implements $StockEmptyCopyWith<$Res> {
  _$StockEmptyCopyWithImpl(this._self, this._then);

  final StockEmpty _self;
  final $Res Function(StockEmpty) _then;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(StockEmpty(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as StockData,
  ));
}

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockDataCopyWith<$Res> get data {
  
  return $StockDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc
mixin _$StockData {

 StockStatus get status; List<String> get stockList;
/// Create a copy of StockData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockDataCopyWith<StockData> get copyWith => _$StockDataCopyWithImpl<StockData>(this as StockData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockData&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.stockList, stockList));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(stockList));

@override
String toString() {
  return 'StockData(status: $status, stockList: $stockList)';
}


}

/// @nodoc
abstract mixin class $StockDataCopyWith<$Res>  {
  factory $StockDataCopyWith(StockData value, $Res Function(StockData) _then) = _$StockDataCopyWithImpl;
@useResult
$Res call({
 StockStatus status, List<String> stockList
});




}
/// @nodoc
class _$StockDataCopyWithImpl<$Res>
    implements $StockDataCopyWith<$Res> {
  _$StockDataCopyWithImpl(this._self, this._then);

  final StockData _self;
  final $Res Function(StockData) _then;

/// Create a copy of StockData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? stockList = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StockStatus,stockList: null == stockList ? _self.stockList : stockList // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [StockData].
extension StockDataPatterns on StockData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockData value)  $default,){
final _that = this;
switch (_that) {
case _StockData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockData value)?  $default,){
final _that = this;
switch (_that) {
case _StockData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StockStatus status,  List<String> stockList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockData() when $default != null:
return $default(_that.status,_that.stockList);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StockStatus status,  List<String> stockList)  $default,) {final _that = this;
switch (_that) {
case _StockData():
return $default(_that.status,_that.stockList);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StockStatus status,  List<String> stockList)?  $default,) {final _that = this;
switch (_that) {
case _StockData() when $default != null:
return $default(_that.status,_that.stockList);case _:
  return null;

}
}

}

/// @nodoc


class _StockData implements StockData {
  const _StockData({this.status = StockStatus.initial, final  List<String> stockList = const []}): _stockList = stockList;
  

@override@JsonKey() final  StockStatus status;
 final  List<String> _stockList;
@override@JsonKey() List<String> get stockList {
  if (_stockList is EqualUnmodifiableListView) return _stockList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stockList);
}


/// Create a copy of StockData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockDataCopyWith<_StockData> get copyWith => __$StockDataCopyWithImpl<_StockData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockData&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._stockList, _stockList));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_stockList));

@override
String toString() {
  return 'StockData(status: $status, stockList: $stockList)';
}


}

/// @nodoc
abstract mixin class _$StockDataCopyWith<$Res> implements $StockDataCopyWith<$Res> {
  factory _$StockDataCopyWith(_StockData value, $Res Function(_StockData) _then) = __$StockDataCopyWithImpl;
@override @useResult
$Res call({
 StockStatus status, List<String> stockList
});




}
/// @nodoc
class __$StockDataCopyWithImpl<$Res>
    implements _$StockDataCopyWith<$Res> {
  __$StockDataCopyWithImpl(this._self, this._then);

  final _StockData _self;
  final $Res Function(_StockData) _then;

/// Create a copy of StockData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? stockList = null,}) {
  return _then(_StockData(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StockStatus,stockList: null == stockList ? _self._stockList : stockList // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
