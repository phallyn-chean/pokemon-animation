import 'package:pokemon_animation/constants/colors.dart';
import 'package:pokemon_animation/core/domain/entities/category.dart';
import 'package:pokemon_animation/routes.dart';

const List<Category> categories = [
  Category(color: AppColors.teal, name: 'Pokedex', route: Routes.pokedex),
  Category(color: AppColors.red, name: 'Moves', route: Routes.pokedex),
  Category(color: AppColors.blue, name: 'Abilities', route: Routes.pokedex),
  Category(color: AppColors.yellow, name: 'Items', route: Routes.items),
  Category(color: AppColors.purple, name: 'Location', route: Routes.pokedex),
  Category(color: AppColors.brown, name: 'Type Effects', route: Routes.typeEffects),
];
