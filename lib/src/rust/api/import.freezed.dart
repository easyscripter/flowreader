// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'import.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportError {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImportError()';
}


}

/// @nodoc
class $ImportErrorCopyWith<$Res>  {
$ImportErrorCopyWith(ImportError _, $Res Function(ImportError) __);
}


/// Adds pattern-matching-related methods to [ImportError].
extension ImportErrorPatterns on ImportError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ImportError_NoTextLayer value)?  noTextLayer,TResult Function( ImportError_Corrupted value)?  corrupted,TResult Function( ImportError_OutOfMemory value)?  outOfMemory,TResult Function( ImportError_Unsupported value)?  unsupported,TResult Function( ImportError_Cancelled value)?  cancelled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ImportError_NoTextLayer() when noTextLayer != null:
return noTextLayer(_that);case ImportError_Corrupted() when corrupted != null:
return corrupted(_that);case ImportError_OutOfMemory() when outOfMemory != null:
return outOfMemory(_that);case ImportError_Unsupported() when unsupported != null:
return unsupported(_that);case ImportError_Cancelled() when cancelled != null:
return cancelled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ImportError_NoTextLayer value)  noTextLayer,required TResult Function( ImportError_Corrupted value)  corrupted,required TResult Function( ImportError_OutOfMemory value)  outOfMemory,required TResult Function( ImportError_Unsupported value)  unsupported,required TResult Function( ImportError_Cancelled value)  cancelled,}){
final _that = this;
switch (_that) {
case ImportError_NoTextLayer():
return noTextLayer(_that);case ImportError_Corrupted():
return corrupted(_that);case ImportError_OutOfMemory():
return outOfMemory(_that);case ImportError_Unsupported():
return unsupported(_that);case ImportError_Cancelled():
return cancelled(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ImportError_NoTextLayer value)?  noTextLayer,TResult? Function( ImportError_Corrupted value)?  corrupted,TResult? Function( ImportError_OutOfMemory value)?  outOfMemory,TResult? Function( ImportError_Unsupported value)?  unsupported,TResult? Function( ImportError_Cancelled value)?  cancelled,}){
final _that = this;
switch (_that) {
case ImportError_NoTextLayer() when noTextLayer != null:
return noTextLayer(_that);case ImportError_Corrupted() when corrupted != null:
return corrupted(_that);case ImportError_OutOfMemory() when outOfMemory != null:
return outOfMemory(_that);case ImportError_Unsupported() when unsupported != null:
return unsupported(_that);case ImportError_Cancelled() when cancelled != null:
return cancelled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  noTextLayer,TResult Function( String field0)?  corrupted,TResult Function()?  outOfMemory,TResult Function( SourceKind field0)?  unsupported,TResult Function()?  cancelled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ImportError_NoTextLayer() when noTextLayer != null:
return noTextLayer();case ImportError_Corrupted() when corrupted != null:
return corrupted(_that.field0);case ImportError_OutOfMemory() when outOfMemory != null:
return outOfMemory();case ImportError_Unsupported() when unsupported != null:
return unsupported(_that.field0);case ImportError_Cancelled() when cancelled != null:
return cancelled();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  noTextLayer,required TResult Function( String field0)  corrupted,required TResult Function()  outOfMemory,required TResult Function( SourceKind field0)  unsupported,required TResult Function()  cancelled,}) {final _that = this;
switch (_that) {
case ImportError_NoTextLayer():
return noTextLayer();case ImportError_Corrupted():
return corrupted(_that.field0);case ImportError_OutOfMemory():
return outOfMemory();case ImportError_Unsupported():
return unsupported(_that.field0);case ImportError_Cancelled():
return cancelled();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  noTextLayer,TResult? Function( String field0)?  corrupted,TResult? Function()?  outOfMemory,TResult? Function( SourceKind field0)?  unsupported,TResult? Function()?  cancelled,}) {final _that = this;
switch (_that) {
case ImportError_NoTextLayer() when noTextLayer != null:
return noTextLayer();case ImportError_Corrupted() when corrupted != null:
return corrupted(_that.field0);case ImportError_OutOfMemory() when outOfMemory != null:
return outOfMemory();case ImportError_Unsupported() when unsupported != null:
return unsupported(_that.field0);case ImportError_Cancelled() when cancelled != null:
return cancelled();case _:
  return null;

}
}

}

/// @nodoc


class ImportError_NoTextLayer extends ImportError {
  const ImportError_NoTextLayer(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportError_NoTextLayer);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImportError.noTextLayer()';
}


}




/// @nodoc


class ImportError_Corrupted extends ImportError {
  const ImportError_Corrupted(this.field0): super._();
  

