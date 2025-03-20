import 'package:dio/dio.dart';
import 'package:tik_app/data/models/product_model.dart';
import 'package:tik_app/core/services/dio_client.dart';
import '../services/app_links.dart';

class Crud {
  final Dio dio;

  Crud({Dio? dioClient}) : dio = dioClient ?? DioClient().dio;

  Future<List<Products>?> getProducts() async {
    try {
      final response = await dio.get(AppLinks.products);
      if (response.statusCode == 200) {
        final productsResponse = ProductResponse.fromJson(response.data);
        return productsResponse.products;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error To getProducts: $e');
      throw Exception('Failed to fetch products');
    }
  }

  Future<Products?> addProduct(Products product) async {
    try {
      final response = await dio.post(
        'https://your-api.com/products',
        data: product.toJson(),
      );

      if (response.statusCode == 201) {
        return Products.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error in addProduct: $e");
      throw Exception('Failed to add product');
    }
  }

  Future<Products> updateProduct(int id, Products updatedProduct) async {
    try {
      final response = await dio.put(
        '${AppLinks.products}/$id',
        data: updatedProduct.toJson(),
      );
      if (response.statusCode == 200) {
        return Products.fromJson(response.data);
      } else {
        throw Exception('Error in updateProduct: ${response.statusCode}');
      }
    } catch (e) {
      print('Error To updateProduct: $e');
      throw Exception('Failed to update product');
    }
  }

  Future<bool> deleteProduct(int id) async {
    try {
      final response = await dio.delete('${AppLinks.products}/$id');
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Error in deleteProduct: ${response.statusCode}');
      }
    } catch (e) {
      print('Error To deleteProduct: $e');
      throw Exception('Failed to delete product');
    }
  }
}
