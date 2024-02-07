import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_review_app/features/vehicles/domain/entity/vehicle_entity.dart';
import 'package:news_review_app/features/vehicles/presentation/view/review_view.dart';
import 'package:news_review_app/features/vehicles/presentation/view/vehicles.dart';
import 'package:news_review_app/features/vehicles/presentation/widget/review_form.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../config/constants/theme_constant.dart';
import '../../../../core/common/provider/internet_connectivity.dart';

class SingleVehicleView extends ConsumerStatefulWidget {
  final String vehicleId;

  const SingleVehicleView({super.key, required this.vehicleId});

  @override
  ConsumerState<SingleVehicleView> createState() => _SingleVehicleViewState();
}

class _SingleVehicleViewState extends ConsumerState<SingleVehicleView> {
  @override
  Widget build(BuildContext context) {
    final vehicleState = ref.watch(vehicleViewModelProvider);
    final vehicle = _findVehicle(vehicleState.vehicles, widget.vehicleId);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color:
                Color.fromARGB(255, 205, 205, 205), // Set button color to grey
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColorConstant.secondaryColor,
            size: 20,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: vehicle != null ? _buildVehicleContent(vehicle) : _buildNotFound(),
      // floatingActionButton: SizedBox(
      //   width: screenWidth * 0.2,
      //   height: screenHeight > 900 ? 90 : 80,
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => ReviewForm(
      //             vehicleId: vehicle!.vehicleid,
      //           ),
      //         ),
      //       );
      //     },
      //     backgroundColor: AppColorConstant.primaryColor,
      //     foregroundColor: AppColorConstant.secondaryColor,
      //     child: Icon(
      //       Icons.reviews,
      //       size: screenHeight > 900 ? 36 : 30,
      //     ),
      // ),
      // ),
    );
  }

  VehicleEntity? _findVehicle(List<VehicleEntity> vehicles, String vehicleId) {
    try {
      final vehicle =
          vehicles.firstWhere((vehicle) => vehicle.vehicleid == vehicleId);
      return vehicle.copyWith();
    } catch (e) {
      return null;
    }
  }

  Widget _buildVehicleContent(VehicleEntity vehicle) {
    final dateTime = DateTime.parse(vehicle.year);
    final formattedDate = DateFormat('yyyy').format(dateTime);
    final internetStatus = ref.watch(connectivityStatusProvider);
    final averageRating = ref.watch(averageRatingProvider(vehicle.vehicleid));
    String formattedRating = averageRating.toStringAsFixed(1);
    final totalReviewCount =
        ref.watch(totalReviewCountProvider(vehicle.vehicleid));

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //   border: Border.all(
        //     color: AppColorConstant
        //         .accentColor, // Set your desired border color here
        //     width: 2.0, // Set the border width
        //   ),
        //   borderRadius: BorderRadius.circular(10), // Set the border radius
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            ConnectivityStatus.isConnected == internetStatus
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: screenHeight * 0.3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            '${ApiEndpoints.vehicleImageUrl}${vehicle.vimage}',
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('./assets/images/splash.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                vehicle.manufacturer,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: screenHeight > 900 ? 32 : 25,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                vehicle.model,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight > 900 ? 64 : 52,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                vehicle.specs,
                style: TextStyle(
                  fontSize: screenHeight > 900 ? 24 : 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 227, 227, 227),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "NRS ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight > 900 ? 32 : 24),
                      ),
                      Text(
                        formatPrice(vehicle.price),
                        style:
                            TextStyle(fontSize: screenHeight > 900 ? 32 : 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: AppColorConstant
                        .accentColor, // Set the color of the line
                    thickness: 2, // Set the thickness of the line
                    height: 20, // Set the height of the line
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              "Manufacturer",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight > 900 ? 24 : 16),
                            ),
                          ),
                          Text(
                            vehicle.manufacturer,
                            style: TextStyle(
                                fontSize: screenHeight > 900 ? 24 : 16),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            child: Text(
                              "Year",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight > 900 ? 24 : 16),
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: TextStyle(
                                fontSize: screenHeight > 900 ? 24 : 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 10, width: screenWidth * 0.14),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              "Color",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight > 900 ? 24 : 16),
                            ),
                          ),
                          Text(
                            vehicle.color,
                            style: TextStyle(
                                fontSize: screenHeight > 900 ? 24 : 16),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            child: Text(
                              "Type",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight > 900 ? 24 : 16),
                            ),
                          ),
                          Text(
                            vehicle.vtype,
                            style: TextStyle(
                                fontSize: screenHeight > 900 ? 24 : 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 227, 227, 227),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      formattedRating,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight > 900 ? 48 : 34,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      child: RatingBar.builder(
                        initialRating: averageRating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: screenHeight > 900 ? 50 : 25,
                        itemPadding: EdgeInsets.zero,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: AppColorConstant.accentColor,
                        ),
                        onRatingUpdate: (rating) {},
                        ignoreGestures: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text("($totalReviewCount Reviews)")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewForm(
                          vehicleId: vehicle.vehicleid,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColorConstant.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Review',
                    style: TextStyle(color: AppColorConstant.primaryColor),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                  height: screenHeight * 0.4,
                  child: VehicleReviewsView(
                    vehicleId: vehicle.vehicleid,
                  )),
            ),
            // const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildNotFound() {
    return const Center(
      child: Text('vehicle not found'),
    );
  }
}
