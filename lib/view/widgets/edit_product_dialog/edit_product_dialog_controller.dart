import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tik_app/data/models/product_model.dart';
import 'package:tik_app/view/home_view/controller/home_controller.dart';

class EditProductController extends GetxController {
  final Products product;
  final HomeController homeController;
  late TextEditingController titleController;
  late TextEditingController priceController;
  final formKey = GlobalKey<FormState>();

  EditProductController({
    required this.product,
    required this.homeController,
  });

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController(text: product.title);
    priceController = TextEditingController(text: product.price.toString());
  }

  @override
  void onClose() {
    titleController.dispose();
    priceController.dispose();
    super.onClose();
  }

  Future<void> saveProduct() async {
    if (formKey.currentState?.validate() ?? false) {
      Products updatedProduct = product.copyWith(
        title: titleController.text,
        price: double.tryParse(priceController.text) ?? product.price,
      );
      print('Updating product data: ${updatedProduct.toJson()}');

      bool success = await homeController.updateProduct(product.id!, updatedProduct);
      Get.back();

      if (success) {
        Get.snackbar("Success", "Product updated successfully",
            snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar("Error", "Failed to update product",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    }
  }
}