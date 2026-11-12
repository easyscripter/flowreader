// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookEntry {

 String get id; String get title; List<String> get authors; BookFormat get format; String get sourceHash; String get converterVersion; DateTime get addedAt; ReadingPosition get position; double get progress; String? get language; DateTime? get lastReadAt;
/// Create a copy of BookEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookEntryCopyWith<BookEntry> get copyWith => _$BookEntryCopyWithImpl<BookEntry>(this as BookEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BookEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&const DeepCollectionEquality().equals(other.authors, _this.authors)&&(identical(other.format, _this.format) || other.format == _this.format)&&(identical(other.sourceHash, _this.sourceHash) || other.sourceHash == _this.sourceHash)&&(identical(other.converterVersion, _this.converterVersion) || other.converterVersion == _this.converterVersion)&&(identical(other.addedAt, _this.addedAt) || other.addedAt == _this.addedAt)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.language, _this.language) || other.language == _this.language)&&(identical(other.lastReadAt, _this.lastReadAt) || other.lastReadAt == _this.lastReadAt));
}


@override
int get hashCode {
  final _this = this as BookEntry;
  return Object.hash(runtimeType,_this.id,_this.title,const DeepCollectionEquality().hash(_this.authors),_this.format,_this.sourceHash,_this.converterVersion,_this.addedAt,_this.position,_this.progress,_this.language,_this.lastReadAt);
}

@override
String toString() {
  final _this = this as BookEntry;
  return 'BookEntry(id: ${_this.id}, title: ${_this.title}, authors: ${_this.authors}, format: ${_this.format}, sourceHash: ${_this.sourceHash}, converterVersion: ${_this.converterVersion}, addedAt: ${_this.addedAt}, position: ${_this.position}, progress: ${_this.progress}, language: ${_this.language}, lastReadAt: ${_this.lastReadAt})';
}


}

/// @nodoc
abstract mixin class $BookEntryCopyWith<$Res>  {
  factory $BookEntryCopyWith(BookEntry value, $Res Function(BookEntry) _then) = _$BookEntryCopyWithImpl;
@useResult
$Res call({
 String id, String title, List<String> authors, BookFormat format, String sourceHash, String converterVersion, DateTime addedAt, ReadingPosition position, double progress, String? language, DateTime? lastReadAt
});


$ReadingPositionCopyWith<$Res> get position;

}
/// @nodoc
class _$BookEntryCopyWithImpl<$Res>
    implements $BookEntryCopyWith<$Res> {
  _$BookEntryCopyWithImpl(this._self, this._then);

  final BookEntry _self;
  final $Res Function(BookEntry) _then;

/// Create a copy of BookEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? authors = null,Object? format = null,Object? sourceHash = null,Object? converterVersion = null,Object? addedAt = null,Object? position = null,Object? progress = null,Object? language = freezed,Object? lastReadAt = freezed,}) {
  return _then(BookEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,authors: null == authors ? _self.authors : authors // ignore: cast_nullable_to_non_nullable
as List<String>,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as BookFormat,sourceHash: null == sourceHash ? _self.sourceHash : sourceHash // ignore: cast_nullable_to_non_nullable
as String,converterVersion: null == converterVersion ? _self.converterVersion : converterVersion // ignore: cast_nullable_to_non_nullable
as String,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as ReadingPosition,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,lastReadAt: freezed == lastReadAt ? _self.lastReadAt : lastReadAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of BookEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReadingPositionCopyWith<$Res> get position {
  
  return $ReadingPositionCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookEntry].
extension BookEntryPatterns on BookEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookEntry value)  $default,){
final _that = this;
switch (_that) {
case _BookEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookEntry value)?  $default,){
final _that = this;
switch (_that) {
case _BookEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  List<String> authors,  BookFormat format,  String sourceHash,  String converterVersion,  DateTime addedAt,  ReadingPosition position,  double progress,  String? language,  DateTime? lastReadAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookEntry() when $default != null:
return $default(_that.id,_that.title,_that.authors,_that.format,_that.sourceHash,_that.converterVersion,_that.addedAt,_that.position,_that.progress,_that.language,_that.lastReadAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  List<String> authors,  BookFormat format,  String sourceHash,  String converterVersion,  DateTime addedAt,  ReadingPosition position,  double progress,  String? language,  DateTime? lastReadAt)  $default,) {final _that = this;
switch (_that) {
case _BookEntry():
return $default(_that.id,_that.title,_that.authors,_that.format,_that.sourceHash,_that.converterVersion,_that.addedAt,_that.position,_that.progress,_that.language,_that.lastReadAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  List<String> authors,  BookFormat format,  String sourceHash,  String converterVersion,  DateTime addedAt,  ReadingPosition position,  double progress,  String? language,  DateTime? lastReadAt)?  $default,) {final _that = this;
switch (_that) {
case _BookEntry() when $default != null:
return $default(_that.id,_that.title,_that.authors,_that.format,_that.sourceHash,_that.converterVersion,_that.addedAt,_that.position,_that.progress,_that.language,_that.lastReadAt);case _:
  return null;

}
}

}

/// @nodoc


class _BookEntry implements BookEntry {
  const _BookEntry({required this.id, required this.title, required  List<String> authors, required this.format, required this.sourceHash, required this.converterVersion, required this.addedAt, required this.position, required this.progress, this.language, this.lastReadAt}): _authors = authors;
  

@override final  String id;
@override final  String title;
 final  List<String> _authors;
@override List<String> get authors {
  if (_authors is EqualUnmodifiableListView) return _authors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_authors);
}

@override final  BookFormat format;
@override final  String sourceHash;
@override final  String converterVersion;
@override final  DateTime addedAt;
@override final  ReadingPosition position;
@override final  double progress;
@override final  String? language;
@override final  DateTime? lastReadAt;

/// Create a copy of BookEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookEntryCopyWith<_BookEntry> get copyWith => __$BookEntryCopyWithImpl<_BookEntry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.authors, _authors)&&(identical(other.format, format) || other.format == format)&&(identical(other.sourceHash, sourceHash) || other.sourceHash == sourceHash)&&(identical(other.converterVersion, converterVersion) || other.converterVersion == converterVersion)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt)&&(identical(other.position, position) || other.position == position)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.language, language) || other.language == language)&&(identical(other.lastReadAt, lastReadAt) || other.lastReadAt == lastReadAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_authors),format,sourceHash,converterVersion,addedAt,position,progress,language,lastReadAt);
}