 final  String field0;

/// Create a copy of ImportError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportError_CorruptedCopyWith<ImportError_Corrupted> get copyWith => _$ImportError_CorruptedCopyWithImpl<ImportError_Corrupted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportError_Corrupted&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'ImportError.corrupted(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ImportError_CorruptedCopyWith<$Res> implements $ImportErrorCopyWith<$Res> {
  factory $ImportError_CorruptedCopyWith(ImportError_Corrupted value, $Res Function(ImportError_Corrupted) _then) = _$ImportError_CorruptedCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$ImportError_CorruptedCopyWithImpl<$Res>
    implements $ImportError_CorruptedCopyWith<$Res> {
  _$ImportError_CorruptedCopyWithImpl(this._self, this._then);

  final ImportError_Corrupted _self;
  final $Res Function(ImportError_Corrupted) _then;

/// Create a copy of ImportError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(ImportError_Corrupted(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ImportError_OutOfMemory extends ImportError {
  const ImportError_OutOfMemory(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportError_OutOfMemory);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImportError.outOfMemory()';
}


}




/// @nodoc


class ImportError_Unsupported extends ImportError {
  const ImportError_Unsupported(this.field0): super._();
  

 final  SourceKind field0;

/// Create a copy of ImportError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportError_UnsupportedCopyWith<ImportError_Unsupported> get copyWith => _$ImportError_UnsupportedCopyWithImpl<ImportError_Unsupported>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportError_Unsupported&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'ImportError.unsupported(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ImportError_UnsupportedCopyWith<$Res> implements $ImportErrorCopyWith<$Res> {
  factory $ImportError_UnsupportedCopyWith(ImportError_Unsupported value, $Res Function(ImportError_Unsupported) _then) = _$ImportError_UnsupportedCopyWithImpl;
@useResult
$Res call({
 SourceKind field0
});




}
/// @nodoc
class _$ImportError_UnsupportedCopyWithImpl<$Res>
    implements $ImportError_UnsupportedCopyWith<$Res> {
  _$ImportError_UnsupportedCopyWithImpl(this._self, this._then);

  final ImportError_Unsupported _self;
  final $Res Function(ImportError_Unsupported) _then;

/// Create a copy of ImportError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(ImportError_Unsupported(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as SourceKind,
  ));
}


}

/// @nodoc


class ImportError_Cancelled extends ImportError {
  const ImportError_Cancelled(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportError_Cancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImportError.cancelled()';
}


}




/// @nodoc
mixin _$ImportEvent {

 Object get field0;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportEvent&&const DeepCollectionEquality().equals(other.field0, field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'ImportEvent(field0: $field0)';
}


}

/// @nodoc
class $ImportEventCopyWith<$Res>  {
$ImportEventCopyWith(ImportEvent _, $Res Function(ImportEvent) __);
}


/// Adds pattern-matching-related methods to [ImportEvent].
extension ImportEventPatterns on ImportEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ImportEvent_Started value)?  started,TResult Function( ImportEvent_Progress value)?  progress,TResult Function( ImportEvent_Done value)?  done,TResult Function( ImportEvent_Failed value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ImportEvent_Started() when started != null:
return started(_that);case ImportEvent_Progress() when progress != null:
return progress(_that);case ImportEvent_Done() when done != null:
return done(_that);case ImportEvent_Failed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ImportEvent_Started value)  started,required TResult Function( ImportEvent_Progress value)  progress,required TResult Function( ImportEvent_Done value)  done,required TResult Function( ImportEvent_Failed value)  failed,}){
final _that = this;
switch (_that) {
case ImportEvent_Started():
return started(_that);case ImportEvent_Progress():
return progress(_that);case ImportEvent_Done():
return done(_that);case ImportEvent_Failed():
return failed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ImportEvent_Started value)?  started,TResult? Function( ImportEvent_Progress value)?  progress,TResult? Function( ImportEvent_Done value)?  done,TResult? Function( ImportEvent_Failed value)?  failed,}){
final _that = this;
switch (_that) {
case ImportEvent_Started() when started != null:
return started(_that);case ImportEvent_Progress() when progress != null:
return progress(_that);case ImportEvent_Done() when done != null:
return done(_that);case ImportEvent_Failed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( PlatformInt64 field0)?  started,TResult Function( Progress field0)?  progress,TResult Function( Uint8List field0)?  done,TResult Function( ImportError field0)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ImportEvent_Started() when started != null:
return started(_that.field0);case ImportEvent_Progress() when progress != null:
return progress(_that.field0);case ImportEvent_Done() when done != null:
return done(_that.field0);case ImportEvent_Failed() when failed != null:
return failed(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( PlatformInt64 field0)  started,required TResult Function( Progress field0)  progress,required TResult Function( Uint8List field0)  done,required TResult Function( ImportError field0)  failed,}) {final _that = this;
switch (_that) {
case ImportEvent_Started():
return started(_that.field0);case ImportEvent_Progress():
return progress(_that.field0);case ImportEvent_Done():
return done(_that.field0);case ImportEvent_Failed():
return failed(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( PlatformInt64 field0)?  started,TResult? Function( Progress field0)?  progress,TResult? Function( Uint8List field0)?  done,TResult? Function( ImportError field0)?  failed,}) {final _that = this;
switch (_that) {
case ImportEvent_Started() when started != null:
return started(_that.field0);case ImportEvent_Progress() when progress != null:
return progress(_that.field0);case ImportEvent_Done() when done != null:
return done(_that.field0);case ImportEvent_Failed() when failed != null:
return failed(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class ImportEvent_Started extends ImportEvent {
  const ImportEvent_Started(this.field0): super._();
  

@override final  PlatformInt64 field0;

/// Create a copy of ImportEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportEvent_StartedCopyWith<ImportEvent_Started> get copyWith => _$ImportEvent_StartedCopyWithImpl<ImportEvent_Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportEvent_Started&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'ImportEvent.started(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ImportEvent_StartedCopyWith<$Res> implements $ImportEventCopyWith<$Res> {
  factory $ImportEvent_StartedCopyWith(ImportEvent_Started value, $Res Function(ImportEvent_Started) _then) = _$ImportEvent_StartedCopyWithImpl;
@useResult
$Res call({
 PlatformInt64 field0
});




}
/// @nodoc
class _$ImportEvent_StartedCopyWithImpl<$Res>
    implements $ImportEvent_StartedCopyWith<$Res> {
  _$ImportEvent_StartedCopyWithImpl(this._self, this._then);

  final ImportEvent_Started _self;
  final $Res Function(ImportEvent_Started) _then;

/// Create a copy of ImportEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(ImportEvent_Started(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as PlatformInt64,
  ));
}


}

/// @nodoc


class ImportEvent_Progress extends ImportEvent {
  const ImportEvent_Progress(this.field0): super._();
  

@override final  Progress field0;

/// Create a copy of ImportEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportEvent_ProgressCopyWith<ImportEvent_Progress> get copyWith => _$ImportEvent_ProgressCopyWithImpl<ImportEvent_Progress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportEvent_Progress&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'ImportEvent.progress(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ImportEvent_ProgressCopyWith<$Res> implements $ImportEventCopyWith<$Res> {
  factory $ImportEvent_ProgressCopyWith(ImportEvent_Progress value, $Res Function(ImportEvent_Progress) _then) = _$ImportEvent_ProgressCopyWithImpl;
@useResult
$Res call({
 Progress field0
});




}
/// @nodoc
class _$ImportEvent_ProgressCopyWithImpl<$Res>
    implements $ImportEvent_ProgressCopyWith<$Res> {
  _$ImportEvent_ProgressCopyWithImpl(this._self, this._then);

  final ImportEvent_Progress _self;
  final $Res Function(ImportEvent_Progress) _then;

/// Create a copy of ImportEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(ImportEvent_Progress(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as Progress,
  ));
}


}

