import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tik_app/view/add_product_view/screen/add_product_screen.dart';
import 'package:tik_app/view/cart_view/screen/cart_screen.dart';
import 'package:tik_app/view/favorites_view/screen/favorites_screen.dart';
import 'package:tik_app/view/home_view/screen/home_screen.dart';



class NavigationController extends GetxController {
  var selectedIndex = 1.obs;

  final List<Widget> screens = [
    CartScreen(),
    HomeContentScreen(),
    FavoritesScreen(),
    AddProdutScreen()
  ];

  Widget get currentScreen => screens[selectedIndex.value];

  void changeIndex(int index) {
    if (index != selectedIndex.value) {
      selectedIndex.value = index;
    }
  }
}
