// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'day_of_week_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DayOfWeekModel _$DayOfWeekModelFromJson(Map<String, dynamic> json) {
  return _DayOfWeekModel.fromJson(json);
}

/// @nodoc
mixin _$DayOfWeekModel {
  String? get id => throw _privateConstructorUsedError;
  int? get day => throw _privateConstructorUsedError;
  String? get dayOfWeek => throw _privateConstructorUsedError;
  bool? get isSelected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DayOfWeekModelCopyWith<DayOfWeekModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayOfWeekModelCopyWith<$Res> {
  factory $DayOfWeekModelCopyWith(
          DayOfWeekModel value, $Res Function(DayOfWeekModel) then) =
      _$DayOfWeekModelCopyWithImpl<$Res, DayOfWeekModel>;
  @useResult
  $Res call({String? id, int? day, String? dayOfWeek, bool? isSelected});
}

/// @nodoc
class _$DayOfWeekModelCopyWithImpl<$Res, $Val extends DayOfWeekModel>
    implements $DayOfWeekModelCopyWith<$Res> {
  _$DayOfWeekModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? day = freezed,
    Object? dayOfWeek = freezed,
    Object? isSelected = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      day: freezed == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int?,
      dayOfWeek: freezed == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as String?,
      isSelected: freezed == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DayOfWeekModelCopyWith<$Res>
    implements $DayOfWeekModelCopyWith<$Res> {
  factory _$$_DayOfWeekModelCopyWith(
          _$_DayOfWeekModel value, $Res Function(_$_DayOfWeekModel) then) =
      __$$_DayOfWeekModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, int? day, String? dayOfWeek, bool? isSelected});
}

/// @nodoc
class __$$_DayOfWeekModelCopyWithImpl<$Res>
    extends _$DayOfWeekModelCopyWithImpl<$Res, _$_DayOfWeekModel>
    implements _$$_DayOfWeekModelCopyWith<$Res> {
  __$$_DayOfWeekModelCopyWithImpl(
      _$_DayOfWeekModel _value, $Res Function(_$_DayOfWeekModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? day = freezed,
    Object? dayOfWeek = freezed,
    Object? isSelected = freezed,
  }) {
    return _then(_$_DayOfWeekModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      day: freezed == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int?,
      dayOfWeek: freezed == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as String?,
      isSelected: freezed == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DayOfWeekModel extends _DayOfWeekModel {
  const _$_DayOfWeekModel(
      {this.id, this.day, this.dayOfWeek, this.isSelected = false})
      : super._();

  factory _$_DayOfWeekModel.fromJson(Map<String, dynamic> json) =>
      _$$_DayOfWeekModelFromJson(json);

  @override
  final String? id;
  @override
  final int? day;
  @override
  final String? dayOfWeek;
  @override
  @JsonKey()
  final bool? isSelected;

  @override
  String toString() {
    return 'DayOfWeekModel(id: $id, day: $day, dayOfWeek: $dayOfWeek, isSelected: $isSelected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DayOfWeekModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, day, dayOfWeek, isSelected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DayOfWeekModelCopyWith<_$_DayOfWeekModel> get copyWith =>
      __$$_DayOfWeekModelCopyWithImpl<_$_DayOfWeekModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DayOfWeekModelToJson(
      this,
    );
  }
}

abstract class _DayOfWeekModel extends DayOfWeekModel {
  const factory _DayOfWeekModel(
      {final String? id,
      final int? day,
      final String? dayOfWeek,
      final bool? isSelected}) = _$_DayOfWeekModel;
  const _DayOfWeekModel._() : super._();

  factory _DayOfWeekModel.fromJson(Map<String, dynamic> json) =
      _$_DayOfWeekModel.fromJson;

  @override
  String? get id;
  @override
  int? get day;
  @override
  String? get dayOfWeek;
  @override
  bool? get isSelected;
  @override
  @JsonKey(ignore: true)
  _$$_DayOfWeekModelCopyWith<_$_DayOfWeekModel> get copyWith =>
      throw _privateConstructorUsedError;
}
