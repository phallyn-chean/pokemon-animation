import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class AppImages {
  static const bulbasaur = _Image('bulbasaur.png');
  static const charmander = _Image('charmander.png');
  static const squirtle = _Image('squirtle.png');
  static const pokeball = _Image('pokeball.png');
  static const male = _Image('male.png');
  static const female = _Image('female.png');
  static const dotted = _Image('dotted.png');
  static const thumbnail = _Image('thumbnail.png');
  static const pikloader = _Image('pika_loader.gif');

  static Future precacheAssets(BuildContext context) async {
    await precacheImage(bulbasaur, context);
    // ignore: use_build_context_synchronously
    await precacheImage(charmander, context);
    // ignore: use_build_context_synchronously
    await precacheImage(squirtle, context);
    // ignore: use_build_context_synchronously
    await precacheImage(pokeball, context);
    // ignore: use_build_context_synchronously
    await precacheImage(male, context);
    // ignore: use_build_context_synchronously
    await precacheImage(female, context);
    // ignore: use_build_context_synchronously
    await precacheImage(dotted, context);
    // ignore: use_build_context_synchronously
    await precacheImage(thumbnail, context);
    // ignore: use_build_context_synchronously
    await precacheImage(pikloader, context);
  }
}
