import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_review_app/features/vehicles/data/model/reviews_api_model.dart';

part 'get_all_reviews_dto.g.dart';

@JsonSerializable()
class GetAllReviewsDTO {
  final bool success;
  final int count;
  final List<ReviewApiModel> data;

  GetAllReviewsDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllReviewsDTOToJson(this);

  factory GetAllReviewsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllReviewsDTOFromJson(json);
}
