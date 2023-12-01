import 'package:flutter/material.dart';
import 'package:pokemon_animation/screens/types/type_container.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({super.key, required this.width, required this.index});

  final double width;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black87, width: 2.5),
            ),
          ),
        ),
        Align(
          child: Container(
            height: 5,
            color: Colors.white,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: width / 7,
            decoration: BoxDecoration(
              color: Colors.white70,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black87,
                width: 2.5,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: TypeDisplayContainer(
            index: index,
            path: "name",
            typeList: const [],
            height: 30,
            value: null,
            width: null,
            j: null,
          ),
        )
      ],
    );
  }
}
