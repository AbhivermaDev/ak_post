import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import '../../modules/dashboard/home/dashboard/view/home_screen_controller.dart';
import '../config/app_urls.dart';
import 'storage_service.dart';

class ApiService {
  late Dio _dio;
  bool _isInitialized = false;
  HomeScreenController get _controller => getx.Get.find<HomeScreenController>();

  Future<void> initialize() async {
    if (_isInitialized) {
      debugPrint('️ ApiService already initialized');
      return;
    }

    try {
      _dio = Dio(
        BaseOptions(
          baseUrl: AppUrls.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      // Add interceptors
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.next(options);
          },
          onResponse: (response, handler) {
            debugPrint('📥 RESPONSE[${response.statusCode}]');
            debugPrint('📥 Data Type: ${response.data.runtimeType}');
            return handler.next(response);
          },
          onError: (DioException error, handler) {
            debugPrint('❌ ERROR[${error.response?.statusCode}]');
            debugPrint('❌ Message: ${error.message}');
            debugPrint('❌ Type: ${error.type}');
            debugPrint('❌ Data: ${error.response?.data}');

            // Show dialog for internet connectivity issues
            _handleInternetError(error);

            return handler.next(error);
          },
        ),
      );

      _isInitialized = true;
      debugPrint('✅ ApiService initialized with baseUrl: ${AppUrls.baseUrl}');
    } catch (e) {
      debugPrint('❌ ApiService initialization failed: $e');
      rethrow;
    }
  }

  void _handleInternetError(DioException error) {
    // Check if error is related to internet connectivity
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError ||
        error.message?.contains('SocketException') == true ||
        error.message?.contains('Failed host lookup') == true) {

      _showInternetErrorDialog();
    }
  }

  void _showInternetErrorDialog() {
    // Check if dialog is already showing
    if (getx.Get.isDialogOpen == true) return;

    getx.Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(maxWidth: 340),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon with gradient background
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red.shade400, Colors.red.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.wifi_off_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              SizedBox(height: 20),

              // Title
              Text(
                'No Internet',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(height: 12),

              // Description
              Text(
                'Please check your connection\nand try again',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              SizedBox(height: 28),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        getx.Get.back();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                      _controller.fetchVehicles();
                      getx.Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Retry',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _checkInitialized() {
    if (!_isInitialized) {
      throw Exception('ApiService not initialized. Call initialize() first.');
    }
  }

  // GET Request
  Future<Response?> get(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      _checkInitialized();
      debugPrint('🔵 GET: $endpoint');
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      debugPrint('❌ GET Error: ${e.message}');
      debugPrint('❌ Error Type: ${e.type}');
      rethrow;
    } catch (e) {
      debugPrint('❌ Unexpected GET Error: $e');
      rethrow;
    }
  }

  // POST Request
  Future<Response?> post(String endpoint, {dynamic data}) async {
    try {
      _checkInitialized();
      debugPrint('🔵 POST Request to: $endpoint');
      debugPrint('🔵 POST Data: $data');
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      debugPrint('❌ POST Error: ${e.message}');
      debugPrint('❌ Error Type: ${e.type}');
      rethrow;
    } catch (e) {
      debugPrint('❌ Unexpected POST Error: $e');
      rethrow;
    }
  }

  // PUT Request
  Future<Response?> put(String endpoint, {dynamic data}) async {
    try {
      _checkInitialized();
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      debugPrint('❌ PUT Error: ${e.message}');
      rethrow;
    }
  }

  // DELETE Request
  Future<Response?> delete(String endpoint, {dynamic data}) async {
    try {
      _checkInitialized();
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      debugPrint('❌ DELETE Error: ${e.message}');
      rethrow;
    }
  }

  void updateBaseUrl(String newBaseUrl) {
    _checkInitialized();
    _dio.options.baseUrl = newBaseUrl;
    debugPrint('✅ Base URL updated to: $newBaseUrl');
  }
}