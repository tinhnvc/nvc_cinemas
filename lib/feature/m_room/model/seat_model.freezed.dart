// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'seat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SeatModel _$SeatModelFromJson(Map<String, dynamic> json) {
  return _SeatModel.fromJson(json);
}

/// @nodoc
mixin _$SeatModel {
  String? get id => throw _privateConstructorUsedError;
  String? get seatTypeId => throw _privateConstructorUsedError;
  String? get roomId => throw _privateConstructorUsedError;
  String? get position => throw _privateConstructorUsedError;
  int? get createAt => throw _privateConstructorUsedError;
  int? get updateAt => throw _privateConstructorUsedError;
  bool? get isSold => throw _privateConstructorUsedError;
  bool? get isSelected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeatModelCopyWith<SeatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatModelCopyWith<$Res> {
  factory $SeatModelCopyWith(SeatModel value, $Res Function(SeatModel) then) =
      _$SeatModelCopyWithImpl<$Res, SeatModel>;
  @useResult
  $Res call(
      {String? id,
      String? seatTypeId,
      String? roomId,
      String? position,
      int? createAt,
      int? updateAt,
      bool? isSold,
      bool? isSelected});
}

/// @nodoc
class _$SeatModelCopyWithImpl<$Res, $Val extends SeatModel>
    implements $SeatModelCopyWith<$Res> {
  _$SeatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? seatTypeId = freezed,
    Object? roomId = freezed,
    Object? position = freezed,
    Object? createAt = freezed,
    Object? updateAt = freezed,
    Object? isSold = freezed,
    Object? isSelected = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      seatTypeId: freezed == seatTypeId
          ? _value.seatTypeId
          : seatTypeId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as int?,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as int?,
      isSold: freezed == isSold
          ? _value.isSold
          : isSold // ignore: cast_nullable_to_non_nullable
              as bool?,
      isSelected: freezed == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SeatModelCopyWith<$Res> implements $SeatModelCopyWith<$Res> {
  factory _$$_SeatModelCopyWith(
          _$_SeatModel value, $Res Function(_$_SeatModel) then) =
      __$$_SeatModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? seatTypeId,
      String? roomId,
      String? position,
      int? createAt,
      int? updateAt,
      bool? isSold,
      bool? isSelected});
}

/// @nodoc
class __$$_SeatModelCopyWithImpl<$Res>
    extends _$SeatModelCopyWithImpl<$Res, _$_SeatModel>
    implements _$$_SeatModelCopyWith<$Res> {
  __$$_SeatModelCopyWithImpl(
      _$_SeatModel _value, $Res Function(_$_SeatModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? seatTypeId = freezed,
    Object? roomId = freezed,
    Object? position = freezed,
    Object? createAt = freezed,
    Object? updateAt = freezed,
    Object? isSold = freezed,
    Object? isSelected = freezed,
  }) {
    return _then(_$_SeatModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      seatTypeId: freezed == seatTypeId
          ? _value.seatTypeId
          : seatTypeId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as int?,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as int?,
      isSold: freezed == isSold
          ? _value.isSold
          : isSold // ignore: cast_nullable_to_non_nullable
              as bool?,
      isSelected: freezed == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SeatModel extends _SeatModel {
  const _$_SeatModel(
      {this.id,
      this.seatTypeId,
      this.roomId,
      this.position,
      this.createAt,
      this.updateAt,
      this.isSold = false,
      this.isSelected = false})
      : super._();

  factory _$_SeatModel.fromJson(Map<String, dynamic> json) =>
      _$$_SeatModelFromJson(json);

  @override
  final String? id;
  @override
  final String? seatTypeId;
  @override
  final String? roomId;
  @override
  final String? position;
  @override
  final int? createAt;
  @override
  final int? updateAt;
  @override
  @JsonKey()
  final bool? isSold;
  @override
  @JsonKey()
  final bool? isSelected;

  @override
  String toString() {
    return 'SeatModel(id: $id, seatTypeId: $seatTypeId, roomId: $roomId, position: $position, createAt: $createAt, updateAt: $updateAt, isSold: $isSold, isSelected: $isSelected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SeatModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.seatTypeId, seatTypeId) ||
                other.seatTypeId == seatTypeId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.updateAt, updateAt) ||
                other.updateAt == updateAt) &&
            (identical(other.isSold, isSold) || other.isSold == isSold) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, seatTypeId, roomId, position,
      createAt, updateAt, isSold, isSelected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SeatModelCopyWith<_$_SeatModel> get copyWith =>
      __$$_SeatModelCopyWithImpl<_$_SeatModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SeatModelToJson(
      this,
    );
  }
}

abstract class _SeatModel extends SeatModel {
  const factory _SeatModel(
      {final String? id,
      final String? seatTypeId,
      final String? roomId,
      final String? position,
      final int? createAt,
      final int? updateAt,
      final bool? isSold,
      final bool? isSelected}) = _$_SeatModel;
  const _SeatModel._() : super._();

  factory _SeatModel.fromJson(Map<String, dynamic> json) =
      _$_SeatModel.fromJson;

  @override
  String? get id;
  @override
  String? get seatTypeId;
  @override
  String? get roomId;
  @override
  String? get position;
  @override
  int? get createAt;
  @override
  int? get updateAt;
  @override
  bool? get isSold;
  @override
  bool? get isSelected;
  @override
  @JsonKey(ignore: true)
  _$$_SeatModelCopyWith<_$_SeatModel> get copyWith =>
      throw _privateConstructorUsedError;
}
