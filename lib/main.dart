
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kv_task/routes/app_pages.dart';
import 'package:kv_task/routes/app_routes.dart';
import 'api/di/dependency_injection.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return GetMaterialApp(
      title: 'Kv Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      getPages:AppPages.pages,
      initialRoute: AppRoutes.splash,

    );
  }
}
