import 'package:pokemon_animation/core/domain/entities/pokemon.dart';
import 'package:pokemon_animation/models/mappers/github_to_local_mapper.dart';
import 'package:pokemon_animation/models/mappers/local_to_entity_mapper.dart';
import 'package:pokemon_animation/services/local/local_datasource.dart';
import 'package:pokemon_animation/services/resource_service.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getAllPokemons();

  Future<List<Pokemon>> getPokemons({required int limit, required int page});

  Future<Pokemon?> getPokemon(String number);
}

class PokemonDefaultRepository extends PokemonRepository {
  final GithubDataSource githubDataSource;
  final LocalDataSource localDataSource;

  PokemonDefaultRepository({required this.githubDataSource, required this.localDataSource});
  @override
  Future<List<Pokemon>> getAllPokemons() async {
    final hashCachedData = await localDataSource.hasData();

    if (!hashCachedData) {
      final pokemonGithubModels = await githubDataSource.getPokemons();
      final pokemonHiveModels = pokemonGithubModels.map((e) => e.toHiveModel());

      await localDataSource.savePokemons(pokemonHiveModels);
    }

    final pokemonHiveModels = await localDataSource.getAllPokemons();

    final pokemonEntities = pokemonHiveModels.map((e) => e.toEntity()).toList();

    return pokemonEntities;
  }

  @override
  Future<Pokemon?> getPokemon(String number) async {
    final pokemonModel = await localDataSource.getPokemon(number);

    if (pokemonModel == null) {
      return null;
    }
    final evolutions = await localDataSource.getEvolutions(pokemonModel);

    final pokemon = pokemonModel.toEntity(evolutions: evolutions);

    return pokemon;
  }

  @override
  Future<List<Pokemon>> getPokemons({required int limit, required int page}) async {
    final hashCachedData = await localDataSource.hasData();

    if (!hashCachedData) {
      final pokemonGithubModels = await githubDataSource.getPokemons();
      final pokemonHiveModels = pokemonGithubModels.map((e) => e.toHiveModel());

      await localDataSource.savePokemons(pokemonHiveModels);
    }

    final pokemonHiveModels = await localDataSource.getPokemons(
      page: page,
      limit: limit,
    );

    final pokemonEntities = pokemonHiveModels.map((e) => e.toEntity()).toList();

    return pokemonEntities;
  }
}
