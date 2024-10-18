import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  final bool isActive;
  const SlideDots(this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 10 : 10,
      width: isActive ? 20 : 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey[400],
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
