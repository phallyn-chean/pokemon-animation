import 'package:pokemon_animation/core/extensions/string.dart';
import 'package:pokemon_animation/models/local/item.dart';
import 'package:pokemon_animation/models/local/pokemon.dart';
import 'package:pokemon_animation/models/local/pokemon_gender.dart';
import 'package:pokemon_animation/models/local/pokemon_stats.dart';
import 'package:pokemon_animation/models/source/items.dart';
import 'package:pokemon_animation/models/source/pokemon_model.dart';

extension GihubPokemonModelToLocalX on GithubPokemonModel {
  PokemonHiveModel toHiveModel() => PokemonHiveModel()
    ..number = id.trim()
    ..name = name.trim()
    ..description = xDescription.trim()
    ..types = types.toList(growable: false)
    ..image = imageUrl.trim()
    ..height = height.trim()
    ..weight = weight.trim()
    ..genera = category.trim()
    ..eggGroups = eggGroups.split(RegExp(r',\s*?')).map((e) => e.trim()).toList()
    ..gender = (PokemonGenderHiveModel()
      ..male = genderMalePercentage.parseDouble()
      ..female = genderFemalePercentage.parseDouble()
      ..genderless = genderless == 1)
    ..stats = (PokemonStatsHiveModel()
      ..hp = hp.toInt()
      ..speed = speed.toInt()
      ..attack = attack.toInt()
      ..defense = defense.toInt()
      ..specialAttack = specialAttack.toInt()
      ..specialDefense = specialDefense.toInt())
    ..baseExp = baseExp.parseDouble()
    ..evolutions = evolutions
    ..evolutionReason = reason;
}

extension GithubItemModelToLocalX on GithubItemModel {
  ItemHiveModel toHiveModel() => ItemHiveModel()
    ..name = name.trim()
    ..category = category.trim()
    ..imageurl = imageUrl.trim()
    ..effect = effect.trim();
}