@override
String toString() {
    return 'BookEntry(id: $id, title: $title, authors: $authors, format: $format, sourceHash: $sourceHash, converterVersion: $converterVersion, addedAt: $addedAt, position: $position, progress: $progress, language: $language, lastReadAt: $lastReadAt)';
}


}

/// @nodoc
abstract mixin class _$BookEntryCopyWith<$Res> implements $BookEntryCopyWith<$Res> {
  factory _$BookEntryCopyWith(_BookEntry value, $Res Function(_BookEntry) _then) = __$BookEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<String> authors, BookFormat format, String sourceHash, String converterVersion, DateTime addedAt, ReadingPosition position, double progress, String? language, DateTime? lastReadAt
});


@override $ReadingPositionCopyWith<$Res> get position;

}
/// @nodoc
class __$BookEntryCopyWithImpl<$Res>
    implements _$BookEntryCopyWith<$Res> {
  __$BookEntryCopyWithImpl(this._self, this._then);

  final _BookEntry _self;
  final $Res Function(_BookEntry) _then;

/// Create a copy of BookEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? authors = null,Object? format = null,Object? sourceHash = null,Object? converterVersion = null,Object? addedAt = null,Object? position = null,Object? progress = null,Object? language = freezed,Object? lastReadAt = freezed,}) {
  return _then(_BookEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,authors: null == authors ? _self._authors : authors // ignore: cast_nullable_to_non_nullable
as List<String>,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as BookFormat,sourceHash: null == sourceHash ? _self.sourceHash : sourceHash // ignore: cast_nullable_to_non_nullable
as String,converterVersion: null == converterVersion ? _self.converterVersion : converterVersion // ignore: cast_nullable_to_non_nullable
as String,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as ReadingPosition,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,lastReadAt: freezed == lastReadAt ? _self.lastReadAt : lastReadAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of BookEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReadingPositionCopyWith<$Res> get position {
  
  return $ReadingPositionCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}

// dart format on
