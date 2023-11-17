import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_animation/services/repositories/item_repository.dart';
import 'package:pokemon_animation/states/items/item_event.dart';
import 'package:pokemon_animation/states/items/item_state.dart';
import 'package:stream_transform/stream_transform.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  static const int itemsPerPage = 20;

  final ItemRepository _itemRepository;

  ItemBloc(this._itemRepository) : super(const ItemState.initial()) {
    on<ItemLoadStarted>(
      _onLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<ItemLoadMoreStarted>(
      _onLoadMoreStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  void _onLoadStarted(ItemLoadStarted event, Emitter<ItemState> emit) async {
    try {
      emit(state.asLoading());

      final items = event.loadAll ? await _itemRepository.getAllItems() : await _itemRepository.getItems(limit: itemsPerPage, page: 1);

      final canLoadMore = items.length >= itemsPerPage;
      emit(state.asLoadSuccess(items, canLoadMore: canLoadMore));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  void _onLoadMoreStarted(ItemLoadMoreStarted event, Emitter<ItemState> emit) async {
    try {
      if (!state.canLoadMore) {
        return;
      }
      emit(state.asLoadingMore());

      final pokemons = await _itemRepository.getItems(limit: itemsPerPage, page: state.page + 1);

      final canLoadMore = pokemons.length >= itemsPerPage;
      emit(state.asLoadMoreSuccess(pokemons, canLoadMore: canLoadMore));
    } on Exception catch (e) {
      emit(state.asLoadMoreFailure(e));
    }
  }
}
