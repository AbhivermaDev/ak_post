
import 'package:get/get.dart';
import 'package:kv_task/modules/dashboard/home/dashboard/view/product_detail_controller.dart';
import 'package:kv_task/modules/dashboard/home/dashboard/view/product_detail_screen.dart';
import '../modules/dashboard/home/dashboard/view/home_screen.dart';
import '../modules/dashboard/home/dashboard/view/home_screen_controller.dart';
import '../modules/splash_controller.dart';
import '../modules/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeScreenController>(() => HomeScreenController());
      }),
    ),

    GetPage(
      name: AppRoutes.productDetail,
      page: () => ProductDetailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProductDetailController>(() => ProductDetailController());
      }),
    ),
  ];
}
