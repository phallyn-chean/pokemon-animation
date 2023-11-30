import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_animation/constants/colors.dart';
import 'package:pokemon_animation/constants/theme/theme_cubit.dart';

class MainTabData {
  final Widget child;
  final String label;

  const MainTabData({required this.child, required this.label});
}

class MainTabView extends StatelessWidget {
  const MainTabView({super.key, required this.tabs, this.paddingAnimation});

  final List<MainTabData> tabs;
  final Animation<double>? paddingAnimation;

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubits>(context, listen: true);
    var isDark = themeCubit.isDark;
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTopAnimatedPadding(),
            _buildTabBar(isDark),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopAnimatedPadding() {
    if (paddingAnimation == null) {
      return const SizedBox(height: 6);
    }
    return AnimatedBuilder(
      animation: paddingAnimation!,
      builder: (context, child) {
        return SizedBox(
          height: (1 - paddingAnimation!.value) * 16 + 6,
        );
      },
    );
  }

  Widget _buildTabBar(bool isDark) {
    return TabBar(
      labelColor: isDark ? AppColors.whiteGrey : AppColors.black,
      unselectedLabelColor: isDark ? AppColors.whiteGrey : AppColors.grey,
      labelPadding: const EdgeInsets.symmetric(vertical: 16),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: AppColors.indigo,
      indicatorWeight: 2,
      tabs: tabs.map((tab) => Text(tab.label)).toList(),
    );
  }

  Widget _buildTabContent() {
    return Expanded(
        child: TabBarView(
      children: tabs.map((tab) => tab.child).toList(),
    ));
  }
}
