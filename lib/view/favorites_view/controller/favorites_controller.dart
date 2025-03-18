import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tik_app/core/constant/colors.dart';
import 'package:tik_app/data/models/product_model.dart';
import '../../../core/classes/crud_class.dart';
import '../../../core/services/service.dart';

class FavoritesController extends GetxController {
  final RxList<Products> favorites = <Products>[].obs;
  final LocalStorageService localStorage = Get.find();
  final AudioPlayer audioPlayer = AudioPlayer();
  final Crud _repository = Crud();

  @override
  void onInit() {
    super.onInit();
    _loadInitialFavorites();
  }

  void _loadInitialFavorites() {
    try {
      final storedFavorites = localStorage.getFavorites();
      favorites.addAll(storedFavorites);
      _removeDuplicates();
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  void _removeDuplicates() {
    final uniqueIds = <int>{};
    favorites.retainWhere((product) => uniqueIds.add(product.id ?? -1));
  }

  Future<void> playSound() async {
    try {
      await audioPlayer.setAsset('assets/sound/fav.mp3.wav');
      await audioPlayer.play();
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  Future<void> toggleFavorite(Products product) async {
    try {
      if (isFavorite(product)) {
        await removeFavorite(product);
      } else {
        await addFavorite(product);
      }
      await saveFavorites();
      await playSound();
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  bool isFavorite(Products product) {
    return favorites.any((p) => p.id == product.id);
  }

  Future<void> addFavorite(Products product) async {
    if (!isFavorite(product)) {
      favorites.add(product);
    }
  }

  Future<void> removeFavorite(Products product) async {
    favorites.removeWhere((p) => p.id == product.id);
  }

  Future<void> removeFavoriteById(int productId) async {
    try {
      favorites.removeWhere((p) => p.id == productId);
      await saveFavorites();
      showSuccessSnackbar('Removed from favorites');
    } catch (e) {
      print('Error removing favorite: $e');
      showErrorSnackbar('Failed to remove favorite');
    }
  }

  Future<void> saveFavorites() async {
    try {
      await localStorage.saveFavorites(favorites);
    } catch (e) {
      print('Error saving favorites: $e');
      throw Exception('Failed to save favorites');
    }
  }
// نفس صفحة الالسلة االأضافة الجاي
  // Future<void> clearFavorites() async {
  //   try {
  //     favorites.clear();
  //     await _saveFavorites();
  //     showSuccessSnackbar('Favorites cleared');
  //   } catch (e) {
  //     print('Error clearing favorites: $e');
  //     showErrorSnackbar('Failed to clear favorites');
  //   }
  // }

  void showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
    );
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      duration: Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error,
      colorText: AppColors.text,
    );
  }

  Future<void> deleteProduct(int id) async {
    try {
      final success = await _repository.deleteProduct(id);
      if (success) {
        removeFavoriteById(id);
        showSuccessSnackbar('Product deleted');
      }
    } catch (e) {
      print('Error deleting product: $e');
      showErrorSnackbar('Failed to delete product');
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  void testSound() async {
    try {
      await audioPlayer.setAsset('assets/sound/fav.mp3.wav');
      await audioPlayer.play();
    } catch (e) {
      print('Sound test error: $e');
    }
  }
}