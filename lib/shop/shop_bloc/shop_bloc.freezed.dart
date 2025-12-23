// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopEvent()';
}


}

/// @nodoc
class $ShopEventCopyWith<$Res>  {
$ShopEventCopyWith(ShopEvent _, $Res Function(ShopEvent) __);
}


/// Adds pattern-matching-related methods to [ShopEvent].
extension ShopEventPatterns on ShopEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _PurchaseItem value)?  purchaseItem,TResult Function( _ClearError value)?  clearError,TResult Function( _CashUpdated value)?  cashUpdated,TResult Function( _OwnedItemsUpdated value)?  ownedItemsUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _PurchaseItem() when purchaseItem != null:
return purchaseItem(_that);case _ClearError() when clearError != null:
return clearError(_that);case _CashUpdated() when cashUpdated != null:
return cashUpdated(_that);case _OwnedItemsUpdated() when ownedItemsUpdated != null:
return ownedItemsUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _PurchaseItem value)  purchaseItem,required TResult Function( _ClearError value)  clearError,required TResult Function( _CashUpdated value)  cashUpdated,required TResult Function( _OwnedItemsUpdated value)  ownedItemsUpdated,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _PurchaseItem():
return purchaseItem(_that);case _ClearError():
return clearError(_that);case _CashUpdated():
return cashUpdated(_that);case _OwnedItemsUpdated():
return ownedItemsUpdated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _PurchaseItem value)?  purchaseItem,TResult? Function( _ClearError value)?  clearError,TResult? Function( _CashUpdated value)?  cashUpdated,TResult? Function( _OwnedItemsUpdated value)?  ownedItemsUpdated,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _PurchaseItem() when purchaseItem != null:
return purchaseItem(_that);case _ClearError() when clearError != null:
return clearError(_that);case _CashUpdated() when cashUpdated != null:
return cashUpdated(_that);case _OwnedItemsUpdated() when ownedItemsUpdated != null:
return ownedItemsUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( int itemId)?  purchaseItem,TResult Function()?  clearError,TResult Function( int cash)?  cashUpdated,TResult Function( List<GameItem> items)?  ownedItemsUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _PurchaseItem() when purchaseItem != null:
return purchaseItem(_that.itemId);case _ClearError() when clearError != null:
return clearError();case _CashUpdated() when cashUpdated != null:
return cashUpdated(_that.cash);case _OwnedItemsUpdated() when ownedItemsUpdated != null:
return ownedItemsUpdated(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( int itemId)  purchaseItem,required TResult Function()  clearError,required TResult Function( int cash)  cashUpdated,required TResult Function( List<GameItem> items)  ownedItemsUpdated,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _PurchaseItem():
return purchaseItem(_that.itemId);case _ClearError():
return clearError();case _CashUpdated():
return cashUpdated(_that.cash);case _OwnedItemsUpdated():
return ownedItemsUpdated(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( int itemId)?  purchaseItem,TResult? Function()?  clearError,TResult? Function( int cash)?  cashUpdated,TResult? Function( List<GameItem> items)?  ownedItemsUpdated,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _PurchaseItem() when purchaseItem != null:
return purchaseItem(_that.itemId);case _ClearError() when clearError != null:
return clearError();case _CashUpdated() when cashUpdated != null:
return cashUpdated(_that.cash);case _OwnedItemsUpdated() when ownedItemsUpdated != null:
return ownedItemsUpdated(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements ShopEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopEvent.started()';
}


}




/// @nodoc


class _PurchaseItem implements ShopEvent {
  const _PurchaseItem(this.itemId);
  

 final  int itemId;

/// Create a copy of ShopEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseItemCopyWith<_PurchaseItem> get copyWith => __$PurchaseItemCopyWithImpl<_PurchaseItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseItem&&(identical(other.itemId, itemId) || other.itemId == itemId));
}


@override
int get hashCode => Object.hash(runtimeType,itemId);

@override
String toString() {
  return 'ShopEvent.purchaseItem(itemId: $itemId)';
}


}

/// @nodoc
abstract mixin class _$PurchaseItemCopyWith<$Res> implements $ShopEventCopyWith<$Res> {
  factory _$PurchaseItemCopyWith(_PurchaseItem value, $Res Function(_PurchaseItem) _then) = __$PurchaseItemCopyWithImpl;
@useResult
$Res call({
 int itemId
});




}
/// @nodoc
class __$PurchaseItemCopyWithImpl<$Res>
    implements _$PurchaseItemCopyWith<$Res> {
  __$PurchaseItemCopyWithImpl(this._self, this._then);

  final _PurchaseItem _self;
  final $Res Function(_PurchaseItem) _then;

/// Create a copy of ShopEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? itemId = null,}) {
  return _then(_PurchaseItem(
null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ClearError implements ShopEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopEvent.clearError()';
}


}




/// @nodoc


class _CashUpdated implements ShopEvent {
  const _CashUpdated(this.cash);
  

 final  int cash;

/// Create a copy of ShopEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashUpdatedCopyWith<_CashUpdated> get copyWith => __$CashUpdatedCopyWithImpl<_CashUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashUpdated&&(identical(other.cash, cash) || other.cash == cash));
}


@override
int get hashCode => Object.hash(runtimeType,cash);

@override
String toString() {
  return 'ShopEvent.cashUpdated(cash: $cash)';
}


}

