import 'package:flutter/material.dart';
import 'package:pokemon_animation/constants/colors.dart';
import 'package:pokemon_animation/constants/types.dart';
import 'package:pokemon_animation/screens/types/bold_text.dart';
import 'package:pokemon_animation/screens/types/type_entities/type_constants.dart';
import 'package:pokemon_animation/services/utils.dart';

class TypeDisplayContainer extends StatelessWidget {
  const TypeDisplayContainer({
    super.key,
    required this.index,
    required this.j,
    required this.path,
    required this.typeList,
    required this.value,
    required this.width,
    required this.height,
  });

  final int index;
  final int? j;
  final String path;
  final List<String> typeList;
  final dynamic value;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    var col = Colors.black;
    var text = '';
    void assigner() {
      if (path == "name") {
        col = types[index].color;
        text = getEnumValue(types[index].type).toUpperCase();
      } else if (j != null) {
        col = types[index].color;
        text = getEnumValue(types[index].type).toUpperCase();
        final jIndex = typeIndices[typeList[(j as int)]];
        if (jIndex != null) {
          col = types[jIndex].color;
          text = getEnumValue(types[jIndex]).toLowerCase();
        }
      }
    }

    assigner();
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 5, right: 5),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        border: Border.all(color: AppColors.black.withAlpha(100)),
        boxShadow: [
          (width != 75)
              ? const BoxShadow(
                  color: AppColors.grey,
                  blurRadius: 25,
                  spreadRadius: 7,
                  offset: Offset(15, 5),
                )
              : const BoxShadow(),
        ],
        color: col,
      ),
      child: BoldText(text: text),
    );
  }
}
