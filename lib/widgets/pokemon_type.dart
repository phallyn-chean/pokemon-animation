import 'package:flutter/material.dart';
import 'package:pokemon_animation/core/domain/entities/pokemon_types.dart';
import 'package:pokemon_animation/widgets/spacer.dart';

class PokemonType extends StatelessWidget {
  const PokemonType(
    this.type, {
    super.key,
    this.extra = '',
    this.large = false,
    this.colored = false,
  });
  final PokemonTypes type;
  final String extra;
  final bool large;
  final bool colored;

  @override
  Widget build(BuildContext context) {
    var bgColor = Theme.of(context).colorScheme.background;
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: large ? 19 : 12, vertical: large ? 6 : 4),
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: (colored ? type.color : bgColor).withOpacity(0.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              type.value,
              textScaleFactor: 1,
              style: TextStyle(
                fontSize: large ? 12 : 8,
                height: 0.8,
                fontWeight: large ? FontWeight.bold : FontWeight.normal,
                color: colored ? type.color : bgColor,
              ),
              textAlign: TextAlign.center,
            ),
            const HSpacer(5),
            Text(
              extra,
              textScaleFactor: 1,
              style: TextStyle(
                fontSize: large ? 12 : 8,
                height: 0.8,
                fontWeight: large ? FontWeight.bold : FontWeight.normal,
                color: colored ? type.color : bgColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
