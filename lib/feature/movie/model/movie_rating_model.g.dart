// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MovieRatingModel _$$_MovieRatingModelFromJson(Map<String, dynamic> json) =>
    _$_MovieRatingModel(
      userId: json['userId'] as String?,
      movieId: json['movieId'] as String?,
      star: json['star'] as String?,
      comment: json['comment'] as String?,
      createAt: json['createAt'] as int?,
    );

Map<String, dynamic> _$$_MovieRatingModelToJson(_$_MovieRatingModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'movieId': instance.movieId,
      'star': instance.star,
      'comment': instance.comment,
      'createAt': instance.createAt,
    };
