import 'package:news_review_app/features/vehicles/domain/entity/vehicle_entity.dart';

class VehicleState {
  final bool isLoading;
  final List<VehicleEntity> vehicles;
  final String? error;

  VehicleState({
    required this.isLoading,
    required this.vehicles,
    this.error,
  });

  factory VehicleState.initial() {
    return VehicleState(
      isLoading: false,
      vehicles: [],
    );
  }

  VehicleState copyWith({
    bool? isLoading,
    List<VehicleEntity>? vehicles,
    String? error,
  }) {
    return VehicleState(
      isLoading: isLoading ?? this.isLoading,
      vehicles: vehicles ?? this.vehicles,
      error: error ?? this.error,
    );
  }
}
