// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'movie_rating_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MovieRatingModel _$MovieRatingModelFromJson(Map<String, dynamic> json) {
  return _MovieRatingModel.fromJson(json);
}

/// @nodoc
mixin _$MovieRatingModel {
  String? get userId => throw _privateConstructorUsedError;
  String? get movieId => throw _privateConstructorUsedError;
  String? get star => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  int? get createAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovieRatingModelCopyWith<MovieRatingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieRatingModelCopyWith<$Res> {
  factory $MovieRatingModelCopyWith(
          MovieRatingModel value, $Res Function(MovieRatingModel) then) =
      _$MovieRatingModelCopyWithImpl<$Res, MovieRatingModel>;
  @useResult
  $Res call(
      {String? userId,
      String? movieId,
      String? star,
      String? comment,
      int? createAt});
}

/// @nodoc
class _$MovieRatingModelCopyWithImpl<$Res, $Val extends MovieRatingModel>
    implements $MovieRatingModelCopyWith<$Res> {
  _$MovieRatingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? movieId = freezed,
    Object? star = freezed,
    Object? comment = freezed,
    Object? createAt = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      movieId: freezed == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as String?,
      star: freezed == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MovieRatingModelCopyWith<$Res>
    implements $MovieRatingModelCopyWith<$Res> {
  factory _$$_MovieRatingModelCopyWith(
          _$_MovieRatingModel value, $Res Function(_$_MovieRatingModel) then) =
      __$$_MovieRatingModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? userId,
      String? movieId,
      String? star,
      String? comment,
      int? createAt});
}

/// @nodoc
class __$$_MovieRatingModelCopyWithImpl<$Res>
    extends _$MovieRatingModelCopyWithImpl<$Res, _$_MovieRatingModel>
    implements _$$_MovieRatingModelCopyWith<$Res> {
  __$$_MovieRatingModelCopyWithImpl(
      _$_MovieRatingModel _value, $Res Function(_$_MovieRatingModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? movieId = freezed,
    Object? star = freezed,
    Object? comment = freezed,
    Object? createAt = freezed,
  }) {
    return _then(_$_MovieRatingModel(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      movieId: freezed == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as String?,
      star: freezed == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MovieRatingModel extends _MovieRatingModel {
  const _$_MovieRatingModel(
      {this.userId, this.movieId, this.star, this.comment, this.createAt})
      : super._();

  factory _$_MovieRatingModel.fromJson(Map<String, dynamic> json) =>
      _$$_MovieRatingModelFromJson(json);

  @override
  final String? userId;
  @override
  final String? movieId;
  @override
  final String? star;
  @override
  final String? comment;
  @override
  final int? createAt;

  @override
  String toString() {
    return 'MovieRatingModel(userId: $userId, movieId: $movieId, star: $star, comment: $comment, createAt: $createAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MovieRatingModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.movieId, movieId) || other.movieId == movieId) &&
            (identical(other.star, star) || other.star == star) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, movieId, star, comment, createAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MovieRatingModelCopyWith<_$_MovieRatingModel> get copyWith =>
      __$$_MovieRatingModelCopyWithImpl<_$_MovieRatingModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MovieRatingModelToJson(
      this,
    );
  }
}

abstract class _MovieRatingModel extends MovieRatingModel {
  const factory _MovieRatingModel(
      {final String? userId,
      final String? movieId,
      final String? star,
      final String? comment,
      final int? createAt}) = _$_MovieRatingModel;
  const _MovieRatingModel._() : super._();

  factory _MovieRatingModel.fromJson(Map<String, dynamic> json) =
      _$_MovieRatingModel.fromJson;

  @override
  String? get userId;
  @override
  String? get movieId;
  @override
  String? get star;
  @override
  String? get comment;
  @override
  int? get createAt;
  @override
  @JsonKey(ignore: true)
  _$$_MovieRatingModelCopyWith<_$_MovieRatingModel> get copyWith =>
      throw _privateConstructorUsedError;
}
