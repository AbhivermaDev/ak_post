
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String keyNotFound = "";
  static String savedUserName = "savedUserName";
  static String savedPassword = "savedPassword";
  static String rememberMe = "rememberMe";
  static String defaultCurrency = "defaultCurrency";
  static String userData = "userData";
  static String userId = "userId";
  static String fcmToken = "fcmToken";
  static String deviceId = "deviceId";
  static String splashLoaded = "splashLoaded";
  static String userEmail = "userEmail";
  static String locale = "locale";
  static SharedPreferences? prefs;

  static Future<SharedPreferences> initialiseSharedPref() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!;
  }

  static Future<bool> checkUserKeys() async {
    SharedPreferences prefs = await initialiseSharedPref();
    return (prefs.containsKey(userData) &&
        prefs.containsKey(userId));
  }

/*
  static Future<void> setUserData(UserData? data) async {
    SharedPreferences prefs = await initialiseSharedPref();
    if (data!=null) {
      prefs.setString(userData, jsonEncode(data.toJson()));
      CommonController.to.userData=data;
      if(data.employeeDetails?.employeeId!=null)
      {
        prefs.setString(userId, data.employeeDetails!.employeeId.toString());
      }
    }
  }
*/

/*
  static Future<UserData?> getUserData() async {
    SharedPreferences prefs = await initialiseSharedPref();
    if (prefs.containsKey(userData)) {
      var str = prefs.getString(userData);
      if (str != null && str.isNotEmpty) {
        UserData data = UserData.fromJson(jsonDecode(str));
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
*/

  static Future<bool> getBool(String key) async {
    SharedPreferences prefs = await initialiseSharedPref();
    if (prefs.containsKey(key)) {
      return prefs.getBool(key)!;
    } else {
      return false;
    }
  }

  static Future<String> getString(String key) async {
    SharedPreferences prefs = await initialiseSharedPref();
    if (prefs.containsKey(key)) {
      return prefs.getString(key)!;
    } else {
      return keyNotFound;
    }
  }

  static Future<void> setString(String key, String value) async {
    SharedPreferences prefs = await initialiseSharedPref();
    prefs.setString(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    SharedPreferences prefs = await initialiseSharedPref();
    prefs.setBool(key, value);
  }

  static Future<void> rememberUserCredentials(String pass, String email) async {
    SharedPreferences prefs = await initialiseSharedPref();
    prefs.setBool(rememberMe, true);
    prefs.setString(savedUserName, email);
    prefs.setString(savedPassword, pass);
  }

  static Future<void> removeUserCredentials() async {
    SharedPreferences prefs = await initialiseSharedPref();
    prefs.setBool(rememberMe, false);
    prefs.setString(savedUserName, "");
    prefs.setString(savedPassword, "");
  }

  static Future<void> removeKey(String key) async {
    SharedPreferences prefs = await initialiseSharedPref();
    if (prefs.containsKey(key)) {
      await prefs.remove(key);
    }
  }

  static Future<bool> cleanSharedPrefs() async {
    try {
      SharedPreferences prefs = await initialiseSharedPref();
      for (String key in prefs.getKeys()) {
        if (key != splashLoaded &&
            key != savedUserName &&
            key != savedPassword &&
            key != rememberMe) {
          prefs.remove(key);
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
