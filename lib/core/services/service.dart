import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/product_model.dart';

class LocalStorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<LocalStorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  
  Future<void> saveCart(List<Products> cartItems) async {
    final cartJson = cartItems.map((item) => item.toJsonString()).toList();
    await _prefs.setStringList('cart', cartJson);
  }

  List<Products> getCart() {
    final cartJson = _prefs.getStringList('cart') ?? [];
    return cartJson.map((json) => Products.fromJsonString(json)).toList();
  }

  Future<void> saveFavorites(List<Products> favorites) async {
    final favJson = favorites.map((item) => item.toJsonString()).toList();
    await _prefs.setStringList('favorites', favJson);
  }

  List<Products> getFavorites() {
    final favJson = _prefs.getStringList('favorites') ?? [];
    return favJson.map((json) => Products.fromJsonString(json)).toList();
  }

  Future<void> saveAddedProducts(List<Products> products) async {
    final productsJson = products.map((item) => item.toJsonString()).toList();
    await _prefs.setStringList('added_products', productsJson);
  }

  List<Products> getAddedProducts() {
    final productsJson = _prefs.getStringList('added_products') ?? [];
    return productsJson.map((json) => Products.fromJsonString(json)).toList();
  }
}
initialServices ()async{
  await Get.putAsync(() => LocalStorageService().init());
}