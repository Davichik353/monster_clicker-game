import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerModel with ChangeNotifier {
  int _coins = 0;
  int _damage = 10;
  int _xp = 0;
  int _level = 1;
  int _selectedWeaponIndex = 0;

  int get coins => _coins;
  int get damage => _damage;
  int get xp => _xp;
  int get level => _level;
  int get selectedWeaponIndex => _selectedWeaponIndex;

  void addCoins(int amount) {
    _coins += amount;
    notifyListeners();
    save();
  }

  void addXP(int amount) {
    _xp += amount;

    while (_xp >= _xpToNextLevel()) {
      _xp -= _xpToNextLevel();
      _level++;
    }

    notifyListeners();
    save();
  }

  int _xpToNextLevel() {
    return _level * 100;
  }

  void buyWeapon(int index) {
    if (index <= _selectedWeaponIndex) return;

    final weaponPrice = _getWeaponPrice(index);
    if (_coins >= weaponPrice) {
      _coins -= weaponPrice;
      _damage = _getWeaponDamage(index);
      _selectedWeaponIndex = index;
      notifyListeners();
      save();
    }
  }

  int _getWeaponDamage(int index) {
    switch (index) {
      case 0:
        return 10;
      case 1:
        return 15;
      case 2:
        return 25;
      case 3:
        return 40;
      default:
        return 10;
    }
  }

  int _getWeaponPrice(int index) {
    switch (index) {
      case 0:
        return 30;
      case 1:
        return 50;
      case 2:
        return 100;
      case 3:
        return 150;
      default:
        return 0;
    }
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _coins = prefs.getInt('coins') ?? 0;
    _damage = prefs.getInt('damage') ?? 10;
    _xp = prefs.getInt('xp') ?? 0;
    _level = prefs.getInt('level') ?? 1;
    _selectedWeaponIndex = prefs.getInt('selectedWeaponIndex') ?? 0;
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('coins', _coins);
    prefs.setInt('damage', _damage);
    prefs.setInt('xp', _xp);
    prefs.setInt('level', _level);
    prefs.setInt('selectedWeaponIndex', _selectedWeaponIndex);
  }
}
