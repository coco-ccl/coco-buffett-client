// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppEvent()';
}


}

/// @nodoc
class $AppEventCopyWith<$Res>  {
$AppEventCopyWith(AppEvent _, $Res Function(AppEvent) __);
}


/// Adds pattern-matching-related methods to [AppEvent].
extension AppEventPatterns on AppEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _AppLocaleChanged value)?  localeChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _AppLocaleChanged() when localeChanged != null:
return localeChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _AppLocaleChanged value)  localeChanged,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _AppLocaleChanged():
return localeChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _AppLocaleChanged value)?  localeChanged,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _AppLocaleChanged() when localeChanged != null:
return localeChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String locale)?  localeChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _AppLocaleChanged() when localeChanged != null:
return localeChanged(_that.locale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String locale)  localeChanged,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _AppLocaleChanged():
return localeChanged(_that.locale);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String locale)?  localeChanged,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _AppLocaleChanged() when localeChanged != null:
return localeChanged(_that.locale);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements AppEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppEvent.started()';
}


}




/// @nodoc


class _AppLocaleChanged implements AppEvent {
  const _AppLocaleChanged(this.locale);
  

 final  String locale;

/// Create a copy of AppEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppLocaleChangedCopyWith<_AppLocaleChanged> get copyWith => __$AppLocaleChangedCopyWithImpl<_AppLocaleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppLocaleChanged&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode => Object.hash(runtimeType,locale);

@override
String toString() {
  return 'AppEvent.localeChanged(locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$AppLocaleChangedCopyWith<$Res> implements $AppEventCopyWith<$Res> {
  factory _$AppLocaleChangedCopyWith(_AppLocaleChanged value, $Res Function(_AppLocaleChanged) _then) = __$AppLocaleChangedCopyWithImpl;
@useResult
$Res call({
 String locale
});




}
/// @nodoc
class __$AppLocaleChangedCopyWithImpl<$Res>
    implements _$AppLocaleChangedCopyWith<$Res> {
  __$AppLocaleChangedCopyWithImpl(this._self, this._then);

  final _AppLocaleChanged _self;
  final $Res Function(_AppLocaleChanged) _then;

/// Create a copy of AppEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? locale = null,}) {
  return _then(_AppLocaleChanged(
null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$AppState {

 AppData get data;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'AppState(data: $data)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 AppData data
});


$AppDataCopyWith<$Res> get data;

}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AppData,
  ));
}
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppDataCopyWith<$Res> get data {
  
  return $AppDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppState].
extension AppStatePatterns on AppState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AppEmpty value)?  empty,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AppEmpty() when empty != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AppEmpty value)  empty,}){
final _that = this;
switch (_that) {
case AppEmpty():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AppEmpty value)?  empty,}){
final _that = this;
switch (_that) {
case AppEmpty() when empty != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AppData data)?  empty,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AppEmpty() when empty != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AppData data)  empty,}) {final _that = this;
switch (_that) {
case AppEmpty():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AppData data)?  empty,}) {final _that = this;
switch (_that) {
case AppEmpty() when empty != null:
return empty(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class AppEmpty implements AppState {
  const AppEmpty(this.data);
  

@override final  AppData data;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppEmptyCopyWith<AppEmpty> get copyWith => _$AppEmptyCopyWithImpl<AppEmpty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppEmpty&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'AppState.empty(data: $data)';
}


}

/// @nodoc
abstract mixin class $AppEmptyCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory $AppEmptyCopyWith(AppEmpty value, $Res Function(AppEmpty) _then) = _$AppEmptyCopyWithImpl;
@override @useResult
$Res call({
 AppData data
});


@override $AppDataCopyWith<$Res> get data;

}
/// @nodoc
class _$AppEmptyCopyWithImpl<$Res>
    implements $AppEmptyCopyWith<$Res> {
  _$AppEmptyCopyWithImpl(this._self, this._then);

  final AppEmpty _self;
  final $Res Function(AppEmpty) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(AppEmpty(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AppData,
  ));
}

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppDataCopyWith<$Res> get data {
  
  return $AppDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc
mixin _$AppData {

 AppStatus get status; String get sample; String get locale;
/// Create a copy of AppData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppDataCopyWith<AppData> get copyWith => _$AppDataCopyWithImpl<AppData>(this as AppData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppData&&(identical(other.status, status) || other.status == status)&&(identical(other.sample, sample) || other.sample == sample)&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode => Object.hash(runtimeType,status,sample,locale);

@override
String toString() {
  return 'AppData(status: $status, sample: $sample, locale: $locale)';
}


}

/// @nodoc
abstract mixin class $AppDataCopyWith<$Res>  {
  factory $AppDataCopyWith(AppData value, $Res Function(AppData) _then) = _$AppDataCopyWithImpl;
@useResult
$Res call({
 AppStatus status, String sample, String locale
});




}
/// @nodoc
class _$AppDataCopyWithImpl<$Res>
    implements $AppDataCopyWith<$Res> {
  _$AppDataCopyWithImpl(this._self, this._then);

  final AppData _self;
  final $Res Function(AppData) _then;

/// Create a copy of AppData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? sample = null,Object? locale = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppStatus,sample: null == sample ? _self.sample : sample // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppData].
extension AppDataPatterns on AppData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppData value)  $default,){
final _that = this;
switch (_that) {
case _AppData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppData value)?  $default,){
final _that = this;
switch (_that) {
case _AppData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppStatus status,  String sample,  String locale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppData() when $default != null:
return $default(_that.status,_that.sample,_that.locale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppStatus status,  String sample,  String locale)  $default,) {final _that = this;
switch (_that) {
case _AppData():
return $default(_that.status,_that.sample,_that.locale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppStatus status,  String sample,  String locale)?  $default,) {final _that = this;
switch (_that) {
case _AppData() when $default != null:
return $default(_that.status,_that.sample,_that.locale);case _:
  return null;

}
}

}

/// @nodoc


class _AppData implements AppData {
  const _AppData({this.status = AppStatus.initial, this.sample = '', this.locale = 'ko'});
  

@override@JsonKey() final  AppStatus status;
@override@JsonKey() final  String sample;
@override@JsonKey() final  String locale;

/// Create a copy of AppData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppDataCopyWith<_AppData> get copyWith => __$AppDataCopyWithImpl<_AppData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppData&&(identical(other.status, status) || other.status == status)&&(identical(other.sample, sample) || other.sample == sample)&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode => Object.hash(runtimeType,status,sample,locale);

@override
String toString() {
  return 'AppData(status: $status, sample: $sample, locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$AppDataCopyWith<$Res> implements $AppDataCopyWith<$Res> {
  factory _$AppDataCopyWith(_AppData value, $Res Function(_AppData) _then) = __$AppDataCopyWithImpl;
@override @useResult
$Res call({
 AppStatus status, String sample, String locale
});




}
/// @nodoc
class __$AppDataCopyWithImpl<$Res>
    implements _$AppDataCopyWith<$Res> {
  __$AppDataCopyWithImpl(this._self, this._then);

  final _AppData _self;
  final $Res Function(_AppData) _then;

/// Create a copy of AppData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? sample = null,Object? locale = null,}) {
  return _then(_AppData(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppStatus,sample: null == sample ? _self.sample : sample // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
