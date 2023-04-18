// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MovieModel _$$_MovieModelFromJson(Map<String, dynamic> json) =>
    _$_MovieModel(
      id: json['id'] as String?,
      category: json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      movieNameVi: json['movieNameVi'] as String?,
      movieNameEn: json['movieNameEn'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      duration: json['duration'] as String?,
      director: json['director'] as String?,
      actor: json['actor'] as String?,
      type: json['type'] as String?,
      dimension: json['dimension'] as String?,
      active: json['active'] as bool? ?? true,
      startTime: json['startTime'] as int?,
      endTime: json['endTime'] as int?,
      createAt: json['createAt'] as int?,
      updateAt: json['updateAt'] as int?,
    );

Map<String, dynamic> _$$_MovieModelToJson(_$_MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'movieNameVi': instance.movieNameVi,
      'movieNameEn': instance.movieNameEn,
      'image': instance.image,
      'description': instance.description,
      'duration': instance.duration,
      'director': instance.director,
      'actor': instance.actor,
      'type': instance.type,
      'dimension': instance.dimension,
      'active': instance.active,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
    };
