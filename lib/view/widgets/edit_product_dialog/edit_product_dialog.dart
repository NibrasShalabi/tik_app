import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/core/constant/text_styles.dart';
import 'package:tik_app/data/models/product_model.dart';
import 'package:tik_app/view/home_view/controller/home_controller.dart';

import 'edit_product_dialog_controller.dart';

class EditProductDialog extends StatelessWidget {
  final Products product;
  final HomeController homeController;

  const EditProductDialog({
    Key? key,
    required this.product,
    required this.homeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProductController>(
      init: EditProductController(product: product, homeController: homeController),
      builder: (controller) {
        return AlertDialog(
          backgroundColor: AppColors.cardColor,
          title: Text(
            "Edit Product",
            style: AppTextStyles.price.copyWith(color: Colors.white),
          ),
          content: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller.titleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: AppTextStyles.title,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  style: AppTextStyles.price,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter a title";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.priceController,
                  decoration: InputDecoration(
                    labelText: "Price",
                    labelStyle: AppTextStyles.title,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  style: AppTextStyles.price,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter a price";
                    }
                    if (double.tryParse(value) == null) {
                      return "Enter a valid number";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("Cancel", style: AppTextStyles.price),
            ),
            ElevatedButton(
              onPressed: controller.saveProduct,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cardColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text("Save", style: AppTextStyles.price),
            ),
          ],
        );
      },
    );
  }
}