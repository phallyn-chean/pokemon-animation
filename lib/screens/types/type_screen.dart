import 'package:flutter/material.dart';
import 'package:pokemon_animation/widgets/main_app_bar.dart';
import 'package:pokemon_animation/widgets/pokeball_background.dart';

class TypeEffectScreen extends StatelessWidget {
  const TypeEffectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PokeballBackground(
      child: NestedScrollView(
        headerSliverBuilder: _buildHeader,
        body: const TypeEffectScreen(),
      ),
    );
  }

  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    return [
      MainSliverAppBar(
        context: context,
        title: 'Type Effects',
      )
    ];
  }
}
