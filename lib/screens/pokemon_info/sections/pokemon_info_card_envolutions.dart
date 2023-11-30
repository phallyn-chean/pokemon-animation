part of '../pokemon_info.dart';

class PokemonBall extends StatelessWidget {
  const PokemonBall(this.pokemon, {super.key});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final pokeballSize = screenHeight * 0.1;
    final pokemonSize = screenHeight * 0.85;
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image(
              image: AppImages.pokeball,
              width: pokeballSize,
              height: pokeballSize,
              color: AppColors.lightGrey,
            ),
            PokemonImage(
              pokemon: pokemon,
              size: Size.square(pokemonSize),
            )
          ],
        ),
        const SizedBox(height: 3),
        Text(pokemon.name),
      ],
    );
  }
}

class PokemonEvolution extends StatefulWidget {
  const PokemonEvolution(this.pokemon, {super.key});

  final Pokemon pokemon;

  @override
  State<PokemonEvolution> createState() => _PokemonEvolutionState();
}

class _PokemonEvolutionState extends State<PokemonEvolution> {
  Pokemon get pokemon => widget.pokemon;
  @override
  Widget build(BuildContext context) {
    final slideController = PokemonInfoStateProvider.of(context).slideController;

    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) {
        final scrollable = slideController.value.floor() == 1;
        return SingleChildScrollView(
          physics: scrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 31, horizontal: 28),
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Evolution Chain',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 0.8),
          ),
          const SizedBox(height: 28),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return _buildRow(
                current: pokemon.evolutions[index],
                next: pokemon.evolutions[index + 1],
                reason: pokemon.evolutions[index + 1].evolutionReason,
              );
            },
            separatorBuilder: (_, __) => const Divider(height: 58),
            itemCount: pokemon.evolutions.length - 1,
          )
        ],
      ),
    );
  }

  Widget _buildRow({
    required Pokemon current,
    required Pokemon next,
    required String reason,
  }) {
    return Row(
      children: [
        Expanded(
          child: PokemonBall(current),
        ),
        Expanded(
          child: Column(
            children: [
              const Icon(Icons.arrow_forward, color: AppColors.lightGrey),
              const SizedBox(height: 7),
              Text(
                reason,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Expanded(child: PokemonBall(next)),
      ],
    );
  }
}
