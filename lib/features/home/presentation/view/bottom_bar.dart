import 'package:flutter/material.dart';

import '../../../../config/constants/theme_constant.dart';

class AppNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const AppNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColorConstant.primaryColor,
      elevation: 0,
      iconSize: 35,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper),
          label: 'News',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.reviews),
          label: 'Reviews',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile ',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onItemSelected,
      selectedItemColor: AppColorConstant.accentColor,
      unselectedItemColor: const Color.fromARGB(255, 242, 242, 242),
    );
  }
}
