// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsApiModel _$NewsApiModelFromJson(Map<String, dynamic> json) => NewsApiModel(
      newsid: json['id'] as String?,
      title: json['title'] as String,
      nimage: json['nimage'] as String,
      content: json['content'] as String,
      date: json['date'] as String,
      writer: json['writer'] as String,
    );

Map<String, dynamic> _$NewsApiModelToJson(NewsApiModel instance) =>
    <String, dynamic>{
      'id': instance.newsid,
      'title': instance.title,
      'nimage': instance.nimage,
      'content': instance.content,
      'date': instance.date,
      'writer': instance.writer,
    };
