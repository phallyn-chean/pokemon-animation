import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_animation/constants/colors.dart';
import 'package:pokemon_animation/constants/images.dart';
import 'package:pokemon_animation/constants/theme/theme_cubit.dart';
import 'package:pokemon_animation/core/domain/entities/item.dart';
import 'package:pokemon_animation/core/extensions/context.dart';
import 'package:pokemon_animation/screens/items/widgets/item_category.dart';
import 'package:pokemon_animation/widgets/spacer.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(this.item, {super.key, required this.index, this.onPress});

  final int index;
  final Function()? onPress;
  final Item item;

  static const double _pokeballFraction = 0.6;
  static const double _itemFraction = 0.61;

  @override
  Widget build(BuildContext context) {
    var themeCubits = BlocProvider.of<ThemeCubits>(context, listen: true);
    var isDark = themeCubits.isDark;
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemHeight = constraints.maxHeight;

        return Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.black12 : AppColors.grey,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(0.12),
                blurRadius: 30,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              color: AppColors.grey,
              child: InkWell(
                onTap: onPress,
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Stack(
                  children: [
                    _buildPokeballDecoration(height: itemHeight),
                    _buildItem(height: itemHeight),
                    CardContent(item),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPokeballDecoration({required double height}) {
    final pokeballSize = height * _pokeballFraction;

    return Positioned(
      bottom: -height * 0.13,
      right: -height * 0.03,
      child: Image(
        image: AppImages.pokeball,
        width: pokeballSize,
        height: pokeballSize,
        color: Colors.white.withOpacity(0.14),
      ),
    );
  }

  Widget _buildItem({required double height}) {
    final itemSize = height * _itemFraction;

    return Positioned(
        child: CachedNetworkImage(
      imageUrl: item.image,
      width: itemSize,
      height: itemSize,
      useOldImageOnUrlChange: true,
      fit: BoxFit.contain,
      alignment: Alignment.bottomRight,
      placeholder: (context, url) {
        return Image(
          image: AppImages.bulbasaur,
          width: itemSize,
          height: itemSize,
          color: Colors.black12,
        );
      },
      errorWidget: (context, url, error) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Image(
              image: AppImages.bulbasaur,
              width: itemSize,
              height: itemSize,
              color: Colors.black12,
            ),
            Icon(
              Icons.warning_amber_rounded,
              size: itemSize * 0.4,
              color: Colors.black45,
            )
          ],
        );
      },
    ));
  }
}

class CardContent extends StatelessWidget {
  const CardContent(this.item, {super.key});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: context.responsive(24),
          bottom: context.responsive(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Hero(
              tag: item.name,
              child: Text(
                item.name,
                style: const TextStyle(
                  fontSize: 14,
                  height: 0.7,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            VSpacer(context.responsive(10)),
            _buildCategory(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.responsive(3),
        right: context.responsive(3),
      ),
      child: ItemCategory(item.category),
    );
  }
}
