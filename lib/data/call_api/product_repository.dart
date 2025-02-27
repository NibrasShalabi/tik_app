import 'package:dio/dio.dart';
import 'package:tik_app/data/models/product_model.dart';

class ProductRepository {
  final String baseUrl = 'https://fakestoreapi.in/api';
  final Dio dio = Dio();

  Future<List<Products>?> getProducts() async {
    try {
      final response = await dio.get('$baseUrl/products');
      if (response.statusCode == 200) {
        final productsResponse = product.fromJson(response.data);
        return productsResponse.products;
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error To getProducts: $e');
      return null;
    }
  }

  Future<Products?> addProduct(Products product) async {
    try {
      final response = await dio.post(
        '$baseUrl/products',
        data: product.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Products.fromJson(response.data);
      } else {
        print('Error In addProduct: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('ُError To addProduct: $e');
      return null;
    }
  }

  Future<bool?> deleteProduct(int id) async {
    try {
      final response = await dio.delete('$baseUrl/products/$id');
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error in deleteProduct: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error To deleteProduct: $e');
      return false;
    }
  }
}
