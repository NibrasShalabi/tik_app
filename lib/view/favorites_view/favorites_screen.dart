import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/core/constant/responsive.dart';
import 'package:tik_app/core/constant/text_styles.dart';
import 'package:tik_app/data/models/product_model.dart';
import 'package:tik_app/view/favorites_view/favorites_controller.dart';
import 'package:tik_app/widgets/product_card.dart';

class FavoritesScreen extends StatelessWidget {
  final FavoritesController favoritesController =
      Get.find<FavoritesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Favorites', style: AppTextStyles.appBarTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.accent),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (favoritesController.favorites.isEmpty) {
          return Center(
            child: Text(
              'No favorites added yet.',
              style: AppTextStyles.subtitle.copyWith(color: AppColors.text),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(AppSize.padding),
          itemCount: favoritesController.favorites.length,
          itemBuilder: (context, index) {
            final Products product = favoritesController.favorites[index];
            return ProductCard(
              product: product,
              onToggleFavorite: () {
                favoritesController.toggleFavorite(product);
              },
              onDelete: () {
                if (product.id != null) {
                  favoritesController.deleteProduct(product.id!);
                }
              },
            );
          },
        );
      }),
    );
  }
}
