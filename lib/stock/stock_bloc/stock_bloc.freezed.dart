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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _BuyStock value)?  buyStock,TResult Function( _SellStock value)?  sellStock,TResult Function( _UpdatePrices value)?  updatePrices,TResult Function( _TriggerEvent value)?  triggerEvent,TResult Function( _ClearEvent value)?  clearEvent,TResult Function( _SelectStock value)?  selectStock,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _BuyStock() when buyStock != null:
return buyStock(_that);case _SellStock() when sellStock != null:
return sellStock(_that);case _UpdatePrices() when updatePrices != null:
return updatePrices(_that);case _TriggerEvent() when triggerEvent != null:
return triggerEvent(_that);case _ClearEvent() when clearEvent != null:
return clearEvent(_that);case _SelectStock() when selectStock != null:
return selectStock(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _BuyStock value)  buyStock,required TResult Function( _SellStock value)  sellStock,required TResult Function( _UpdatePrices value)  updatePrices,required TResult Function( _TriggerEvent value)  triggerEvent,required TResult Function( _ClearEvent value)  clearEvent,required TResult Function( _SelectStock value)  selectStock,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _BuyStock():
return buyStock(_that);case _SellStock():
return sellStock(_that);case _UpdatePrices():
return updatePrices(_that);case _TriggerEvent():
return triggerEvent(_that);case _ClearEvent():
return clearEvent(_that);case _SelectStock():
return selectStock(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _BuyStock value)?  buyStock,TResult? Function( _SellStock value)?  sellStock,TResult? Function( _UpdatePrices value)?  updatePrices,TResult? Function( _TriggerEvent value)?  triggerEvent,TResult? Function( _ClearEvent value)?  clearEvent,TResult? Function( _SelectStock value)?  selectStock,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _BuyStock() when buyStock != null:
return buyStock(_that);case _SellStock() when sellStock != null:
return sellStock(_that);case _UpdatePrices() when updatePrices != null:
return updatePrices(_that);case _TriggerEvent() when triggerEvent != null:
return triggerEvent(_that);case _ClearEvent() when clearEvent != null:
return clearEvent(_that);case _SelectStock() when selectStock != null:
return selectStock(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String symbol,  int quantity)?  buyStock,TResult Function( String symbol,  int quantity)?  sellStock,TResult Function()?  updatePrices,TResult Function( models.StockEventModel event)?  triggerEvent,TResult Function()?  clearEvent,TResult Function( String symbol)?  selectStock,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _BuyStock() when buyStock != null:
return buyStock(_that.symbol,_that.quantity);case _SellStock() when sellStock != null:
return sellStock(_that.symbol,_that.quantity);case _UpdatePrices() when updatePrices != null:
return updatePrices();case _TriggerEvent() when triggerEvent != null:
return triggerEvent(_that.event);case _ClearEvent() when clearEvent != null:
return clearEvent();case _SelectStock() when selectStock != null:
return selectStock(_that.symbol);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String symbol,  int quantity)  buyStock,required TResult Function( String symbol,  int quantity)  sellStock,required TResult Function()  updatePrices,required TResult Function( models.StockEventModel event)  triggerEvent,required TResult Function()  clearEvent,required TResult Function( String symbol)  selectStock,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _BuyStock():
return buyStock(_that.symbol,_that.quantity);case _SellStock():
return sellStock(_that.symbol,_that.quantity);case _UpdatePrices():
return updatePrices();case _TriggerEvent():
return triggerEvent(_that.event);case _ClearEvent():
return clearEvent();case _SelectStock():
return selectStock(_that.symbol);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String symbol,  int quantity)?  buyStock,TResult? Function( String symbol,  int quantity)?  sellStock,TResult? Function()?  updatePrices,TResult? Function( models.StockEventModel event)?  triggerEvent,TResult? Function()?  clearEvent,TResult? Function( String symbol)?  selectStock,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _BuyStock() when buyStock != null:
return buyStock(_that.symbol,_that.quantity);case _SellStock() when sellStock != null:
return sellStock(_that.symbol,_that.quantity);case _UpdatePrices() when updatePrices != null:
return updatePrices();case _TriggerEvent() when triggerEvent != null:
return triggerEvent(_that.event);case _ClearEvent() when clearEvent != null:
return clearEvent();case _SelectStock() when selectStock != null:
return selectStock(_that.symbol);case _:
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


