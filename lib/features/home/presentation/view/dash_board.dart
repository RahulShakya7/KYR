import 'package:flutter/material.dart';
import 'package:news_review_app/features/auth/presentation/view/profile_view.dart';
import 'package:news_review_app/features/news/presentation/view/news.dart';

import '../../../vehicles/presentation/view/vehicles.dart';
import 'bottombarlist/home.dart';
import 'top_bar.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DashBoardView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> screenlst = [
    const HomeView(),
    const NewsView(),
    const VehicleView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppBarView(
      selectedIndex: _selectedIndex,
      onItemSelected: _onItemTapped,
      body: screenlst[_selectedIndex],
    );
  }
}
