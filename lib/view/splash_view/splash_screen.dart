import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/core/constant/routes.dart';
import 'package:tik_app/core/constant/text_styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    indecetot();

    return Scaffold(
      backgroundColor: AppColors.accent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Lottie.asset(
            'assets/animation/Animation_1740222879103.json',
            width: screenWidth * 0.5,
            height: screenHeight * 0.3,
            fit: BoxFit.contain,
          ),
          Text("Welcome to TikApp!",textAlign: TextAlign.center, style:AppTextStyles.Welcome)

          ,
        ],
      ),
    );
  }

  void indecetot() {
     Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.home,);
    });
  }
}
