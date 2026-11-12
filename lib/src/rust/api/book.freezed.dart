// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FormatError {

 Object get field0;



@override
bool operator ==(Object other) {
  final _this = this as FormatError;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatError&&const DeepCollectionEquality().equals(other.field0, _this.field0));
}


@override
int get hashCode {
  final _this = this as FormatError;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.field0));
}

@override
String toString() {
  final _this = this as FormatError;
  return 'FormatError(field0: ${_this.field0})';
}


}

/// @nodoc
class $FormatErrorCopyWith<$Res>  {
$FormatErrorCopyWith(FormatError _, $Res Function(FormatError) __);
}


/// Adds pattern-matching-related methods to [FormatError].
extension FormatErrorPatterns on FormatError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FormatError_UnsupportedFormatVersion value)?  unsupportedFormatVersion,TResult Function( FormatError_Corrupt value)?  corrupt,TResult Function( FormatError_Encode value)?  encode,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FormatError_UnsupportedFormatVersion() when unsupportedFormatVersion != null:
return unsupportedFormatVersion(_that);case FormatError_Corrupt() when corrupt != null:
return corrupt(_that);case FormatError_Encode() when encode != null:
return encode(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FormatError_UnsupportedFormatVersion value)  unsupportedFormatVersion,required TResult Function( FormatError_Corrupt value)  corrupt,required TResult Function( FormatError_Encode value)  encode,}){
final _that = this;
switch (_that) {
case FormatError_UnsupportedFormatVersion():
return unsupportedFormatVersion(_that);case FormatError_Corrupt():
return corrupt(_that);case FormatError_Encode():
return encode(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FormatError_UnsupportedFormatVersion value)?  unsupportedFormatVersion,TResult? Function( FormatError_Corrupt value)?  corrupt,TResult? Function( FormatError_Encode value)?  encode,}){
final _that = this;
switch (_that) {
case FormatError_UnsupportedFormatVersion() when unsupportedFormatVersion != null:
return unsupportedFormatVersion(_that);case FormatError_Corrupt() when corrupt != null:
return corrupt(_that);case FormatError_Encode() when encode != null:
return encode(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int field0)?  unsupportedFormatVersion,TResult Function( String field0)?  corrupt,TResult Function( String field0)?  encode,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FormatError_UnsupportedFormatVersion() when unsupportedFormatVersion != null:
return unsupportedFormatVersion(_that.field0);case FormatError_Corrupt() when corrupt != null:
return corrupt(_that.field0);case FormatError_Encode() when encode != null:
return encode(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int field0)  unsupportedFormatVersion,required TResult Function( String field0)  corrupt,required TResult Function( String field0)  encode,}) {final _that = this;
switch (_that) {
case FormatError_UnsupportedFormatVersion():
return unsupportedFormatVersion(_that.field0);case FormatError_Corrupt():
return corrupt(_that.field0);case FormatError_Encode():
return encode(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int field0)?  unsupportedFormatVersion,TResult? Function( String field0)?  corrupt,TResult? Function( String field0)?  encode,}) {final _that = this;
switch (_that) {
case FormatError_UnsupportedFormatVersion() when unsupportedFormatVersion != null:
return unsupportedFormatVersion(_that.field0);case FormatError_Corrupt() when corrupt != null:
return corrupt(_that.field0);case FormatError_Encode() when encode != null:
return encode(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class FormatError_UnsupportedFormatVersion extends FormatError {
  const FormatError_UnsupportedFormatVersion(this.field0): super._();
  

@override final  int field0;

/// Create a copy of FormatError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatError_UnsupportedFormatVersionCopyWith<FormatError_UnsupportedFormatVersion> get copyWith => _$FormatError_UnsupportedFormatVersionCopyWithImpl<FormatError_UnsupportedFormatVersion>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatError_UnsupportedFormatVersion&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode {
    return Object.hash(runtimeType,field0);
}

@override
String toString() {
    return 'FormatError.unsupportedFormatVersion(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FormatError_UnsupportedFormatVersionCopyWith<$Res> implements $FormatErrorCopyWith<$Res> {
  factory $FormatError_UnsupportedFormatVersionCopyWith(FormatError_UnsupportedFormatVersion value, $Res Function(FormatError_UnsupportedFormatVersion) _then) = _$FormatError_UnsupportedFormatVersionCopyWithImpl;
@useResult
$Res call({
 int field0
});




}
/// @nodoc
class _$FormatError_UnsupportedFormatVersionCopyWithImpl<$Res>
    implements $FormatError_UnsupportedFormatVersionCopyWith<$Res> {
  _$FormatError_UnsupportedFormatVersionCopyWithImpl(this._self, this._then);

  final FormatError_UnsupportedFormatVersion _self;
  final $Res Function(FormatError_UnsupportedFormatVersion) _then;

/// Create a copy of FormatError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FormatError_UnsupportedFormatVersion(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class FormatError_Corrupt extends FormatError {
  const FormatError_Corrupt(this.field0): super._();
  

@override final  String field0;

/// Create a copy of FormatError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatError_CorruptCopyWith<FormatError_Corrupt> get copyWith => _$FormatError_CorruptCopyWithImpl<FormatError_Corrupt>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatError_Corrupt&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode {
    return Object.hash(runtimeType,field0);
}

@override
String toString() {
    return 'FormatError.corrupt(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FormatError_CorruptCopyWith<$Res> implements $FormatErrorCopyWith<$Res> {
  factory $FormatError_CorruptCopyWith(FormatError_Corrupt value, $Res Function(FormatError_Corrupt) _then) = _$FormatError_CorruptCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$FormatError_CorruptCopyWithImpl<$Res>
    implements $FormatError_CorruptCopyWith<$Res> {
  _$FormatError_CorruptCopyWithImpl(this._self, this._then);

  final FormatError_Corrupt _self;
  final $Res Function(FormatError_Corrupt) _then;

/// Create a copy of FormatError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FormatError_Corrupt(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FormatError_Encode extends FormatError {
  const FormatError_Encode(this.field0): super._();
  

@override final  String field0;

/// Create a copy of FormatError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatError_EncodeCopyWith<FormatError_Encode> get copyWith => _$FormatError_EncodeCopyWithImpl<FormatError_Encode>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatError_Encode&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode {
    return Object.hash(runtimeType,field0);
}

@override
String toString() {
    return 'FormatError.encode(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FormatError_EncodeCopyWith<$Res> implements $FormatErrorCopyWith<$Res> {
  factory $FormatError_EncodeCopyWith(FormatError_Encode value, $Res Function(FormatError_Encode) _then) = _$FormatError_EncodeCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$FormatError_EncodeCopyWithImpl<$Res>
    implements $FormatError_EncodeCopyWith<$Res> {
  _$FormatError_EncodeCopyWithImpl(this._self, this._then);

  final FormatError_Encode _self;
  final $Res Function(FormatError_Encode) _then;

/// Create a copy of FormatError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FormatError_Encode(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
