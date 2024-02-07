import 'package:equatable/equatable.dart';

import '../../data/model/vehicle_api_model.dart';

class VehicleEntity extends Equatable {
  final String vehicleid;
  final String manufacturer;
  final String vimage;
  final String model;
  final String year;
  final String price;
  final String specs;
  final String color;
  final String vtype;
  final List<String> reviews;

  const VehicleEntity({
    required this.vehicleid,
    required this.manufacturer,
    required this.vimage,
    required this.model,
    required this.year,
    required this.price,
    required this.specs,
    required this.color,
    required this.vtype,
    required this.reviews,
  });

  VehicleEntity copyWith({
    String? vehicleid,
    String? manufacturer,
    String? vimage,
    String? model,
    String? year,
    String? price,
    String? specs,
    String? color,
    String? vtype,
    List<String>? reviews,
  }) {
    return VehicleEntity(
      vehicleid: vehicleid ?? this.vehicleid,
      manufacturer: manufacturer ?? this.manufacturer,
      vimage: vimage ?? this.vimage,
      model: model ?? this.model,
      year: year ?? this.year,
      price: price ?? this.price,
      specs: specs ?? this.specs,
      color: color ?? this.color,
      vtype: vtype ?? this.vtype,
      reviews: reviews ?? this.reviews,
    );
  }

  VehicleApiModel fromEntity(VehicleEntity entity) => VehicleApiModel(
        vehicleid: entity.vehicleid,
        manufacturer: entity.manufacturer,
        vimage: entity.vimage,
        model: entity.model,
        year: entity.year,
        price: entity.price,
        specs: entity.specs,
        color: entity.color,
        vtype: entity.vtype,
        reviews:
            entity.reviews.toList(), // Ensure that reviews are a List<String>
      );

  factory VehicleEntity.fromJson(Map<String, dynamic> json) => VehicleEntity(
        vehicleid: json["vehicleid"],
        manufacturer: json["manufacturer"],
        vimage: json["vimage"],
        model: json["model"],
        year: json["year"],
        price: json["price"],
        specs: json["specs"],
        color: json["color"],
        vtype: json["vtype"],
        reviews: List<String>.from(json["reviews"].map((x) => x.toString())),
      );

  Map<String, dynamic> toJson() => {
        "vehicleid": vehicleid,
        "manufacturer": manufacturer,
        "vimage": vimage,
        "model": model,
        "year": year,
        "price": price,
        "specs": specs,
        "color": color,
        "vtype": vtype,
        "reviews": reviews.map((reviewId) => reviewId).toList(),
      };

  @override
  List<Object?> get props => [
        vehicleid,
        manufacturer,
        vimage,
        model,
        year,
        price,
        specs,
        color,
        vtype,
        reviews,
      ];
}
