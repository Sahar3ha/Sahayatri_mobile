import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sahayatri/features/favourites/domain/repository/favourite_repository.dart';

final getFavouriteUseCaseProvider = Provider.autoDispose<GetFavouriteUseCase>(
  (ref) =>
      GetFavouriteUseCase(repository: ref.read(favouriteRepositoryProvider)),
);

class GetFavouriteUseCase {
  final IFavouriteRepository repository;
  GetFavouriteUseCase({required this.repository});

  Future<Either<Failure, List<FavouriteEntity>>> getFavourite(int page) async {
    return await repository.getFavourite(page);
  }

  Future<Either<Failure, bool>> deleteFavourite(
      FavouriteEntity favouriteEntity) async {
    return await repository.deleteFavourite(favouriteEntity);
  }
}
