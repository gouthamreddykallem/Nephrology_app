import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    required this.value,
    super.key,
  }) : height = 12.0;

  const AnimatedProgressBar.mini({
    required this.value,
    super.key,
  }) : height = 8.0;

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final maxWidth = constraints.maxWidth;
        return Container(
          padding: const EdgeInsets.all(8.0) / 3,
          width: maxWidth,
          child: Stack(
            children: [
              Container(
                height: height,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                height: height,
                width: maxWidth * value.clamp(0.0, 1.0),
                decoration: BoxDecoration(
                  color: value.toRandomColor(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Example extension method to generate a random color
extension RandomColor on double {
  Color toRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}