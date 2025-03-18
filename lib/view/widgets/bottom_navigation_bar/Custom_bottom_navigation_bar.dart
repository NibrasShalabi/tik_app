import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'bottom_navigation_bar_controller.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final NavigationController navController;

  const CustomBottomNavigationBar({Key? key, required this.navController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: AppColors.background,
      color: AppColors.accent,
      animationDuration: const Duration(milliseconds: 300),
      index: navController.selectedIndex.value,
      onTap: (index) => navController.changeIndex(index),
      items: [
        _buildIconNavItem(Icons.shopping_cart, Icons.shopping_cart_outlined, 0),
        _buildIconNavItem(Icons.home, Icons.home_outlined, 1),
        _buildIconNavItem(Icons.favorite, Icons.favorite_outline, 2),
        _buildIconNavItem(Icons.add_circle, Icons.add_circle_outline, 3),
      ],
    ));
  }



  Widget _buildIconNavItem(IconData activeIcon, IconData inactiveIcon, int index) {
    return Icon(
      navController.selectedIndex.value == index ? activeIcon : inactiveIcon,
      color: AppColors.text,
      size: 40,
    );
  }
}