// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_tab_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeTabState {

 String get address; List<PostEntity> get posts;
/// Create a copy of HomeTabState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeTabStateCopyWith<HomeTabState> get copyWith => _$HomeTabStateCopyWithImpl<HomeTabState>(this as HomeTabState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeTabState&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other.posts, posts));
}


@override
int get hashCode => Object.hash(runtimeType,address,const DeepCollectionEquality().hash(posts));

@override
String toString() {
  return 'HomeTabState(address: $address, posts: $posts)';
}


}

/// @nodoc
abstract mixin class $HomeTabStateCopyWith<$Res>  {
  factory $HomeTabStateCopyWith(HomeTabState value, $Res Function(HomeTabState) _then) = _$HomeTabStateCopyWithImpl;
@useResult
$Res call({
 String address, List<PostEntity> posts
});




}
/// @nodoc
class _$HomeTabStateCopyWithImpl<$Res>
    implements $HomeTabStateCopyWith<$Res> {
  _$HomeTabStateCopyWithImpl(this._self, this._then);

  final HomeTabState _self;
  final $Res Function(HomeTabState) _then;

/// Create a copy of HomeTabState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,Object? posts = null,}) {
  return _then(_self.copyWith(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<PostEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeTabState].
extension HomeTabStatePatterns on HomeTabState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeTabState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeTabState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeTabState value)  $default,){
final _that = this;
switch (_that) {
case _HomeTabState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeTabState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeTabState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String address,  List<PostEntity> posts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeTabState() when $default != null:
return $default(_that.address,_that.posts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String address,  List<PostEntity> posts)  $default,) {final _that = this;
switch (_that) {
case _HomeTabState():
return $default(_that.address,_that.posts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String address,  List<PostEntity> posts)?  $default,) {final _that = this;
switch (_that) {
case _HomeTabState() when $default != null:
return $default(_that.address,_that.posts);case _:
  return null;

}
}

}

/// @nodoc


class _HomeTabState implements HomeTabState {
  const _HomeTabState({this.address = '', final  List<PostEntity> posts = const []}): _posts = posts;
  

@override@JsonKey() final  String address;
 final  List<PostEntity> _posts;
@override@JsonKey() List<PostEntity> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}


/// Create a copy of HomeTabState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeTabStateCopyWith<_HomeTabState> get copyWith => __$HomeTabStateCopyWithImpl<_HomeTabState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeTabState&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other._posts, _posts));
}


@override
int get hashCode => Object.hash(runtimeType,address,const DeepCollectionEquality().hash(_posts));

@override
String toString() {
  return 'HomeTabState(address: $address, posts: $posts)';
}


}

/// @nodoc
abstract mixin class _$HomeTabStateCopyWith<$Res> implements $HomeTabStateCopyWith<$Res> {
  factory _$HomeTabStateCopyWith(_HomeTabState value, $Res Function(_HomeTabState) _then) = __$HomeTabStateCopyWithImpl;
@override @useResult
$Res call({
 String address, List<PostEntity> posts
});




}
/// @nodoc
class __$HomeTabStateCopyWithImpl<$Res>
    implements _$HomeTabStateCopyWith<$Res> {
  __$HomeTabStateCopyWithImpl(this._self, this._then);

  final _HomeTabState _self;
  final $Res Function(_HomeTabState) _then;

/// Create a copy of HomeTabState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? posts = null,}) {
  return _then(_HomeTabState(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<PostEntity>,
  ));
}


}

// dart format on
