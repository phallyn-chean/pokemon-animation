import 'package:flutter/material.dart';
import 'package:pokemon_animation/constants/colors.dart';

class FabItemData {
  final IconData icon;
  final void Function()? onPress;
  final String title;

  const FabItemData(this.title, this.icon, {this.onPress});
}

class FabItem extends StatelessWidget {
  const FabItem(this.item, {super.key});
  final FabItemData item;

  @override
  Widget build(BuildContext context) {
    var bgColor = Theme.of(context).colorScheme.background;
    return MaterialButton(
      onPressed: item.onPress,
      shape: const StadiumBorder(),
      padding: const EdgeInsets.fromLTRB(24, 8, 16, 8),
      color: bgColor,
      splashColor: Colors.grey[100],
      highlightColor: Colors.grey[100],
      elevation: 0,
      highlightElevation: 2,
      disabledColor: bgColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(item.title),
          const SizedBox(width: 8),
          Icon(
            item.icon,
            color: AppColors.indigo,
          )
        ],
      ),
    );
  }
}

class ExpandedAnimationFab extends AnimatedWidget {
  final List<FabItemData> items;
  final void Function()? onPress;
  const ExpandedAnimationFab({required this.items, required Animation animation, this.onPress, super.key}) : super(listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IgnorePointer(
          ignoring: animation.value == 0,
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 12),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: _buildItem,
            separatorBuilder: (_, __) => const SizedBox(height: 9),
            itemCount: items.length,
          ),
        ),
        FloatingActionButton(
          backgroundColor: AppColors.indigo,
          onPressed: onPress,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animation,
          ),
        )
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;

    final transform = Matrix4.translationValues(
      -(screenWidth - animation.value * screenWidth) * ((items.length - index) / 4),
      0.0,
      0.0,
    );

    return Align(
      alignment: Alignment.centerRight,
      child: Transform(
        transform: transform,
        child: Opacity(
          opacity: animation.value,
          child: FabItem(items[index]),
        ),
      ),
    );
  }
}
