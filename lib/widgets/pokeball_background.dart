import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_animation/constants/colors.dart';
import 'package:pokemon_animation/constants/images.dart';
import 'package:pokemon_animation/constants/theme/theme_cubit.dart';
import 'package:pokemon_animation/widgets/main_app_bar.dart';

class PokeballBackground extends StatelessWidget {
  const PokeballBackground({
    super.key,
    required this.child,
    this.floatingActionButton,
  });

  final Widget child;
  final Widget? floatingActionButton;

  static const double _pokeballWidthFraction = 0.664;

  @override
  Widget build(BuildContext context) {
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final pokeballSize = MediaQuery.of(context).size.width * _pokeballWidthFraction;
    final appBarHeight = AppBar().preferredSize.height;
    final iconButtonPadding = mainAppbarPadding;
    final iconSize = IconTheme.of(context).size ?? 0;

    final pokeballTopMargin = -(pokeballSize / 2 - safeAreaTop - appBarHeight / 2);
    final pokeballRightMargin = -(pokeballSize / 2 - iconButtonPadding - iconSize / 2);

    var themeCubit = BlocProvider.of<ThemeCubits>(context, listen: true);
    var isDark = themeCubit.isDark;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: pokeballTopMargin,
            right: pokeballRightMargin,
            child: Image(
              image: AppImages.pokeball,
              width: pokeballSize,
              height: pokeballSize,
              color: !isDark ? AppColors.whiteGrey : Colors.black.withOpacity(0.05),
            ),
          ),
          child,
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
