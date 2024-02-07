import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../domain/use_case/vehicle_usecase.dart';
import '../state/vehicles_state.dart';
import '../viewmodel/vehicle_view_model.dart';
import 'single_vehicle_view.dart';

final vehicleViewModelProvider =
    StateNotifierProvider<VehicleViewModel, VehicleState>(
  (ref) => VehicleViewModel(
    ref.watch(vehicleUsecaseProvider),
  ),
);

class VehicleView extends ConsumerStatefulWidget {
  const VehicleView({super.key});

  @override
  ConsumerState<VehicleView> createState() => _VehicleViewState();
}

class _VehicleViewState extends ConsumerState<VehicleView> {
  late ShakeDetector shakeDetector;

  @override
  void initState() {
    super.initState();
    shakeDetector = ShakeDetector(
      onShake: _refreshVehicles,
    );
    shakeDetector.startListening();
  }

  @override
  void dispose() {
    shakeDetector.stopListening();
    super.dispose();
  }

  Future<void> _refreshVehicles() async {
    await ref.read(vehicleViewModelProvider.notifier).getvehicles();
  }

  @override
  Widget build(BuildContext context) {
    final vehicleState = ref.watch(vehicleViewModelProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final itemWidth = screenWidth * 0.9; // 90% of screen width
    final itemHeight = screenHeight * 0.2; // 20% of screen height

    String formatPrice(String price) {
      try {
        int priceInt = int.parse(price);

        if (priceInt >= 100000) {
          double lakh = priceInt / 100000;
          return '${lakh.toStringAsFixed(lakh.truncateToDouble() == lakh ? 0 : 1)} lakh';
        } else {
          return price;
        }
      } catch (e) {
        // Handle the case where parsing fails
        return "Invalid Price";
      }
    }

    double tileHeight;
    if (screenHeight > 900) {
      tileHeight = screenHeight * 0.2;
    } else {
      tileHeight = screenHeight * 0.15;
    }
    return RefreshIndicator(
      onRefresh: _refreshVehicles,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Vehicles',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (vehicleState.isLoading) ...{
                const CircularProgressIndicator(),
              } else if (vehicleState.error != null) ...{
                Text(vehicleState.error!),
              } else if (vehicleState.vehicles.isEmpty) ...{
                const Center(child: Text('No Vehicles')),
              } else ...{
                Expanded(
                  child: ListView.builder(
                    itemCount: vehicleState.vehicles.length,
                    itemBuilder: (BuildContext context, int index) {
                      final vehicle = vehicleState.vehicles[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleVehicleView(
                                vehicleId: vehicle.vehicleid,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: tileHeight,
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                final double imageHeight = itemHeight;
                                final double imageWidth = itemWidth;
                                // final averageRating = ref.watch(
                                //     averageRatingProvider(vehicle.vehicleid));
                                return Container(
                                  padding: const EdgeInsets.all(0),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: screenWidth * 0.3,
                                        alignment: Alignment.centerLeft,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Image.network(
                                            '${ApiEndpoints.vehicleImageUrl}${vehicle.vimage}',
                                            width: imageWidth,
                                            height: imageHeight,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    vehicle.model,
                                                    style: TextStyle(
                                                        fontSize:
                                                            screenHeight > 900
                                                                ? 32
                                                                : 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "NRS",
                                                  style: TextStyle(
                                                      fontSize:
                                                          screenHeight > 900
                                                              ? 32
                                                              : 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                formatPrice(vehicle.price),
                                                style: TextStyle(
                                                  fontSize: screenHeight > 900
                                                      ? 32
                                                      : 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}

class ShakeDetector {
  final Function onShake;
  StreamSubscription<AccelerometerEvent>? _subscription;

  ShakeDetector({required this.onShake});

  void startListening() {
    _subscription = accelerometerEvents?.listen((event) {
      final double acceleration = event.y;

      if (acceleration > 18) {
        onShake();
      }
    });
  }

  void stopListening() {
    _subscription?.cancel();
  }
}
