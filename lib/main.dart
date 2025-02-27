import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tik_app/routes.dart';
import 'package:tik_app/view/favorites_view/favorites_controller.dart';
import 'package:tik_app/view/home_view/home_controller.dart';
import 'core/constant/responsive.dart';
import 'core/constant/routes.dart';

void main() {
  Get.put(HomeController());
  Get.put(FavoritesController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        AppSize.init(context);
        return GetMaterialApp(
          title: 'Tik App',
          debugShowCheckedModeBanner: false,
          getPages: AppPages.pages,
          initialRoute: AppRoutes.splash,
        );
      },
    );
  }
}
