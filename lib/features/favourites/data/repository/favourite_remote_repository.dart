import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/favourites/data/data_source/favourite_remote_data_source.dart';
import 'package:sahayatri/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sahayatri/features/favourites/domain/repository/favourite_repository.dart';

final favouriteRemoteRepositoryProvider =
    Provider.autoDispose<IFavouriteRepository>(
  (ref) => FavouriteRemoteRepoImpl(
      favouriteRemoteDataSource: ref.read(favouriteDataSourceProvider)),
);

class FavouriteRemoteRepoImpl implements IFavouriteRepository {
  final FavouriteRemoteDataSource favouriteRemoteDataSource;

  const FavouriteRemoteRepoImpl({required this.favouriteRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addFavourite(FavouriteEntity favouriteEntity) async{
    return await favouriteRemoteDataSource.addFavourite(favouriteEntity);
  }

  @override
  Future<Either<Failure, List<FavouriteEntity>>> getFavourite(int page) async {
    return await favouriteRemoteDataSource.getFavourite(page);
  }

  @override
  Future<Either<Failure, bool>> deleteFavourite(FavouriteEntity favouriteEntity) {
    return favouriteRemoteDataSource.deleteFavourite(favouriteEntity);
  }
}
