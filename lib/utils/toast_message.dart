import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import '../theme/app_colors.dart';

class CommonToast {
  static void _show(String message, {required Color backgroundColor}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: appColors.appWhite,
      fontSize: 16.0,
    );
  }

  static void showToast(String message) {
    _show(message, backgroundColor: appColors.appBlack);
  }

  static void showToastError(String message) {
    _show(message, backgroundColor: appColors.appRed);
  }

  static void showToastSuccess(String message) {
    _show(message, backgroundColor: appColors.appGreen);
  }
}
