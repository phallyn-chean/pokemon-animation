import 'package:flutter/material.dart';
import 'package:pokemon_animation/constants/types.dart';
import 'package:pokemon_animation/screens/types/colored_pokeball.dart';
import 'package:pokemon_animation/screens/types/modal_draggable.dart';

class ModalSheet extends StatelessWidget {
  const ModalSheet({super.key, required this.width, required this.index});

  final double width;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: types[index].color,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (context) {
              return ModalDraggable(width: width, index: index);
            },
          );
        },
        child: CircularContainer(width: width, index: index),
      ),
    );
  }
}
