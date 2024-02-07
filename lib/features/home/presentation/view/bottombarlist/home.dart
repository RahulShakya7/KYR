import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_review_app/features/auth/domain/entity/user_entity.dart';
import 'package:news_review_app/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:news_review_app/features/news/presentation/view/news_draft.dart';
import 'package:news_review_app/features/news/presentation/viewmodel/news_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    var newsState = ref.watch(newsViewModelProvider);
    var userState = ref.watch(authViewModelProvider);
    UserEntity? user = userState.user;

    final currentTime =
        DateFormat.jm().format(DateTime.now()); // Get current time
    final currentDate =
        DateFormat.yMMMMd().format(DateTime.now()); // Get current date

    // final isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    final screenHeight = MediaQuery.of(context).size.height;

    final List<String> imgList = [
      'assets/slider/Rectangle1.png',
      'assets/slider/Rectangle2.png',
      'assets/slider/Rectangle3.png',
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Builder(
              builder: (context) {
                final double height = MediaQuery.of(context).size.height;
                return CarouselSlider(
                  options: CarouselOptions(
                    height: height / 1.48,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    // autoPlay: false,
                  ),
                  items: imgList.asMap().entries.map((entry) {
                    int index = entry.key;
                    String item = entry.value;
                    String subheading = '';
                    String heading = '';
                    if (index == 0) {
                      subheading = 'Go for the tracks';
                      heading = 'KTM Duke 890';
                    } else if (index == 1) {
                      subheading = 'Offroading with';
                      heading = 'Tata Gravitas';
                    } else if (index == 2) {
                      subheading = 'Pick your taste';
                      heading = 'Yamaha R1';
                    }

                    return Builder(
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            Center(
                              child: Image.asset(
                                item,
                                fit: BoxFit.cover,
                                height: height,
                              ),
                            ),
                            Positioned(
                              bottom: 80,
                              left: 30,
                              child: Text(
                                subheading,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(2, 2),
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 35,
                              left: 30,
                              child: Text(
                                heading,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(2, 2),
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 12, right: 12),
              child: Text(
                'Welcome, ${user?.username ?? "User"}',
                style: TextStyle(
                  fontSize: screenHeight > 900 ? 55 : 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // const SizedBox(height: 5),
            // Text(
            //   '$currentTime  |  $currentDate',
            //   style: TextStyle(
            //     fontSize: screenHeight > 900 ? 40 : 25,
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(12),
              height: screenHeight > 900
                  ? (screenHeight * 0.5)
                  : (screenHeight * 0.42),
              child: const NewsDraftView(),
            ),
            // const SizedBox(height: 20),
            // const Divider(
            //   height: 1,
            //   thickness: 2,
            //   color: AppColorConstant.secondaryColor,
            // ),
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(12),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Welcome to our KnowYourRide. We are a team of passionate individuals dedicated services to our customers. We provide quality content on the latest vehicle trends and reviews of vehicles',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Our Vision',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'To be a leader in our industry by delivering innovative solutions and exceptional customer experiences.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            // // const Divider(
            // //   height: 1,
            // //   thickness: 2,
            // //   color: Colors.grey,
            // // ),
            // const SizedBox(height: 10),
            // Container(
            //   padding: const EdgeInsets.only(top: 0, bottom: 5),
            //   // decoration:
            //   // BoxDecoration(border: Border.all(color: Colors.black)),
            //   child: Column(
            //     children: [
            //       Text(
            //         'Check out our Reviews',
            //         style: TextStyle(
            //           fontSize: screenHeight > 900 ? 30 : 20,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       const SizedBox(height: 8),
            //       Padding(
            //         padding: EdgeInsets.symmetric(
            //             horizontal: isTablet ? 64.0 : 16.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Expanded(
            //               child: ElevatedButton(
            //                 onPressed: () {
            //                   Navigator.of(context).push(MaterialPageRoute(
            //                     builder: (context) => const DashBoardView(),
            //                   ));
            //                 },
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: AppColorConstant.primaryColor,
            //                   padding: EdgeInsets.all(isTablet ? 32.0 : 14.0),
            //                 ),
            //                 child: Text(
            //                   'Reviews',
            //                   style: TextStyle(
            //                     color: AppColorConstant.secondaryColor,
            //                     fontSize: screenHeight > 900 ? 24 : 16,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 16),
            // Container(
            //   padding: const EdgeInsets.only(top: 0, bottom: 5),
            //   // decoration:
            //   // BoxDecoration(border: Border.all(color: Colors.black)),
            //   child: Column(
            //     children: [
            //       Text(
            //         'Choose your Type',
            //         style: TextStyle(
            //           fontSize: screenHeight > 900 ? 30 : 20,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       const SizedBox(height: 8),
            //       Padding(
            //         padding: EdgeInsets.symmetric(
            //             horizontal: isTablet ? 64.0 : 16.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Expanded(
            //               child: ElevatedButton(
            //                 onPressed: () {},
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: AppColorConstant.primaryColor,
            //                   padding: EdgeInsets.all(isTablet ? 32.0 : 16.0),
            //                 ),
            //                 child: Text(
            //                   'Gas',
            //                   style: TextStyle(
            //                     color: AppColorConstant.secondaryColor,
            //                     fontSize: screenHeight > 900 ? 24 : 16,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             const SizedBox(width: 16),
            //             Expanded(
            //               child: ElevatedButton(
            //                 onPressed: () {},
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: AppColorConstant.primaryColor,
            //                   padding: EdgeInsets.all(isTablet ? 32.0 : 16.0),
            //                 ),
            //                 child: Text(
            //                   'Electric',
            //                   style: TextStyle(
            //                     color: AppColorConstant.secondaryColor,
            //                     fontSize: screenHeight > 900 ? 24 : 16,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
