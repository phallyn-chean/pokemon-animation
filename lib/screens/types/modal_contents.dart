import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_animation/constants/images.dart';
import 'package:pokemon_animation/constants/types.dart';
import 'package:pokemon_animation/core/domain/entities/pokemon.dart';
import 'package:pokemon_animation/routes.dart';
import 'package:pokemon_animation/screens/types/type_container.dart';
import 'package:pokemon_animation/screens/types/type_entities/widget_list.dart';
import 'package:pokemon_animation/services/utils.dart';
import 'package:pokemon_animation/states/pokemon/pokemon_bloc.dart';
import 'package:pokemon_animation/states/pokemon/pokemon_event.dart';
import 'package:pokemon_animation/states/pokemon/pokemon_state.dart';
import 'package:pokemon_animation/widgets/pokemon_card.dart';

class ModalContents extends StatefulWidget {
  const ModalContents({super.key, required this.width, required this.index, required this.scrollController});

  final double width;
  final int index;
  final ScrollController scrollController;

  @override
  State<ModalContents> createState() => _ModalContentsState();
}

class _ModalContentsState extends State<ModalContents> {
  final List<bool> _isOpen = [false, false, false];

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      context.read<PokemonBloc>().add(const PokemonLoadStarted(loadAll: true));
    });
  }

  void _onPokemonPress(int index, Pokemon pokemon) {
    context.read<PokemonBloc>().add(PokemonSelectChanged(pokemonId: pokemon.number));

    AppNavigator.push(Routes.pokemonInfo, pokemon);
  }

  PokeTypes get pokeType => types[widget.index];

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      controller: widget.scrollController,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            alignment: Alignment.center,
            child: TypeDisplayContainer(
              index: widget.index,
              path: 'name',
              typeList: const [],
              height: 70,
              width: 200,
              value: null,
              j: null,
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            height: 1,
            width: widget.width / 1.7,
            color: Colors.black12,
          ),
        ),
        if (pokeType.superEffective.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: lister(widget.index, 2, widget.width, "Effective Against".toUpperCase()),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: lister(widget.index, 0.5, widget.width, "Weak Against".toUpperCase()),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: lister(widget.index, 1, widget.width, "Normal Against".toUpperCase()),
        ),
        if (pokeType.nilEffective.isNotEmpty)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: lister(widget.index, 0, widget.width, "No Effect Against".toUpperCase()),
          ),
        BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state.error != null) {
              return _buildError();
            }

            return _buildTypePanelList(state.pokemons);
          },
        )
      ],
    );
  }

  ExpansionPanel _buildTypePokemonPanel(List<Pokemon> pokemons) {
    final filteredPokemons = pokemons.where((pokemon) => pokemon.types.contains(pokeType.type)).toList();

    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Image(
                image: AppImages.pokeball,
                width: 30,
                height: 30,
                color: pokeType.color.withOpacity(0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text("${getEnumValue(pokeType.type)[0].toUpperCase() + getEnumValue(pokeType.type).substring(1)} Type $pokemons"),
            )
          ],
        );
      },
      canTapOnHeader: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: filteredPokemons.isNotEmpty
            ? GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 1.4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children: filteredPokemons.map((pokemon) {
                  return PokemonCard(
                    pokemon,
                    onPress: () => _onPokemonPress(pokemons.indexOf(pokemon), pokemon),
                  );
                }).toList(),
              )
            : const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "No Pokemon Found",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
      ),
      isExpanded: _isOpen[0],
    );
  }

  ExpansionPanel _buildTypeItemsPanel() {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Image(
                image: AppImages.pokeball,
                width: 30,
                height: 30,
                color: pokeType.color.withOpacity(0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text("${getEnumValue(pokeType.type)[0].toUpperCase() + getEnumValue(pokeType.type).substring(1)} Type Items"),
            )
          ],
        );
      },
      canTapOnHeader: true,
      body: const Text(
        "Under Development",
      ),
      isExpanded: _isOpen[1],
    );
  }

  Widget _buildTypePanelList(List<Pokemon> pokemons) {
    return ExpansionPanelList(
      animationDuration: const Duration(milliseconds: 500),
      children: [
        _buildTypePokemonPanel(pokemons),
        _buildTypeItemsPanel(),
      ],
      expansionCallback: (panelIndex, isExpanded) => setState(() {
        _isOpen[panelIndex] = !_isOpen[panelIndex];
      }),
    );
  }

  Widget _buildError() {
    return Container(
      padding: const EdgeInsets.only(bottom: 28),
      alignment: Alignment.center,
      child: const Icon(
        Icons.warning_amber_rounded,
        size: 60,
        color: Colors.black26,
      ),
    );
  }
}
