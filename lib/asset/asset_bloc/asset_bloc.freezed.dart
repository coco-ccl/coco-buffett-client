// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AssetEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssetEvent()';
}


}

/// @nodoc
class $AssetEventCopyWith<$Res>  {
$AssetEventCopyWith(AssetEvent _, $Res Function(AssetEvent) __);
}


/// Adds pattern-matching-related methods to [AssetEvent].
extension AssetEventPatterns on AssetEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _DepositChanged value)?  depositChanged,TResult Function( _ItemPurchased value)?  itemPurchased,TResult Function( _BalanceAdded value)?  balanceAdded,TResult Function( _CashUpdated value)?  cashUpdated,TResult Function( _StocksUpdated value)?  stocksUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _DepositChanged() when depositChanged != null:
return depositChanged(_that);case _ItemPurchased() when itemPurchased != null:
return itemPurchased(_that);case _BalanceAdded() when balanceAdded != null:
return balanceAdded(_that);case _CashUpdated() when cashUpdated != null:
return cashUpdated(_that);case _StocksUpdated() when stocksUpdated != null:
return stocksUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _DepositChanged value)  depositChanged,required TResult Function( _ItemPurchased value)  itemPurchased,required TResult Function( _BalanceAdded value)  balanceAdded,required TResult Function( _CashUpdated value)  cashUpdated,required TResult Function( _StocksUpdated value)  stocksUpdated,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _DepositChanged():
return depositChanged(_that);case _ItemPurchased():
return itemPurchased(_that);case _BalanceAdded():
return balanceAdded(_that);case _CashUpdated():
return cashUpdated(_that);case _StocksUpdated():
return stocksUpdated(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _DepositChanged value)?  depositChanged,TResult? Function( _ItemPurchased value)?  itemPurchased,TResult? Function( _BalanceAdded value)?  balanceAdded,TResult? Function( _CashUpdated value)?  cashUpdated,TResult? Function( _StocksUpdated value)?  stocksUpdated,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _DepositChanged() when depositChanged != null:
return depositChanged(_that);case _ItemPurchased() when itemPurchased != null:
return itemPurchased(_that);case _BalanceAdded() when balanceAdded != null:
return balanceAdded(_that);case _CashUpdated() when cashUpdated != null:
return cashUpdated(_that);case _StocksUpdated() when stocksUpdated != null:
return stocksUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( int amount)?  depositChanged,TResult Function( String itemName,  int price)?  itemPurchased,TResult Function( int amount)?  balanceAdded,TResult Function( int cash)?  cashUpdated,TResult Function( List<Stock> stocks)?  stocksUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _DepositChanged() when depositChanged != null:
return depositChanged(_that.amount);case _ItemPurchased() when itemPurchased != null:
return itemPurchased(_that.itemName,_that.price);case _BalanceAdded() when balanceAdded != null:
return balanceAdded(_that.amount);case _CashUpdated() when cashUpdated != null:
return cashUpdated(_that.cash);case _StocksUpdated() when stocksUpdated != null:
return stocksUpdated(_that.stocks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( int amount)  depositChanged,required TResult Function( String itemName,  int price)  itemPurchased,required TResult Function( int amount)  balanceAdded,required TResult Function( int cash)  cashUpdated,required TResult Function( List<Stock> stocks)  stocksUpdated,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _DepositChanged():
return depositChanged(_that.amount);case _ItemPurchased():
return itemPurchased(_that.itemName,_that.price);case _BalanceAdded():
return balanceAdded(_that.amount);case _CashUpdated():
return cashUpdated(_that.cash);case _StocksUpdated():
return stocksUpdated(_that.stocks);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( int amount)?  depositChanged,TResult? Function( String itemName,  int price)?  itemPurchased,TResult? Function( int amount)?  balanceAdded,TResult? Function( int cash)?  cashUpdated,TResult? Function( List<Stock> stocks)?  stocksUpdated,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _DepositChanged() when depositChanged != null:
return depositChanged(_that.amount);case _ItemPurchased() when itemPurchased != null:
return itemPurchased(_that.itemName,_that.price);case _BalanceAdded() when balanceAdded != null:
return balanceAdded(_that.amount);case _CashUpdated() when cashUpdated != null:
return cashUpdated(_that.cash);case _StocksUpdated() when stocksUpdated != null:
return stocksUpdated(_that.stocks);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements AssetEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssetEvent.started()';
}


}




