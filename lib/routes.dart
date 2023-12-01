import 'package:flutter/material.dart';
import 'package:pokemon_animation/core/fade_route_page.dart';
import 'package:pokemon_animation/screens/home/home_screen.dart';
import 'package:pokemon_animation/screens/pokedex/pokedex.dart';
import 'package:pokemon_animation/screens/pokemon_info/pokemon_info.dart';
import 'package:pokemon_animation/screens/splash_screen/splash_screen.dart';
import 'package:pokemon_animation/screens/types/type_screen.dart';

enum Routes { splash, home, pokedex, pokemonInfo, typeEffects, items }

class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String pokedex = '/home/pokedex';
  static const String pokemonInfo = '/home/pokemon';
  static const String typeEffectsScreen = '/home/type';
  static const String itemList = '/home/items';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.home: _Paths.home,
    Routes.pokedex: _Paths.pokedex,
    Routes.pokemonInfo: _Paths.pokemonInfo,
    Routes.typeEffects: _Paths.typeEffectsScreen,
    Routes.items: _Paths.itemList,
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.splash:
        return FadeRoute(page: const SplashScreen());

      case _Paths.pokedex:
        return FadeRoute(page: const PokedexScreen());

      case _Paths.pokemonInfo:
        return FadeRoute(page: const PokemonInfo());

      case _Paths.typeEffectsScreen:
        return FadeRoute(page: const TypeEffectScreen());

      case _Paths.home:
      default:
        return FadeRoute(page: const HomeScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) {
    return state?.pushNamed(_Paths.of(route), arguments: arguments);
  }

  static Future? replaceWith<T>(Routes route, [T? arguments]) {
    return state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);
  }

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
