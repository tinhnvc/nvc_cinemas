// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'room_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) {
  return _RoomModel.fromJson(json);
}

/// @nodoc
mixin _$RoomModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get size => throw _privateConstructorUsedError;
  int? get seatAmount => throw _privateConstructorUsedError;
  int? get availableSeat => throw _privateConstructorUsedError;
  bool? get active => throw _privateConstructorUsedError;
  int? get createAt => throw _privateConstructorUsedError;
  int? get updateAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomModelCopyWith<RoomModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomModelCopyWith<$Res> {
  factory $RoomModelCopyWith(RoomModel value, $Res Function(RoomModel) then) =
      _$RoomModelCopyWithImpl<$Res, RoomModel>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? size,
      int? seatAmount,
      int? availableSeat,
      bool? active,
      int? createAt,
      int? updateAt});
}

/// @nodoc
class _$RoomModelCopyWithImpl<$Res, $Val extends RoomModel>
    implements $RoomModelCopyWith<$Res> {
  _$RoomModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? size = freezed,
    Object? seatAmount = freezed,
    Object? availableSeat = freezed,
    Object? active = freezed,
    Object? createAt = freezed,
    Object? updateAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      seatAmount: freezed == seatAmount
          ? _value.seatAmount
          : seatAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      availableSeat: freezed == availableSeat
          ? _value.availableSeat
          : availableSeat // ignore: cast_nullable_to_non_nullable
              as int?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
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
}

/// @nodoc
abstract class _$$_RoomModelCopyWith<$Res> implements $RoomModelCopyWith<$Res> {
  factory _$$_RoomModelCopyWith(
          _$_RoomModel value, $Res Function(_$_RoomModel) then) =
      __$$_RoomModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? size,
      int? seatAmount,
      int? availableSeat,
      bool? active,
      int? createAt,
      int? updateAt});
}

/// @nodoc
class __$$_RoomModelCopyWithImpl<$Res>
    extends _$RoomModelCopyWithImpl<$Res, _$_RoomModel>
    implements _$$_RoomModelCopyWith<$Res> {
  __$$_RoomModelCopyWithImpl(
      _$_RoomModel _value, $Res Function(_$_RoomModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? size = freezed,
    Object? seatAmount = freezed,
    Object? availableSeat = freezed,
    Object? active = freezed,
    Object? createAt = freezed,
    Object? updateAt = freezed,
  }) {
    return _then(_$_RoomModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      seatAmount: freezed == seatAmount
          ? _value.seatAmount
          : seatAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      availableSeat: freezed == availableSeat
          ? _value.availableSeat
          : availableSeat // ignore: cast_nullable_to_non_nullable
              as int?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
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
class _$_RoomModel extends _RoomModel {
  const _$_RoomModel(
      {this.id,
      this.name,
      this.size,
      this.seatAmount,
      this.availableSeat,
      this.active = true,
      this.createAt,
      this.updateAt})
      : super._();

  factory _$_RoomModel.fromJson(Map<String, dynamic> json) =>
      _$$_RoomModelFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? size;
  @override
  final int? seatAmount;
  @override
  final int? availableSeat;
  @override
  @JsonKey()
  final bool? active;
  @override
  final int? createAt;
  @override
  final int? updateAt;

  @override
  String toString() {
    return 'RoomModel(id: $id, name: $name, size: $size, seatAmount: $seatAmount, availableSeat: $availableSeat, active: $active, createAt: $createAt, updateAt: $updateAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoomModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.seatAmount, seatAmount) ||
                other.seatAmount == seatAmount) &&
            (identical(other.availableSeat, availableSeat) ||
                other.availableSeat == availableSeat) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.updateAt, updateAt) ||
                other.updateAt == updateAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, size, seatAmount,
      availableSeat, active, createAt, updateAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoomModelCopyWith<_$_RoomModel> get copyWith =>
      __$$_RoomModelCopyWithImpl<_$_RoomModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoomModelToJson(
      this,
    );
  }
}

abstract class _RoomModel extends RoomModel {
  const factory _RoomModel(
      {final String? id,
      final String? name,
      final String? size,
      final int? seatAmount,
      final int? availableSeat,
      final bool? active,
      final int? createAt,
      final int? updateAt}) = _$_RoomModel;
  const _RoomModel._() : super._();

  factory _RoomModel.fromJson(Map<String, dynamic> json) =
      _$_RoomModel.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get size;
  @override
  int? get seatAmount;
  @override
  int? get availableSeat;
  @override
  bool? get active;
  @override
  int? get createAt;
  @override
  int? get updateAt;
  @override
  @JsonKey(ignore: true)
  _$$_RoomModelCopyWith<_$_RoomModel> get copyWith =>
      throw _privateConstructorUsedError;
}
