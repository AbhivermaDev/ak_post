import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CommonController extends GetxController {
  static CommonController get to => Get.find();

  String getLanguageCode() {
    final code = Get.locale?.languageCode.toLowerCase();

    if (code == 'hn') {
      return 'HI'; // Hindi
    } else if (code == 'mr') {
      return 'MR'; // Marathi
    } else {
      return 'EN'; // Default English
    }
  }
}
