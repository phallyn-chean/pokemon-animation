part of '../home_screen.dart';

class _PokemonNews extends StatelessWidget {
  const _PokemonNews();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        _buildHeader(context),
        _buildNews(),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(28, 0, 28, 22),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pokémon News',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          Text(
            'View All',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.indigo),
          )
        ],
      ),
    );
  }

  Widget _buildNews() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const NewsCard(
          time: '15 November 2023',
          title: 'Pokémon Rumble Rush Arrives Soon',
          thumbnail: AppImages.thumbnail,
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: 9,
    );
  }
}
