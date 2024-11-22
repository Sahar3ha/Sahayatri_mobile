import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sahayatri/features/favourites/domain/usecase/get_favourite_usecase.dart';
import 'package:sahayatri/features/favourites/presentation/state/favourites_state.dart';

final getFavouriteViewModelProvider =
    StateNotifierProvider<GetFavouriteViewModel, FavouriteState>((ref) {
  final getFavouriteusecase = ref.read(getFavouriteUseCaseProvider);
  return GetFavouriteViewModel(getFavouriteusecase);
});

class GetFavouriteViewModel extends StateNotifier<FavouriteState> {
  final GetFavouriteUseCase _getFavouriteUseCase;

  GetFavouriteViewModel(this._getFavouriteUseCase)
      : super(FavouriteState.initialState()) {
    getFavourite();
  }

  Future resetState() async {
    state = FavouriteState.initialState();
    getFavourite();
  }

  Future<void> deleteFavourite(FavouriteEntity favouriteId) async {
    try {
      await _getFavouriteUseCase.deleteFavourite(favouriteId);
    } catch (error) {
      print(error.toString());
    }
  }

  Future getFavourite() async {
    state = state.copywith(isLoading: true);

    final currentState = state;
    final page = currentState.page + 1;
    final favourites = currentState.favourites;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source
      final result = await _getFavouriteUseCase.getFavourite(page);
      result.fold(
        (failure) =>
            state = state.copywith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copywith(hasReachedMax: true);
          } else {
            state = state.copywith(
              favourites: [...favourites, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }
}
