import 'package:flutter/material.dart';

class PokemonInfoStateProvider extends InheritedWidget {
  const PokemonInfoStateProvider({
    super.key,
    required this.slideController,
    required this.rotateController,
    required Widget child,
  }) : super(child: child);

  final AnimationController slideController;
  final AnimationController rotateController;

  static PokemonInfoStateProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<PokemonInfoStateProvider>();

    return result!;
  }

  @override
  bool updateShouldNotify(covariant PokemonInfoStateProvider oldWidget) {
    return false;
  }
}
