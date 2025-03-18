import 'package:flutter/material.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/core/constant/text_styles.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {

  const CustomAppbar({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.accent,
      title: Text(
        'Welcome Back..',
        style: AppTextStyles.appBarTitle,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
