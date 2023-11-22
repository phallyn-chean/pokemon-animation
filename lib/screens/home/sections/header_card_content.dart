part of '../home_screen.dart';

class _HeaderCardContent extends StatelessWidget {
  static const double height = 582;

  void _onSelectCategory(Category category) {
    AppNavigator.push(category.route);
  }

  @override
  Widget build(BuildContext context) {
    var themCubit = BlocProvider.of<ThemeCubits>(context, listen: true);
    var isDark = themCubit.isDark;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      child: PokeballBackground(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  padding: const EdgeInsets.only(left: 28),
                  onPressed: () {
                    themCubit.toggleTheme();
                  },
                  icon: Icon(
                    isDark ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
                    color: isDark ? Colors.orange : Colors.black,
                    size: 25,
                  ),
                ),
              ),
            ),
            _buildTitle(),
            const SearchBarWidget(),
            _buildCategories(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.all(28),
        alignment: Alignment.bottomLeft,
        child: const Text(
          "What Pokemon\nare you looking for?",
          style: TextStyle(
            fontSize: 30,
            height: 1.6,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(28, 42, 28, 62),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 2.6,
        mainAxisSpacing: 15,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryCard(
          categories[index],
          onPress: () => _onSelectCategory(categories[index]),
        );
      },
    );
  }
}
