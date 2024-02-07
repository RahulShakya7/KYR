import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_review_app/features/news/domain/entity/news_entity.dart';

import '../../../../config/constants/hive_table_constant.dart';

part 'news_hive_model.g.dart';

final newsHiveModelProvider = Provider(
  (ref) => NewsHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.newsTableId)
class NewsHiveModel {
  @HiveField(0)
  final String newsid;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final String date;

  @HiveField(4)
  final String writer;

  NewsHiveModel.empty()
      : this(newsid: '', title: '', content: '', date: '', writer: '');

  NewsHiveModel({
    required this.newsid,
    required this.title,
    required this.content,
    required this.date,
    required this.writer,
  });

  NewsEntity toEntity() => NewsEntity(
        newsid: newsid,
        title: title,
        nimage: '',
        content: content,
        date: date,
        writer: writer,
      );

  NewsHiveModel toHiveModel(NewsEntity entity, String newsid) => NewsHiveModel(
        newsid: newsid,
        title: entity.title,
        content: entity.content,
        date: entity.date,
        writer: entity.writer,
      );

  List<NewsHiveModel> toHiveModelList(List<NewsEntity> entities) =>
      entities.map((entity) => toHiveModel(entity, newsid)).toList();

  List<NewsEntity> toEntityList(List<NewsHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'newsid: $newsid, title: $title, content: $content, date: $date, writer: $writer';
  }
}
