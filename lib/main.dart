import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tik_app/routes.dart';
import 'bindings/initialize_binding.dart';
import 'core/constant/responsive.dart';
import 'core/constant/routes.dart';
import 'core/services/service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
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
          initialBinding: InitialBindings(),
          getPages: AppPages.pages,
          initialRoute: AppRoutes.splash,
        );
      },
    );
  }
}
