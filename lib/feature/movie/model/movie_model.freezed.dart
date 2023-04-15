// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'movie_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return _MovieModel.fromJson(json);
}

/// @nodoc
mixin _$MovieModel {
  String? get id => throw _privateConstructorUsedError;
  CategoryModel? get category => throw _privateConstructorUsedError;
  String? get movieNameVi => throw _privateConstructorUsedError;
  String? get movieNameEn => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  String? get director => throw _privateConstructorUsedError;
  String? get actor => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  bool? get active => throw _privateConstructorUsedError;
  int? get startTime => throw _privateConstructorUsedError;
  int? get endTime => throw _privateConstructorUsedError;
  int? get createAt => throw _privateConstructorUsedError;
  int? get updateAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MovieModelCopyWith<MovieModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieModelCopyWith<$Res> {
  factory $MovieModelCopyWith(
          MovieModel value, $Res Function(MovieModel) then) =
      _$MovieModelCopyWithImpl<$Res, MovieModel>;
  @useResult
  $Res call(
      {String? id,
      CategoryModel? category,
      String? movieNameVi,
      String? movieNameEn,
      String? image,
      String? description,
      String? duration,
      String? director,
      String? actor,
      String? type,
      bool? active,
      int? startTime,
      int? endTime,
      int? createAt,
      int? updateAt});

  $CategoryModelCopyWith<$Res>? get category;
}

/// @nodoc
class _$MovieModelCopyWithImpl<$Res, $Val extends MovieModel>
    implements $MovieModelCopyWith<$Res> {
  _$MovieModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? category = freezed,
    Object? movieNameVi = freezed,
    Object? movieNameEn = freezed,
    Object? image = freezed,
    Object? description = freezed,
    Object? duration = freezed,
    Object? director = freezed,
    Object? actor = freezed,
    Object? type = freezed,
    Object? active = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? createAt = freezed,
    Object? updateAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
      movieNameVi: freezed == movieNameVi
          ? _value.movieNameVi
          : movieNameVi // ignore: cast_nullable_to_non_nullable
              as String?,
      movieNameEn: freezed == movieNameEn
          ? _value.movieNameEn
          : movieNameEn // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      director: freezed == director
          ? _value.director
          : director // ignore: cast_nullable_to_non_nullable
              as String?,
      actor: freezed == actor
          ? _value.actor
          : actor // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as int?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as int?,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as int?,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryModelCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryModelCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MovieModelCopyWith<$Res>
    implements $MovieModelCopyWith<$Res> {
  factory _$$_MovieModelCopyWith(
          _$_MovieModel value, $Res Function(_$_MovieModel) then) =
      __$$_MovieModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      CategoryModel? category,
      String? movieNameVi,
      String? movieNameEn,
      String? image,
      String? description,
      String? duration,
      String? director,
      String? actor,
      String? type,
      bool? active,
      int? startTime,
      int? endTime,
      int? createAt,
      int? updateAt});

  @override
  $CategoryModelCopyWith<$Res>? get category;
}

/// @nodoc
class __$$_MovieModelCopyWithImpl<$Res>
    extends _$MovieModelCopyWithImpl<$Res, _$_MovieModel>
    implements _$$_MovieModelCopyWith<$Res> {
  __$$_MovieModelCopyWithImpl(
      _$_MovieModel _value, $Res Function(_$_MovieModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? category = freezed,
    Object? movieNameVi = freezed,
    Object? movieNameEn = freezed,
    Object? image = freezed,
    Object? description = freezed,
    Object? duration = freezed,
    Object? director = freezed,
    Object? actor = freezed,
    Object? type = freezed,
    Object? active = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? createAt = freezed,
    Object? updateAt = freezed,
  }) {
    return _then(_$_MovieModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
      movieNameVi: freezed == movieNameVi
          ? _value.movieNameVi
          : movieNameVi // ignore: cast_nullable_to_non_nullable
              as String?,
      movieNameEn: freezed == movieNameEn
          ? _value.movieNameEn
          : movieNameEn // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      director: freezed == director
          ? _value.director
          : director // ignore: cast_nullable_to_non_nullable
              as String?,
      actor: freezed == actor
          ? _value.actor
          : actor // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as int?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as int?,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as int?,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MovieModel extends _MovieModel {
  const _$_MovieModel(
      {this.id,
      this.category,
      this.movieNameVi,
      this.movieNameEn,
      this.image,
      this.description,
      this.duration,
      this.director,
      this.actor,
      this.type,
      this.active = true,
      this.startTime,
      this.endTime,
      this.createAt,
      this.updateAt})
      : super._();

  factory _$_MovieModel.fromJson(Map<String, dynamic> json) =>
      _$$_MovieModelFromJson(json);

  @override
  final String? id;
  @override
  final CategoryModel? category;
  @override
  final String? movieNameVi;
  @override
  final String? movieNameEn;
  @override
  final String? image;
  @override
  final String? description;
  @override
  final String? duration;
  @override
  final String? director;
  @override
  final String? actor;
  @override
  final String? type;
  @override
  @JsonKey()
  final bool? active;
  @override
  final int? startTime;
  @override
  final int? endTime;
  @override
  final int? createAt;
  @override
  final int? updateAt;

  @override
  String toString() {
    return 'MovieModel(id: $id, category: $category, movieNameVi: $movieNameVi, movieNameEn: $movieNameEn, image: $image, description: $description, duration: $duration, director: $director, actor: $actor, type: $type, active: $active, startTime: $startTime, endTime: $endTime, createAt: $createAt, updateAt: $updateAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MovieModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.movieNameVi, movieNameVi) ||
                other.movieNameVi == movieNameVi) &&
            (identical(other.movieNameEn, movieNameEn) ||
                other.movieNameEn == movieNameEn) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.director, director) ||
                other.director == director) &&
            (identical(other.actor, actor) || other.actor == actor) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.updateAt, updateAt) ||
                other.updateAt == updateAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      category,
      movieNameVi,
      movieNameEn,
      image,
      description,
      duration,
      director,
      actor,
      type,
      active,
      startTime,
      endTime,
      createAt,
      updateAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MovieModelCopyWith<_$_MovieModel> get copyWith =>
      __$$_MovieModelCopyWithImpl<_$_MovieModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MovieModelToJson(
      this,
    );
  }
}

abstract class _MovieModel extends MovieModel {
  const factory _MovieModel(
      {final String? id,
      final CategoryModel? category,
      final String? movieNameVi,
      final String? movieNameEn,
      final String? image,
      final String? description,
      final String? duration,
      final String? director,
      final String? actor,
      final String? type,
      final bool? active,
      final int? startTime,
      final int? endTime,
      final int? createAt,
      final int? updateAt}) = _$_MovieModel;
  const _MovieModel._() : super._();

  factory _MovieModel.fromJson(Map<String, dynamic> json) =
      _$_MovieModel.fromJson;

  @override
  String? get id;
  @override
  CategoryModel? get category;
  @override
  String? get movieNameVi;
  @override
  String? get movieNameEn;
  @override
  String? get image;
  @override
  String? get description;
  @override
  String? get duration;
  @override
  String? get director;
  @override
  String? get actor;
  @override
  String? get type;
  @override
  bool? get active;
  @override
  int? get startTime;
  @override
  int? get endTime;
  @override
  int? get createAt;
  @override
  int? get updateAt;
  @override
  @JsonKey(ignore: true)
  _$$_MovieModelCopyWith<_$_MovieModel> get copyWith =>
      throw _privateConstructorUsedError;
}
