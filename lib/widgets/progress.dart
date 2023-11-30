import 'package:flutter/material.dart';
import 'package:pokemon_animation/constants/colors.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    this.backgroundColor = AppColors.lighterGrey,
    this.color = AppColors.red,
    required this.progress,
    this.enableAnimation = true,
  });

  final Color backgroundColor;
  final Color color;
  final double progress;
  final bool enableAnimation;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: color,
      ),
    );
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 3,
      alignment: Alignment.centerLeft,
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: AppColors.lightGrey,
      ),
      child: enableAnimation
          ? AnimatedAlign(
              alignment: const Alignment(1, 0),
              duration: const Duration(milliseconds: 260),
              widthFactor: progress,
              child: child,
            )
          : FractionallySizedBox(
              widthFactor: progress,
              child: child,
            ),
    );
  }
}
