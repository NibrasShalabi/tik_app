import 'package:get/get.dart';
import 'package:tik_app/core/classes/crud_class.dart';
import 'package:tik_app/data/models/product_model.dart';

class HomeController extends GetxController {
  final RxList<Products> products = <Products>[].obs;
  final RxList<Products> filteredProducts = <Products>[].obs;
  final RxString searchQuery = ''.obs;
  final Crud repository = Crud();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }
  Future<void> fetchProducts() async {
    try {
      var productList = await repository.getProducts();
      if (productList != null) {
        products.assignAll(productList);
        filteredProducts.assignAll(productList);
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }
  void filterProducts(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(
          products.where((p) => p.matchesQuery(query)).toList()
      );
    }
  }
  Future<void> addProduct(Products product) async {
    try {
      var newProduct = await repository.addProduct(product);
      if (newProduct != null) {
        products.insert(0, newProduct);
        filterProducts(searchQuery.value);
        Get.snackbar('Success', 'Product added successfully');
        update();
      } else {
        Get.snackbar('Error', 'Failed to add product: Server returned null');
      }
    } catch (e) {
      print("Error adding product: $e");
      Get.snackbar(
        'Error',
        'Failed to add product: ${e.toString()}',
        duration: Duration(seconds: 5),
      );
    }
  }

  Future<bool> updateProduct(int id, Products updatedProduct) async {
    try {
      final updated = await repository.updateProduct(id, updatedProduct);
      int index = products.indexWhere((p) => p.id == id);
      if (index != -1) {
        products[index] = updated.copyWith(id: id);
        filterProducts(searchQuery.value);
        update();
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating product: $e');
      Get.snackbar("Error", "Failed to update product");
      return false;
    }
  }


  Future<void> deleteProduct(int id) async {
    try {
      bool success = await repository.deleteProduct(id) ?? false;
      if (success) {
        products.removeWhere((p) => p.id == id);
        filterProducts(searchQuery.value);
        Get.snackbar("Deleted", "Product deleted successfully");
      }
    } catch (e) {
      print("Error deleting product: $e");
      Get.snackbar("Error", "Failed to delete product");
    }
  }
}
