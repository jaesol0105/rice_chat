// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_write_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PostWriteState {

 List<XFile> get images;// 선택한 이미지 리스트
 String get title; List<String> get tags; String get content; bool get loading;
/// Create a copy of PostWriteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostWriteStateCopyWith<PostWriteState> get copyWith => _$PostWriteStateCopyWithImpl<PostWriteState>(this as PostWriteState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostWriteState&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.content, content) || other.content == content)&&(identical(other.loading, loading) || other.loading == loading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(images),title,const DeepCollectionEquality().hash(tags),content,loading);

@override
String toString() {
  return 'PostWriteState(images: $images, title: $title, tags: $tags, content: $content, loading: $loading)';
}


}

/// @nodoc
abstract mixin class $PostWriteStateCopyWith<$Res>  {
  factory $PostWriteStateCopyWith(PostWriteState value, $Res Function(PostWriteState) _then) = _$PostWriteStateCopyWithImpl;
@useResult
$Res call({
 List<XFile> images, String title, List<String> tags, String content, bool loading
});




}
/// @nodoc
class _$PostWriteStateCopyWithImpl<$Res>
    implements $PostWriteStateCopyWith<$Res> {
  _$PostWriteStateCopyWithImpl(this._self, this._then);

  final PostWriteState _self;
  final $Res Function(PostWriteState) _then;

/// Create a copy of PostWriteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? images = null,Object? title = null,Object? tags = null,Object? content = null,Object? loading = null,}) {
  return _then(_self.copyWith(
images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<XFile>,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PostWriteState].
extension PostWriteStatePatterns on PostWriteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostWriteState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostWriteState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostWriteState value)  $default,){
final _that = this;
switch (_that) {
case _PostWriteState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostWriteState value)?  $default,){
final _that = this;
switch (_that) {
case _PostWriteState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<XFile> images,  String title,  List<String> tags,  String content,  bool loading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostWriteState() when $default != null:
return $default(_that.images,_that.title,_that.tags,_that.content,_that.loading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<XFile> images,  String title,  List<String> tags,  String content,  bool loading)  $default,) {final _that = this;
switch (_that) {
case _PostWriteState():
return $default(_that.images,_that.title,_that.tags,_that.content,_that.loading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<XFile> images,  String title,  List<String> tags,  String content,  bool loading)?  $default,) {final _that = this;
switch (_that) {
case _PostWriteState() when $default != null:
return $default(_that.images,_that.title,_that.tags,_that.content,_that.loading);case _:
  return null;

}
}

}

/// @nodoc


class _PostWriteState extends PostWriteState {
  const _PostWriteState({final  List<XFile> images = const [], this.title = '', final  List<String> tags = const [], this.content = '', this.loading = false}): _images = images,_tags = tags,super._();
  

 final  List<XFile> _images;
@override@JsonKey() List<XFile> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

// 선택한 이미지 리스트
@override@JsonKey() final  String title;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  String content;
@override@JsonKey() final  bool loading;

/// Create a copy of PostWriteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostWriteStateCopyWith<_PostWriteState> get copyWith => __$PostWriteStateCopyWithImpl<_PostWriteState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostWriteState&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.content, content) || other.content == content)&&(identical(other.loading, loading) || other.loading == loading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_images),title,const DeepCollectionEquality().hash(_tags),content,loading);

@override
String toString() {
  return 'PostWriteState(images: $images, title: $title, tags: $tags, content: $content, loading: $loading)';
}


}

/// @nodoc
abstract mixin class _$PostWriteStateCopyWith<$Res> implements $PostWriteStateCopyWith<$Res> {
  factory _$PostWriteStateCopyWith(_PostWriteState value, $Res Function(_PostWriteState) _then) = __$PostWriteStateCopyWithImpl;
@override @useResult
$Res call({
 List<XFile> images, String title, List<String> tags, String content, bool loading
});




}
/// @nodoc
class __$PostWriteStateCopyWithImpl<$Res>
    implements _$PostWriteStateCopyWith<$Res> {
  __$PostWriteStateCopyWithImpl(this._self, this._then);

  final _PostWriteState _self;
  final $Res Function(_PostWriteState) _then;

/// Create a copy of PostWriteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? images = null,Object? title = null,Object? tags = null,Object? content = null,Object? loading = null,}) {
  return _then(_PostWriteState(
images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<XFile>,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
