import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/vehicle_usecase.dart';
import '../state/vehicles_state.dart';

final vehicleViewModelProvider =
    StateNotifierProvider<VehicleViewModel, VehicleState>(
  (ref) => VehicleViewModel(
    ref.watch(vehicleUsecaseProvider),
  ),
);

class VehicleViewModel extends StateNotifier<VehicleState> {
  final VehicleUseCase vehicleUseCase;

  VehicleViewModel(this.vehicleUseCase) : super(VehicleState.initial()) {
    getvehicles();
  }

  deletevehicle() {}

  getvehicles() async {
    state = state.copyWith(isLoading: true);
    var data = await vehicleUseCase.getVehicles();
    state = state.copyWith(vehicles: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, vehicles: r, error: null),
    );
  }
}
