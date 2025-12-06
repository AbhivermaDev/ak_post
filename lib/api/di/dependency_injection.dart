import 'package:get/get.dart';
import 'package:kv_task/modules/dashboard/home/dashboard/data/home_service.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class DependencyInjection {

  static Future<void> init() async {
    await _initServices();
  }

  static Future<void> _initServices() async {
    try {
      // 1️⃣ Initialize StorageService FIRST
      final storageService = StorageService();
      await storageService.initialize();
      Get.put<StorageService>(storageService, permanent: true);
      print('✅ StorageService initialized');

      // 2️⃣ Initialize ApiService
      final apiService = ApiService();
      await apiService.initialize();
      Get.put<ApiService>(apiService, permanent: true);
      print('✅ ApiService initialized');

      // 3️⃣ Register HomeService
      Get.lazyPut<HomeService>(() => HomeService());
      print('✅ HomeService registered');

    } catch (e) {
      print('❌ DependencyInjection Error: $e');
      rethrow;
    }
  }

  // Get service instances
  static ApiService get apiService => Get.find<ApiService>();
  static HomeService get homeService => Get.find<HomeService>();
  static StorageService get storageService => Get.find<StorageService>();

  // Dispose all dependencies
  static void dispose() {
    Get.deleteAll();
  }

  // Check if service is registered
  static bool isRegistered<T>() {
    return Get.isRegistered<T>();
  }

  // Register a service if not already registered
  static void registerIfNotExists<T>(T service) {
    if (!Get.isRegistered<T>()) {
      Get.put<T>(service);
    }
  }

  // Register a lazy service
  static void registerLazy<T>(T Function() factory) {
    if (!Get.isRegistered<T>()) {
      Get.lazyPut<T>(factory);
    }
  }

  // Register a singleton service
  static void registerSingleton<T>(T service) {
    if (!Get.isRegistered<T>()) {
      Get.put<T>(service, permanent: true);
    }
  }
}