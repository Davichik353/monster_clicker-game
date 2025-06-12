import 'package:flutter/material.dart';
import 'package:monster_clicker/services/game_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GameModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Главная")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Монет: ${model.coins}"),
            Text("Уровень: ${model.level}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/battle');
              },
              child: const Text("Начать бой"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/shop'); // Перейти в магазин
              },
              child: const Text("Перейти в магазин"),
            ),
          ],
        ),
      ),
    );
  }
}
