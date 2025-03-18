import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/core/constant/text_styles.dart';
import 'package:tik_app/view/cart_view/controller/cart_controller.dart';
import 'package:tik_app/view/favorites_view/controller/favorites_controller.dart';
import 'package:tik_app/view/widgets/custom_product_list.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final FavoritesController favoritesController = Get.put(FavoritesController());

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Obx(
            () => FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: AppColors.background,
          icon: const Icon(Icons.shopping_cart, color: AppColors.text),
          label: Text(
            '\$${cartController.totalPrice.toStringAsFixed(2)}',
            style: AppTextStyles.price,
          ),
        ),
      ),
      body: CustomProductList(
        products: cartController.cartItems,
        emptyMessage: 'Empty Cart',
        onToggleFavorite: (product) => favoritesController.toggleFavorite(product),
        onDelete: (product) {
          if (product.id != null) cartController.deleteProductFromCart(product.id!);
        },
        onAddToCart: (product) => cartController.removeFromCart(product),
      )
    );
  }
}