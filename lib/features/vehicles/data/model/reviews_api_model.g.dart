// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewApiModel _$ReviewApiModelFromJson(Map<String, dynamic> json) =>
    ReviewApiModel(
      vehicleid: json['id'] as String?,
      user: json['user'] as String,
      username: json['username'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$ReviewApiModelToJson(ReviewApiModel instance) =>
    <String, dynamic>{
      'id': instance.vehicleid,
      'user': instance.user,
      'username': instance.username,
      'rating': instance.rating,
      'comment': instance.comment,
    };
