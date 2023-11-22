part of '../pokedex.dart';

class FabMenu extends StatefulWidget {
  const FabMenu({super.key});

  @override
  State<FabMenu> createState() => _FabMenuState();
}

class _FabMenuState extends State<FabMenu> with SingleTickerProviderStateMixin {
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  bool _isFabMenuVisible = false;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: animationDuration,
    );

    _fabAnimation = _fabController.curvedTweenAnimation(begin: 0.0, end: 1.0);
  }

  @override
  void dispose() {
    super.dispose();
    _fabController.dispose();
  }

  void _toggleFabMenu() {
    _isFabMenuVisible = !_isFabMenuVisible;

    if (_isFabMenuVisible) {
      _fabController.forward();
    } else {
      _fabController.reverse();
    }
  }

  void _showSearchModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const SearchBottomModal(),
    );
  }

  void _showGenerationModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const GenerationModal(),
      // todo
    );
  }

  void onPress([Function? callback]) {
    _toggleFabMenu();
    callback?.call();
  }

  @override
  Widget build(BuildContext context) {
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    return AnimatedOverlay(
      animation: _fabAnimation,
      color: Colors.black,
      onPress: _toggleFabMenu,
      child: Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.only(right: 26, bottom: 26 + safeAreaBottom),
        child: ExpandedAnimationFab(
          items: [
            FabItemData(
              'Favorite Pokemon',
              Icons.favorite,
              onPress: () => onPress(),
            ),
            FabItemData(
              'All Type',
              Icons.filter_vintage,
              onPress: () => onPress(),
            ),
            FabItemData(
              'All Gen',
              Icons.flash_on,
              onPress: () => onPress(_showGenerationModal),
            ),
            FabItemData(
              'Search',
              Icons.search,
              onPress: () => onPress(_showSearchModal),
            )
          ],
          animation: _fabAnimation,
          onPress: _toggleFabMenu,
        ),
      ),
    );
  }
}
