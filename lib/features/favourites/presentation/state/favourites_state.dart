import 'package:sahayatri/features/favourites/domain/entity/favourite_entity.dart';

class FavouriteState {
  final bool isLoading;
  final String? error;
  final List<FavouriteEntity> favourites;
  final bool? showMessage;
  final int page;
  final bool hasReachedMax;


  FavouriteState(
      {required this.isLoading,
      this.error,
      required this.favourites,
      this.showMessage,
      required this.page,
      required this.hasReachedMax
      });

  factory FavouriteState.initialState() => FavouriteState(
      isLoading: false, error: null, showMessage: false, favourites: [],hasReachedMax: false,
      page: 0);

  FavouriteState copywith({
    bool? isLoading,
    String? error,
    List<FavouriteEntity>? favourites,
    bool? showMessage,
    bool? hasReachedMax,
    int? page
  }) {
    return FavouriteState(
        isLoading: isLoading ?? this.isLoading,
        error:  error?? this.error,
        showMessage: showMessage?? this.showMessage,
        favourites: favourites ?? this.favourites,
        page: page?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      );
        
  }
}
