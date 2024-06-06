import 'package:shared_preferences/shared_preferences.dart';

class SimplePreferences {
  static late SharedPreferences _preferences;
  static String _name = "";

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    _name = _preferences.getString('keyname') ?? '';
  }

  static Future setName(String name) async {
    await _preferences.setString("keyname", name);
  }

  static getName() => _name;
}
