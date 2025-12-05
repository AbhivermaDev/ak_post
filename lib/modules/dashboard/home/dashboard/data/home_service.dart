import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:kv_task/modules/dashboard/home/dashboard/data/post_detail_response.dart';
import 'package:kv_task/modules/dashboard/home/dashboard/data/post_response.dart';
import '../../../../../api/base_model.dart';
import '../../../../../api/config/app_urls.dart';
import '../../../../../api/services/api_service.dart';

class HomeService {
  ApiService get _apiService => Get.find<ApiService>();

  Future<ApiResponse<List<PostModel>>> postGet() async {
    try {
      final response = await _apiService.get(AppUrls.posts);

      if (response == null) {
        return ApiResponse.error("Null response from server");
      }

      if (response.statusCode == 200) {

        if (response.data is List) {
          List<PostModel> posts =
          (response.data as List).map((e) => PostModel.fromJson(e)).toList();

          return ApiResponse.success(posts);
        } else {
          return ApiResponse.error("Expected list but got ${response.data.runtimeType}");
        }

      } else {
        return ApiResponse.error("Server error: ${response.statusCode}");
      }
    } on DioException catch (e) {
      return ApiResponse.error("Dio Error: ${e.message}");
    } catch (e) {
      return ApiResponse.error("Unexpected Error: $e");
    }
  }

  Future<ApiResponse<UserPost>> postDetailGet({required int id}) async {
    try {
      final response = await _apiService.get("${AppUrls.posts}/$id");

      print("🔍 RAW RESPONSE: ${response?.data}");
      print("🔍 STATUS CODE: ${response?.statusCode}");
      print("🔍 TYPE: ${response?.data.runtimeType}");

      if (response == null) {
        return ApiResponse.error("Null response from server");
      }

      if (response.statusCode == 200) {

        if (response.data is Map<String, dynamic>) {
          UserPost post = UserPost.fromJson(response.data);
          return ApiResponse.success(post);
        } else {
          return ApiResponse.error(
              "Expected Map but got ${response.data.runtimeType}");
        }

      } else {
        return ApiResponse.error("Server error: ${response.statusCode}");
      }

    } on DioException catch (e) {
      return ApiResponse.error("Dio Error: ${e.message}");
    } catch (e) {
      return ApiResponse.error("Unexpected Error: $e");
    }
  }

}
