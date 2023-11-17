import 'package:pokemon_animation/core/domain/entities/item.dart';
import 'package:pokemon_animation/models/mappers/github_to_local_mapper.dart';
import 'package:pokemon_animation/models/mappers/local_to_entity_mapper.dart';
import 'package:pokemon_animation/services/local/local_datasource.dart';
import 'package:pokemon_animation/services/resource_service.dart';

abstract class ItemRepository {
  Future<List<Item>> getAllItems();

  Future<List<Item>> getItems({required int limit, required int page});
}

class ItemDefaultRepository extends ItemRepository {
  final GithubDataSource githubDataSource;
  final LocalDataSource localDataSource;
  ItemDefaultRepository({required this.githubDataSource, required this.localDataSource});
  @override
  Future<List<Item>> getAllItems() async {
    final hasCachedData = await localDataSource.hasData();

    if (!hasCachedData) {
      final itemGithubModel = await githubDataSource.getItems();
      final itemHiveModels = itemGithubModel.map((e) => e.toHiveModel());

      await localDataSource.saveItems(itemHiveModels);
    }

    final itemHiveModels = await localDataSource.getAllItems();
    final itemEntities = itemHiveModels.map((e) => e.toEntity()).toList();

    return itemEntities;
  }

  @override
  Future<List<Item>> getItems({required int limit, required int page}) async {
    final hasCachedData = await localDataSource.hasItemData();

    if (!hasCachedData) {
      final itemGihubModels = await githubDataSource.getItems();
      final itemHiveModels = itemGihubModels.map((e) => e.toHiveModel());

      await localDataSource.saveItems(itemHiveModels);
    }

    final itemHiveModels = await localDataSource.getItems(
      page: page,
      limit: limit,
    );

    final itemEntities = itemHiveModels.map((e) => e.toEntity()).toList();

    return itemEntities;
  }
}
