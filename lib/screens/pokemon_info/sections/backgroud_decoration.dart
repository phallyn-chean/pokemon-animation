part of '../pokemon_info.dart';

class BoxDecorationWidget extends StatelessWidget {
  const BoxDecorationWidget({super.key});
  static const Size size = Size.square(144);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi * 5 / 12,
      alignment: Alignment.center,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: const Alignment(-0.2, -0.2),
            end: const Alignment(1.5, -0.3),
            colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0),
            ],
          ),
        ),
      ),
    );
  }
}

class DottedDecoration extends StatelessWidget {
  const DottedDecoration({super.key, required this.animation});
  final Animation<double> animation;

  static const Size size = Size(57, 31);

  @override
  Widget build(BuildContext context) {
    return AnimatedFade(
      animation: animation,
      child: Image(
        image: AppImages.dotted,
        width: size.width,
        height: size.height,
        color: Colors.white30,
      ),
    );
  }
}

class BackgroundDecoration extends StatefulWidget {
  const BackgroundDecoration({super.key});

  @override
  State<BackgroundDecoration> createState() => _BackgroundDecorationState();
}

class _BackgroundDecorationState extends State<BackgroundDecoration> {
  Animation<double> get slideController => PokemonInfoStateProvider.of(context).slideController;
  Animation<double> get rotateController => PokemonInfoStateProvider.of(context).rotateController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(),
        _buildBoxDecoration(),
        _buildDottedDecoration(),
        _buildAppBarPokeballDecoration(),
      ],
    );
  }

  Widget _buildBackground() {
    return CurrentPokemonSelector((pokemon) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        constraints: const BoxConstraints.expand(),
        color: pokemon.color,
      );
    });
  }

  Widget _buildBoxDecoration() {
    return Positioned(
      top: -BoxDecorationWidget.size.height * 0.4,
      left: -BoxDecorationWidget.size.width * 0.4,
      child: const BoxDecorationWidget(),
    );
  }

  Widget _buildDottedDecoration() {
    return Positioned(
      top: 4,
      right: 72,
      child: DottedDecoration(animation: slideController),
    );
  }

  Widget _buildAppBarPokeballDecoration() {
    final screenSize = MediaQuery.of(context).size;
    final safeAreaTop = MediaQuery.of(context).padding.top;

    final pokeSize = screenSize.width * 0.5;
    final appBarHeight = AppBar().preferredSize.height;
    const iconButtonPadding = mainAppbarPadding;
    final iconSize = IconTheme.of(context).size ?? 0;

    final pokeballTopMargin = -(pokeSize / 2 - safeAreaTop - appBarHeight / 2);
    final pokeballRightMargin = -(pokeSize / 2 - iconButtonPadding - iconSize / 2);

    return Positioned(
      top: pokeballTopMargin,
      right: pokeballRightMargin,
      child: IgnorePointer(
        ignoring: true,
        child: AnimatedFade(
          animation: slideController,
          child: RotationTransition(
            turns: rotateController,
            child: Image(
              image: AppImages.pokeball,
              width: pokeSize,
              height: pokeSize,
              color: Colors.white24,
            ),
          ),
        ),
      ),
    );
  }
}
