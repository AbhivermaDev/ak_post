import 'package:get/get.dart';
import '../../../../../api/base_model.dart';
import '../data/home_service.dart';
import '../data/post_detail_response.dart';

class ProductDetailController extends GetxController {
  HomeService get _service => Get.find<HomeService>();

  var isLoading = false.obs;

  Rxn<UserPost> post = Rxn<UserPost>();
  RxString errorMessage = "".obs;

  late int postId;

  @override
  void onInit() {
    super.onInit();
    postId = Get.arguments ?? 0;
    fetchModels(postId);
  }

  /// Fetch single post detail
  Future<void> fetchModels(int id) async {
    try {
      isLoading(true);
      errorMessage("");

      final response = await _service.postDetailGet(id: id);

      if (response.success && response.data != null) {
        post.value = response.data;     // ✅ Correct
      } else {
        post.value = null;
        errorMessage(response.message ?? "Failed to load post");
        print("❌ Failed: ${response.message}");
      }

    } catch (e) {
      post.value = null;
      errorMessage("Something went wrong: $e");
      print("❌ ERROR: $e");

    } finally {
      isLoading(false);
    }
  }
}
