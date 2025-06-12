class Player {
  int hp = 100;
  int maxHP = 100;
  int attack = 10;
  int defense = 5;

  void takeDamage(int damage) {
    final realDamage = (damage * (1 - defense / 100)).toInt();
    hp -= realDamage;
    if (hp < 0) hp = 0;
  }

  bool isAlive() => hp > 0;
}
