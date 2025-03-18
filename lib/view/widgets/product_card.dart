import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/core/constant/responsive.dart';
import 'package:tik_app/core/constant/text_styles.dart';
import 'package:tik_app/data/models/product_model.dart';
import 'package:tik_app/view/cart_view/controller/cart_controller.dart';
import 'package:tik_app/view/favorites_view/controller/favorites_controller.dart';
import 'package:tik_app/view/home_view/controller/home_controller.dart';
import 'edit_product_dialog.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  final VoidCallback onDelete;
  final VoidCallback onToggleFavorite;
  final VoidCallback onAddToCart;

  ProductCard({
    Key? key,
    required this.product,
    required this.onDelete,
    required this.onToggleFavorite,
    required this.onAddToCart,
  }) : super(key: key);

  final FavoritesController favoritesController =
      Get.find<FavoritesController>();
  final HomeController homeController = Get.find<HomeController>();
  final CartController cartController = Get.find<CartController>();

  void _editProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EditProductDialog(
        product: product,
        homeController: homeController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSize.padding / 2),
      child: Card(
        color: AppColors.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.cardBorderRadius),
        ),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(AppSize.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: AppSize.imageSize,
                      height: AppSize.imageSize,
                      color: Colors.grey[300],
                      child: product.image != null && product.image!.isNotEmpty
                          ? Image.network(
                              product.image!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.broken_image,
                                      color: AppColors.text),
                            )
                          : Icon(Icons.image, color: AppColors.text),
                    ),
                  ),
                  SizedBox(width: AppSize.padding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title ?? 'No Title',
                          style: AppTextStyles.title,
                          softWrap: true,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Brand: ${product.brand ?? 'N/A'}',
                          style: AppTextStyles.subtitle
                              .copyWith(color: AppColors.text.withOpacity(0.7)),
                          softWrap: true,
                        ),
                        Text(
                          'Model: ${product.model ?? 'N/A'}',
                          style: AppTextStyles.subtitle
                              .copyWith(color: AppColors.text.withOpacity(0.7)),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize.padding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price}',
                    style: AppTextStyles.price,
                  ),
                  if (product.discount != null && product.discount! > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${product.discount}% OFF',
                        style: AppTextStyles.subtitle
                            .copyWith(color: AppColors.text),
                        softWrap: true,
                      ),
                    ),
                ],
              ),
              SizedBox(height: AppSize.padding),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => IconButton(
                        icon: Icon(
                          favoritesController.favorites.contains(product)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: 28,
                        ),
                        onPressed: onToggleFavorite,
                      )),
                  IconButton(
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.deepPurple,
                      size: 28,
                    ),
                    onPressed: onAddToCart,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit,
                            color: Colors.deepPurple, size: 28),
                        onPressed: () => _editProduct(context),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete,
                            color: AppColors.deleteColor, size: 28),
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
