import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kv_task/modules/dashboard/home/dashboard/view/home_screen_controller.dart';
import 'package:kv_task/theme/app_colors.dart';
import 'package:kv_task/widgets/app_text.dart';

import '../../../../../routes/app_routes.dart';
class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  AppText(title: "Posts", fontSize: 18, color: appColors.appWhite,fontWeight: FontWeight.bold,),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appColors.appCOlor,
        actions: [
          Obx(() => controller.favoriteIds.isNotEmpty
              ? Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: appColors.appWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    AppText(title:
                      '${controller.favoriteIds.length}',
                        fontWeight: FontWeight.bold,
                        color: appColors.black,
                      ),
                  ],
                ),
              ),
            ),
          )
              : const SizedBox()),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: appColors.appCOlor,
                ),
                const SizedBox(height: 16),
                const AppText(title:
                  "Loading posts...",
                    fontSize: 14,
                    color: Colors.grey,
                  ),
              ],
            ),
          );
        }

        if (controller.postList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inbox_outlined,
                  size: 80,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                const AppText(title:
                  "No posts available",
                    fontSize: 16,
                    color: Colors.grey,
                  ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: controller.postList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final post = controller.postList[index];

              return Obx(() {
                final isFav = controller.isFavorite(post.id ?? 0);

                return GestureDetector(
                  onTap: () {
                    controller.toggleFavorite(post.id ?? 0);
                    Get.toNamed(AppRoutes.productDetail,arguments: post.id);
                  },

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isFav ? appColors.appWhite : Colors.yellow.shade100,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isFav
                            ? Colors.grey.shade300
                            : Colors.yellow.shade700,
                        width: isFav ? 1 : 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isFav
                              ? Colors.black.withOpacity(0.05)
                              : Colors.yellow.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isFav
                                ? appColors.appCOlor.withOpacity(0.1)
                                : Colors.yellow.shade200,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isFav
                                      ? appColors.appCOlor
                                      : Colors.orange.shade600,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: AppText(title:
                                  'User ${post.userId ?? 0}',
                                    color: appColors.appWhite,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              GestureDetector(
                                onTap: () {
                                  controller.toggleFavorite(post.id ?? 0);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: isFav
                                        ? appColors.appWhite
                                        : appColors.appWhite.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    isFav
                                        ? Icons.check_circle
                                        : Icons.favorite_border,
                                    size: 20,
                                    color: isFav
                                        ? Colors.green.shade600
                                        : Colors.red.shade400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isFav
                                        ? Colors.grey.shade200
                                        : Colors.yellow.shade200,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: AppText(title:
                                    'Post #${post.id ?? 0}',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: isFav
                                          ? Colors.grey.shade700
                                          : Colors.orange.shade800,
                                    ),
                                  ),
                                const SizedBox(height: 8),


                                Expanded(
                                  child: AppText(
                                    title: post.title ?? "No Title",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    maxLines: 3,
                                    textOverflow: TextOverflow.ellipsis,
                                    color: appColors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                AppText(
                                  title: post.body ?? "",
                                  fontSize: 11,
                                  maxLines: 2,
                                  textOverflow: TextOverflow.ellipsis,
                                  color: Colors.grey.shade600,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: isFav
                                    ? Colors.grey.shade200
                                    : Colors.yellow.shade300,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isFav
                                      ? Colors.green.shade50
                                      : Colors.yellow.shade300,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isFav
                                        ? Colors.green.shade300
                                        : Colors.yellow.shade700,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      isFav
                                          ? Icons.check_circle
                                          : Icons.star,
                                      size: 12,
                                      color: isFav
                                          ? Colors.green.shade700
                                          : Colors.orange.shade800,
                                    ),
                                    const SizedBox(width: 4),
                                    AppText(title:
                                      isFav ? 'Read' : 'New',
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: isFav
                                            ? Colors.green.shade700
                                            : Colors.orange.shade800,
                                      ),

                                  ],
                                ),
                              ),
                              AppText(title:
                                'Tap to ${isFav ? 'unread' : 'read'}',
                                  fontSize: 10,
                                  color: Colors.grey.shade500,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        );
      }),
    );
  }
}