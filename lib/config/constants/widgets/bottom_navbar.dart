import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:news_review_app/config/constants/theme_constant.dart';
import 'package:news_review_app/features/auth/presentation/view/profile_view.dart';
import 'package:news_review_app/features/home/presentation/view/bottombarlist/home.dart';
import 'package:news_review_app/features/news/presentation/view/news.dart';
import 'package:news_review_app/features/vehicles/presentation/view/vehicles.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({Key? key}) : super(key: key);

  @override
  CustomBottomNavbarState createState() => CustomBottomNavbarState();
}

class CustomBottomNavbarState extends State<CustomBottomNavbar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          // Screens corresponding to each index
          Center(child: HomeView()),
          Center(child: NewsView()),
          Center(child: VehicleView()),
          Center(child: ProfileView()),
        ],
      ),
      bottomNavigationBar: FloatingNavbar(
        onTap: (int val) {
          setState(() {
            _currentIndex = val;
          });
        },
        currentIndex: _currentIndex,
        items: [
          FloatingNavbarItem(icon: Icons.home),
          FloatingNavbarItem(icon: Icons.newspaper),
          FloatingNavbarItem(icon: Icons.reviews_outlined),
          FloatingNavbarItem(icon: Icons.person),
        ],
        backgroundColor: AppColorConstant.secondaryColor,
        selectedBackgroundColor: AppColorConstant.secondaryColor,
        selectedItemColor: AppColorConstant.accentColor,
        elevation: 25,
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
      ),
    );
  }
}
