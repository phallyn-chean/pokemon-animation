import 'package:flutter/material.dart';
import 'package:pokemon_animation/constants/types.dart';
import 'package:pokemon_animation/screens/types/modal_sheet.dart';

class TypeEffectGrid extends StatelessWidget {
  const TypeEffectGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Builder(
      builder: (context) {
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ModalSheet(width: w, index: index);
                  },
                  childCount: types.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
