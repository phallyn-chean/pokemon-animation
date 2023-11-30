import 'package:json_annotation/json_annotation.dart';

part 'pokemon_model.g.dart';

@JsonSerializable()
class GithubPokemonModel {
  @JsonKey(required: true, disallowNullValue: true)
  late String name;

  @JsonKey(required: true, disallowNullValue: true)
  late String id;

  @JsonKey(required: true, name: 'imageurl', disallowNullValue: true)
  late String imageUrl;

  @JsonKey(name: 'xdescription', defaultValue: '')
  late String xDescription;

  @JsonKey(name: 'ydescription', defaultValue: '')
  late String yDescription;

  @JsonKey(defaultValue: '')
  late String height;

  @JsonKey(defaultValue: '')
  late String category;

  @JsonKey(defaultValue: '')
  late String weight;

  @JsonKey(name: 'typeofpokemon', required: true, disallowNullValue: true)
  late List<String> types;

  @JsonKey(defaultValue: [])
  late List<String> weaknesses;

  @JsonKey(defaultValue: [])
  late List<String> evolutions;

  @JsonKey(defaultValue: [])
  late List<String> abilities;

  @JsonKey(defaultValue: 0)
  late num hp;

  @JsonKey(defaultValue: 0)
  late num attack;

  @JsonKey(defaultValue: 0)
  late num defense;

  @JsonKey(name: 'special_attack', defaultValue: 0)
  late num specialAttack;

  @JsonKey(name: 'special_defense', defaultValue: 0)
  late num specialDefense;

  @JsonKey(defaultValue: 0)
  late num speed;

  @JsonKey(defaultValue: 0)
  late num total;

  @JsonKey(name: 'male_percentage')
  late String? genderMalePercentage;

  @JsonKey(name: 'female_percentage')
  late String? genderFemalePercentage;

  @JsonKey(required: true, disallowNullValue: true)
  late num genderless;

  @JsonKey()
  late String cycles;

  @JsonKey(name: 'egg_groups')
  late String? eggGroups;

  @JsonKey(name: 'evoledfrom')
  late String? evoledFrom;

  @JsonKey()
  late String? reason;

  @JsonKey(name: 'base_exp', defaultValue: '0')
  late String baseExp;

  GithubPokemonModel(
    this.name,
    this.id,
    this.imageUrl,
    this.xDescription,
    this.yDescription,
    this.height,
    this.category,
    this.weight,
    this.types,
    this.weaknesses,
    this.evolutions,
    this.abilities,
    this.hp,
    this.attack,
    this.defense,
    this.specialAttack,
    this.specialDefense,
    this.speed,
    this.total,
    this.genderMalePercentage,
    this.genderFemalePercentage,
    this.genderless,
    this.cycles,
    this.eggGroups,
    this.evoledFrom,
    this.reason,
    this.baseExp,
  );

  factory GithubPokemonModel.fromJson(Map<String, dynamic> json) {
    return _$GithubPokemonModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GithubPokemonModelToJson(this);
  }
}
