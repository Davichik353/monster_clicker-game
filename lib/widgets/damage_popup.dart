import 'package:flutter/material.dart';

class DamagePopup extends StatelessWidget {
  final double x;
  final double y;

  const DamagePopup({Key? key, required this.x, required this.y})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 600),
        tween: Tween(begin: 0, end: -50),
        builder: (context, value, child) {
          return Opacity(
            opacity: 1 - (value.abs() / 50),
            child: Transform.translate(offset: Offset(0, value), child: child),
          );
        },
        child: const Text(
          "-10",
          style: TextStyle(fontSize: 20, color: Colors.redAccent),
        ),
      ),
    );
  }
}
