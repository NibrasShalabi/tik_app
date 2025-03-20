import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/product_model.dart';

class LocalStorageService extends GetxService {
  late SharedPreferences prefs;

  Future<LocalStorageService> init() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  
  Future<void> saveCart(List<Products> cartItems) async {
    final cartJson = cartItems.map((item) => item.toJsonString()).toList();
    await prefs.setStringList('cart', cartJson);
  }

  List<Products> getCart() {
    final cartJson = prefs.getStringList('cart') ?? [];
    return cartJson.map((json) => Products.fromJsonString(json)).toList();
  }

  Future<void> saveFavorites(List<Products> favorites) async {
    final favJson = favorites.map((item) => item.toJsonString()).toList();
    await prefs.setStringList('favorites', favJson);
  }

  List<Products> getFavorites() {
    final favJson = prefs.getStringList('favorites') ?? [];
    return favJson.map((json) => Products.fromJsonString(json)).toList();
  }

  Future<void> saveAddedProducts(List<Products> products) async {
    final productsJson = products.map((item) => item.toJsonString()).toList();
    await prefs.setStringList('added_products', productsJson);
  }

  List<Products> getAddedProducts() {
    final productsJson = prefs.getStringList('added_products') ?? [];
    return productsJson.map((json) => Products.fromJsonString(json)).toList();
  }
}
initialServices ()async{
  await Get.putAsync(() => LocalStorageService().init());
}