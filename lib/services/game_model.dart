import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameModel with ChangeNotifier {
  int _coins = 0;
  int _xp = 0;
  int _level = 1;
  int _damage = 10;

  int get coins => _coins;
  int get xp => _xp;
  int get level => _level;
  int get damage => _damage;

  void addCoins(int amount) {
    _coins += amount;
    notifyListeners();
    save();
  }

  void increaseDamage() {
    if (_coins >= 30) {
      _coins -= 30;
      _damage += 5;
      notifyListeners();
      save();
    }
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _coins = prefs.getInt('coins') ?? 0;
    _xp = prefs.getInt('xp') ?? 0;
    _level = prefs.getInt('level') ?? 1;
    _damage = prefs.getInt('damage') ?? 10;
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('coins', _coins);
    prefs.setInt('xp', _xp);
    prefs.setInt('level', _level);
    prefs.setInt('damage', _damage);
  }
}
