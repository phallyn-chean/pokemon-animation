import 'package:flutter/material.dart';

class AnimatedSlideWidget extends AnimatedWidget {
  const AnimatedSlideWidget({required this.animation, required this.child, super.key}) : super(listenable: animation);

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final slideWidth = MediaQuery.of(context).size.width * 0.3;
    return Transform.translate(
      offset: Offset(slideWidth * (1 - animation.value), 0),
      child: child,
    );
  }
}
