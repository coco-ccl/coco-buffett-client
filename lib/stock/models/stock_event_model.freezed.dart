// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventEffect {

 EventEffectType get type; double get value; List<String> get sectors; int get duration;
/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventEffectCopyWith<EventEffect> get copyWith => _$EventEffectCopyWithImpl<EventEffect>(this as EventEffect, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventEffect&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.sectors, sectors)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode => Object.hash(runtimeType,type,value,const DeepCollectionEquality().hash(sectors),duration);

@override
String toString() {
  return 'EventEffect(type: $type, value: $value, sectors: $sectors, duration: $duration)';
}


}

/// @nodoc
abstract mixin class $EventEffectCopyWith<$Res>  {
  factory $EventEffectCopyWith(EventEffect value, $Res Function(EventEffect) _then) = _$EventEffectCopyWithImpl;
@useResult
$Res call({
 EventEffectType type, double value, List<String> sectors, int duration
});




}
/// @nodoc
class _$EventEffectCopyWithImpl<$Res>
    implements $EventEffectCopyWith<$Res> {
  _$EventEffectCopyWithImpl(this._self, this._then);

  final EventEffect _self;
  final $Res Function(EventEffect) _then;

/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? value = null,Object? sectors = null,Object? duration = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventEffectType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,sectors: null == sectors ? _self.sectors : sectors // ignore: cast_nullable_to_non_nullable
as List<String>,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EventEffect].
extension EventEffectPatterns on EventEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventEffect value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventEffect() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventEffect value)  $default,){
final _that = this;
switch (_that) {
case _EventEffect():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventEffect value)?  $default,){
final _that = this;
switch (_that) {
case _EventEffect() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EventEffectType type,  double value,  List<String> sectors,  int duration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventEffect() when $default != null:
return $default(_that.type,_that.value,_that.sectors,_that.duration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EventEffectType type,  double value,  List<String> sectors,  int duration)  $default,) {final _that = this;
switch (_that) {
case _EventEffect():
return $default(_that.type,_that.value,_that.sectors,_that.duration);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EventEffectType type,  double value,  List<String> sectors,  int duration)?  $default,) {final _that = this;
switch (_that) {
case _EventEffect() when $default != null:
return $default(_that.type,_that.value,_that.sectors,_that.duration);case _:
  return null;

}
}

}

/// @nodoc


class _EventEffect implements EventEffect {
  const _EventEffect({required this.type, this.value = 0, final  List<String> sectors = const [], this.duration = 0}): _sectors = sectors;
  

@override final  EventEffectType type;
@override@JsonKey() final  double value;
 final  List<String> _sectors;
@override@JsonKey() List<String> get sectors {
  if (_sectors is EqualUnmodifiableListView) return _sectors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sectors);
}

@override@JsonKey() final  int duration;

/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventEffectCopyWith<_EventEffect> get copyWith => __$EventEffectCopyWithImpl<_EventEffect>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventEffect&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other._sectors, _sectors)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode => Object.hash(runtimeType,type,value,const DeepCollectionEquality().hash(_sectors),duration);

