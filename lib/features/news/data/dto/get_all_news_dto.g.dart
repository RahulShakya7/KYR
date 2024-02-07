// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_news_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllNewsDTO _$GetAllNewsDTOFromJson(Map<String, dynamic> json) =>
    GetAllNewsDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => NewsApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllNewsDTOToJson(GetAllNewsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
