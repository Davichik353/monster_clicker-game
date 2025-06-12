import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:monster_clicker/models/monster.dart';
import 'package:monster_clicker/services/game_model.dart';
import 'package:monster_clicker/services/sound_service.dart';

class BattleScreen extends StatefulWidget {
  final int level;

  const BattleScreen({super.key, this.level = 0});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  late Monster currentMonster;
  late int monsterHP;
  late SoundService soundService;

  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();

    // Инициализируем монстра, но НЕ вызываем showDialog
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_dialogShown) {
        _showIntroDialog(context);
        _dialogShown = true;
      }
    });

    currentMonster = animeMonsters[widget.level];
    monsterHP = currentMonster.maxHP;
    soundService = SoundService();
    soundService.playBackgroundMusic(currentMonster.musicAsset);
  }

  void _showIntroDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: Text("Битва с ${currentMonster.name}"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Тип монстра: ${currentMonster.type}"),
                const SizedBox(height: 10),
                const Text("Приготовься к бою!"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Начать"),
              ),
            ],
          ),
        );
      }
    });
  }

  void _attackMonster() {
    final model = Provider.of<GameModel>(context, listen: false);

    setState(() {
      final playerAttackType = MonsterType.normal;
      final damage = calculateDamage(
        playerAttackType,
        currentMonster.type,
        model.damage,
      );
      monsterHP -= damage;

      model.addCoins(10);
      model.save();

      if (monsterHP <= 0) {
        soundService.stopBackgroundMusic();
        _showVictoryDialog(context);
      }
    });
  }

  int calculateDamage(
    MonsterType attackType,
    MonsterType targetType,
    int playerDamage,
  ) {
    // Сильные атаки
    if (attackType == MonsterType.fire && targetType == MonsterType.earth)
      return 30;
    if (attackType == MonsterType.water && targetType == MonsterType.fire)
      return 30;
    if (attackType == MonsterType.air && targetType == MonsterType.water)
      return 30;

    // Слабые атаки
    if (attackType == MonsterType.fire && targetType == MonsterType.water)
      return 5;
    if (attackType == MonsterType.water && targetType == MonsterType.earth)
      return 5;
    if (attackType == MonsterType.earth && targetType == MonsterType.air)
      return 5;

    return playerDamage;
  }

  void _showVictoryDialog(BuildContext context) {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Победа!"),
        content: Text("Вы победили ${currentMonster.name}!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (widget.level < animeMonsters.length - 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BattleScreen(level: widget.level + 1),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(
              widget.level < animeMonsters.length - 1
                  ? "Следующий уровень"
                  : "В меню",
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GameModel>(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/backgrounds/demon.jpg', fit: BoxFit.cover),
          Image.asset('assets/backgrounds/goblin.jpg', fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Игрок атакует!",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  "${currentMonster.name}: $monsterHP / ${currentMonster.maxHP}",
                  style: const TextStyle(color: Colors.white),
                ),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: _attackMonster,
                    child: const Text("Атаковать"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    soundService.stopBackgroundMusic();
    super.dispose();
  }
}
