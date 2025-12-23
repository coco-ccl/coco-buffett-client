// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayerEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlayerEvent()';
}


}

/// @nodoc
class $PlayerEventCopyWith<$Res>  {
$PlayerEventCopyWith(PlayerEvent _, $Res Function(PlayerEvent) __);
}


/// Adds pattern-matching-related methods to [PlayerEvent].
extension PlayerEventPatterns on PlayerEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _MoveStarted value)?  moveStarted,TResult Function( _MoveStopped value)?  moveStopped,TResult Function( _FaceChanged value)?  faceChanged,TResult Function( _HairChanged value)?  hairChanged,TResult Function( _TopChanged value)?  topChanged,TResult Function( _BottomChanged value)?  bottomChanged,TResult Function( _ShoesChanged value)?  shoesChanged,TResult Function( _LoadEquippedItems value)?  loadEquippedItems,TResult Function( _SetAllItems value)?  setAllItems,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoveStarted() when moveStarted != null:
return moveStarted(_that);case _MoveStopped() when moveStopped != null:
return moveStopped(_that);case _FaceChanged() when faceChanged != null:
return faceChanged(_that);case _HairChanged() when hairChanged != null:
return hairChanged(_that);case _TopChanged() when topChanged != null:
return topChanged(_that);case _BottomChanged() when bottomChanged != null:
return bottomChanged(_that);case _ShoesChanged() when shoesChanged != null:
return shoesChanged(_that);case _LoadEquippedItems() when loadEquippedItems != null:
return loadEquippedItems(_that);case _SetAllItems() when setAllItems != null:
return setAllItems(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _MoveStarted value)  moveStarted,required TResult Function( _MoveStopped value)  moveStopped,required TResult Function( _FaceChanged value)  faceChanged,required TResult Function( _HairChanged value)  hairChanged,required TResult Function( _TopChanged value)  topChanged,required TResult Function( _BottomChanged value)  bottomChanged,required TResult Function( _ShoesChanged value)  shoesChanged,required TResult Function( _LoadEquippedItems value)  loadEquippedItems,required TResult Function( _SetAllItems value)  setAllItems,}){
final _that = this;
switch (_that) {
case _MoveStarted():
return moveStarted(_that);case _MoveStopped():
return moveStopped(_that);case _FaceChanged():
return faceChanged(_that);case _HairChanged():
return hairChanged(_that);case _TopChanged():
return topChanged(_that);case _BottomChanged():
return bottomChanged(_that);case _ShoesChanged():
return shoesChanged(_that);case _LoadEquippedItems():
return loadEquippedItems(_that);case _SetAllItems():
return setAllItems(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _MoveStarted value)?  moveStarted,TResult? Function( _MoveStopped value)?  moveStopped,TResult? Function( _FaceChanged value)?  faceChanged,TResult? Function( _HairChanged value)?  hairChanged,TResult? Function( _TopChanged value)?  topChanged,TResult? Function( _BottomChanged value)?  bottomChanged,TResult? Function( _ShoesChanged value)?  shoesChanged,TResult? Function( _LoadEquippedItems value)?  loadEquippedItems,TResult? Function( _SetAllItems value)?  setAllItems,}){
final _that = this;
switch (_that) {
case _MoveStarted() when moveStarted != null:
return moveStarted(_that);case _MoveStopped() when moveStopped != null:
return moveStopped(_that);case _FaceChanged() when faceChanged != null:
return faceChanged(_that);case _HairChanged() when hairChanged != null:
return hairChanged(_that);case _TopChanged() when topChanged != null:
return topChanged(_that);case _BottomChanged() when bottomChanged != null:
return bottomChanged(_that);case _ShoesChanged() when shoesChanged != null:
return shoesChanged(_that);case _LoadEquippedItems() when loadEquippedItems != null:
return loadEquippedItems(_that);case _SetAllItems() when setAllItems != null:
return setAllItems(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Vector2 direction)?  moveStarted,TResult Function()?  moveStopped,TResult Function( String faceId)?  faceChanged,TResult Function( String hairId)?  hairChanged,TResult Function( String topId)?  topChanged,TResult Function( String bottomId)?  bottomChanged,TResult Function( String shoesId)?  shoesChanged,TResult Function()?  loadEquippedItems,TResult Function( String faceId,  String hairId,  String topId,  String bottomId,  String shoesId)?  setAllItems,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoveStarted() when moveStarted != null:
return moveStarted(_that.direction);case _MoveStopped() when moveStopped != null:
return moveStopped();case _FaceChanged() when faceChanged != null:
return faceChanged(_that.faceId);case _HairChanged() when hairChanged != null:
return hairChanged(_that.hairId);case _TopChanged() when topChanged != null:
return topChanged(_that.topId);case _BottomChanged() when bottomChanged != null:
return bottomChanged(_that.bottomId);case _ShoesChanged() when shoesChanged != null:
return shoesChanged(_that.shoesId);case _LoadEquippedItems() when loadEquippedItems != null:
return loadEquippedItems();case _SetAllItems() when setAllItems != null:
return setAllItems(_that.faceId,_that.hairId,_that.topId,_that.bottomId,_that.shoesId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Vector2 direction)  moveStarted,required TResult Function()  moveStopped,required TResult Function( String faceId)  faceChanged,required TResult Function( String hairId)  hairChanged,required TResult Function( String topId)  topChanged,required TResult Function( String bottomId)  bottomChanged,required TResult Function( String shoesId)  shoesChanged,required TResult Function()  loadEquippedItems,required TResult Function( String faceId,  String hairId,  String topId,  String bottomId,  String shoesId)  setAllItems,}) {final _that = this;
switch (_that) {
case _MoveStarted():
return moveStarted(_that.direction);case _MoveStopped():
return moveStopped();case _FaceChanged():
return faceChanged(_that.faceId);case _HairChanged():
return hairChanged(_that.hairId);case _TopChanged():
return topChanged(_that.topId);case _BottomChanged():
return bottomChanged(_that.bottomId);case _ShoesChanged():
return shoesChanged(_that.shoesId);case _LoadEquippedItems():
return loadEquippedItems();case _SetAllItems():
return setAllItems(_that.faceId,_that.hairId,_that.topId,_that.bottomId,_that.shoesId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Vector2 direction)?  moveStarted,TResult? Function()?  moveStopped,TResult? Function( String faceId)?  faceChanged,TResult? Function( String hairId)?  hairChanged,TResult? Function( String topId)?  topChanged,TResult? Function( String bottomId)?  bottomChanged,TResult? Function( String shoesId)?  shoesChanged,TResult? Function()?  loadEquippedItems,TResult? Function( String faceId,  String hairId,  String topId,  String bottomId,  String shoesId)?  setAllItems,}) {final _that = this;
switch (_that) {
case _MoveStarted() when moveStarted != null:
return moveStarted(_that.direction);case _MoveStopped() when moveStopped != null:
return moveStopped();case _FaceChanged() when faceChanged != null:
return faceChanged(_that.faceId);case _HairChanged() when hairChanged != null:
return hairChanged(_that.hairId);case _TopChanged() when topChanged != null:
return topChanged(_that.topId);case _BottomChanged() when bottomChanged != null:
return bottomChanged(_that.bottomId);case _ShoesChanged() when shoesChanged != null:
return shoesChanged(_that.shoesId);case _LoadEquippedItems() when loadEquippedItems != null:
return loadEquippedItems();case _SetAllItems() when setAllItems != null:
return setAllItems(_that.faceId,_that.hairId,_that.topId,_that.bottomId,_that.shoesId);case _:
  return null;

}
}

}

