// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TimeModel _$$_TimeModelFromJson(Map<String, dynamic> json) => _$_TimeModel(
      id: json['id'] as String?,
      movieId: json['movieId'] as String?,
      roomId: json['roomId'] as String?,
      from: json['from'] as int?,
      to: json['to'] as int?,
    );

Map<String, dynamic> _$$_TimeModelToJson(_$_TimeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'movieId': instance.movieId,
      'roomId': instance.roomId,
      'from': instance.from,
      'to': instance.to,
    };
