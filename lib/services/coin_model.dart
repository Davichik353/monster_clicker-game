import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinModel with ChangeNotifier {
  int _coins = 0;
  int _damage = 10;

  int get coins => _coins;
  int get damage => _damage;

  void addCoins(int amount) {
    _coins += amount;
    notifyListeners();
    save();
  }

  void increaseDamage() {
    if (_coins >= 20) {
      _coins -= 20;
      _damage += 5;
      notifyListeners();
      save();
    }
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _coins = prefs.getInt('coins') ?? 0;
    _damage = prefs.getInt('damage') ?? 10;
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('coins', _coins);
    prefs.setInt('damage', _damage);
  }
}
