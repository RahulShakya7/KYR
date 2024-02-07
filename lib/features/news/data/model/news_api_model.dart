import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entity/news_entity.dart';

part 'news_api_model.g.dart';

final newsApiModelProvider = Provider<NewsApiModel>(
  (ref) => const NewsApiModel.empty(),
);

@JsonSerializable()
class NewsApiModel extends Equatable {
  @JsonKey(name: 'id')
  final String? newsid;
  final String title;
  final String nimage;
  final String content;
  final String date;
  final String writer;

  const NewsApiModel({
    required this.newsid,
    required this.title,
    required this.nimage,
    required this.content,
    required this.date,
    required this.writer,
  });
  const NewsApiModel.empty()
      : newsid = '',
        title = '',
        nimage = '',
        content = '',
        date = '',
        writer = '';

  Map<String, dynamic> toJson() => _$NewsApiModelToJson(this);

  factory NewsApiModel.fromJson(Map<String, dynamic> json) =>
      _$NewsApiModelFromJson(json);

  // Convert API Object to Entity
  NewsEntity toEntity() => NewsEntity(
        newsid: newsid ?? '',
        title: title,
        nimage: nimage,
        content: content,
        date: date,
        writer: writer,
      );

  // Convert Entity to API Object
  NewsApiModel fromEntity(NewsEntity entity) => NewsApiModel(
        newsid: newsid ?? '',
        title: title,
        nimage: nimage,
        content: content,
        date: date,
        writer: writer,
      );

  // Convert API List to Entity List
  List<NewsEntity> toEntityList(List<NewsApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props =>
      [newsid, title, content, nimage, content, date, writer];
}
