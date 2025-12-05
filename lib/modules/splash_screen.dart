import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/app_text.dart';
import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (controller) {
            return FadeTransition(
              opacity: controller.fadeAnimation,
              child: ScaleTransition(
                scale: controller.scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    // App Logo Box
                    Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.gif_box,
                        size: 60,
                        color: Colors.blueAccent,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const AppText(
                      title: "Just See Post",
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),

                    const SizedBox(height: 8),

                    AppText(
                      title: "Crafting Post",
                      fontSize: 14,
                      color: Colors.black54,
                    ),

                    const SizedBox(height: 30),

                    const CircularProgressIndicator(strokeWidth: 3),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
