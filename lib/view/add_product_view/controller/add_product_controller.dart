import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/data/models/product_model.dart';
import 'package:tik_app/view/home_view/controller/home_controller.dart';
class AddProductController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  Future<void> addProduct() async {
    try {
      if (!formKey.currentState!.validate()) {
        showErrorSnackbar('Please fix the errors in the form'.tr);
        return;
      }

      isLoading.value = true;

      final newProduct = Products(
        title: titleController.text.trim(),
        price: double.parse(priceController.text.trim()),
        description: descriptionController.text.trim(),
        brand: brandController.text.trim(),
        model: modelController.text.trim(),
        category: categoryController.text.trim(),
        color: "N/A",
        discount: 0,
        popular: false,
        onSale: false,
      );

      await homeController.addProduct(newProduct);

      showSuccessSnackbar('Product added successfully'.tr);
      clearForm();
      Get.back();
    } on SocketException catch (_) {
      showErrorSnackbar('Server connection failed'.tr, isServerError: true);
    } on FormatException catch (_) {
      showErrorSnackbar('Invalid data format'.tr);
    } catch (e) {
      showErrorSnackbar('Failed to add product: ${e.toString()}'.tr);
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    titleController.clear();
    priceController.clear();
    descriptionController.clear();
    brandController.clear();
    modelController.clear();
    categoryController.clear();
  }

  void showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success'.tr,
      message,
      colorText: AppColors.text,
      backgroundColor: AppColors.success.withOpacity(0.9),
      icon: Icon(Icons.check_circle, color: AppColors.success),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  void showErrorSnackbar(String message, {bool isServerError = false}) {
    Get.snackbar(
      isServerError ? 'Server Error'.tr : 'Error'.tr,
      message,
      colorText: AppColors.text,
      backgroundColor: isServerError
          ? AppColors.error.withOpacity(0.8)
          : AppColors.warning.withOpacity(0.8),
      icon: Icon(
        isServerError ? Icons.cloud_off : Icons.error,
        color: isServerError ? AppColors.error : AppColors.warning,
      ),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 5),
    );
  }
}