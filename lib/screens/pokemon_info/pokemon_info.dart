import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_animation/constants/colors.dart';
import 'package:pokemon_animation/constants/images.dart';
import 'package:pokemon_animation/constants/theme/theme_cubit.dart';
import 'package:pokemon_animation/constants/utils/string.dart';
import 'package:pokemon_animation/core/domain/entities/pokemon.dart';
import 'package:pokemon_animation/core/domain/entities/pokemon_props.dart';
import 'package:pokemon_animation/core/domain/entities/pokemon_types.dart';
import 'package:pokemon_animation/screens/pokemon_info/state_provider.dart';
import 'package:pokemon_animation/states/pokemon/pokemon_bloc.dart';
import 'package:pokemon_animation/states/pokemon/pokemon_event.dart';
import 'package:pokemon_animation/states/pokemon/pokemon_selector.dart';
import 'package:pokemon_animation/widgets/animated_fade.dart';
import 'package:pokemon_animation/widgets/animated_slide.dart';
import 'package:pokemon_animation/widgets/auto_slideup_panel.dart';
import 'package:pokemon_animation/widgets/hero.dart';
import 'package:pokemon_animation/widgets/main_app_bar.dart';
import 'package:pokemon_animation/widgets/main_tab_view.dart';
import 'package:pokemon_animation/widgets/pokemon_image.dart';
import 'package:pokemon_animation/widgets/pokemon_type.dart';
import 'package:pokemon_animation/widgets/progress.dart';

part 'sections/backgroud_decoration.dart';
part 'sections/pokemon_info_card.dart';
part 'sections/pokemon_info_card_basestats.dart';
part 'sections/pokemon_info_card_about.dart';
part 'sections/pokemon_info_card_envolutions.dart';
part 'sections/pokemon_overall_info.dart';

class PokemonInfo extends StatefulWidget {
  const PokemonInfo({super.key});

  @override
  State<PokemonInfo> createState() => _PokemonInfoState();
}

class _PokemonInfoState extends State<PokemonInfo> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _rotateController;

  @override
  void initState() {
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PokemonInfoStateProvider(
      slideController: _slideController,
      rotateController: _rotateController,
      child: const Scaffold(
        body: Stack(
          children: [
            BackgroundDecoration(),
            PokemonInfoCard(),
            PokemonOverallInfo(),
          ],
        ),
      ),
    );
  }
}