/// @nodoc


class _MoveStarted implements PlayerEvent {
  const _MoveStarted(this.direction);
  

 final  Vector2 direction;

/// Create a copy of PlayerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoveStartedCopyWith<_MoveStarted> get copyWith => __$MoveStartedCopyWithImpl<_MoveStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoveStarted&&(identical(other.direction, direction) || other.direction == direction));
}


@override
int get hashCode => Object.hash(runtimeType,direction);

@override
String toString() {
  return 'PlayerEvent.moveStarted(direction: $direction)';
}


}

/// @nodoc
abstract mixin class _$MoveStartedCopyWith<$Res> implements $PlayerEventCopyWith<$Res> {
  factory _$MoveStartedCopyWith(_MoveStarted value, $Res Function(_MoveStarted) _then) = __$MoveStartedCopyWithImpl;
@useResult
$Res call({
 Vector2 direction
});




}
/// @nodoc
class __$MoveStartedCopyWithImpl<$Res>
    implements _$MoveStartedCopyWith<$Res> {
  __$MoveStartedCopyWithImpl(this._self, this._then);

  final _MoveStarted _self;
  final $Res Function(_MoveStarted) _then;

/// Create a copy of PlayerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? direction = null,}) {
  return _then(_MoveStarted(
null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Vector2,
  ));
}


}

