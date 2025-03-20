import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/view/cart_view/controller/cart_controller.dart';
import 'package:tik_app/view/favorites_view/controller/favorites_controller.dart';
import 'package:tik_app/view/home_view/controller/home_controller.dart';
import 'package:tik_app/view/widgets/bottom_navigation_bar/Custom_bottom_navigation_bar.dart';
import 'package:tik_app/view/widgets/bottom_navigation_bar/bottom_navigation_bar_controller.dart';
import 'package:tik_app/view/widgets/custom_appbar.dart';
import 'package:tik_app/view/widgets/custom_product_list.dart';
import 'package:tik_app/view/widgets/custom_search_bar.dart';

class HomeScreen extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppbar(),
      body: Obx(() => navController.currentScreen),
      bottomNavigationBar: CustomBottomNavigationBar(navController: navController),
    );
  }
}

class HomeContentScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final FavoritesController favoritesController = Get.find();
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          CustomSearchBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => await homeController.fetchProducts(),
              child: CustomProductList(
                products: homeController.filteredProducts,
                emptyMessage: 'No products found',
                onToggleFavorite: (product) =>
                    favoritesController.toggleFavorite(product),
                onDelete: (product) {
                  if (product.id != null) homeController.deleteProduct(product.id!);
                },
                onAddToCart: (product) => cartController.addToCart(product),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