/// @nodoc


class _DepositChanged implements AssetEvent {
  const _DepositChanged(this.amount);
  

 final  int amount;

/// Create a copy of AssetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepositChangedCopyWith<_DepositChanged> get copyWith => __$DepositChangedCopyWithImpl<_DepositChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DepositChanged&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'AssetEvent.depositChanged(amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$DepositChangedCopyWith<$Res> implements $AssetEventCopyWith<$Res> {
  factory _$DepositChangedCopyWith(_DepositChanged value, $Res Function(_DepositChanged) _then) = __$DepositChangedCopyWithImpl;
@useResult
$Res call({
 int amount
});




}
/// @nodoc
class __$DepositChangedCopyWithImpl<$Res>
    implements _$DepositChangedCopyWith<$Res> {
  __$DepositChangedCopyWithImpl(this._self, this._then);

  final _DepositChanged _self;
  final $Res Function(_DepositChanged) _then;

/// Create a copy of AssetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? amount = null,}) {
  return _then(_DepositChanged(
null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ItemPurchased implements AssetEvent {
  const _ItemPurchased({required this.itemName, required this.price});
  

 final  String itemName;
 final  int price;

/// Create a copy of AssetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemPurchasedCopyWith<_ItemPurchased> get copyWith => __$ItemPurchasedCopyWithImpl<_ItemPurchased>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemPurchased&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.price, price) || other.price == price));
}


@override
int get hashCode => Object.hash(runtimeType,itemName,price);

@override
String toString() {
  return 'AssetEvent.itemPurchased(itemName: $itemName, price: $price)';
}


}

/// @nodoc
abstract mixin class _$ItemPurchasedCopyWith<$Res> implements $AssetEventCopyWith<$Res> {
  factory _$ItemPurchasedCopyWith(_ItemPurchased value, $Res Function(_ItemPurchased) _then) = __$ItemPurchasedCopyWithImpl;
@useResult
$Res call({
 String itemName, int price
});




}
/// @nodoc
class __$ItemPurchasedCopyWithImpl<$Res>
    implements _$ItemPurchasedCopyWith<$Res> {
  __$ItemPurchasedCopyWithImpl(this._self, this._then);

  final _ItemPurchased _self;
  final $Res Function(_ItemPurchased) _then;

/// Create a copy of AssetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? itemName = null,Object? price = null,}) {
  return _then(_ItemPurchased(
itemName: null == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _BalanceAdded implements AssetEvent {
  const _BalanceAdded(this.amount);
  

 final  int amount;

/// Create a copy of AssetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalanceAddedCopyWith<_BalanceAdded> get copyWith => __$BalanceAddedCopyWithImpl<_BalanceAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BalanceAdded&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'AssetEvent.balanceAdded(amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$BalanceAddedCopyWith<$Res> implements $AssetEventCopyWith<$Res> {
  factory _$BalanceAddedCopyWith(_BalanceAdded value, $Res Function(_BalanceAdded) _then) = __$BalanceAddedCopyWithImpl;
@useResult
$Res call({
 int amount
});




}
/// @nodoc
class __$BalanceAddedCopyWithImpl<$Res>
    implements _$BalanceAddedCopyWith<$Res> {
  __$BalanceAddedCopyWithImpl(this._self, this._then);

  final _BalanceAdded _self;
  final $Res Function(_BalanceAdded) _then;

/// Create a copy of AssetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? amount = null,}) {
  return _then(_BalanceAdded(
null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _CashUpdated implements AssetEvent {
  const _CashUpdated(this.cash);
  

 final  int cash;

/// Create a copy of AssetEvent
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
  return 'AssetEvent.cashUpdated(cash: $cash)';
}


}

/// @nodoc
abstract mixin class _$CashUpdatedCopyWith<$Res> implements $AssetEventCopyWith<$Res> {
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

/// Create a copy of AssetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cash = null,}) {
  return _then(_CashUpdated(
null == cash ? _self.cash : cash // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _StocksUpdated implements AssetEvent {
  const _StocksUpdated(final  List<Stock> stocks): _stocks = stocks;
  

 final  List<Stock> _stocks;
 List<Stock> get stocks {
  if (_stocks is EqualUnmodifiableListView) return _stocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stocks);
}


/// Create a copy of AssetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StocksUpdatedCopyWith<_StocksUpdated> get copyWith => __$StocksUpdatedCopyWithImpl<_StocksUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StocksUpdated&&const DeepCollectionEquality().equals(other._stocks, _stocks));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stocks));

@override
String toString() {
  return 'AssetEvent.stocksUpdated(stocks: $stocks)';
}


}

/// @nodoc
abstract mixin class _$StocksUpdatedCopyWith<$Res> implements $AssetEventCopyWith<$Res> {
  factory _$StocksUpdatedCopyWith(_StocksUpdated value, $Res Function(_StocksUpdated) _then) = __$StocksUpdatedCopyWithImpl;
@useResult
$Res call({
 List<Stock> stocks
});




}
/// @nodoc
class __$StocksUpdatedCopyWithImpl<$Res>
    implements _$StocksUpdatedCopyWith<$Res> {
  __$StocksUpdatedCopyWithImpl(this._self, this._then);

  final _StocksUpdated _self;
  final $Res Function(_StocksUpdated) _then;

/// Create a copy of AssetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stocks = null,}) {
  return _then(_StocksUpdated(
null == stocks ? _self._stocks : stocks // ignore: cast_nullable_to_non_nullable
as List<Stock>,
  ));
}


}

/// @nodoc
mixin _$AssetState {

 AssetData get data;
/// Create a copy of AssetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetStateCopyWith<AssetState> get copyWith => _$AssetStateCopyWithImpl<AssetState>(this as AssetState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetState&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'AssetState(data: $data)';
}


}

/// @nodoc
abstract mixin class $AssetStateCopyWith<$Res>  {
  factory $AssetStateCopyWith(AssetState value, $Res Function(AssetState) _then) = _$AssetStateCopyWithImpl;
@useResult
$Res call({
 AssetData data
});


$AssetDataCopyWith<$Res> get data;

}
/// @nodoc
class _$AssetStateCopyWithImpl<$Res>
    implements $AssetStateCopyWith<$Res> {
  _$AssetStateCopyWithImpl(this._self, this._then);

  final AssetState _self;
  final $Res Function(AssetState) _then;

/// Create a copy of AssetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AssetData,
  ));
}
/// Create a copy of AssetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetDataCopyWith<$Res> get data {
  
  return $AssetDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AssetState].
extension AssetStatePatterns on AssetState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetState value)  $default,){
final _that = this;
switch (_that) {
case _AssetState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetState value)?  $default,){
final _that = this;
switch (_that) {
case _AssetState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AssetData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetState() when $default != null:
return $default(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AssetData data)  $default,) {final _that = this;
switch (_that) {
case _AssetState():
return $default(_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AssetData data)?  $default,) {final _that = this;
switch (_that) {
case _AssetState() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _AssetState implements AssetState {
  const _AssetState(this.data);
  

@override final  AssetData data;

/// Create a copy of AssetState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetStateCopyWith<_AssetState> get copyWith => __$AssetStateCopyWithImpl<_AssetState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetState&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'AssetState(data: $data)';
}


}

/// @nodoc
abstract mixin class _$AssetStateCopyWith<$Res> implements $AssetStateCopyWith<$Res> {
  factory _$AssetStateCopyWith(_AssetState value, $Res Function(_AssetState) _then) = __$AssetStateCopyWithImpl;
@override @useResult
$Res call({
 AssetData data
});


@override $AssetDataCopyWith<$Res> get data;

}
/// @nodoc
class __$AssetStateCopyWithImpl<$Res>
    implements _$AssetStateCopyWith<$Res> {
  __$AssetStateCopyWithImpl(this._self, this._then);

  final _AssetState _self;
  final $Res Function(_AssetState) _then;

/// Create a copy of AssetState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_AssetState(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AssetData,
  ));
}

/// Create a copy of AssetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetDataCopyWith<$Res> get data {
  
  return $AssetDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc
mixin _$AssetData {

 int get deposit;// 예치금 (원)
 List<Stock> get stocks;// 보유 주식 리스트
 int get totalSpent;// 총 지출
 List<PurchaseRecord> get purchaseHistory;
/// Create a copy of AssetData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetDataCopyWith<AssetData> get copyWith => _$AssetDataCopyWithImpl<AssetData>(this as AssetData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetData&&(identical(other.deposit, deposit) || other.deposit == deposit)&&const DeepCollectionEquality().equals(other.stocks, stocks)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&const DeepCollectionEquality().equals(other.purchaseHistory, purchaseHistory));
}


@override
int get hashCode => Object.hash(runtimeType,deposit,const DeepCollectionEquality().hash(stocks),totalSpent,const DeepCollectionEquality().hash(purchaseHistory));

@override
String toString() {
  return 'AssetData(deposit: $deposit, stocks: $stocks, totalSpent: $totalSpent, purchaseHistory: $purchaseHistory)';
}


}

/// @nodoc
abstract mixin class $AssetDataCopyWith<$Res>  {
  factory $AssetDataCopyWith(AssetData value, $Res Function(AssetData) _then) = _$AssetDataCopyWithImpl;
@useResult
$Res call({
 int deposit, List<Stock> stocks, int totalSpent, List<PurchaseRecord> purchaseHistory
});




}
/// @nodoc
class _$AssetDataCopyWithImpl<$Res>
    implements $AssetDataCopyWith<$Res> {
  _$AssetDataCopyWithImpl(this._self, this._then);

  final AssetData _self;
  final $Res Function(AssetData) _then;

/// Create a copy of AssetData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deposit = null,Object? stocks = null,Object? totalSpent = null,Object? purchaseHistory = null,}) {
  return _then(_self.copyWith(
deposit: null == deposit ? _self.deposit : deposit // ignore: cast_nullable_to_non_nullable
as int,stocks: null == stocks ? _self.stocks : stocks // ignore: cast_nullable_to_non_nullable
as List<Stock>,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,purchaseHistory: null == purchaseHistory ? _self.purchaseHistory : purchaseHistory // ignore: cast_nullable_to_non_nullable
as List<PurchaseRecord>,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetData].
extension AssetDataPatterns on AssetData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetData value)  $default,){
final _that = this;
switch (_that) {
case _AssetData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetData value)?  $default,){
final _that = this;
switch (_that) {
case _AssetData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int deposit,  List<Stock> stocks,  int totalSpent,  List<PurchaseRecord> purchaseHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetData() when $default != null:
return $default(_that.deposit,_that.stocks,_that.totalSpent,_that.purchaseHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int deposit,  List<Stock> stocks,  int totalSpent,  List<PurchaseRecord> purchaseHistory)  $default,) {final _that = this;
switch (_that) {
case _AssetData():
return $default(_that.deposit,_that.stocks,_that.totalSpent,_that.purchaseHistory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int deposit,  List<Stock> stocks,  int totalSpent,  List<PurchaseRecord> purchaseHistory)?  $default,) {final _that = this;
switch (_that) {
case _AssetData() when $default != null:
return $default(_that.deposit,_that.stocks,_that.totalSpent,_that.purchaseHistory);case _:
  return null;

}
}

}

/// @nodoc


class _AssetData implements AssetData {
  const _AssetData({required this.deposit, required final  List<Stock> stocks, required this.totalSpent, required final  List<PurchaseRecord> purchaseHistory}): _stocks = stocks,_purchaseHistory = purchaseHistory;
  

@override final  int deposit;
// 예치금 (원)
 final  List<Stock> _stocks;
// 예치금 (원)
@override List<Stock> get stocks {
  if (_stocks is EqualUnmodifiableListView) return _stocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stocks);
}

// 보유 주식 리스트
@override final  int totalSpent;
// 총 지출
 final  List<PurchaseRecord> _purchaseHistory;
// 총 지출
@override List<PurchaseRecord> get purchaseHistory {
  if (_purchaseHistory is EqualUnmodifiableListView) return _purchaseHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_purchaseHistory);
}


/// Create a copy of AssetData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetDataCopyWith<_AssetData> get copyWith => __$AssetDataCopyWithImpl<_AssetData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetData&&(identical(other.deposit, deposit) || other.deposit == deposit)&&const DeepCollectionEquality().equals(other._stocks, _stocks)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&const DeepCollectionEquality().equals(other._purchaseHistory, _purchaseHistory));
}