/// @nodoc


class _MoveStopped implements PlayerEvent {
  const _MoveStopped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoveStopped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlayerEvent.moveStopped()';
}


}




/// @nodoc


class _FaceChanged implements PlayerEvent {
  const _FaceChanged(this.faceId);
  

 final  String faceId;

/// Create a copy of PlayerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FaceChangedCopyWith<_FaceChanged> get copyWith => __$FaceChangedCopyWithImpl<_FaceChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FaceChanged&&(identical(other.faceId, faceId) || other.faceId == faceId));
}


@override
int get hashCode => Object.hash(runtimeType,faceId);

@override
String toString() {
  return 'PlayerEvent.faceChanged(faceId: $faceId)';
}


}

/// @nodoc
abstract mixin class _$FaceChangedCopyWith<$Res> implements $PlayerEventCopyWith<$Res> {
  factory _$FaceChangedCopyWith(_FaceChanged value, $Res Function(_FaceChanged) _then) = __$FaceChangedCopyWithImpl;
@useResult
$Res call({
 String faceId
});




}
/// @nodoc
class __$FaceChangedCopyWithImpl<$Res>
    implements _$FaceChangedCopyWith<$Res> {
  __$FaceChangedCopyWithImpl(this._self, this._then);

  final _FaceChanged _self;
  final $Res Function(_FaceChanged) _then;

/// Create a copy of PlayerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? faceId = null,}) {
  return _then(_FaceChanged(
null == faceId ? _self.faceId : faceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _HairChanged implements PlayerEvent {
  const _HairChanged(this.hairId);
  

 final  String hairId;

/// Create a copy of PlayerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HairChangedCopyWith<_HairChanged> get copyWith => __$HairChangedCopyWithImpl<_HairChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HairChanged&&(identical(other.hairId, hairId) || other.hairId == hairId));
}


@override
int get hashCode => Object.hash(runtimeType,hairId);

@override
String toString() {
  return 'PlayerEvent.hairChanged(hairId: $hairId)';
}


}

/// @nodoc
abstract mixin class _$HairChangedCopyWith<$Res> implements $PlayerEventCopyWith<$Res> {
  factory _$HairChangedCopyWith(_HairChanged value, $Res Function(_HairChanged) _then) = __$HairChangedCopyWithImpl;
@useResult
$Res call({
 String hairId
});




}
/// @nodoc
class __$HairChangedCopyWithImpl<$Res>
    implements _$HairChangedCopyWith<$Res> {
  __$HairChangedCopyWithImpl(this._self, this._then);

  final _HairChanged _self;
  final $Res Function(_HairChanged) _then;

/// Create a copy of PlayerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? hairId = null,}) {
  return _then(_HairChanged(
null == hairId ? _self.hairId : hairId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TopChanged implements PlayerEvent {
  const _TopChanged(this.topId);
  

 final  String topId;

/// Create a copy of PlayerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopChangedCopyWith<_TopChanged> get copyWith => __$TopChangedCopyWithImpl<_TopChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopChanged&&(identical(other.topId, topId) || other.topId == topId));
}


@override
int get hashCode => Object.hash(runtimeType,topId);

@override
String toString() {
  return 'PlayerEvent.topChanged(topId: $topId)';
}


}

/// @nodoc
abstract mixin class _$TopChangedCopyWith<$Res> implements $PlayerEventCopyWith<$Res> {
  factory _$TopChangedCopyWith(_TopChanged value, $Res Function(_TopChanged) _then) = __$TopChangedCopyWithImpl;
@useResult
$Res call({
 String topId
});




}
/// @nodoc
class __$TopChangedCopyWithImpl<$Res>
    implements _$TopChangedCopyWith<$Res> {
  __$TopChangedCopyWithImpl(this._self, this._then);

  final _TopChanged _self;
  final $Res Function(_TopChanged) _then;

/// Create a copy of PlayerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? topId = null,}) {
  return _then(_TopChanged(
null == topId ? _self.topId : topId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _BottomChanged implements PlayerEvent {
  const _BottomChanged(this.bottomId);
  

 final  String bottomId;

/// Create a copy of PlayerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BottomChangedCopyWith<_BottomChanged> get copyWith => __$BottomChangedCopyWithImpl<_BottomChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BottomChanged&&(identical(other.bottomId, bottomId) || other.bottomId == bottomId));
}


@override
int get hashCode => Object.hash(runtimeType,bottomId);

@override
String toString() {
  return 'PlayerEvent.bottomChanged(bottomId: $bottomId)';
}


}

/// @nodoc
abstract mixin class _$BottomChangedCopyWith<$Res> implements $PlayerEventCopyWith<$Res> {
  factory _$BottomChangedCopyWith(_BottomChanged value, $Res Function(_BottomChanged) _then) = __$BottomChangedCopyWithImpl;
@useResult
$Res call({
 String bottomId
});




}
/// @nodoc
class __$BottomChangedCopyWithImpl<$Res>
    implements _$BottomChangedCopyWith<$Res> {
  __$BottomChangedCopyWithImpl(this._self, this._then);

  final _BottomChanged _self;
  final $Res Function(_BottomChanged) _then;

/// Create a copy of PlayerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bottomId = null,}) {
  return _then(_BottomChanged(
null == bottomId ? _self.bottomId : bottomId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ShoesChanged implements PlayerEvent {
  const _ShoesChanged(this.shoesId);
  

 final  String shoesId;

/// Create a copy of PlayerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShoesChangedCopyWith<_ShoesChanged> get copyWith => __$ShoesChangedCopyWithImpl<_ShoesChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShoesChanged&&(identical(other.shoesId, shoesId) || other.shoesId == shoesId));
}


@override
int get hashCode => Object.hash(runtimeType,shoesId);

@override
String toString() {
  return 'PlayerEvent.shoesChanged(shoesId: $shoesId)';
}


}

/// @nodoc
abstract mixin class _$ShoesChangedCopyWith<$Res> implements $PlayerEventCopyWith<$Res> {
  factory _$ShoesChangedCopyWith(_ShoesChanged value, $Res Function(_ShoesChanged) _then) = __$ShoesChangedCopyWithImpl;
@useResult
$Res call({
 String shoesId
});




}
/// @nodoc
class __$ShoesChangedCopyWithImpl<$Res>
    implements _$ShoesChangedCopyWith<$Res> {
  __$ShoesChangedCopyWithImpl(this._self, this._then);

  final _ShoesChanged _self;
  final $Res Function(_ShoesChanged) _then;

/// Create a copy of PlayerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? shoesId = null,}) {
  return _then(_ShoesChanged(
null == shoesId ? _self.shoesId : shoesId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadEquippedItems implements PlayerEvent {
  const _LoadEquippedItems();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadEquippedItems);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlayerEvent.loadEquippedItems()';
}


}




/// @nodoc


class _SetAllItems implements PlayerEvent {
  const _SetAllItems({required this.faceId, required this.hairId, required this.topId, required this.bottomId, required this.shoesId});
  

 final  String faceId;
 final  String hairId;
 final  String topId;
 final  String bottomId;
 final  String shoesId;

/// Create a copy of PlayerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetAllItemsCopyWith<_SetAllItems> get copyWith => __$SetAllItemsCopyWithImpl<_SetAllItems>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetAllItems&&(identical(other.faceId, faceId) || other.faceId == faceId)&&(identical(other.hairId, hairId) || other.hairId == hairId)&&(identical(other.topId, topId) || other.topId == topId)&&(identical(other.bottomId, bottomId) || other.bottomId == bottomId)&&(identical(other.shoesId, shoesId) || other.shoesId == shoesId));
}


@override
int get hashCode => Object.hash(runtimeType,faceId,hairId,topId,bottomId,shoesId);

@override
String toString() {
  return 'PlayerEvent.setAllItems(faceId: $faceId, hairId: $hairId, topId: $topId, bottomId: $bottomId, shoesId: $shoesId)';
}


}

/// @nodoc
abstract mixin class _$SetAllItemsCopyWith<$Res> implements $PlayerEventCopyWith<$Res> {
  factory _$SetAllItemsCopyWith(_SetAllItems value, $Res Function(_SetAllItems) _then) = __$SetAllItemsCopyWithImpl;
@useResult
$Res call({
 String faceId, String hairId, String topId, String bottomId, String shoesId
});




}
/// @nodoc
class __$SetAllItemsCopyWithImpl<$Res>
    implements _$SetAllItemsCopyWith<$Res> {
  __$SetAllItemsCopyWithImpl(this._self, this._then);

  final _SetAllItems _self;
  final $Res Function(_SetAllItems) _then;

/// Create a copy of PlayerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? faceId = null,Object? hairId = null,Object? topId = null,Object? bottomId = null,Object? shoesId = null,}) {
  return _then(_SetAllItems(
faceId: null == faceId ? _self.faceId : faceId // ignore: cast_nullable_to_non_nullable
as String,hairId: null == hairId ? _self.hairId : hairId // ignore: cast_nullable_to_non_nullable
as String,topId: null == topId ? _self.topId : topId // ignore: cast_nullable_to_non_nullable
as String,bottomId: null == bottomId ? _self.bottomId : bottomId // ignore: cast_nullable_to_non_nullable
as String,shoesId: null == shoesId ? _self.shoesId : shoesId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$PlayerState {

 PlayerData get data;
/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerStateCopyWith<PlayerState> get copyWith => _$PlayerStateCopyWithImpl<PlayerState>(this as PlayerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerState&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'PlayerState(data: $data)';
}


}

/// @nodoc
abstract mixin class $PlayerStateCopyWith<$Res>  {
  factory $PlayerStateCopyWith(PlayerState value, $Res Function(PlayerState) _then) = _$PlayerStateCopyWithImpl;
@useResult
$Res call({
 PlayerData data
});


$PlayerDataCopyWith<$Res> get data;

}
/// @nodoc
class _$PlayerStateCopyWithImpl<$Res>
    implements $PlayerStateCopyWith<$Res> {
  _$PlayerStateCopyWithImpl(this._self, this._then);

  final PlayerState _self;
  final $Res Function(PlayerState) _then;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PlayerData,
  ));
}
/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerDataCopyWith<$Res> get data {
  
  return $PlayerDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlayerState].
extension PlayerStatePatterns on PlayerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PlayerIdle value)?  idle,TResult Function( PlayerMoving value)?  moving,TResult Function( PlayerCustomizing value)?  customizing,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PlayerIdle() when idle != null:
return idle(_that);case PlayerMoving() when moving != null:
return moving(_that);case PlayerCustomizing() when customizing != null:
return customizing(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PlayerIdle value)  idle,required TResult Function( PlayerMoving value)  moving,required TResult Function( PlayerCustomizing value)  customizing,}){
final _that = this;
switch (_that) {
case PlayerIdle():
return idle(_that);case PlayerMoving():
return moving(_that);case PlayerCustomizing():
return customizing(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PlayerIdle value)?  idle,TResult? Function( PlayerMoving value)?  moving,TResult? Function( PlayerCustomizing value)?  customizing,}){
final _that = this;
switch (_that) {
case PlayerIdle() when idle != null:
return idle(_that);case PlayerMoving() when moving != null:
return moving(_that);case PlayerCustomizing() when customizing != null:
return customizing(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( PlayerData data)?  idle,TResult Function( PlayerData data)?  moving,TResult Function( PlayerData data)?  customizing,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PlayerIdle() when idle != null:
return idle(_that.data);case PlayerMoving() when moving != null:
return moving(_that.data);case PlayerCustomizing() when customizing != null:
return customizing(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( PlayerData data)  idle,required TResult Function( PlayerData data)  moving,required TResult Function( PlayerData data)  customizing,}) {final _that = this;
switch (_that) {
case PlayerIdle():
return idle(_that.data);case PlayerMoving():
return moving(_that.data);case PlayerCustomizing():
return customizing(_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( PlayerData data)?  idle,TResult? Function( PlayerData data)?  moving,TResult? Function( PlayerData data)?  customizing,}) {final _that = this;
switch (_that) {
case PlayerIdle() when idle != null:
return idle(_that.data);case PlayerMoving() when moving != null:
return moving(_that.data);case PlayerCustomizing() when customizing != null:
return customizing(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class PlayerIdle implements PlayerState {
  const PlayerIdle(this.data);
  

@override final  PlayerData data;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerIdleCopyWith<PlayerIdle> get copyWith => _$PlayerIdleCopyWithImpl<PlayerIdle>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerIdle&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'PlayerState.idle(data: $data)';
}


}

/// @nodoc
abstract mixin class $PlayerIdleCopyWith<$Res> implements $PlayerStateCopyWith<$Res> {
  factory $PlayerIdleCopyWith(PlayerIdle value, $Res Function(PlayerIdle) _then) = _$PlayerIdleCopyWithImpl;
@override @useResult
$Res call({
 PlayerData data
});


@override $PlayerDataCopyWith<$Res> get data;

}
/// @nodoc
class _$PlayerIdleCopyWithImpl<$Res>
    implements $PlayerIdleCopyWith<$Res> {
  _$PlayerIdleCopyWithImpl(this._self, this._then);

  final PlayerIdle _self;
  final $Res Function(PlayerIdle) _then;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(PlayerIdle(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PlayerData,
  ));
}

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerDataCopyWith<$Res> get data {
  
  return $PlayerDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class PlayerMoving implements PlayerState {
  const PlayerMoving(this.data);
  

@override final  PlayerData data;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerMovingCopyWith<PlayerMoving> get copyWith => _$PlayerMovingCopyWithImpl<PlayerMoving>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerMoving&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'PlayerState.moving(data: $data)';
}


}

/// @nodoc
abstract mixin class $PlayerMovingCopyWith<$Res> implements $PlayerStateCopyWith<$Res> {
  factory $PlayerMovingCopyWith(PlayerMoving value, $Res Function(PlayerMoving) _then) = _$PlayerMovingCopyWithImpl;
@override @useResult
$Res call({
 PlayerData data
});


@override $PlayerDataCopyWith<$Res> get data;

}
/// @nodoc
class _$PlayerMovingCopyWithImpl<$Res>
    implements $PlayerMovingCopyWith<$Res> {
  _$PlayerMovingCopyWithImpl(this._self, this._then);

  final PlayerMoving _self;
  final $Res Function(PlayerMoving) _then;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(PlayerMoving(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PlayerData,
  ));
}

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerDataCopyWith<$Res> get data {
  
  return $PlayerDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class PlayerCustomizing implements PlayerState {
  const PlayerCustomizing(this.data);
  

@override final  PlayerData data;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerCustomizingCopyWith<PlayerCustomizing> get copyWith => _$PlayerCustomizingCopyWithImpl<PlayerCustomizing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerCustomizing&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'PlayerState.customizing(data: $data)';
}


}

/// @nodoc
abstract mixin class $PlayerCustomizingCopyWith<$Res> implements $PlayerStateCopyWith<$Res> {
  factory $PlayerCustomizingCopyWith(PlayerCustomizing value, $Res Function(PlayerCustomizing) _then) = _$PlayerCustomizingCopyWithImpl;
@override @useResult
$Res call({
 PlayerData data
});


@override $PlayerDataCopyWith<$Res> get data;

}
/// @nodoc
class _$PlayerCustomizingCopyWithImpl<$Res>
    implements $PlayerCustomizingCopyWith<$Res> {
  _$PlayerCustomizingCopyWithImpl(this._self, this._then);

  final PlayerCustomizing _self;
  final $Res Function(PlayerCustomizing) _then;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(PlayerCustomizing(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PlayerData,
  ));
}

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerDataCopyWith<$Res> get data {
  
  return $PlayerDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc
mixin _$PlayerData {

 String get faceId; String get hairId; String get topId; String get bottomId; String get shoesId; Direction get direction; Vector2? get velocity;
/// Create a copy of PlayerData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerDataCopyWith<PlayerData> get copyWith => _$PlayerDataCopyWithImpl<PlayerData>(this as PlayerData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerData&&(identical(other.faceId, faceId) || other.faceId == faceId)&&(identical(other.hairId, hairId) || other.hairId == hairId)&&(identical(other.topId, topId) || other.topId == topId)&&(identical(other.bottomId, bottomId) || other.bottomId == bottomId)&&(identical(other.shoesId, shoesId) || other.shoesId == shoesId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.velocity, velocity) || other.velocity == velocity));
}


@override
int get hashCode => Object.hash(runtimeType,faceId,hairId,topId,bottomId,shoesId,direction,velocity);

@override
String toString() {
  return 'PlayerData(faceId: $faceId, hairId: $hairId, topId: $topId, bottomId: $bottomId, shoesId: $shoesId, direction: $direction, velocity: $velocity)';
}


}

/// @nodoc
abstract mixin class $PlayerDataCopyWith<$Res>  {
  factory $PlayerDataCopyWith(PlayerData value, $Res Function(PlayerData) _then) = _$PlayerDataCopyWithImpl;
@useResult
$Res call({
 String faceId, String hairId, String topId, String bottomId, String shoesId, Direction direction, Vector2? velocity
});




}
/// @nodoc
class _$PlayerDataCopyWithImpl<$Res>
    implements $PlayerDataCopyWith<$Res> {
  _$PlayerDataCopyWithImpl(this._self, this._then);

  final PlayerData _self;
  final $Res Function(PlayerData) _then;

/// Create a copy of PlayerData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? faceId = null,Object? hairId = null,Object? topId = null,Object? bottomId = null,Object? shoesId = null,Object? direction = null,Object? velocity = freezed,}) {
  return _then(_self.copyWith(
faceId: null == faceId ? _self.faceId : faceId // ignore: cast_nullable_to_non_nullable
as String,hairId: null == hairId ? _self.hairId : hairId // ignore: cast_nullable_to_non_nullable
as String,topId: null == topId ? _self.topId : topId // ignore: cast_nullable_to_non_nullable
as String,bottomId: null == bottomId ? _self.bottomId : bottomId // ignore: cast_nullable_to_non_nullable
as String,shoesId: null == shoesId ? _self.shoesId : shoesId // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Direction,velocity: freezed == velocity ? _self.velocity : velocity // ignore: cast_nullable_to_non_nullable
as Vector2?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerData].
extension PlayerDataPatterns on PlayerData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerData value)  $default,){
final _that = this;
switch (_that) {
case _PlayerData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerData value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String faceId,  String hairId,  String topId,  String bottomId,  String shoesId,  Direction direction,  Vector2? velocity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerData() when $default != null:
return $default(_that.faceId,_that.hairId,_that.topId,_that.bottomId,_that.shoesId,_that.direction,_that.velocity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String faceId,  String hairId,  String topId,  String bottomId,  String shoesId,  Direction direction,  Vector2? velocity)  $default,) {final _that = this;
switch (_that) {
case _PlayerData():
return $default(_that.faceId,_that.hairId,_that.topId,_that.bottomId,_that.shoesId,_that.direction,_that.velocity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String faceId,  String hairId,  String topId,  String bottomId,  String shoesId,  Direction direction,  Vector2? velocity)?  $default,) {final _that = this;
switch (_that) {
case _PlayerData() when $default != null:
return $default(_that.faceId,_that.hairId,_that.topId,_that.bottomId,_that.shoesId,_that.direction,_that.velocity);case _:
  return null;

}
}

}

/// @nodoc


class _PlayerData implements PlayerData {
  const _PlayerData({this.faceId = 'default', this.hairId = 'short_brown', this.topId = 'tshirt_white', this.bottomId = 'pants_black', this.shoesId = 'shoes_black', this.direction = Direction.down, this.velocity});
  

@override@JsonKey() final  String faceId;
@override@JsonKey() final  String hairId;
@override@JsonKey() final  String topId;
@override@JsonKey() final  String bottomId;
@override@JsonKey() final  String shoesId;
@override@JsonKey() final  Direction direction;
@override final  Vector2? velocity;

/// Create a copy of PlayerData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerDataCopyWith<_PlayerData> get copyWith => __$PlayerDataCopyWithImpl<_PlayerData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerData&&(identical(other.faceId, faceId) || other.faceId == faceId)&&(identical(other.hairId, hairId) || other.hairId == hairId)&&(identical(other.topId, topId) || other.topId == topId)&&(identical(other.bottomId, bottomId) || other.bottomId == bottomId)&&(identical(other.shoesId, shoesId) || other.shoesId == shoesId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.velocity, velocity) || other.velocity == velocity));
}


@override
int get hashCode => Object.hash(runtimeType,faceId,hairId,topId,bottomId,shoesId,direction,velocity);

@override
String toString() {
  return 'PlayerData(faceId: $faceId, hairId: $hairId, topId: $topId, bottomId: $bottomId, shoesId: $shoesId, direction: $direction, velocity: $velocity)';
}


}

/// @nodoc
abstract mixin class _$PlayerDataCopyWith<$Res> implements $PlayerDataCopyWith<$Res> {
  factory _$PlayerDataCopyWith(_PlayerData value, $Res Function(_PlayerData) _then) = __$PlayerDataCopyWithImpl;
@override @useResult
$Res call({
 String faceId, String hairId, String topId, String bottomId, String shoesId, Direction direction, Vector2? velocity
});




}
/// @nodoc
class __$PlayerDataCopyWithImpl<$Res>
    implements _$PlayerDataCopyWith<$Res> {
  __$PlayerDataCopyWithImpl(this._self, this._then);

  final _PlayerData _self;
  final $Res Function(_PlayerData) _then;

/// Create a copy of PlayerData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? faceId = null,Object? hairId = null,Object? topId = null,Object? bottomId = null,Object? shoesId = null,Object? direction = null,Object? velocity = freezed,}) {
  return _then(_PlayerData(
faceId: null == faceId ? _self.faceId : faceId // ignore: cast_nullable_to_non_nullable
as String,hairId: null == hairId ? _self.hairId : hairId // ignore: cast_nullable_to_non_nullable
as String,topId: null == topId ? _self.topId : topId // ignore: cast_nullable_to_non_nullable
as String,bottomId: null == bottomId ? _self.bottomId : bottomId // ignore: cast_nullable_to_non_nullable
as String,shoesId: null == shoesId ? _self.shoesId : shoesId // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Direction,velocity: freezed == velocity ? _self.velocity : velocity // ignore: cast_nullable_to_non_nullable
as Vector2?,
  ));
}


}

// dart format on
