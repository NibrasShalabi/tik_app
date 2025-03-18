import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:tik_app/view/favorites_view/screen/favorites_screen.dart';
import 'package:tik_app/view/home_view/screen/home_screen.dart';
import 'package:tik_app/view/splash_view/splash_screen.dart';

import 'core/constant/routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () =>  HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () =>  FavoritesScreen(),
    ),
  ];
}
