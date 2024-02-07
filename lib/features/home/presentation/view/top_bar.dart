import 'package:flutter/material.dart';
import 'package:news_review_app/config/constants/widgets/bottom_navbar.dart';

import '../../../../config/constants/theme_constant.dart';

class AppBarView extends StatelessWidget {
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const AppBarView({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Container(
          alignment: Alignment.center,
          height: 70,
          width: 200,
          child: Image.asset(
            'assets/logo/logo.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColorConstant.primaryColor,
        foregroundColor: AppColorConstant.secondaryColor,
      ),
      body: body,
      bottomNavigationBar: const CustomBottomNavbar(),
    );
  }
}
