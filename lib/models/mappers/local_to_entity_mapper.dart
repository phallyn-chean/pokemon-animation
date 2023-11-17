import 'package:pokemon_animation/core/domain/entities/item.dart';
import 'package:pokemon_animation/core/domain/entities/pokemon.dart';
import 'package:pokemon_animation/core/domain/entities/pokemon_props.dart';
import 'package:pokemon_animation/core/domain/entities/pokemon_types.dart';
import 'package:pokemon_animation/models/local/item.dart';
import 'package:pokemon_animation/models/local/pokemon.dart';
import 'package:pokemon_animation/models/local/pokemon_gender.dart';
import 'package:pokemon_animation/models/local/pokemon_stats.dart';

extension PokemonHiveModelX on PokemonHiveModel {
  Pokemon toEntity({List<PokemonHiveModel> evolutions = const []}) => Pokemon(
        number: number.trim(),
        name: name.trim(),
        description: description.trim(),
        types: types.map((e) => PokemonTypesX.parse(e)).toList(),
        image: image.trim(),
        height: height.trim(),
        weight: weight.trim(),
        genera: genera.trim(),
        eggGroups: eggGroups.map((e) => e.trim()).where((element) => element.isNotEmpty).toList(),
        gender: gender.toEntity(),
        stats: stats.toEntity(),
        baseExp: baseExp,
        evolutions: evolutions.map((e) => e.toEntity()).toList(),
        evolutionReason: evolutionReason,
      );
}

extension PokemonGenderHiveModelX on PokemonGenderHiveModel {
  PokemonGender toEntity() => PokemonGender(
        genderless: genderless,
        male: male,
        female: female,
      );
}

extension PokemonStatsHiveModelX on PokemonStatsHiveModel {
  PokemonStats toEntity() => PokemonStats(
        attack: attack,
        specialAttack: specialAttack,
        defense: defense,
        specialDefense: specialDefense,
        hp: hp,
        speed: speed,
      );
}

extension ItemHiveModelX on ItemHiveModel {
  Item toEntity({List<ItemHiveModel> evolutions = const []}) => Item(
        category: name.trim(),
        effect: effect.trim(),
        name: name.trim(),
        image: imageurl.trim(),
      );
}
