import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_animation/app.dart';
import 'package:pokemon_animation/constants/theme/theme_cubit.dart';
import 'package:pokemon_animation/services/local/local_datasource.dart';
import 'package:pokemon_animation/services/network.dart';
import 'package:pokemon_animation/services/repositories/item_repository.dart';
import 'package:pokemon_animation/services/repositories/pokemon_repository.dart';
import 'package:pokemon_animation/services/resource_service.dart';
import 'package:pokemon_animation/states/items/item_bloc.dart';
import 'package:pokemon_animation/states/pokemon/pokemon_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDataSource.initialize();
  runApp(MultiBlocProvider(
    providers: [
      RepositoryProvider<NetworkManager>(create: (context) => NetworkManager()),
      RepositoryProvider<LocalDataSource>(create: (context) => LocalDataSource()),
      RepositoryProvider<GithubDataSource>(create: (context) => GithubDataSource(context.read<NetworkManager>())),
      RepositoryProvider<PokemonRepository>(
        create: (context) => PokemonDefaultRepository(
          githubDataSource: context.read<GithubDataSource>(),
          localDataSource: context.read<LocalDataSource>(),
        ),
      ),
      RepositoryProvider<ItemRepository>(
        create: (context) => ItemDefaultRepository(
          githubDataSource: context.read<GithubDataSource>(),
          localDataSource: context.read<LocalDataSource>(),
        ),
      )
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<PokemonBloc>(create: (context) => PokemonBloc(context.read<PokemonRepository>())),
        BlocProvider<ItemBloc>(create: (context) => ItemBloc(context.read<ItemRepository>())),
        BlocProvider<ThemeCubits>(create: (context) => ThemeCubits()),
      ],
      child: const PokemonApp(),
    ),
  ));
}
