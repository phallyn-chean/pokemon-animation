part of '../pokemon_info.dart';

class PokemonInfoCard extends StatefulWidget {
  const PokemonInfoCard({super.key});

  static const double minCardHeightFraction = 0.54;

  @override
  State<PokemonInfoCard> createState() => _PokemonInfoCardState();
}

class _PokemonInfoCardState extends State<PokemonInfoCard> {
  AnimationController get slideController => PokemonInfoStateProvider.of(context).slideController;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final safeArea = MediaQuery.of(context).padding;
    final appBarHeight = AppBar().preferredSize.height;

    final carMinHeight = screenHeight * PokemonInfoCard.minCardHeightFraction;
    final cardMaxHeight = screenHeight - appBarHeight - safeArea.top;
    return AutoSlideUpPanel(
      minHeight: carMinHeight,
      maxHeight: cardMaxHeight,
      onPanelSlide: (position) => slideController.value = position,
      child: CurrentPokemonSelector((pokemon) {
        return MainTabView(tabs: [
          MainTabData(child: PokemonAbout(pokemon), label: 'About'),
          MainTabData(child: PokemonBaseState(pokemon), label: 'Base Stats'),
          MainTabData(child: Container(), label: 'Evolution'),
          const MainTabData(
              child: Align(
                alignment: Alignment.topCenter,
                child: Text('Under Development!'),
              ),
              label: 'Moves'),
        ]);
      }),
    );
  }
}