@override
int get hashCode => Object.hash(runtimeType,deposit,const DeepCollectionEquality().hash(_stocks),totalSpent,const DeepCollectionEquality().hash(_purchaseHistory));

@override
String toString() {
  return 'AssetData(deposit: $deposit, stocks: $stocks, totalSpent: $totalSpent, purchaseHistory: $purchaseHistory)';
}


}

/// @nodoc
abstract mixin class _$AssetDataCopyWith<$Res> implements $AssetDataCopyWith<$Res> {
  factory _$AssetDataCopyWith(_AssetData value, $Res Function(_AssetData) _then) = __$AssetDataCopyWithImpl;
@override @useResult
$Res call({
 int deposit, List<Stock> stocks, int totalSpent, List<PurchaseRecord> purchaseHistory
});




}
/// @nodoc
class __$AssetDataCopyWithImpl<$Res>
    implements _$AssetDataCopyWith<$Res> {
  __$AssetDataCopyWithImpl(this._self, this._then);

  final _AssetData _self;
  final $Res Function(_AssetData) _then;

/// Create a copy of AssetData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deposit = null,Object? stocks = null,Object? totalSpent = null,Object? purchaseHistory = null,}) {
  return _then(_AssetData(
deposit: null == deposit ? _self.deposit : deposit // ignore: cast_nullable_to_non_nullable
as int,stocks: null == stocks ? _self._stocks : stocks // ignore: cast_nullable_to_non_nullable
as List<Stock>,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,purchaseHistory: null == purchaseHistory ? _self._purchaseHistory : purchaseHistory // ignore: cast_nullable_to_non_nullable
as List<PurchaseRecord>,
  ));
}


}

