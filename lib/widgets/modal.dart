import 'package:flutter/material.dart';
import 'package:pokemon_animation/constants/colors.dart';

class Modal extends StatelessWidget {
  const Modal({super.key, this.title, required this.child});
  static const Radius _borderRadius = Radius.circular(30);

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: _borderRadius,
          topRight: _borderRadius,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [const DragLine(), Title(text: title), child],
      ),
    );
  }
}

class DragLine extends StatelessWidget {
  const DragLine({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 3,
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: AppColors.lightGrey,
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    if (text == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(
        text ?? '',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
