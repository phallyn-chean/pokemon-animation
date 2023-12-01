import 'package:flutter/material.dart';
import 'package:pokemon_animation/constants/colors.dart';
import 'package:pokemon_animation/constants/images.dart';
import 'package:pokemon_animation/screens/types/modal_contents.dart';

class ModalDraggable extends StatelessWidget {
  const ModalDraggable({super.key, required this.width, required this.index});

  final double width;
  final int index;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      expand: false,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              Align(
                child: Image(
                  image: AppImages.pokeball,
                  width: width / 2,
                  height: width / 2,
                  color: AppColors.black.withOpacity(0.1),
                ),
              ),
              ModalContents(width: width, index: index, scrollController: scrollController),
            ],
          ),
        );
      },
    );
  }
}
