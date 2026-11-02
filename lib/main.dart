import 'package:flutter/material.dart';

import 'slot_machine.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth:
                        constraints.minWidth,
                    minHeight:
                        constraints.minHeight,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: SlotMachine(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}
