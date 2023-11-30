part of '../pokedex.dart';

class PokemonGrid extends StatefulWidget {
  const PokemonGrid({super.key});

  @override
  State<PokemonGrid> createState() => _PokemonGridState();
}

class _PokemonGridState extends State<PokemonGrid> {
  static const double _endReachedThreshold = 200;

  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  PokemonBloc get pokemonBloc => context.read<PokemonBloc>();

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      pokemonBloc.add(const PokemonLoadStarted());
      _scrollKey.currentState?.innerController.addListener(_onScroll);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollKey.currentState?.innerController.dispose();
    _scrollKey.currentState?.dispose();
  }

  void _onScroll() {
    final innerController = _scrollKey.currentState?.innerController;

    if (innerController == null || !innerController.hasClients) {
      return;
    }
    final thresholdReached = innerController.position.extentAfter < _endReachedThreshold;
    if (thresholdReached) {
      pokemonBloc.add(PokemonLoadMoreStarted());
    }
  }

  Future _onRefresh() async {
    pokemonBloc.add(const PokemonLoadStarted());
    return pokemonBloc.stream.firstWhere((element) => element.status != PokemonStateStatus.loading);
  }

  void _onPokemonPress(Pokemon pokemon) {
    pokemonBloc.add(PokemonSelectChanged(pokemonId: pokemon.number));
    AppNavigator.push(Routes.pokemonInfo, pokemon);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      key: _scrollKey,
      headerSliverBuilder: (_, __) => [
        MainSliverAppBar(context: context),
      ],
      body: PokemonStateStatusSelector((status) {
        switch (status) {
          case PokemonStateStatus.loading:
            return _buildLoading();
          case PokemonStateStatus.loadSuccess:
          case PokemonStateStatus.loadMoreSuccess:
          case PokemonStateStatus.loadingMore:
            return _buildGrid();
          case PokemonStateStatus.loadFailure:
          case PokemonStateStatus.loadMoreFailure:
            return _buildError();
          default:
            return Container();
        }
      }),
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
          sliver: NumberOfPokemonsSelector((numberOfPokemons) {
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  return PokemonSelector(index, (pokemon, _) {
                    return PokemonCard(
                      pokemon,
                      onPress: () {
                        _onPokemonPress(pokemon);
                      },
                    );
                  });
                },
                childCount: numberOfPokemons,
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
          child: PokemonCanLoadMoreSelector((canLoadMore) {
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
