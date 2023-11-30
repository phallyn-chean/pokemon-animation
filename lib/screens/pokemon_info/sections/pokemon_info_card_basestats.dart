part of '../pokemon_info.dart';

class Stat extends StatelessWidget {
  const Stat({
    super.key,
    required this.animation,
    required this.label,
    this.progress,
    required this.value,
  });

  final Animation animation;
  final String label;
  final double? progress;
  final num value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.6),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text("$value"),
        ),
        Expanded(
            child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final currentProgress = progress ?? value / 100;

            return ProgressBar(
              progress: animation.value * currentProgress,
              color: currentProgress < 0.5 ? AppColors.red : AppColors.teal,
              enableAnimation: animation.value == 1,
            );
          },
        ))
      ],
    );
  }
}

class PokemonBaseState extends StatefulWidget {
  const PokemonBaseState(this.pokemon, {super.key});

  final Pokemon pokemon;

  @override
  State<PokemonBaseState> createState() => _PokemonBaseStateState();
}

class _PokemonBaseStateState extends State<PokemonBaseState> with SingleTickerProviderStateMixin {
  late Animation<double> _progressAnimation;
  late AnimationController _progressController;

  Pokemon get pokemon => widget.pokemon;

  AnimationController get slideController => PokemonInfoStateProvider.of(context).slideController;

  @override
  void initState() {
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(curve: Curves.easeInOut, parent: _progressController),
    );

    _progressController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) {
        final scrollable = slideController.value.floor() == 1;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          physics: scrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildState(pokemon.stats),
          const SizedBox(height: 27),
          const Text(
            'Type Defense',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 0.8,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'The effectiveness of each type on ${pokemon.name}.',
            style: TextStyle(color: AppColors.black.withOpacity(0.6)),
          ),
          const SizedBox(height: 15),
          _buildEffectivenesses(pokemon.typeEffectiveness),
        ],
      ),
    );
  }

  Widget _buildState(PokemonStats stats) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stat(animation: _progressAnimation, label: 'Hp', value: stats.hp),
        const SizedBox(height: 14),
        Stat(animation: _progressAnimation, label: 'Attack', value: stats.attack),
        const SizedBox(height: 14),
        Stat(animation: _progressAnimation, label: 'Defense', value: stats.defense),
        const SizedBox(height: 14),
        Stat(animation: _progressAnimation, label: 'Sp. Atk', value: stats.specialAttack),
        const SizedBox(height: 14),
        Stat(animation: _progressAnimation, label: 'Sp. Def', value: stats.specialDefense),
        const SizedBox(height: 14),
        Stat(animation: _progressAnimation, label: 'Speed', value: stats.speed),
        const SizedBox(height: 14),
        Stat(animation: _progressAnimation, label: 'Tool', value: stats.total, progress: stats.total / 600)
      ],
    );
  }

  Widget _buildEffectivenesses(Map<PokemonTypes, double> typeEffectiveness) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: typeEffectiveness.keys
          .map((type) => PokemonType(
                type,
                large: true,
                colored: true,
                extra: 'X${removeTrailingZero(typeEffectiveness[type] ?? 1)}',
              ))
          .toList(),
    );
  }
}
