import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static Future<void> initAppData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('coins')) prefs.setInt('coins', 0);
    if (!prefs.containsKey('damage')) prefs.setInt('damage', 10);
  }
}
