import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_review_app/features/auth/data/model/user_api_model.dart';

part 'get_user_dto.g.dart';

@JsonSerializable()
class GetUserDTO {
  final bool success;
  final UserApiModel data;

  GetUserDTO({
    required this.success,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetUserDTOToJson(this);

  factory GetUserDTO.fromJson(Map<String, dynamic> json) =>
      _$GetUserDTOFromJson(json);
}
