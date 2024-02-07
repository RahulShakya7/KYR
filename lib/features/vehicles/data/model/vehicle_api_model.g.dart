// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleApiModel _$VehicleApiModelFromJson(Map<String, dynamic> json) =>
    VehicleApiModel(
      vehicleid: json['id'] as String?,
      manufacturer: json['manufacturer'] as String,
      vimage: json['vimage'] as String?,
      model: json['model'] as String,
      year: json['year'] as String,
      price: json['price'] as String,
      specs: json['specs'] as String,
      color: json['color'] as String,
      vtype: json['vtype'] as String,
      reviews:
          (json['reviews'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$VehicleApiModelToJson(VehicleApiModel instance) =>
    <String, dynamic>{
      'id': instance.vehicleid,
      'manufacturer': instance.manufacturer,
      'vimage': instance.vimage,
      'model': instance.model,
      'year': instance.year,
      'price': instance.price,
      'specs': instance.specs,
      'color': instance.color,
      'vtype': instance.vtype,
      'reviews': instance.reviews,
    };
