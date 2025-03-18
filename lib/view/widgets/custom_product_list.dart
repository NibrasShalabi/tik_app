import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/data/models/product_model.dart';
import 'package:tik_app/view/widgets/product_card.dart';

class CustomProductList extends StatelessWidget {
  final RxList<Products> products;
  final String emptyMessage;
  final Function(Products) onToggleFavorite;
  final Function(Products) onDelete;
  final Function(Products) onAddToCart;

  const CustomProductList({
    Key? key,
    required this.products,
    required this.emptyMessage,
    required this.onToggleFavorite,
    required this.onDelete,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        if (products.isEmpty) {
          return Center(
            child: Text(
              emptyMessage,
              style: TextStyle(fontSize: 16, color: AppColors.text),
            ),
          );
        }

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              product: product,
              onToggleFavorite: () => onToggleFavorite(product),
              onDelete: () => onDelete(product),
              onAddToCart: () => onAddToCart(product),
            );
          },
        );
      },
    );
  }
}