import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tik_app/data/models/product_model.dart';
import '../../../core/classes/crud_class.dart';
import '../../../core/services/service.dart';

class CartController extends GetxController {
  final RxList<Products> cartItems = <Products>[].obs;
  final RxInt cartCount = 0.obs;
  final LocalStorageService localStorage = Get.find();
  final AudioPlayer audioPlayer = AudioPlayer();
  final Crud crud = Crud();

  @override
  void onInit() {
    super.onInit();
    loadCartFromStorage();
  }

  double get totalPrice => cartItems.fold(
    0,
        (previousValue, product) => previousValue + (product.price ?? 0),
  );

  Future<void> loadCartFromStorage() async {
    try {
      final storedCart = localStorage.getCart();
      cartItems.addAll(storedCart);
      updateCartCount();
    } catch (e) {
      print('Error loading cart: $e');
    }
  }

  Future<void> saveCartToStorage() async {
    try {
      await localStorage.saveCart(cartItems);
    } catch (e) {
      print('Error saving cart: $e');
      Get.snackbar('Error', 'Failed to save cart');
    }
  }

  void updateCartCount() {
    cartCount.value = cartItems.length;
  }

  Future<void> playSound() async {
    try {
      await audioPlayer.setAsset('assets/sound/cart.mp3.wav');
      await audioPlayer.play();
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  Future<void> addToCart(Products product) async {
    try {
      cartItems.add(product);
      updateCartCount();
      await saveCartToStorage();
      await playSound();
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  Future<void> removeFromCart(Products product) async {
    try {
      cartItems.removeWhere((p) => p.id == product.id);
      updateCartCount();
      await saveCartToStorage();
      await playSound();
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }
// عشان ضيف زر و نضق السلة لتحديث االجاي
  // Future<void> clearCart() async {
  //   try {
  //     cartItems.clear();
  //     updateCartCount();
  //     await saveCartToStorage();
  //   } catch (e) {
  //     print('Error clearing cart: $e');
  //   }
  // }

  Future<void> deleteProductFromCart(int id) async {
    try {
      final success = await crud.deleteProduct(id);
      if (success) {
        cartItems.removeWhere((item) => item.id == id);
        updateCartCount();
        await saveCartToStorage();
      }
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}