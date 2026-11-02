import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'slot_row.dart';

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
  var _isSpinning = false;
  var _isJackpot = false;

  Future<String> _spinReel({
    required int totalTicks,
    required void Function(String) onTick,
  }) async {
    String result = _symbols[0];
    for (int i = 0; i < totalTicks; i++) {
      final progress = i / totalTicks;
      final delay = progress < 0.2
          ? 40
          : progress < 0.5
          ? 100
          : 200;
      await Future.delayed(
        Duration(milliseconds: delay),
      );
      if (!mounted) return result;
      result =
          _symbols[_random.nextInt(
            _symbols.length,
          )];
      onTick(result);
    }
    return result;
  }

  Future<void> _spin() async {
    if (!mounted || _coins <= 0 || _isSpinning)
      return;
    setState(() {
      _isSpinning = true;
      _isJackpot = false;
      _message = '';
    });
    final results = await Future.wait([
      _spinReel(
        totalTicks: 10,
        onTick: (val) =>
            setState(() => _slot1 = val),
      ),
      _spinReel(
        totalTicks: 13,
        onTick: (val) =>
            setState(() => _slot2 = val),
      ),
      _spinReel(
        totalTicks: 16,
        onTick: (val) =>
            setState(() => _slot3 = val),
      ),
    ]);
    if (!mounted) return;

    final isWin =
        results[0] == results[1] &&
        results[1] == results[2];
    final isJackpot =
        isWin && results[0] == _seven;

    await Future.delayed(
      const Duration(milliseconds: 800),
    );
    if (!mounted) return;

    setState(() {
      _isSpinning = false;
      _isJackpot = isJackpot;
      if (isJackpot) {
        _coins += 10;
        _message = 'ДЖЕКПОТ! 🎰🎰🎰 +10 монет';
      } else if (isWin) {
        _coins += 3;
        _message = 'Победа! 🎉 +3 монеты';
      } else {
        _coins -= 1;
        _message = _coins == 0
            ? 'Монеты закончились! 😢'
            : 'Попробуй ещё раз 😔 -1 монета';
      }
    });
  }

  void _reset() {
    if (_isSpinning) return;
    setState(() {
      _coins = 10;
      _slot1 = _cherry;
      _slot2 = _lemon;
      _slot3 = _seven;
      _message = '';
      _isJackpot = false;
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
        AnimatedOpacity(
          opacity: _isSpinning ? 0.85 : 1.0,
          duration: const Duration(
            milliseconds: 100,
          ),
          child: SlotRow(
            slot1: _slot1,
            slot2: _slot2,
            slot3: _slot3,
          ),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 36,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 400,
            ),
            child: Text(
              _isSpinning
                  ? '🎰 Крутим...'
                  : _message,
              textAlign: TextAlign.center,
              key: ValueKey(
                _isSpinning
                    ? 'spinning'
                    : _message,
              ),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: _isJackpot
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _coins > 0 && !_isSpinning
              ? _spin
              : null,
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
        const SizedBox(height: 12),
        TextButton(
          onPressed: _isSpinning ? null : _reset,
          child: const Text(
            'Начать заново',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