/// @nodoc
mixin _$Stock {

 String get name;// 주식 이름
 String get ticker;// 주식 티커
 int get quantity;// 보유 수량 (주)
 int get avgPrice;
/// Create a copy of Stock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockCopyWith<Stock> get copyWith => _$StockCopyWithImpl<Stock>(this as Stock, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Stock&&(identical(other.name, name) || other.name == name)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.avgPrice, avgPrice) || other.avgPrice == avgPrice));
}


@override
int get hashCode => Object.hash(runtimeType,name,ticker,quantity,avgPrice);

@override
String toString() {
  return 'Stock(name: $name, ticker: $ticker, quantity: $quantity, avgPrice: $avgPrice)';
}


}

/// @nodoc
abstract mixin class $StockCopyWith<$Res>  {
  factory $StockCopyWith(Stock value, $Res Function(Stock) _then) = _$StockCopyWithImpl;
@useResult
$Res call({
 String name, String ticker, int quantity, int avgPrice
});




}
/// @nodoc
class _$StockCopyWithImpl<$Res>
    implements $StockCopyWith<$Res> {
  _$StockCopyWithImpl(this._self, this._then);

  final Stock _self;
  final $Res Function(Stock) _then;

/// Create a copy of Stock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? ticker = null,Object? quantity = null,Object? avgPrice = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,avgPrice: null == avgPrice ? _self.avgPrice : avgPrice // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Stock].
extension StockPatterns on Stock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Stock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Stock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Stock value)  $default,){
final _that = this;
switch (_that) {
case _Stock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Stock value)?  $default,){
final _that = this;
switch (_that) {
case _Stock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String ticker,  int quantity,  int avgPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Stock() when $default != null:
return $default(_that.name,_that.ticker,_that.quantity,_that.avgPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String ticker,  int quantity,  int avgPrice)  $default,) {final _that = this;
switch (_that) {
case _Stock():
return $default(_that.name,_that.ticker,_that.quantity,_that.avgPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String ticker,  int quantity,  int avgPrice)?  $default,) {final _that = this;
switch (_that) {
case _Stock() when $default != null:
return $default(_that.name,_that.ticker,_that.quantity,_that.avgPrice);case _:
  return null;

}
}

}

/// @nodoc


class _Stock implements Stock {
  const _Stock({required this.name, required this.ticker, required this.quantity, this.avgPrice = 0});
  

@override final  String name;
// 주식 이름
@override final  String ticker;
// 주식 티커
@override final  int quantity;
// 보유 수량 (주)
@override@JsonKey() final  int avgPrice;

/// Create a copy of Stock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockCopyWith<_Stock> get copyWith => __$StockCopyWithImpl<_Stock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Stock&&(identical(other.name, name) || other.name == name)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.avgPrice, avgPrice) || other.avgPrice == avgPrice));
}


@override
int get hashCode => Object.hash(runtimeType,name,ticker,quantity,avgPrice);

@override
String toString() {
  return 'Stock(name: $name, ticker: $ticker, quantity: $quantity, avgPrice: $avgPrice)';
}


}

