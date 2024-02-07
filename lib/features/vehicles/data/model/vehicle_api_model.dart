import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/vehicle_entity.dart';

part 'vehicle_api_model.g.dart';

final vehicleApiModelProvider = Provider<VehicleApiModel>(
  (ref) => VehicleApiModel.empty(),
);

@JsonSerializable()
class VehicleApiModel extends Equatable {
  @JsonKey(name: 'id')
  final String? vehicleid;
  final String manufacturer;
  final String? vimage;
  final String model;
  final String year;
  final String price;
  final String specs;
  final String color;
  final String vtype;
  final List<String> reviews;

  const VehicleApiModel({
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

  factory VehicleApiModel.fromJson(Map<String, dynamic> json) {
    // Convert the "reviews" field to a List<String> or set it to an empty list if null.
    final reviews = (json['reviews'] as List<dynamic>?)
        ?.map(
            (review) => review.toString()) // Convert review objects to strings
        .toList();

    return VehicleApiModel(
      vehicleid: json['id'] as String?,
      manufacturer: json['manufacturer'] as String,
      vimage: json['vimage'] as String?,
      model: json['model'] as String,
      year: json['year'] as String,
      price: json['price'] as String,
      specs: json['specs'] as String,
      color: json['color'] as String,
      vtype: json['vtype'] as String,
      reviews: reviews ?? [],
    );
  }

  Map<String, dynamic> toJson() => _$VehicleApiModelToJson(this);

  factory VehicleApiModel.empty() => const VehicleApiModel(
        vehicleid: '',
        manufacturer: '',
        vimage: '',
        model: '',
        year: '',
        price: '',
        specs: '',
        color: '',
        vtype: '',
        reviews: [],
      );

  // Convert API Object to Entity
  VehicleEntity toEntity() => VehicleEntity(
        vehicleid: vehicleid ?? '',
        manufacturer: manufacturer,
        vimage: vimage ?? '',
        model: model,
        year: year,
        price: price,
        specs: specs,
        color: color,
        vtype: vtype,
        reviews: reviews,
      );

  // Convert Entity to API Object
  VehicleApiModel fromEntity(VehicleEntity entity) => VehicleApiModel(
        vehicleid: entity.vehicleid,
        manufacturer: entity.manufacturer,
        vimage: entity.vimage,
        model: entity.model,
        year: entity.year,
        price: entity.year,
        specs: entity.specs,
        color: entity.color,
        vtype: entity.vtype,
        reviews: entity.reviews,
      );

  // Convert API List to Entity List
  List<VehicleEntity> toEntityList(List<VehicleApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

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
