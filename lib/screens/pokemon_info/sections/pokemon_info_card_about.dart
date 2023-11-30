part of '../pokemon_info.dart';

class Label extends Text {
  Label(String text, bool isDark, {super.key})
      : super(
          text,
          style: TextStyle(
            color: isDark ? AppColors.whiteGrey.withOpacity(0.6) : AppColors.black.withOpacity(0.6),
            height: 0.8,
          ),
        );
}

class ContentSection extends StatelessWidget {
  const ContentSection({super.key, required this.label, this.children});

  final String label;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(height: 0.8, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 22),
        if (children != null) ...children!,
      ],
    );
  }
}

class TextIcon extends StatelessWidget {
  const TextIcon(this.icon, this.text, {super.key});
  final ImageProvider icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(image: icon, width: 12, height: 12),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(height: 0.8),
        )
      ],
    );
  }
}

class PokemonAbout extends StatelessWidget {
  const PokemonAbout(this.pokemon, {super.key});
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final slideController = PokemonInfoStateProvider.of(context).slideController;

    var themeCubit = BlocProvider.of<ThemeCubits>(context, listen: true);
    var isDark = themeCubit.isDark;
    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) {
        final scrollable = slideController.value.floor() == 1;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 27),
          physics: scrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
          child: child,
        );
      },
      child: Column(
        children: [
          _buildDescription(pokemon.description),
          const SizedBox(height: 28),
          _buildHeightWeight(pokemon.height, pokemon.weight, context, isDark),
          const SizedBox(height: 31),
          _buildBreeding(pokemon.gender, pokemon.eggGroups, isDark),
          const SizedBox(height: 35),
          _buildLocation(),
          const SizedBox(height: 26),
          _buildTraining(pokemon.baseExp, isDark),
        ],
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Text(
      description,
      style: const TextStyle(height: 1.3),
    );
  }

  Widget _buildHeightWeight(String height, String weight, BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Theme.of(context).colorScheme.background, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          offset: const Offset(0, 8),
          blurRadius: 23,
        ),
      ]),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label('Height', isDark),
                const SizedBox(height: 11),
                Text(
                  height,
                  style: const TextStyle(height: 0.8),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label('Weight', isDark),
                const SizedBox(height: 11),
                Text(
                  weight,
                  style: const TextStyle(height: 0.8),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBreeding(PokemonGender gender, List<String> eggGroups, bool isDark) {
    return ContentSection(
      label: 'Breeding',
      children: [
        Row(
          children: [
            Expanded(
              child: Label('Gender', isDark),
            ),
            if (gender.genderless)
              const Expanded(
                flex: 3,
                child: Text(
                  'Genderless',
                  style: TextStyle(height: 0.8),
                ),
              )
            else ...[
              Expanded(
                child: TextIcon(AppImages.male, '${gender.male}%'),
              ),
              Expanded(
                flex: 2,
                child: TextIcon(AppImages.female, '${gender.female}%'),
              ),
            ]
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: Label('Egg Groups', isDark),
            ),
            Expanded(
              flex: 2,
              child: Text(
                eggGroups.join(', '),
                style: const TextStyle(height: 0.8),
              ),
            ),
            const Expanded(
              flex: 2,
              child: SizedBox(),
            )
          ],
        )
      ],
    );
  }

  Widget _buildLocation() {
    return ContentSection(
      label: 'Location',
      children: [
        AspectRatio(
          aspectRatio: 2.2,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.teal,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTraining(double baseExp, bool isDark) {
    return ContentSection(
      label: 'Training',
      children: [
        Row(
          children: [
            Expanded(flex: 1, child: Label('Base Exp', isDark)),
            Expanded(flex: 3, child: Text('$baseExp')),
          ],
        )
      ],
    );
  }
}
