import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_animation/constants/constant.dart';
import 'package:pokemon_animation/constants/theme.dart';
import 'package:pokemon_animation/constants/theme/theme_cubit.dart';
import 'package:pokemon_animation/routes.dart';

class PokemonApp extends StatefulWidget {
  const PokemonApp({super.key});

  @override
  State<PokemonApp> createState() => _PokemonAppState();
}

class _PokemonAppState extends State<PokemonApp> {
  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubits>(context, listen: true);
    var isDark = themeCubit.isDark;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      title: 'Flutter Pokemon Animation',
      theme: isDark ? Themings.dartTheme : Themings.lightTheme,
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppNavigator.onGenerateRoute,
      builder: (context, child) {
        if (child == null) {
          return const SizedBox.shrink();
        }
        final data = MediaQuery.of(context);
        final smallestSize = min(data.size.width, data.size.height);
        final textScaleFator = min(smallestSize / AppConstants.designScreenSize.width, 1.0);

        return MediaQuery(
          data: data.copyWith(textScaleFactor: textScaleFator),
          child: child,
        );
      },
    );
  }
}
