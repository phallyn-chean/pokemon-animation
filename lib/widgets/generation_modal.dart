import 'package:flutter/material.dart';
import 'package:pokemon_animation/core/domain/entities/generation.dart';
import 'package:pokemon_animation/models/data/generations.dart';
import 'package:pokemon_animation/screens/pokedex/widgets/generation_card.dart';
import 'package:pokemon_animation/widgets/modal.dart';

class GenerationModal extends StatelessWidget {
  const GenerationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return Modal(
          title: 'Generation',
          child: _buildGenerations(context, scrollController),
        );
      },
    );
  }

  Widget _buildGenerations(BuildContext context, ScrollController scrollController) {
    final safeAreaButtom = MediaQuery.of(context).padding.bottom;
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.fromLTRB(26, 26, 26, 26 + safeAreaButtom),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.55,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: generations.length,
        itemBuilder: (context, index) {
          return _buildGenerationCard(generations[index]);
        },
      ),
    );
  }

  Widget _buildGenerationCard(Generation generation) {
    return GenerationCard(generation);
  }
}
