import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/vehicle_api_model.dart';

part 'get_all_vehicles_dto.g.dart';

@JsonSerializable()
class GetAllVehicleDTO {
  final bool success;
  final int count;
  final List<VehicleApiModel> data;

  GetAllVehicleDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllVehicleDTOToJson(this);

  factory GetAllVehicleDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllVehicleDTOFromJson(json);
}
