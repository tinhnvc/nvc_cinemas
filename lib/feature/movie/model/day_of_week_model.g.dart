// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_of_week_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DayOfWeekModel _$$_DayOfWeekModelFromJson(Map<String, dynamic> json) =>
    _$_DayOfWeekModel(
      id: json['id'] as String?,
      day: json['day'] as int?,
      dayOfWeek: json['dayOfWeek'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$$_DayOfWeekModelToJson(_$_DayOfWeekModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'dayOfWeek': instance.dayOfWeek,
      'isSelected': instance.isSelected,
    };
