// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PortfolioItem {

 String get symbol; int get quantity; double get avgPrice;
/// Create a copy of PortfolioItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioItemCopyWith<PortfolioItem> get copyWith => _$PortfolioItemCopyWithImpl<PortfolioItem>(this as PortfolioItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioItem&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.avgPrice, avgPrice) || other.avgPrice == avgPrice));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,quantity,avgPrice);

@override
String toString() {
  return 'PortfolioItem(symbol: $symbol, quantity: $quantity, avgPrice: $avgPrice)';
}


}

/// @nodoc
abstract mixin class $PortfolioItemCopyWith<$Res>  {
  factory $PortfolioItemCopyWith(PortfolioItem value, $Res Function(PortfolioItem) _then) = _$PortfolioItemCopyWithImpl;
@useResult
$Res call({
 String symbol, int quantity, double avgPrice
});




}
/// @nodoc
class _$PortfolioItemCopyWithImpl<$Res>
    implements $PortfolioItemCopyWith<$Res> {
  _$PortfolioItemCopyWithImpl(this._self, this._then);

  final PortfolioItem _self;
  final $Res Function(PortfolioItem) _then;

/// Create a copy of PortfolioItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? quantity = null,Object? avgPrice = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,avgPrice: null == avgPrice ? _self.avgPrice : avgPrice // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PortfolioItem].
extension PortfolioItemPatterns on PortfolioItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioItem value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioItem value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  int quantity,  double avgPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioItem() when $default != null:
return $default(_that.symbol,_that.quantity,_that.avgPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  int quantity,  double avgPrice)  $default,) {final _that = this;
switch (_that) {
case _PortfolioItem():
return $default(_that.symbol,_that.quantity,_that.avgPrice);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  int quantity,  double avgPrice)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioItem() when $default != null:
return $default(_that.symbol,_that.quantity,_that.avgPrice);case _:
  return null;

}
}

}

/// @nodoc


class _PortfolioItem implements PortfolioItem {
  const _PortfolioItem({required this.symbol, required this.quantity, required this.avgPrice});
  

@override final  String symbol;
@override final  int quantity;
@override final  double avgPrice;

/// Create a copy of PortfolioItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioItemCopyWith<_PortfolioItem> get copyWith => __$PortfolioItemCopyWithImpl<_PortfolioItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioItem&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.avgPrice, avgPrice) || other.avgPrice == avgPrice));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,quantity,avgPrice);

@override
String toString() {
  return 'PortfolioItem(symbol: $symbol, quantity: $quantity, avgPrice: $avgPrice)';
}


}

/// @nodoc
abstract mixin class _$PortfolioItemCopyWith<$Res> implements $PortfolioItemCopyWith<$Res> {
  factory _$PortfolioItemCopyWith(_PortfolioItem value, $Res Function(_PortfolioItem) _then) = __$PortfolioItemCopyWithImpl;
@override @useResult
$Res call({
 String symbol, int quantity, double avgPrice
});




}
/// @nodoc
class __$PortfolioItemCopyWithImpl<$Res>
    implements _$PortfolioItemCopyWith<$Res> {
  __$PortfolioItemCopyWithImpl(this._self, this._then);

  final _PortfolioItem _self;
  final $Res Function(_PortfolioItem) _then;

/// Create a copy of PortfolioItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? quantity = null,Object? avgPrice = null,}) {
  return _then(_PortfolioItem(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,avgPrice: null == avgPrice ? _self.avgPrice : avgPrice // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