/// @nodoc
abstract mixin class _$StockCopyWith<$Res> implements $StockCopyWith<$Res> {
  factory _$StockCopyWith(_Stock value, $Res Function(_Stock) _then) = __$StockCopyWithImpl;
@override @useResult
$Res call({
 String name, String ticker, int quantity, int avgPrice
});




}
/// @nodoc
class __$StockCopyWithImpl<$Res>
    implements _$StockCopyWith<$Res> {
  __$StockCopyWithImpl(this._self, this._then);

  final _Stock _self;
  final $Res Function(_Stock) _then;

/// Create a copy of Stock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? ticker = null,Object? quantity = null,Object? avgPrice = null,}) {
  return _then(_Stock(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,avgPrice: null == avgPrice ? _self.avgPrice : avgPrice // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$PurchaseRecord {

 String get itemName; int get price; DateTime get timestamp;
/// Create a copy of PurchaseRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseRecordCopyWith<PurchaseRecord> get copyWith => _$PurchaseRecordCopyWithImpl<PurchaseRecord>(this as PurchaseRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseRecord&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.price, price) || other.price == price)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,itemName,price,timestamp);

@override
String toString() {
  return 'PurchaseRecord(itemName: $itemName, price: $price, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $PurchaseRecordCopyWith<$Res>  {
  factory $PurchaseRecordCopyWith(PurchaseRecord value, $Res Function(PurchaseRecord) _then) = _$PurchaseRecordCopyWithImpl;
@useResult
$Res call({
 String itemName, int price, DateTime timestamp
});




}
/// @nodoc
class _$PurchaseRecordCopyWithImpl<$Res>
    implements $PurchaseRecordCopyWith<$Res> {
  _$PurchaseRecordCopyWithImpl(this._self, this._then);

  final PurchaseRecord _self;
  final $Res Function(PurchaseRecord) _then;

/// Create a copy of PurchaseRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemName = null,Object? price = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
itemName: null == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseRecord].
extension PurchaseRecordPatterns on PurchaseRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseRecord value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseRecord value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String itemName,  int price,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseRecord() when $default != null:
return $default(_that.itemName,_that.price,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String itemName,  int price,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _PurchaseRecord():
return $default(_that.itemName,_that.price,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String itemName,  int price,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseRecord() when $default != null:
return $default(_that.itemName,_that.price,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _PurchaseRecord implements PurchaseRecord {
  const _PurchaseRecord({required this.itemName, required this.price, required this.timestamp});
  

@override final  String itemName;
@override final  int price;
@override final  DateTime timestamp;

/// Create a copy of PurchaseRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseRecordCopyWith<_PurchaseRecord> get copyWith => __$PurchaseRecordCopyWithImpl<_PurchaseRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseRecord&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.price, price) || other.price == price)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,itemName,price,timestamp);

@override
String toString() {
  return 'PurchaseRecord(itemName: $itemName, price: $price, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$PurchaseRecordCopyWith<$Res> implements $PurchaseRecordCopyWith<$Res> {
  factory _$PurchaseRecordCopyWith(_PurchaseRecord value, $Res Function(_PurchaseRecord) _then) = __$PurchaseRecordCopyWithImpl;
@override @useResult
$Res call({
 String itemName, int price, DateTime timestamp
});




}
/// @nodoc
class __$PurchaseRecordCopyWithImpl<$Res>
    implements _$PurchaseRecordCopyWith<$Res> {
  __$PurchaseRecordCopyWithImpl(this._self, this._then);

  final _PurchaseRecord _self;
  final $Res Function(_PurchaseRecord) _then;

/// Create a copy of PurchaseRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemName = null,Object? price = null,Object? timestamp = null,}) {
  return _then(_PurchaseRecord(
itemName: null == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
