import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/core/constant/text_styles.dart';

import '../controller/add_product_controller.dart';

class AddProdutScreen extends StatelessWidget {
  final AddProductController controller = Get.put(AddProductController());

  AddProdutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(
                  controller: controller.titleController,
                  label: "Product Title".tr,
                  validator: (value) => value!.isEmpty ? 'Title is required'.tr : null,
                ),
                _buildTextField(
                  controller: controller.imageController,
                  label: "Image URL".tr,
                  validator: (value) {
                    if (value!.isEmpty) return 'Image URL is required'.tr;
                    if (!value.startsWith('http')) return 'Invalid URL format'.tr;
                    return null;
                  },
                ),
                _buildTextField(
                  controller: controller.priceController,
                  label: "Price".tr,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return 'Price is required'.tr;
                    if (double.tryParse(value) == null) return 'Invalid number format'.tr;
                    return null;
                  },
                ),
                _buildTextField(
                  controller: controller.descriptionController,
                  label: "Description".tr,
                  maxLines: 3,
                  validator: (value) => value!.isEmpty ? 'Description is required'.tr : null,
                ),
                _buildTextField(
                  controller: controller.brandController,
                  label: "Brand".tr,
                  validator: (value) => value!.isEmpty ? 'Brand is required'.tr : null,
                ),
                _buildTextField(
                  controller: controller.modelController,
                  label: "Model".tr,
                  validator: (value) => value!.isEmpty ? 'Model is required'.tr : null,
                ),
                _buildTextField(
                  controller: controller.categoryController,
                  label: "Category".tr,
                  validator: (value) => value!.isEmpty ? 'Category is required'.tr : null,
                ),
                const SizedBox(height: 30),
                Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value ? null : () => controller.addProduct(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: AppColors.text)
                      : Text(
                    "Add Product".tr,
                    style: AppTextStyles.title.copyWith(
                        color: AppColors.text,
                        fontWeight: FontWeight.bold),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    FormFieldValidator<String>? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(color: AppColors.text),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.text.withOpacity(0.7)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.accent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.accent, width: 2)),
          errorStyle: TextStyle(color: AppColors.error),
          contentPadding: const EdgeInsets.all(16),
        ),
        validator: validator,
      ),
    );
  }
}