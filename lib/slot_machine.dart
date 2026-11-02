import 'package:flutter/material.dart';

import 'dart:math';

class SlotMachine extends StatefulWidget {
  const SlotMachine({super.key});

  @override
  State<StatefulWidget> createState() =>
      _SlotMachineState();
}

class _SlotMachineState
    extends State<SlotMachine> {
  static const _cherry =
      'assets/images/cherry.png';
  static const _lemon = 'assets/images/lemon.png';
  static const _seven = 'assets/images/seven.png';
  static const _symbols = [
    _cherry,
    _lemon,
    _seven,
  ];
  final _random = Random();

  var _coins = 10;
  var _slot1 = _cherry;
  var _slot2 = _lemon;
  var _slot3 = _seven;
  var _message = '';

  void _spin() {
    setState(() {
      _slot1 =
          _symbols[_random.nextInt(
            _symbols.length,
          )];
      _slot2 =
          _symbols[_random.nextInt(
            _symbols.length,
          )];
      _slot3 =
          _symbols[_random.nextInt(
            _symbols.length,
          )];

      if (_slot1 == _slot2 && _slot2 == _slot3) {
        _coins += 3;
        _message = 'Победа! 🎉 +3 монеты';
      } else {
        _coins -= 1;
        _message =
            'Попробуй ещё раз 😔 -1 монета';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '💰 Монеты: $_coins',
          style: const TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 40),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                _slot1,
                width: 100,
                height: 100,
              ),
              const SizedBox(width: 16),
              Image.asset(
                _slot2,
                width: 100,
                height: 100,
              ),
              const SizedBox(width: 16),
              Image.asset(
                _slot3,
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          _message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _spin,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            padding: const EdgeInsets.symmetric(
              horizontal: 48,
              vertical: 16,
            ),
          ),
          child: Text(
            'КРУТИТЬ 🎰',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
