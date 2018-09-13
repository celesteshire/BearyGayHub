import 'package:shared_preferences/shared_preferences.dart';

final BasicAuthKey = "basicAuthKey";

class Storage {
  static save(String key, String value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setString(key, value);
  }

  static getString(String key) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(key);
  }

  static remove(String key) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.remove(key);
  }
}