import 'package:flutter/material.dart';
import 'package:pokemon_animation/constants/colors.dart';
import 'package:pokemon_animation/constants/images.dart';
import 'package:pokemon_animation/constants/types.dart';
import 'package:pokemon_animation/services/utils.dart';

class Redirection extends StatelessWidget {
  const Redirection({
    super.key,
    required this.index,
    required this.term,
    required this.func,
  });

  final int index;
  final String term;
  final void Function() func;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: func,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Image(
                      image: AppImages.pokeball,
                      width: 30,
                      height: 30,
                      color: types[index].color.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text("${getEnumValue(types[index].type)[0].toUpperCase() + getEnumValue(types[index].type).substring(1)} Type$term"),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: AppColors.black.withOpacity(0.5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
