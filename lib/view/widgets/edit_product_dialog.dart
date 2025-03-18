import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/core/constant/text_styles.dart';
import 'package:tik_app/data/models/product_model.dart';
import 'package:tik_app/view/home_view/controller/home_controller.dart';

class EditProductDialog extends StatefulWidget {
  final Products product;
  final HomeController homeController;

  const EditProductDialog({
    Key? key,
    required this.product,
    required this.homeController,
  }) : super(key: key);

  @override
  _EditProductDialogState createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  late TextEditingController titleController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.product.title);
    priceController = TextEditingController(text: widget.product.price.toString());
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _saveProduct() async {
    Products updatedProduct = widget.product.copyWith(
      title: titleController.text,
      price: double.tryParse(priceController.text) ?? widget.product.price,
    );

    bool success = await widget.homeController.updateProduct(widget.product.id!, updatedProduct);

    Navigator.pop(context);

    if (success) {
      Get.snackbar("Success", "Product updated successfully",
          snackPosition: SnackPosition.TOP);
    } else {
      Get.snackbar("Error", "Failed to update product",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardColor,
      title: Text("Edit Product", style: AppTextStyles.price.copyWith(color: Colors.white)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: "Title",
              labelStyle:  AppTextStyles.title,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            style: AppTextStyles.price,
          ),
          SizedBox(height: 10),
          TextField(
            controller: priceController,
            decoration: InputDecoration(
              labelText: "Price",
              labelStyle: AppTextStyles.title,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            style: AppTextStyles.price,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: AppTextStyles.price),
        ),
        ElevatedButton(
          onPressed: _saveProduct,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.cardColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text("Save", style: AppTextStyles.price),
        ),
      ],
    );
  }
}
