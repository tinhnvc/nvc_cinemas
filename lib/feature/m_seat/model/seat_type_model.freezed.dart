// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'seat_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SeatTypeModel _$SeatTypeModelFromJson(Map<String, dynamic> json) {
  return _SeatTypeModel.fromJson(json);
}

/// @nodoc
mixin _$SeatTypeModel {
  String? get id => throw _privateConstructorUsedError;
  String? get typeName => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  int? get otherPrice => throw _privateConstructorUsedError;
  bool? get active => throw _privateConstructorUsedError;
  bool? get isDefault => throw _privateConstructorUsedError;
  int? get createAt => throw _privateConstructorUsedError;
  int? get updateAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeatTypeModelCopyWith<SeatTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatTypeModelCopyWith<$Res> {
  factory $SeatTypeModelCopyWith(
          SeatTypeModel value, $Res Function(SeatTypeModel) then) =
      _$SeatTypeModelCopyWithImpl<$Res, SeatTypeModel>;
  @useResult
  $Res call(
      {String? id,
      String? typeName,
      int? price,
      int? otherPrice,
      bool? active,
      bool? isDefault,
      int? createAt,
      int? updateAt});
}

/// @nodoc
class _$SeatTypeModelCopyWithImpl<$Res, $Val extends SeatTypeModel>
    implements $SeatTypeModelCopyWith<$Res> {
  _$SeatTypeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? typeName = freezed,
    Object? price = freezed,
    Object? otherPrice = freezed,
    Object? active = freezed,
    Object? isDefault = freezed,
    Object? createAt = freezed,
    Object? updateAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      typeName: freezed == typeName
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      otherPrice: freezed == otherPrice
          ? _value.otherPrice
          : otherPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDefault: freezed == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_SeatTypeModelCopyWith<$Res>
    implements $SeatTypeModelCopyWith<$Res> {
  factory _$$_SeatTypeModelCopyWith(
          _$_SeatTypeModel value, $Res Function(_$_SeatTypeModel) then) =
      __$$_SeatTypeModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? typeName,
      int? price,
      int? otherPrice,
      bool? active,
      bool? isDefault,
      int? createAt,
      int? updateAt});
}

/// @nodoc
class __$$_SeatTypeModelCopyWithImpl<$Res>
    extends _$SeatTypeModelCopyWithImpl<$Res, _$_SeatTypeModel>
    implements _$$_SeatTypeModelCopyWith<$Res> {
  __$$_SeatTypeModelCopyWithImpl(
      _$_SeatTypeModel _value, $Res Function(_$_SeatTypeModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? typeName = freezed,
    Object? price = freezed,
    Object? otherPrice = freezed,
    Object? active = freezed,
    Object? isDefault = freezed,
    Object? createAt = freezed,
    Object? updateAt = freezed,
  }) {
    return _then(_$_SeatTypeModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      typeName: freezed == typeName
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      otherPrice: freezed == otherPrice
          ? _value.otherPrice
          : otherPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDefault: freezed == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
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
class _$_SeatTypeModel extends _SeatTypeModel {
  const _$_SeatTypeModel(
      {this.id,
      this.typeName,
      this.price,
      this.otherPrice,
      this.active = true,
      this.isDefault = false,
      this.createAt,
      this.updateAt})
      : super._();

  factory _$_SeatTypeModel.fromJson(Map<String, dynamic> json) =>
      _$$_SeatTypeModelFromJson(json);

  @override
  final String? id;
  @override
  final String? typeName;
  @override
  final int? price;
  @override
  final int? otherPrice;
  @override
  @JsonKey()
  final bool? active;
  @override
  @JsonKey()
  final bool? isDefault;
  @override
  final int? createAt;
  @override
  final int? updateAt;

  @override
  String toString() {
    return 'SeatTypeModel(id: $id, typeName: $typeName, price: $price, otherPrice: $otherPrice, active: $active, isDefault: $isDefault, createAt: $createAt, updateAt: $updateAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SeatTypeModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.otherPrice, otherPrice) ||
                other.otherPrice == otherPrice) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.updateAt, updateAt) ||
                other.updateAt == updateAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, typeName, price, otherPrice,
      active, isDefault, createAt, updateAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SeatTypeModelCopyWith<_$_SeatTypeModel> get copyWith =>
      __$$_SeatTypeModelCopyWithImpl<_$_SeatTypeModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SeatTypeModelToJson(
      this,
    );
  }
}

abstract class _SeatTypeModel extends SeatTypeModel {
  const factory _SeatTypeModel(
      {final String? id,
      final String? typeName,
      final int? price,
      final int? otherPrice,
      final bool? active,
      final bool? isDefault,
      final int? createAt,
      final int? updateAt}) = _$_SeatTypeModel;
  const _SeatTypeModel._() : super._();

  factory _SeatTypeModel.fromJson(Map<String, dynamic> json) =
      _$_SeatTypeModel.fromJson;

  @override
  String? get id;
  @override
  String? get typeName;
  @override
  int? get price;
  @override
  int? get otherPrice;
  @override
  bool? get active;
  @override
  bool? get isDefault;
  @override
  int? get createAt;
  @override
  int? get updateAt;
  @override
  @JsonKey(ignore: true)
  _$$_SeatTypeModelCopyWith<_$_SeatTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
