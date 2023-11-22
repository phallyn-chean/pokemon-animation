import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_animation/constants/duration.dart';
import 'package:pokemon_animation/constants/images.dart';
import 'package:pokemon_animation/core/domain/entities/pokemon.dart';
import 'package:pokemon_animation/core/extensions/animation.dart';
import 'package:pokemon_animation/routes.dart';
import 'package:pokemon_animation/states/pokemon/pokemon_bloc.dart';
import 'package:pokemon_animation/states/pokemon/pokemon_event.dart';
import 'package:pokemon_animation/states/pokemon/pokemon_selector.dart';
import 'package:pokemon_animation/states/pokemon/pokemon_state.dart';
import 'package:pokemon_animation/widgets/animated_overlay.dart';
import 'package:pokemon_animation/widgets/fab.dart';
import 'package:pokemon_animation/widgets/generation_modal.dart';
import 'package:pokemon_animation/widgets/main_app_bar.dart';
import 'package:pokemon_animation/widgets/pokeball_background.dart';
import 'package:pokemon_animation/widgets/pokemon_card.dart';
import 'package:pokemon_animation/widgets/pokemon_refresh_control.dart';
import 'package:pokemon_animation/widgets/search_modal.dart';

part 'sections/fab_menu.dart';
part 'sections/pokemon_grid.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  @override
  Widget build(BuildContext context) {
    return const PokeballBackground(
      child: Stack(
        children: [
          PokemonGrid(),
          FabMenu(),
        ],
      ),
    );
  }
}
