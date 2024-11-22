import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/core/failure/failure.dart';
import 'package:sahayatri/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sahayatri/features/favourites/domain/repository/favourite_repository.dart';

final addFavouriteUseCaseProvider = Provider.autoDispose<AddFavouriteUseCase>(
    (ref) =>
        AddFavouriteUseCase(repository: ref.read(favouriteRepositoryProvider)));

class AddFavouriteUseCase {
  final IFavouriteRepository repository;

  AddFavouriteUseCase({required this.repository});

  Future<Either<Failure, bool>> addFavourite(
      FavouriteEntity favouriteEntity) async {
    return await repository.addFavourite(favouriteEntity);
  }
  

}
