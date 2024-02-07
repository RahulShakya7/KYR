import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_review_app/features/news/data/model/news_api_model.dart';

part 'get_all_news_dto.g.dart';

@JsonSerializable()
class GetAllNewsDTO {
  final bool success;
  final int count;
  final List<NewsApiModel> data;

  GetAllNewsDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllNewsDTOToJson(this);

  factory GetAllNewsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllNewsDTOFromJson(json);
}
