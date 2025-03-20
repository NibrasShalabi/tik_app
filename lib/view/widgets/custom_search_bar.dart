import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/core/constant/responsive.dart';
import 'package:tik_app/core/constant/text_styles.dart';
import 'package:tik_app/view/home_view/controller/home_controller.dart';

class CustomSearchBar extends StatelessWidget {
   CustomSearchBar({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSize.padding),
      child: TextField(
        style: TextStyle(color: AppColors.text),
        decoration: InputDecoration(
          hintText: 'Search products...',
          hintStyle: AppTextStyles.price,

          prefixIcon: Icon(Icons.search, color: AppColors.accent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.accent),
          ),
          filled: true,
          fillColor: Colors.black,
        ),
        onChanged: (value) => homeController.filterProducts(value),
      ),
    );
  }
}
