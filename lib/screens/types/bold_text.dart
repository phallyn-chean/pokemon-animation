import 'package:flutter/material.dart';
import 'package:pokemon_animation/constants/colors.dart';

class BoldText extends StatelessWidget {
  const BoldText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.whiteGrey,
        shadows: [
          Shadow(
            offset: Offset(-1, -1),
            color: Colors.black,
          ),
          Shadow(
            offset: Offset(1, -1),
            color: Colors.black,
          ),
          Shadow(
            offset: Offset(1, 1),
            color: Colors.black,
          ),
          Shadow(
            offset: Offset(-1, 1),
            color: Colors.black,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
