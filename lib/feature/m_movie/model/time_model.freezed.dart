// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'time_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TimeModel _$TimeModelFromJson(Map<String, dynamic> json) {
  return _TimeModel.fromJson(json);
}

/// @nodoc
mixin _$TimeModel {
  String? get id => throw _privateConstructorUsedError;
  String? get movieId => throw _privateConstructorUsedError;
  String? get roomId => throw _privateConstructorUsedError;
  int? get from => throw _privateConstructorUsedError;
  int? get to => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeModelCopyWith<TimeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeModelCopyWith<$Res> {
  factory $TimeModelCopyWith(TimeModel value, $Res Function(TimeModel) then) =
      _$TimeModelCopyWithImpl<$Res, TimeModel>;
  @useResult
  $Res call({String? id, String? movieId, String? roomId, int? from, int? to});
}

/// @nodoc
class _$TimeModelCopyWithImpl<$Res, $Val extends TimeModel>
    implements $TimeModelCopyWith<$Res> {
  _$TimeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? movieId = freezed,
    Object? roomId = freezed,
    Object? from = freezed,
    Object? to = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      movieId: freezed == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as int?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TimeModelCopyWith<$Res> implements $TimeModelCopyWith<$Res> {
  factory _$$_TimeModelCopyWith(
          _$_TimeModel value, $Res Function(_$_TimeModel) then) =
      __$$_TimeModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? movieId, String? roomId, int? from, int? to});
}

/// @nodoc
class __$$_TimeModelCopyWithImpl<$Res>
    extends _$TimeModelCopyWithImpl<$Res, _$_TimeModel>
    implements _$$_TimeModelCopyWith<$Res> {
  __$$_TimeModelCopyWithImpl(
      _$_TimeModel _value, $Res Function(_$_TimeModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? movieId = freezed,
    Object? roomId = freezed,
    Object? from = freezed,
    Object? to = freezed,
  }) {
    return _then(_$_TimeModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      movieId: freezed == movieId
          ? _value.movieId
          : movieId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as int?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TimeModel extends _TimeModel {
  const _$_TimeModel({this.id, this.movieId, this.roomId, this.from, this.to})
      : super._();

  factory _$_TimeModel.fromJson(Map<String, dynamic> json) =>
      _$$_TimeModelFromJson(json);

  @override
  final String? id;
  @override
  final String? movieId;
  @override
  final String? roomId;
  @override
  final int? from;
  @override
  final int? to;

  @override
  String toString() {
    return 'TimeModel(id: $id, movieId: $movieId, roomId: $roomId, from: $from, to: $to)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TimeModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.movieId, movieId) || other.movieId == movieId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, movieId, roomId, from, to);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TimeModelCopyWith<_$_TimeModel> get copyWith =>
      __$$_TimeModelCopyWithImpl<_$_TimeModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TimeModelToJson(
      this,
    );
  }
}

abstract class _TimeModel extends TimeModel {
  const factory _TimeModel(
      {final String? id,
      final String? movieId,
      final String? roomId,
      final int? from,
      final int? to}) = _$_TimeModel;
  const _TimeModel._() : super._();

  factory _TimeModel.fromJson(Map<String, dynamic> json) =
      _$_TimeModel.fromJson;

  @override
  String? get id;
  @override
  String? get movieId;
  @override
  String? get roomId;
  @override
  int? get from;
  @override
  int? get to;
  @override
  @JsonKey(ignore: true)
  _$$_TimeModelCopyWith<_$_TimeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
