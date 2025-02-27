import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/core/constant/text_styles.dart';
import 'package:tik_app/data/models/product_model.dart';
import 'package:tik_app/view/home_view/home_controller.dart';

class AddProductDialog extends StatefulWidget {
  final HomeController homeController;

  const AddProductDialog({super.key, required this.homeController});

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      final newProduct = Products(
        title: titleController.text.trim(),
        image: imageController.text.trim(),
        price: int.tryParse(priceController.text.trim()) ?? 0,
        description: descriptionController.text.trim(),
        brand: brandController.text.trim(),
        model: modelController.text.trim(),
        category: categoryController.text.trim(),
        color: "N/A",
        discount: 0,
        popular: false,
        onSale: false,
      );

      widget.homeController.addProduct(newProduct);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardColor,
      title: Text(
        "Add Product",
        style: AppTextStyles.title.copyWith(color: AppColors.text),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(titleController, "Title"),
              _buildTextField(imageController, "Image URL"),
              _buildTextField(priceController, "Price",
                  keyboardType: TextInputType.number),
              _buildTextField(descriptionController, "Description"),
              _buildTextField(brandController, "Brand"),
              _buildTextField(modelController, "Model"),
              _buildTextField(categoryController, "Category"),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _addProduct,
          child: Text("Add", style: TextStyle(color: AppColors.accent)),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Text("Cancel", style: TextStyle(color: AppColors.accent)),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: AppColors.text),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.text),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "$label is required";
          }
          return null;
        },
      ),
    );
  }
}
