import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/review_entity.dart';

part 'reviews_api_model.g.dart';

final reviewApiModelProvider = Provider<ReviewApiModel>(
  (ref) => ReviewApiModel.empty(),
);

@JsonSerializable()
class ReviewApiModel extends Equatable {
  @JsonKey(name: 'id')
  final String? vehicleid;
  final String user;
  final String username;
  final double rating;
  final String comment;

  const ReviewApiModel({
    required this.vehicleid,
    required this.user,
    required this.username,
    required this.rating,
    required this.comment,
  });

  factory ReviewApiModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewApiModelToJson(this);

  factory ReviewApiModel.empty() => const ReviewApiModel(
      vehicleid: '', user: '', username: '', rating: 0, comment: '');

  // Convert API Object to Entity
  ReviewEntity toEntity() => ReviewEntity(
        vehicleid: vehicleid,
        user: user,
        username: username,
        rating: rating,
        comment: comment,
      );

  // Convert Entity to API Object
  ReviewApiModel fromEntity(ReviewEntity entity) => ReviewApiModel(
        vehicleid: entity.vehicleid,
        user: entity.user,
        username: entity.username,
        rating: entity.rating,
        comment: entity.comment,
      );

  // Convert API List to Entity List
  List<ReviewEntity> toEntityList(List<ReviewApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        vehicleid,
        user,
        username,
        rating,
        comment,
      ];
}
