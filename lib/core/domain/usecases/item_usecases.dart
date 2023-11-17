import 'package:pokemon_animation/core/domain/entities/item.dart';
import 'package:pokemon_animation/services/repositories/item_repository.dart';
import 'package:pokemon_animation/services/usecase.dart';

class GetItemUseCase extends NoParamsUseCase<List<Item>> {
  final ItemRepository repository;
  const GetItemUseCase({required this.repository});
  @override
  Future<List<Item>> call() {
    return repository.getAllItems();
  }
}
