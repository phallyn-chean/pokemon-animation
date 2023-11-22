import 'package:flutter/material.dart';
import 'package:pokemon_animation/constants/utils/size.dart';
import 'package:pokemon_animation/routes.dart';

const double mainAppbarPadding = 28;

class MainSliverAppBar extends SliverAppBar {
  static const TextStyle _textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: kToolbarHeight / 3,
    height: 1,
  );
  MainSliverAppBar(
      {GlobalKey? appBarKey,
      String title = 'Pokedex',
      double height = kToolbarHeight + mainAppbarPadding * 2,
      double expandedFontSize = 30,
      void Function()? onLeadingPress = AppNavigator.pop,
      void Function()? onTrailingPress,
      required BuildContext context})
      : super(
          centerTitle: true,
          expandedHeight: height,
          floating: false,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: onLeadingPress,
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          actions: [
            IconButton(
              padding: const EdgeInsets.symmetric(horizontal: mainAppbarPadding),
              onPressed: onTrailingPress,
              icon: Icon(
                Icons.favorite_border_outlined,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            )
          ],
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints boxConstraints) {
              final safeAreaTop = MediaQuery.of(context).padding.top;
              final minHeight = safeAreaTop + kTextTabBarHeight;
              final maxHeight = height + safeAreaTop;

              final percent = (boxConstraints.maxHeight - minHeight) / (maxHeight - minHeight);
              final fontSize = _textStyle.fontSize ?? 16;
              final currentTextStyle = _textStyle.copyWith(fontSize: fontSize + (expandedFontSize - fontSize) * percent);

              final textWidth = getTextSize(context, title, currentTextStyle).width;
              const startX = mainAppbarPadding;
              final endX = MediaQuery.of(context).size.width / 2 - textWidth / 2 - startX;
              final dx = startX + endX - endX * percent;
              return Container(
                color: Theme.of(context).colorScheme.background.withOpacity(0.8 - percent * 0.8),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: kToolbarHeight / 3),
                      child: Transform.translate(
                        offset: Offset(dx, boxConstraints.maxHeight - kToolbarHeight),
                        child: Text(
                          title,
                          style: currentTextStyle,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
}

class MainAppBar extends AppBar {
  MainAppBar({super.key, Widget? title, IconData? rightIcon})
      : super(
          title: title,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const IconButton(
            padding: EdgeInsets.symmetric(horizontal: mainAppbarPadding),
            onPressed: AppNavigator.pop,
            icon: Icon(Icons.arrow_back),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: mainAppbarPadding),
              child: Icon(
                rightIcon,
                color: Colors.white,
              ),
            ),
          ],
        );
}
