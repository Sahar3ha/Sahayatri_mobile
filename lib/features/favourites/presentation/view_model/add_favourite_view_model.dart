import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/shared_pref/user_shared_prefs.dart';
import 'package:sahayatri/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sahayatri/features/favourites/domain/usecase/add_favourite_usecase.dart';
import 'package:sahayatri/features/favourites/domain/usecase/get_favourite_usecase.dart';
import 'package:sahayatri/features/favourites/presentation/state/favourites_state.dart';

final favouriteViewModelProvider =
    StateNotifierProvider.autoDispose<AddFavouriteViewModel, FavouriteState>(
        (ref) => AddFavouriteViewModel(
            addFavouriteUseCase: ref.read(addFavouriteUseCaseProvider),
            userSharedPrefs: ref.read(userSharedPrefsProvider),
            getFavouriteUseCase: ref.read(getFavouriteUseCaseProvider)));

class AddFavouriteViewModel extends StateNotifier<FavouriteState> {
  final AddFavouriteUseCase addFavouriteUseCase;
  final UserSharedPrefs userSharedPrefs;
  final GetFavouriteUseCase getFavouriteUseCase;

  AddFavouriteViewModel(
      {required this.addFavouriteUseCase,
      required this.userSharedPrefs,
      required this.getFavouriteUseCase})
      : super(FavouriteState.initialState());

  void addFavourite(FavouriteEntity favouriteEntity) {
    state = state.copywith(isLoading: true);

    final userId = userSharedPrefs.getUserId();
    final updatedEntity = favouriteEntity.copyWith(userId: userId);

    addFavouriteUseCase.addFavourite(updatedEntity).then((value) {
      value.fold(
        (failure) => state = state.copywith(isLoading: false),
        (success) =>
            state = state.copywith(isLoading: false, showMessage: true),
      );
    });
  }

  Future getFavourite() async {
    state = state.copywith(isLoading: true);

    final currentState = state;
    final page = currentState.page + 1;
    final favourites = currentState.favourites;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source
      final result = await getFavouriteUseCase.getFavourite(page);
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

  void deleteFavourite(FavouriteEntity favouriteId) async {
    try {
      await getFavouriteUseCase.deleteFavourite(favouriteId);
    } catch (error) {
      print(error.toString());
    }
  }

  void resetMessage() async {
    state = FavouriteState.initialState();
    getFavourite();
  }
}
