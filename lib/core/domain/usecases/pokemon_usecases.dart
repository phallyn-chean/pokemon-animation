import 'package:pokemon_animation/core/domain/entities/pokemon.dart';
import 'package:pokemon_animation/services/repositories/pokemon_repository.dart';
import 'package:pokemon_animation/services/usecase.dart';

class GetAllPokemonsUseCase extends NoParamsUseCase<List<Pokemon>> {
  final PokemonRepository repository;

  const GetAllPokemonsUseCase({required this.repository});
  @override
  Future<List<Pokemon>> call() {
    return repository.getAllPokemos();
  }
}

class GetPokemonParams {
  final int page;
  final int limit;

  const GetPokemonParams({required this.limit, required this.page});
}

class GetPokemonsUseCase extends UseCase<List<Pokemon>, GetPokemonParams> {
  final PokemonRepository repository;
  const GetPokemonsUseCase({required this.repository});
  @override
  Future<List<Pokemon>> call(GetPokemonParams params) {
    return repository.getPokemons(limit: params.limit, page: params.page);
  }
}

class GetPokemonParam {
  final String number;
  const GetPokemonParam({required this.number});
}

class GetPokemonUseCase extends UseCase<Pokemon?, GetPokemonParam> {
  final PokemonRepository repository;

  const GetPokemonUseCase({required this.repository});
  @override
  Future<Pokemon?> call(GetPokemonParam params) {
    return repository.getPokemon(params.number);
  }
}