/// @nodoc


class ImportEvent_Done extends ImportEvent {
  const ImportEvent_Done(this.field0): super._();
  

@override final  Uint8List field0;

/// Create a copy of ImportEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportEvent_DoneCopyWith<ImportEvent_Done> get copyWith => _$ImportEvent_DoneCopyWithImpl<ImportEvent_Done>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportEvent_Done&&const DeepCollectionEquality().equals(other.field0, field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'ImportEvent.done(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ImportEvent_DoneCopyWith<$Res> implements $ImportEventCopyWith<$Res> {
  factory $ImportEvent_DoneCopyWith(ImportEvent_Done value, $Res Function(ImportEvent_Done) _then) = _$ImportEvent_DoneCopyWithImpl;
@useResult
$Res call({
 Uint8List field0
});




}
/// @nodoc
class _$ImportEvent_DoneCopyWithImpl<$Res>
    implements $ImportEvent_DoneCopyWith<$Res> {
  _$ImportEvent_DoneCopyWithImpl(this._self, this._then);

  final ImportEvent_Done _self;
  final $Res Function(ImportEvent_Done) _then;

/// Create a copy of ImportEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(ImportEvent_Done(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc


class ImportEvent_Failed extends ImportEvent {
  const ImportEvent_Failed(this.field0): super._();
  

@override final  ImportError field0;

/// Create a copy of ImportEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportEvent_FailedCopyWith<ImportEvent_Failed> get copyWith => _$ImportEvent_FailedCopyWithImpl<ImportEvent_Failed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportEvent_Failed&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'ImportEvent.failed(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ImportEvent_FailedCopyWith<$Res> implements $ImportEventCopyWith<$Res> {
  factory $ImportEvent_FailedCopyWith(ImportEvent_Failed value, $Res Function(ImportEvent_Failed) _then) = _$ImportEvent_FailedCopyWithImpl;
@useResult
$Res call({
 ImportError field0
});


$ImportErrorCopyWith<$Res> get field0;

}
/// @nodoc
class _$ImportEvent_FailedCopyWithImpl<$Res>
    implements $ImportEvent_FailedCopyWith<$Res> {
  _$ImportEvent_FailedCopyWithImpl(this._self, this._then);

  final ImportEvent_Failed _self;
  final $Res Function(ImportEvent_Failed) _then;

/// Create a copy of ImportEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(ImportEvent_Failed(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as ImportError,
  ));
}

/// Create a copy of ImportEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImportErrorCopyWith<$Res> get field0 {
  
  return $ImportErrorCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}

// dart format on
