import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_animation/constants/images.dart';
import 'package:pokemon_animation/core/domain/entities/pokemon.dart';

class PokemonImage extends StatelessWidget {
  const PokemonImage({
    super.key,
    required this.pokemon,
    this.padding = EdgeInsets.zero,
    this.useHero = true,
    required this.size,
    this.placeholder = AppImages.bulbasaur,
    this.tintColor,
  });

  final Pokemon pokemon;
  final EdgeInsets padding;
  final bool useHero;
  final Size size;
  final ImageProvider placeholder;
  final Color? tintColor;

  static const Size _cacheMaxSize = Size(700, 700);

  @override
  Widget build(BuildContext context) {
    return HeroMode(
        enabled: useHero,
        child: Hero(
          tag: pokemon.image,
          child: AnimatedPadding(
            padding: padding,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutQuint,
            child: CachedNetworkImage(
              imageUrl: pokemon.image,
              imageRenderMethodForWeb: ImageRenderMethodForWeb.HtmlImage,
              useOldImageOnUrlChange: true,
              maxWidthDiskCache: _cacheMaxSize.width.toInt(),
              maxHeightDiskCache: _cacheMaxSize.height.toInt(),
              fadeInDuration: const Duration(milliseconds: 120),
              fadeOutDuration: const Duration(milliseconds: 120),
              imageBuilder: (context, imageProvider) {
                return Image(
                  image: imageProvider,
                  width: size.width,
                  height: size.height,
                  alignment: Alignment.bottomCenter,
                  color: tintColor,
                  fit: BoxFit.contain,
                );
              },
              placeholder: (context, url) {
                return Image(
                  image: placeholder,
                  width: size.width,
                  height: size.height,
                  alignment: Alignment.bottomCenter,
                  color: Colors.black12,
                  fit: BoxFit.contain,
                );
              },
              errorWidget: (_, __, ___) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(
                      image: placeholder,
                      width: size.width,
                      height: size.height,
                      color: Colors.black12,
                    ),
                    Icon(
                      Icons.warning_amber_rounded,
                      size: size.width * 0.3,
                      color: Colors.black26,
                    )
                  ],
                );
              },
            ),
          ),
        ));
  }
}
