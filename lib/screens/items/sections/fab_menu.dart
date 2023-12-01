part of '../items.dart';

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
    _fabController = AnimationController(
      vsync: this,
      duration: animationDuration,
    );

    _fabAnimation = _fabController.curvedTweenAnimation(begin: 0, end: 1);
    super.initState();
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
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
      builder: (context) {
        return const SearchBottomModal();
      },
    );
  }

  void _showGenerationModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const GenerationModal();
      },
    );
  }

  void onPress([Function? callback]) {
    _toggleFabMenu();

    callback?.call();
  }

  @override
  Widget build(BuildContext context) {
    final safeAreaButtom = MediaQuery.of(context).padding.bottom;
    return AnimatedOverlay(
      animation: _fabAnimation,
      color: Theme.of(context).colorScheme.background,
      onPress: _toggleFabMenu,
      child: Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.only(right: 26, bottom: 26 + safeAreaButtom),
        child: ExpandedAnimationFab(
          onPress: _toggleFabMenu,
          items: [
            FabItemData(
              'Favourite Pokemon',
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
              Icons.favorite,
              onPress: () => onPress(_showSearchModal),
            ),
          ],
          animation: _fabAnimation,
        ),
      ),
    );
  }
}
