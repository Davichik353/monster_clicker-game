import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:monster_clicker/services/game_model.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GameModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Магазин")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Монет: ${model.coins}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: model.coins >= 30
                  ? () {
                      model.addCoins(-30);
                      model.increaseDamage();
                      model.save();
                    }
                  : null,
              child: const Text("Купить меч (+5 урона) — 30 монет"),
            ),
          ],
        ),
      ),
    );
  }
}
