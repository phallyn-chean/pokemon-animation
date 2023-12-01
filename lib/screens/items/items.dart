import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_animation/constants/duration.dart';
import 'package:pokemon_animation/constants/images.dart';
import 'package:pokemon_animation/core/extensions/animation.dart';
import 'package:pokemon_animation/screens/items/widgets/item_card.dart';
import 'package:pokemon_animation/states/items/item_bloc.dart';
import 'package:pokemon_animation/states/items/item_event.dart';
import 'package:pokemon_animation/states/items/item_selector.dart';
import 'package:pokemon_animation/states/items/item_state.dart';
import 'package:pokemon_animation/widgets/animated_overlay.dart';
import 'package:pokemon_animation/widgets/fab.dart';
import 'package:pokemon_animation/widgets/generation_modal.dart';
import 'package:pokemon_animation/widgets/main_app_bar.dart';
import 'package:pokemon_animation/widgets/pokeball_background.dart';
import 'package:pokemon_animation/widgets/pokemon_refresh_control.dart';
import 'package:pokemon_animation/widgets/search_modal.dart';

part 'sections/fab_menu.dart';
part 'sections/items_grid.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return const PokeballBackground(
        child: Stack(
      children: [
        ItemGrid(),
      ],
    ));
  }
}
