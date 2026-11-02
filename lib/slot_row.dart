import 'package:flutter/material.dart';

class SlotRow extends StatelessWidget {
  const SlotRow({
    super.key,
    required this.slot1,
    required this.slot2,
    required this.slot3,
  });

  final String slot1;
  final String slot2;
  final String slot3;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            slot1,
            width: 100,
            height: 100,
          ),
          const SizedBox(width: 16),
          Image.asset(
            slot2,
            width: 100,
            height: 100,
          ),
          const SizedBox(width: 16),
          Image.asset(
            slot3,
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}
