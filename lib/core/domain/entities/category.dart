import 'package:flutter/material.dart';
import 'package:pokemon_animation/routes.dart';

class Category {
  final Color color;

  final String name;
  final Routes route;

  const Category({required this.color, required this.name, required this.route});
}
