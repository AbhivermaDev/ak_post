import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import '../config/app_urls.dart';
import 'storage_service.dart';

class ApiService {
  late Dio _dio;
  bool _isInitialized = false;

  // Get StorageService from GetX
  StorageService get _storageService => getx.Get.find<StorageService>();

  Future<void> initialize() async {
    if (_isInitialized) {
      debugPrint('⚠️ ApiService already initialized');
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
            // try {
            //   // Add auth token if available
            //   final token = _storageService.getAuthToken();
            //
            //   if (token != null && token.isNotEmpty) {
            //     options.headers['Authorization'] = 'Bearer $token';
            //     debugPrint('📤 Token added: ${token.substring(0, 20)}...');
            //   }
            //
            //   debugPrint('📤 REQUEST[${options.method}] => ${options.path}');
            //   debugPrint('📤 Headers: ${options.headers}');
            //   debugPrint('📤 Data: ${options.data}');
            // } catch (e) {
            //   debugPrint('⚠️ Interceptor error: $e');
            // }

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