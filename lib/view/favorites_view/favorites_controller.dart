import 'package:get/get.dart';
import 'package:tik_app/data/call_api/product_repository.dart';
import 'package:tik_app/data/models/product_model.dart';

class FavoritesController extends GetxController {
  var favorites = <Products>[].obs;
  var products = <Products>[].obs;

  final ProductRepository repository = ProductRepository();

  void toggleFavorite(Products product) {
    if (favorites.contains(product)) {
      favorites.remove(product);
    } else {
      favorites.add(product);
    }
  }

  void removeFavorite(Products product) {
    favorites.remove(product);
  }

  Future<void> deleteProduct(int id) async {
    try {
      bool success = (await repository.deleteProduct(id)) ?? false;
      if (success) {
        products.removeWhere((p) => p.id == id);
      }
    } catch (e) {
      print("Error, Failed to delete product: $e");
    }
  }
}