class _BuyStock implements StockEvent {
  const _BuyStock({required this.symbol, required this.quantity});
  

 final  String symbol;
 final  int quantity;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuyStockCopyWith<_BuyStock> get copyWith => __$BuyStockCopyWithImpl<_BuyStock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuyStock&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,quantity);

@override
String toString() {
  return 'StockEvent.buyStock(symbol: $symbol, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$BuyStockCopyWith<$Res> implements $StockEventCopyWith<$Res> {
  factory _$BuyStockCopyWith(_BuyStock value, $Res Function(_BuyStock) _then) = __$BuyStockCopyWithImpl;
@useResult
$Res call({
 String symbol, int quantity
});




}
/// @nodoc
class __$BuyStockCopyWithImpl<$Res>
    implements _$BuyStockCopyWith<$Res> {
  __$BuyStockCopyWithImpl(this._self, this._then);

  final _BuyStock _self;
  final $Res Function(_BuyStock) _then;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? quantity = null,}) {
  return _then(_BuyStock(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _SellStock implements StockEvent {
  const _SellStock({required this.symbol, required this.quantity});
  

 final  String symbol;
 final  int quantity;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SellStockCopyWith<_SellStock> get copyWith => __$SellStockCopyWithImpl<_SellStock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellStock&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,quantity);

@override
String toString() {
  return 'StockEvent.sellStock(symbol: $symbol, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$SellStockCopyWith<$Res> implements $StockEventCopyWith<$Res> {
  factory _$SellStockCopyWith(_SellStock value, $Res Function(_SellStock) _then) = __$SellStockCopyWithImpl;
@useResult
$Res call({
 String symbol, int quantity
});




}
/// @nodoc
class __$SellStockCopyWithImpl<$Res>
    implements _$SellStockCopyWith<$Res> {
  __$SellStockCopyWithImpl(this._self, this._then);

  final _SellStock _self;
  final $Res Function(_SellStock) _then;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? quantity = null,}) {
  return _then(_SellStock(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _UpdatePrices implements StockEvent {
  const _UpdatePrices();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdatePrices);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StockEvent.updatePrices()';
}


}




/// @nodoc


class _TriggerEvent implements StockEvent {
  const _TriggerEvent(this.event);
  

 final  models.StockEventModel event;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TriggerEventCopyWith<_TriggerEvent> get copyWith => __$TriggerEventCopyWithImpl<_TriggerEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TriggerEvent&&(identical(other.event, event) || other.event == event));
}


@override
int get hashCode => Object.hash(runtimeType,event);

@override
String toString() {
  return 'StockEvent.triggerEvent(event: $event)';
}


}

/// @nodoc
abstract mixin class _$TriggerEventCopyWith<$Res> implements $StockEventCopyWith<$Res> {
  factory _$TriggerEventCopyWith(_TriggerEvent value, $Res Function(_TriggerEvent) _then) = __$TriggerEventCopyWithImpl;
@useResult
$Res call({
 models.StockEventModel event
});


$StockEventModelCopyWith<$Res> get event;

}
/// @nodoc
class __$TriggerEventCopyWithImpl<$Res>
    implements _$TriggerEventCopyWith<$Res> {
  __$TriggerEventCopyWithImpl(this._self, this._then);

  final _TriggerEvent _self;
  final $Res Function(_TriggerEvent) _then;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? event = null,}) {
  return _then(_TriggerEvent(
null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as models.StockEventModel,
  ));
}

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockEventModelCopyWith<$Res> get event {
  
  return $StockEventModelCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}

/// @nodoc


class _ClearEvent implements StockEvent {
  const _ClearEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StockEvent.clearEvent()';
}


}




/// @nodoc


class _SelectStock implements StockEvent {
  const _SelectStock(this.symbol);
  

 final  String symbol;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectStockCopyWith<_SelectStock> get copyWith => __$SelectStockCopyWithImpl<_SelectStock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectStock&&(identical(other.symbol, symbol) || other.symbol == symbol));
}


@override
int get hashCode => Object.hash(runtimeType,symbol);

@override
String toString() {
  return 'StockEvent.selectStock(symbol: $symbol)';
}


}

