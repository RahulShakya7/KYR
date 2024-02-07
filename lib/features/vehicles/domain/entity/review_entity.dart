import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String? vehicleid;
  final String user;
  final String username;
  final double rating;
  final String comment;

  const ReviewEntity({
    required this.vehicleid,
    required this.user,
    required this.username,
    required this.rating,
    required this.comment,
  });

  factory ReviewEntity.fromJson(Map<String, dynamic> json) => ReviewEntity(
        vehicleid: json["vehicleid"],
        user: json["user"],
        username: json["username"],
        rating: json["rating"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "vehicleid": vehicleid,
        "user": user,
        "username": username,
        "rating": rating,
        "comment": comment,
      };

  @override
  List<Object?> get props => [
        vehicleid,
        user,
        username,
        rating,
        comment,
      ];
}
