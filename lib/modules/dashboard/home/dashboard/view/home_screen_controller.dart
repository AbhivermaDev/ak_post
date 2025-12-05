import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kv_task/api/services/storage_service.dart';
import '../data/home_service.dart';
import '../data/post_response.dart';

class HomeScreenController extends GetxController {
  var isLoading = false.obs;
  HomeService get _service => Get.find<HomeService>();
  StorageService get _storageService => Get.find<StorageService>();

  var postList = <PostModel>[].obs;
  var favoriteIds = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadFavorites();
    fetchVehicles();
  }

  void _loadFavorites() {
    try {
      final favs = _storageService.getObject('favorite_products');
      if (favs != null && favs is List) {
        favoriteIds.value = List<int>.from(favs);
        print(" Loaded ${favoriteIds.length} favorites");
      } else {
        print(" No favorites found, starting fresh");
      }
    } catch (e) {
      print("Error loading favorites: $e");
    }
  }

  Future<void> _saveFavorites() async {
    await _storageService.setObject('favorite_products', favoriteIds);
    print("Saved ${favoriteIds.length} favorites");
  }

  void toggleFavorite(int productId) {
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
      print("Removed from favorites: $productId");
    } else {
      favoriteIds.add(productId);
      print("Added to favorites: $productId");
    }
    favoriteIds.refresh();
    _saveFavorites();
    update();
  }

  bool isFavorite(int productId) {
    return favoriteIds.contains(productId);
  }

  Future<void> fetchVehicles() async {
    try {
      isLoading(true);
      final response = await _service.postGet();

      if (response.success && response.data != null) {
        final List<PostModel> res = response.data!;

        if (res.isNotEmpty) {
          postList.value = res;
        } else {
          postList.clear();
        }
      } else {
        postList.clear();
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to load products',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      postList.clear();
      Get.snackbar(
        'Error',
        'Failed to load products: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}