/// @nodoc
abstract mixin class _$CashUpdatedCopyWith<$Res> implements $ShopEventCopyWith<$Res> {
  factory _$CashUpdatedCopyWith(_CashUpdated value, $Res Function(_CashUpdated) _then) = __$CashUpdatedCopyWithImpl;
@useResult
$Res call({
 int cash
});




}
/// @nodoc
class __$CashUpdatedCopyWithImpl<$Res>
    implements _$CashUpdatedCopyWith<$Res> {
  __$CashUpdatedCopyWithImpl(this._self, this._then);

  final _CashUpdated _self;
  final $Res Function(_CashUpdated) _then;

/// Create a copy of ShopEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cash = null,}) {
  return _then(_CashUpdated(
null == cash ? _self.cash : cash // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _OwnedItemsUpdated implements ShopEvent {
  const _OwnedItemsUpdated(final  List<GameItem> items): _items = items;
  

 final  List<GameItem> _items;
 List<GameItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ShopEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnedItemsUpdatedCopyWith<_OwnedItemsUpdated> get copyWith => __$OwnedItemsUpdatedCopyWithImpl<_OwnedItemsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnedItemsUpdated&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ShopEvent.ownedItemsUpdated(items: $items)';
}


}

/// @nodoc
abstract mixin class _$OwnedItemsUpdatedCopyWith<$Res> implements $ShopEventCopyWith<$Res> {
  factory _$OwnedItemsUpdatedCopyWith(_OwnedItemsUpdated value, $Res Function(_OwnedItemsUpdated) _then) = __$OwnedItemsUpdatedCopyWithImpl;
@useResult
$Res call({
 List<GameItem> items
});




}
/// @nodoc
class __$OwnedItemsUpdatedCopyWithImpl<$Res>
    implements _$OwnedItemsUpdatedCopyWith<$Res> {
  __$OwnedItemsUpdatedCopyWithImpl(this._self, this._then);

  final _OwnedItemsUpdated _self;
  final $Res Function(_OwnedItemsUpdated) _then;

/// Create a copy of ShopEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_OwnedItemsUpdated(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GameItem>,
  ));
}


}

/// @nodoc
mixin _$ShopState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopState()';
}


}

/// @nodoc
class $ShopStateCopyWith<$Res>  {
$ShopStateCopyWith(ShopState _, $Res Function(ShopState) __);
}


/// Adds pattern-matching-related methods to [ShopState].
extension ShopStatePatterns on ShopState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( int currentCash,  List<GameItem> ownedItems,  List<GameItem> allItems,  String? errorMessage)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.currentCash,_that.ownedItems,_that.allItems,_that.errorMessage);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( int currentCash,  List<GameItem> ownedItems,  List<GameItem> allItems,  String? errorMessage)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.currentCash,_that.ownedItems,_that.allItems,_that.errorMessage);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( int currentCash,  List<GameItem> ownedItems,  List<GameItem> allItems,  String? errorMessage)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.currentCash,_that.ownedItems,_that.allItems,_that.errorMessage);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ShopState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopState.initial()';
}


}




/// @nodoc


class _Loading implements ShopState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopState.loading()';
}


}




/// @nodoc


class _Loaded implements ShopState {
  const _Loaded({required this.currentCash, required final  List<GameItem> ownedItems, required final  List<GameItem> allItems, this.errorMessage}): _ownedItems = ownedItems,_allItems = allItems;
  

 final  int currentCash;
 final  List<GameItem> _ownedItems;
 List<GameItem> get ownedItems {
  if (_ownedItems is EqualUnmodifiableListView) return _ownedItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ownedItems);
}

 final  List<GameItem> _allItems;
 List<GameItem> get allItems {
  if (_allItems is EqualUnmodifiableListView) return _allItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allItems);
}

 final  String? errorMessage;

/// Create a copy of ShopState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.currentCash, currentCash) || other.currentCash == currentCash)&&const DeepCollectionEquality().equals(other._ownedItems, _ownedItems)&&const DeepCollectionEquality().equals(other._allItems, _allItems)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,currentCash,const DeepCollectionEquality().hash(_ownedItems),const DeepCollectionEquality().hash(_allItems),errorMessage);

@override
String toString() {
  return 'ShopState.loaded(currentCash: $currentCash, ownedItems: $ownedItems, allItems: $allItems, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $ShopStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 int currentCash, List<GameItem> ownedItems, List<GameItem> allItems, String? errorMessage
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of ShopState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? currentCash = null,Object? ownedItems = null,Object? allItems = null,Object? errorMessage = freezed,}) {
  return _then(_Loaded(
currentCash: null == currentCash ? _self.currentCash : currentCash // ignore: cast_nullable_to_non_nullable
as int,ownedItems: null == ownedItems ? _self._ownedItems : ownedItems // ignore: cast_nullable_to_non_nullable
as List<GameItem>,allItems: null == allItems ? _self._allItems : allItems // ignore: cast_nullable_to_non_nullable
as List<GameItem>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Error implements ShopState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of ShopState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ShopState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ShopStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of ShopState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
