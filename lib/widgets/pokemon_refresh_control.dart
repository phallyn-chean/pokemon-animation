import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_animation/constants/images.dart';

class PokemonRefreshControl extends StatelessWidget {
  const PokemonRefreshControl({super.key, required this.onRefresh});
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: onRefresh,
      builder: (_, __, ___, ____, _____) {
        return const Image(image: AppImages.pikloader);
      },
    );
  }
}
