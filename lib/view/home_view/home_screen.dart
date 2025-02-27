import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/core/constant/responsive.dart';
import 'package:tik_app/core/constant/text_styles.dart';
import 'package:tik_app/data/models/product_model.dart';
import 'package:tik_app/view/favorites_view/favorites_controller.dart';
import 'package:tik_app/widgets/add_product_dialog.dart';
import 'package:tik_app/widgets/product_card.dart';

import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final FavoritesController favoritesController =
      Get.find<FavoritesController>();

  HomeScreen({Key? key}) : super(key: key);

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddProductDialog(homeController: homeController),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Products', style: AppTextStyles.appBarTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: AppColors.accent),
            onPressed: () {
              Get.toNamed('/favorites');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        child: Icon(Icons.add),
        onPressed: () => _showAddProductDialog(context),
      ),
      body: Obx(() {
        if (homeController.products.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: EdgeInsets.all(AppSize.padding),
          itemCount: homeController.products.length,
          itemBuilder: (context, index) {
            final Products product = homeController.products[index];
            return ProductCard(
              product: product,
              onToggleFavorite: () {
                favoritesController.toggleFavorite(product);
              },
              onDelete: () {
                if (product.id != null) {
                  homeController.deleteProduct(product.id!);
                }
              },
            );
          },
        );
      }),
    );
  }
}
