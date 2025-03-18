import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/view/cart_view/controller/cart_controller.dart';
import 'package:tik_app/view/favorites_view/controller/favorites_controller.dart';
import 'package:tik_app/view/widgets/custom_product_list.dart';

class FavoritesScreen extends StatelessWidget {
  final FavoritesController favoritesController = Get.put(FavoritesController());
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomProductList(
        products: favoritesController.favorites,
        emptyMessage: 'No favorites added yet.',
        onToggleFavorite: (product) => favoritesController.toggleFavorite(product),
        onDelete: (product) {
          if (product.id != null) favoritesController.deleteProduct(product.id!);
        },
        onAddToCart: (product) => cartController.addToCart(product),
      )
    );
  }
}