@override
String toString() {
  return 'EventEffect(type: $type, value: $value, sectors: $sectors, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$EventEffectCopyWith<$Res> implements $EventEffectCopyWith<$Res> {
  factory _$EventEffectCopyWith(_EventEffect value, $Res Function(_EventEffect) _then) = __$EventEffectCopyWithImpl;
@override @useResult
$Res call({
 EventEffectType type, double value, List<String> sectors, int duration
});




}
/// @nodoc
class __$EventEffectCopyWithImpl<$Res>
    implements _$EventEffectCopyWith<$Res> {
  __$EventEffectCopyWithImpl(this._self, this._then);

  final _EventEffect _self;
  final $Res Function(_EventEffect) _then;

/// Create a copy of EventEffect
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? value = null,Object? sectors = null,Object? duration = null,}) {
  return _then(_EventEffect(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventEffectType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,sectors: null == sectors ? _self._sectors : sectors // ignore: cast_nullable_to_non_nullable
as List<String>,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$StockEventModel {

 String get id; String get title; String get description; EventEffect get effect; double get probability; bool get isPositive; DateTime? get startTime;
/// Create a copy of StockEventModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockEventModelCopyWith<StockEventModel> get copyWith => _$StockEventModelCopyWithImpl<StockEventModel>(this as StockEventModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockEventModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.effect, effect) || other.effect == effect)&&(identical(other.probability, probability) || other.probability == probability)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive)&&(identical(other.startTime, startTime) || other.startTime == startTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,effect,probability,isPositive,startTime);

@override
String toString() {
  return 'StockEventModel(id: $id, title: $title, description: $description, effect: $effect, probability: $probability, isPositive: $isPositive, startTime: $startTime)';
}


}

/// @nodoc
abstract mixin class $StockEventModelCopyWith<$Res>  {
  factory $StockEventModelCopyWith(StockEventModel value, $Res Function(StockEventModel) _then) = _$StockEventModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, EventEffect effect, double probability, bool isPositive, DateTime? startTime
});


$EventEffectCopyWith<$Res> get effect;

}
/// @nodoc
class _$StockEventModelCopyWithImpl<$Res>
    implements $StockEventModelCopyWith<$Res> {
  _$StockEventModelCopyWithImpl(this._self, this._then);

  final StockEventModel _self;
  final $Res Function(StockEventModel) _then;

/// Create a copy of StockEventModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? effect = null,Object? probability = null,Object? isPositive = null,Object? startTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,effect: null == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as EventEffect,probability: null == probability ? _self.probability : probability // ignore: cast_nullable_to_non_nullable
as double,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of StockEventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventEffectCopyWith<$Res> get effect {
  
  return $EventEffectCopyWith<$Res>(_self.effect, (value) {
    return _then(_self.copyWith(effect: value));
  });
}
}


/// Adds pattern-matching-related methods to [StockEventModel].
extension StockEventModelPatterns on StockEventModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockEventModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockEventModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockEventModel value)  $default,){
final _that = this;
switch (_that) {
case _StockEventModel():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockEventModel value)?  $default,){
final _that = this;
switch (_that) {
case _StockEventModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  EventEffect effect,  double probability,  bool isPositive,  DateTime? startTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockEventModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.effect,_that.probability,_that.isPositive,_that.startTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  EventEffect effect,  double probability,  bool isPositive,  DateTime? startTime)  $default,) {final _that = this;
switch (_that) {
case _StockEventModel():
return $default(_that.id,_that.title,_that.description,_that.effect,_that.probability,_that.isPositive,_that.startTime);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  EventEffect effect,  double probability,  bool isPositive,  DateTime? startTime)?  $default,) {final _that = this;
switch (_that) {
case _StockEventModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.effect,_that.probability,_that.isPositive,_that.startTime);case _:
  return null;

}
}

}

/// @nodoc


class _StockEventModel implements StockEventModel {
  const _StockEventModel({required this.id, required this.title, required this.description, required this.effect, required this.probability, required this.isPositive, this.startTime});
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  EventEffect effect;
@override final  double probability;
@override final  bool isPositive;
@override final  DateTime? startTime;

/// Create a copy of StockEventModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockEventModelCopyWith<_StockEventModel> get copyWith => __$StockEventModelCopyWithImpl<_StockEventModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockEventModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.effect, effect) || other.effect == effect)&&(identical(other.probability, probability) || other.probability == probability)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive)&&(identical(other.startTime, startTime) || other.startTime == startTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,effect,probability,isPositive,startTime);

@override
String toString() {
  return 'StockEventModel(id: $id, title: $title, description: $description, effect: $effect, probability: $probability, isPositive: $isPositive, startTime: $startTime)';
}


}

/// @nodoc
abstract mixin class _$StockEventModelCopyWith<$Res> implements $StockEventModelCopyWith<$Res> {
  factory _$StockEventModelCopyWith(_StockEventModel value, $Res Function(_StockEventModel) _then) = __$StockEventModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, EventEffect effect, double probability, bool isPositive, DateTime? startTime
});


@override $EventEffectCopyWith<$Res> get effect;

}
/// @nodoc
class __$StockEventModelCopyWithImpl<$Res>
    implements _$StockEventModelCopyWith<$Res> {
  __$StockEventModelCopyWithImpl(this._self, this._then);

  final _StockEventModel _self;
  final $Res Function(_StockEventModel) _then;

/// Create a copy of StockEventModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? effect = null,Object? probability = null,Object? isPositive = null,Object? startTime = freezed,}) {
  return _then(_StockEventModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,effect: null == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as EventEffect,probability: null == probability ? _self.probability : probability // ignore: cast_nullable_to_non_nullable
as double,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of StockEventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventEffectCopyWith<$Res> get effect {
  
  return $EventEffectCopyWith<$Res>(_self.effect, (value) {
    return _then(_self.copyWith(effect: value));
  });
}
}

// dart format on
