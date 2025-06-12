import 'package:flutter/material.dart';
import 'package:monster_clicker/screens/battle_screen.dart';
import 'package:monster_clicker/screens/home_screen.dart';
import 'package:monster_clicker/screens/shop_screen.dart';
import 'package:monster_clicker/services/game_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => GameModel(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monster Clicker',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/battle': (context) => BattleScreen(level: 0),
        '/shop': (context) => ShopScreen(), // Добавляем маршрут для магазина
      },
    );
  }
}
