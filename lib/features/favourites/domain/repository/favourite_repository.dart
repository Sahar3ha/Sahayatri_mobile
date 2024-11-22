import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/favourites/data/repository/favourite_remote_repository.dart';
import 'package:sahayatri/features/favourites/domain/entity/favourite_entity.dart';

final favouriteRepositoryProvider =
    Provider.autoDispose<IFavouriteRepository>((ref) {
  return ref.read(favouriteRemoteRepositoryProvider);
});

abstract class IFavouriteRepository {
  Future<Either<Failure, bool>> addFavourite(FavouriteEntity favouriteEntity);
  Future<Either<Failure, List<FavouriteEntity>>> getFavourite(int page);
  Future<Either<Failure,bool>>deleteFavourite(FavouriteEntity favouriteEntity);
}
