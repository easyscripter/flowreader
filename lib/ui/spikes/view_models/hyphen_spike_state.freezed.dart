// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hyphen_spike_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HyphenSpikeState {

 String get text; double get width; bool get justify;
/// Create a copy of HyphenSpikeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HyphenSpikeStateCopyWith<HyphenSpikeState> get copyWith => _$HyphenSpikeStateCopyWithImpl<HyphenSpikeState>(this as HyphenSpikeState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HyphenSpikeState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HyphenSpikeState&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.width, _this.width) || other.width == _this.width)&&(identical(other.justify, _this.justify) || other.justify == _this.justify));
}


@override
int get hashCode {
  final _this = this as HyphenSpikeState;
  return Object.hash(runtimeType,_this.text,_this.width,_this.justify);
}

@override
String toString() {
  final _this = this as HyphenSpikeState;
  return 'HyphenSpikeState(text: ${_this.text}, width: ${_this.width}, justify: ${_this.justify})';
}


}

/// @nodoc
abstract mixin class $HyphenSpikeStateCopyWith<$Res>  {
  factory $HyphenSpikeStateCopyWith(HyphenSpikeState value, $Res Function(HyphenSpikeState) _then) = _$HyphenSpikeStateCopyWithImpl;
@useResult
$Res call({
 String text, double width, bool justify
});




}
/// @nodoc
class _$HyphenSpikeStateCopyWithImpl<$Res>
    implements $HyphenSpikeStateCopyWith<$Res> {
  _$HyphenSpikeStateCopyWithImpl(this._self, this._then);

  final HyphenSpikeState _self;
  final $Res Function(HyphenSpikeState) _then;

/// Create a copy of HyphenSpikeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? width = null,Object? justify = null,}) {
  return _then(HyphenSpikeState(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,justify: null == justify ? _self.justify : justify // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HyphenSpikeState].
extension HyphenSpikeStatePatterns on HyphenSpikeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HyphenSpikeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HyphenSpikeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HyphenSpikeState value)  $default,){
final _that = this;
switch (_that) {
case _HyphenSpikeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HyphenSpikeState value)?  $default,){
final _that = this;
switch (_that) {
case _HyphenSpikeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  double width,  bool justify)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HyphenSpikeState() when $default != null:
return $default(_that.text,_that.width,_that.justify);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  double width,  bool justify)  $default,) {final _that = this;
switch (_that) {
case _HyphenSpikeState():
return $default(_that.text,_that.width,_that.justify);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  double width,  bool justify)?  $default,) {final _that = this;
switch (_that) {
case _HyphenSpikeState() when $default != null:
return $default(_that.text,_that.width,_that.justify);case _:
  return null;

}
}

}

/// @nodoc


class _HyphenSpikeState implements HyphenSpikeState {
  const _HyphenSpikeState({required this.text, this.width = HyphenSpikeState.defaultWidth, this.justify = true});
  

@override final  String text;
@override@JsonKey() final  double width;
@override@JsonKey() final  bool justify;

/// Create a copy of HyphenSpikeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HyphenSpikeStateCopyWith<_HyphenSpikeState> get copyWith => __$HyphenSpikeStateCopyWithImpl<_HyphenSpikeState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HyphenSpikeState&&(identical(other.text, text) || other.text == text)&&(identical(other.width, width) || other.width == width)&&(identical(other.justify, justify) || other.justify == justify));
}


@override
int get hashCode {
    return Object.hash(runtimeType,text,width,justify);
}

@override
String toString() {
    return 'HyphenSpikeState(text: $text, width: $width, justify: $justify)';
}


}

/// @nodoc
abstract mixin class _$HyphenSpikeStateCopyWith<$Res> implements $HyphenSpikeStateCopyWith<$Res> {
  factory _$HyphenSpikeStateCopyWith(_HyphenSpikeState value, $Res Function(_HyphenSpikeState) _then) = __$HyphenSpikeStateCopyWithImpl;
@override @useResult
$Res call({
 String text, double width, bool justify
});




}
/// @nodoc
class __$HyphenSpikeStateCopyWithImpl<$Res>
    implements _$HyphenSpikeStateCopyWith<$Res> {
  __$HyphenSpikeStateCopyWithImpl(this._self, this._then);

  final _HyphenSpikeState _self;
  final $Res Function(_HyphenSpikeState) _then;

/// Create a copy of HyphenSpikeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? width = null,Object? justify = null,}) {
  return _then(_HyphenSpikeState(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,justify: null == justify ? _self.justify : justify // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