/// @nodoc
abstract mixin class _$SelectStockCopyWith<$Res> implements $StockEventCopyWith<$Res> {
  factory _$SelectStockCopyWith(_SelectStock value, $Res Function(_SelectStock) _then) = __$SelectStockCopyWithImpl;
@useResult
$Res call({
 String symbol
});




}
/// @nodoc
class __$SelectStockCopyWithImpl<$Res>
    implements _$SelectStockCopyWith<$Res> {
  __$SelectStockCopyWithImpl(this._self, this._then);

  final _SelectStock _self;
  final $Res Function(_SelectStock) _then;

/// Create a copy of StockEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? symbol = null,}) {
  return _then(_SelectStock(
null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$StockState {

 StockData get stockData;
/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockStateCopyWith<StockState> get copyWith => _$StockStateCopyWithImpl<StockState>(this as StockState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockState&&(identical(other.stockData, stockData) || other.stockData == stockData));
}


@override
int get hashCode => Object.hash(runtimeType,stockData);

@override
String toString() {
  return 'StockState(stockData: $stockData)';
}


}

/// @nodoc
abstract mixin class $StockStateCopyWith<$Res>  {
  factory $StockStateCopyWith(StockState value, $Res Function(StockState) _then) = _$StockStateCopyWithImpl;
@useResult
$Res call({
 StockData stockData
});


$StockDataCopyWith<$Res> get stockData;

}
/// @nodoc
class _$StockStateCopyWithImpl<$Res>
    implements $StockStateCopyWith<$Res> {
  _$StockStateCopyWithImpl(this._self, this._then);

  final StockState _self;
  final $Res Function(StockState) _then;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stockData = null,}) {
  return _then(_self.copyWith(
stockData: null == stockData ? _self.stockData : stockData // ignore: cast_nullable_to_non_nullable
as StockData,
  ));
}
/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockDataCopyWith<$Res> get stockData {
  
  return $StockDataCopyWith<$Res>(_self.stockData, (value) {
    return _then(_self.copyWith(stockData: value));
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StockDataState value)?  data,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StockDataState() when data != null:
return data(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StockDataState value)  data,}){
final _that = this;
switch (_that) {
case StockDataState():
return data(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StockDataState value)?  data,}){
final _that = this;
switch (_that) {
case StockDataState() when data != null:
return data(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( StockData stockData)?  data,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StockDataState() when data != null:
return data(_that.stockData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( StockData stockData)  data,}) {final _that = this;
switch (_that) {
case StockDataState():
return data(_that.stockData);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( StockData stockData)?  data,}) {final _that = this;
switch (_that) {
case StockDataState() when data != null:
return data(_that.stockData);case _:
  return null;

}
}

}

/// @nodoc


class StockDataState implements StockState {
  const StockDataState(this.stockData);
  

@override final  StockData stockData;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockDataStateCopyWith<StockDataState> get copyWith => _$StockDataStateCopyWithImpl<StockDataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockDataState&&(identical(other.stockData, stockData) || other.stockData == stockData));
}


@override
int get hashCode => Object.hash(runtimeType,stockData);

@override
String toString() {
  return 'StockState.data(stockData: $stockData)';
}


}

/// @nodoc
abstract mixin class $StockDataStateCopyWith<$Res> implements $StockStateCopyWith<$Res> {
  factory $StockDataStateCopyWith(StockDataState value, $Res Function(StockDataState) _then) = _$StockDataStateCopyWithImpl;
@override @useResult
$Res call({
 StockData stockData
});


@override $StockDataCopyWith<$Res> get stockData;

}
/// @nodoc
class _$StockDataStateCopyWithImpl<$Res>
    implements $StockDataStateCopyWith<$Res> {
  _$StockDataStateCopyWithImpl(this._self, this._then);

  final StockDataState _self;
  final $Res Function(StockDataState) _then;

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stockData = null,}) {
  return _then(StockDataState(
null == stockData ? _self.stockData : stockData // ignore: cast_nullable_to_non_nullable
as StockData,
  ));
}

/// Create a copy of StockState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockDataCopyWith<$Res> get stockData {
  
  return $StockDataCopyWith<$Res>(_self.stockData, (value) {
    return _then(_self.copyWith(stockData: value));
  });
}
}

