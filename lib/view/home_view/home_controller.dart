import 'package:get/get.dart';
import 'package:tik_app/data/call_api/product_repository.dart';
import 'package:tik_app/data/models/product_model.dart';

class HomeController extends GetxController {
  var products = <Products>[].obs;
  final ProductRepository repository = ProductRepository();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      var productList = await repository.getProducts();
      if (productList != null) {
        products.assignAll(productList);
      }
    } catch (e) {
      print("Error, Failed to fetch products: $e");
    }
  }

  Future<void> addProduct(Products product) async {
    try {
      var newProduct = await repository.addProduct(product);
      if (newProduct != null) {
        products.add(newProduct);
      }
    } catch (e) {
      print("Error, Failed to add product: $e");
    }
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
