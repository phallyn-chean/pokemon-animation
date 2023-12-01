part of '../items.dart';

class ItemGrid extends StatefulWidget {
  const ItemGrid({super.key});

  @override
  State<ItemGrid> createState() => _ItemGridState();
}

class _ItemGridState extends State<ItemGrid> {
  static const double _endReachedThreshold = 200;

  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  ItemBloc get itemBloc => context.read<ItemBloc>();

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      itemBloc.add(const ItemLoadStarted());
      _scrollKey.currentState?.innerController.addListener(_onScroll);
    });
  }

  @override
  void dispose() {
    _scrollKey.currentState?.innerController.dispose();
    _scrollKey.currentState?.dispose();
    super.dispose();
  }

  void _onScroll() {
    final innerController = _scrollKey.currentState?.innerController;

    if (innerController == null || !innerController.hasClients) {
      return;
    }

    final thresholdReached = innerController.position.extentAfter < _endReachedThreshold;

    if (thresholdReached) {
      itemBloc.add(ItemLoadMoreStarted());
    }
  }

  Future _onRefresh() async {
    itemBloc.add(const ItemLoadStarted());

    return itemBloc.stream.firstWhere((element) => element.status != ItemStateStatus.loading);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      key: _scrollKey,
      headerSliverBuilder: (_, __) {
        return [
          MainSliverAppBar(context: context),
        ];
      },
      body: ItemStateStatusSelector(
        (status) {
          switch (status) {
            case ItemStateStatus.loading:
              return _buildLoading();
            case ItemStateStatus.loadSuccess:
            case ItemStateStatus.loadMoreSuccess:
            case ItemStateStatus.loadingMore:
              return _buildGrid();
            case ItemStateStatus.loadFailure:
            case ItemStateStatus.loadMoreFailure:
              return _buildError();
            default:
              return Container();
          }
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Image(image: AppImages.pikloader),
    );
  }

  Widget _buildGrid() {
    return CustomScrollView(
      slivers: [
        PokemonRefreshControl(onRefresh: _onRefresh),
        SliverPadding(
          padding: const EdgeInsets.all(28),
          sliver: NumberOfItemsSelector((numberOfItems) {
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ItemSelector(index, (item, _) {
                    return ItemCard(item, index: index);
                  });
                },
                childCount: numberOfItems,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: ItemCanLoadMoreSelector((canLoadMore) {
            if (!canLoadMore) {
              return const SizedBox.shrink();
            }

            return Container(
              padding: const EdgeInsets.only(bottom: 28),
              alignment: Alignment.center,
              child: const Image(image: AppImages.pikloader),
            );
          }),
        )
      ],
    );
  }

  Widget _buildError() {
    return CustomScrollView(
      slivers: [
        PokemonRefreshControl(onRefresh: _onRefresh),
        SliverFillRemaining(
          child: Container(
            padding: const EdgeInsets.only(bottom: 28),
            alignment: Alignment.center,
            child: const Icon(
              Icons.warning_amber_rounded,
              size: 60,
              color: Colors.black26,
            ),
          ),
        )
      ],
    );
  }
}