/// @nodoc
mixin _$StockData {

 StockStatus get status; double get currentBalance; List<Stock> get stocks; List<PortfolioItem> get portfolio; Map<String, List<PriceHistory>> get priceHistory; models.StockEventModel? get activeEvent; String? get selectedStock; String? get errorMessage;
/// Create a copy of StockData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockDataCopyWith<StockData> get copyWith => _$StockDataCopyWithImpl<StockData>(this as StockData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockData&&(identical(other.status, status) || other.status == status)&&(identical(other.currentBalance, currentBalance) || other.currentBalance == currentBalance)&&const DeepCollectionEquality().equals(other.stocks, stocks)&&const DeepCollectionEquality().equals(other.portfolio, portfolio)&&const DeepCollectionEquality().equals(other.priceHistory, priceHistory)&&(identical(other.activeEvent, activeEvent) || other.activeEvent == activeEvent)&&(identical(other.selectedStock, selectedStock) || other.selectedStock == selectedStock)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,currentBalance,const DeepCollectionEquality().hash(stocks),const DeepCollectionEquality().hash(portfolio),const DeepCollectionEquality().hash(priceHistory),activeEvent,selectedStock,errorMessage);

@override
String toString() {
  return 'StockData(status: $status, currentBalance: $currentBalance, stocks: $stocks, portfolio: $portfolio, priceHistory: $priceHistory, activeEvent: $activeEvent, selectedStock: $selectedStock, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $StockDataCopyWith<$Res>  {
  factory $StockDataCopyWith(StockData value, $Res Function(StockData) _then) = _$StockDataCopyWithImpl;
@useResult
$Res call({
 StockStatus status, double currentBalance, List<Stock> stocks, List<PortfolioItem> portfolio, Map<String, List<PriceHistory>> priceHistory, models.StockEventModel? activeEvent, String? selectedStock, String? errorMessage
});


$StockEventModelCopyWith<$Res>? get activeEvent;

}
/// @nodoc
class _$StockDataCopyWithImpl<$Res>
    implements $StockDataCopyWith<$Res> {
  _$StockDataCopyWithImpl(this._self, this._then);

  final StockData _self;
  final $Res Function(StockData) _then;

/// Create a copy of StockData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? currentBalance = null,Object? stocks = null,Object? portfolio = null,Object? priceHistory = null,Object? activeEvent = freezed,Object? selectedStock = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StockStatus,currentBalance: null == currentBalance ? _self.currentBalance : currentBalance // ignore: cast_nullable_to_non_nullable
as double,stocks: null == stocks ? _self.stocks : stocks // ignore: cast_nullable_to_non_nullable
as List<Stock>,portfolio: null == portfolio ? _self.portfolio : portfolio // ignore: cast_nullable_to_non_nullable
as List<PortfolioItem>,priceHistory: null == priceHistory ? _self.priceHistory : priceHistory // ignore: cast_nullable_to_non_nullable
as Map<String, List<PriceHistory>>,activeEvent: freezed == activeEvent ? _self.activeEvent : activeEvent // ignore: cast_nullable_to_non_nullable
as models.StockEventModel?,selectedStock: freezed == selectedStock ? _self.selectedStock : selectedStock // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of StockData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockEventModelCopyWith<$Res>? get activeEvent {
    if (_self.activeEvent == null) {
    return null;
  }

  return $StockEventModelCopyWith<$Res>(_self.activeEvent!, (value) {
    return _then(_self.copyWith(activeEvent: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StockStatus status,  double currentBalance,  List<Stock> stocks,  List<PortfolioItem> portfolio,  Map<String, List<PriceHistory>> priceHistory,  models.StockEventModel? activeEvent,  String? selectedStock,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockData() when $default != null:
return $default(_that.status,_that.currentBalance,_that.stocks,_that.portfolio,_that.priceHistory,_that.activeEvent,_that.selectedStock,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StockStatus status,  double currentBalance,  List<Stock> stocks,  List<PortfolioItem> portfolio,  Map<String, List<PriceHistory>> priceHistory,  models.StockEventModel? activeEvent,  String? selectedStock,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _StockData():
return $default(_that.status,_that.currentBalance,_that.stocks,_that.portfolio,_that.priceHistory,_that.activeEvent,_that.selectedStock,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StockStatus status,  double currentBalance,  List<Stock> stocks,  List<PortfolioItem> portfolio,  Map<String, List<PriceHistory>> priceHistory,  models.StockEventModel? activeEvent,  String? selectedStock,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _StockData() when $default != null:
return $default(_that.status,_that.currentBalance,_that.stocks,_that.portfolio,_that.priceHistory,_that.activeEvent,_that.selectedStock,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _StockData implements StockData {
  const _StockData({this.status = StockStatus.initial, this.currentBalance = 10000000, final  List<Stock> stocks = const [], final  List<PortfolioItem> portfolio = const [], final  Map<String, List<PriceHistory>> priceHistory = const {}, this.activeEvent, this.selectedStock, this.errorMessage}): _stocks = stocks,_portfolio = portfolio,_priceHistory = priceHistory;
  

@override@JsonKey() final  StockStatus status;
@override@JsonKey() final  double currentBalance;
 final  List<Stock> _stocks;
@override@JsonKey() List<Stock> get stocks {
  if (_stocks is EqualUnmodifiableListView) return _stocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stocks);
}

 final  List<PortfolioItem> _portfolio;
@override@JsonKey() List<PortfolioItem> get portfolio {
  if (_portfolio is EqualUnmodifiableListView) return _portfolio;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_portfolio);
}

 final  Map<String, List<PriceHistory>> _priceHistory;
@override@JsonKey() Map<String, List<PriceHistory>> get priceHistory {
  if (_priceHistory is EqualUnmodifiableMapView) return _priceHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_priceHistory);
}

@override final  models.StockEventModel? activeEvent;
@override final  String? selectedStock;
@override final  String? errorMessage;

/// Create a copy of StockData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockDataCopyWith<_StockData> get copyWith => __$StockDataCopyWithImpl<_StockData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockData&&(identical(other.status, status) || other.status == status)&&(identical(other.currentBalance, currentBalance) || other.currentBalance == currentBalance)&&const DeepCollectionEquality().equals(other._stocks, _stocks)&&const DeepCollectionEquality().equals(other._portfolio, _portfolio)&&const DeepCollectionEquality().equals(other._priceHistory, _priceHistory)&&(identical(other.activeEvent, activeEvent) || other.activeEvent == activeEvent)&&(identical(other.selectedStock, selectedStock) || other.selectedStock == selectedStock)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,currentBalance,const DeepCollectionEquality().hash(_stocks),const DeepCollectionEquality().hash(_portfolio),const DeepCollectionEquality().hash(_priceHistory),activeEvent,selectedStock,errorMessage);

@override
String toString() {
  return 'StockData(status: $status, currentBalance: $currentBalance, stocks: $stocks, portfolio: $portfolio, priceHistory: $priceHistory, activeEvent: $activeEvent, selectedStock: $selectedStock, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$StockDataCopyWith<$Res> implements $StockDataCopyWith<$Res> {
  factory _$StockDataCopyWith(_StockData value, $Res Function(_StockData) _then) = __$StockDataCopyWithImpl;
@override @useResult
$Res call({
 StockStatus status, double currentBalance, List<Stock> stocks, List<PortfolioItem> portfolio, Map<String, List<PriceHistory>> priceHistory, models.StockEventModel? activeEvent, String? selectedStock, String? errorMessage
});


@override $StockEventModelCopyWith<$Res>? get activeEvent;

}
/// @nodoc
class __$StockDataCopyWithImpl<$Res>
    implements _$StockDataCopyWith<$Res> {
  __$StockDataCopyWithImpl(this._self, this._then);

  final _StockData _self;
  final $Res Function(_StockData) _then;

/// Create a copy of StockData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? currentBalance = null,Object? stocks = null,Object? portfolio = null,Object? priceHistory = null,Object? activeEvent = freezed,Object? selectedStock = freezed,Object? errorMessage = freezed,}) {
  return _then(_StockData(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StockStatus,currentBalance: null == currentBalance ? _self.currentBalance : currentBalance // ignore: cast_nullable_to_non_nullable
as double,stocks: null == stocks ? _self._stocks : stocks // ignore: cast_nullable_to_non_nullable
as List<Stock>,portfolio: null == portfolio ? _self._portfolio : portfolio // ignore: cast_nullable_to_non_nullable
as List<PortfolioItem>,priceHistory: null == priceHistory ? _self._priceHistory : priceHistory // ignore: cast_nullable_to_non_nullable
as Map<String, List<PriceHistory>>,activeEvent: freezed == activeEvent ? _self.activeEvent : activeEvent // ignore: cast_nullable_to_non_nullable
as models.StockEventModel?,selectedStock: freezed == selectedStock ? _self.selectedStock : selectedStock // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of StockData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockEventModelCopyWith<$Res>? get activeEvent {
    if (_self.activeEvent == null) {
    return null;
  }

  return $StockEventModelCopyWith<$Res>(_self.activeEvent!, (value) {
    return _then(_self.copyWith(activeEvent: value));
  });
}
}

// dart format on
