enum MonsterType { normal, fire, water, earth, air }

class Monster {
  final String name;
  final int maxHP;
  final String emoji;
  final MonsterType type;
  final String backgroundAsset;
  final String musicAsset;

  Monster({
    required this.name,
    required this.maxHP,
    required this.emoji,
    required this.type,
    required this.backgroundAsset,
    required this.musicAsset,
  });
}

List<Monster> animeMonsters = [
  Monster(
    name: "Гоблин",
    maxHP: 50,
    emoji: "👹",
    type: MonsterType.normal,
    backgroundAsset: "assets/backgrounds/goblin.png",
    musicAsset: "music/goblin.mp3",
  ),
  Monster(
    name: "Архидемон",
    maxHP: 100,
    emoji: "😈",
    type: MonsterType.fire,
    backgroundAsset: "assets/backgrounds/demon.png",
    musicAsset: "music/demon.mp3",
  ),
];
