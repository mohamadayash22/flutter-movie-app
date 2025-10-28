import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/resources/app_strings.dart';
import 'package:movies_app/watchlist/data/datasource/watchlist_local_data_source.dart';
import 'package:movies_app/watchlist/data/models/watchlist_item_model.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/watchlist/domain/repository/watchlist_repository.dart';

class WatchListRepositoryImpl extends WatchlistRepository {
  final WatchlistLocalDataSource _watchlistLocalDataSource;

  WatchListRepositoryImpl(this._watchlistLocalDataSource);

  @override
  Future<Either<Failure, List<Media>>> getWatchListItems() async {
    try {
      final models = await _watchlistLocalDataSource.getWatchListItems();
      final entities = models
          .map((model) => model.toEntity())
          .toList()
          .reversed
          .toList();
      return Right(entities);
    } on DatabaseException {
      return Left(DatabaseFailure(AppStrings.databaseError));
    } catch (_) {
      return Left(DatabaseFailure(AppStrings.unknownError));
    }
  }

  @override
  Future<Either<Failure, int>> addWatchListItem(Media media) async {
    try {
      final model = WatchlistItemModel.fromEntity(media);
      int id = await _watchlistLocalDataSource.addWatchListItem(model);
      return Right(id);
    } on DatabaseException {
      return Left(DatabaseFailure(AppStrings.databaseError));
    } catch (_) {
      return Left(DatabaseFailure(AppStrings.unknownError));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeWatchListItem(int index) async {
    try {
      await _watchlistLocalDataSource.removeWatchListItem(index);
      return const Right(unit);
    } on DatabaseException {
      return Left(DatabaseFailure(AppStrings.databaseError));
    } catch (_) {
      return Left(DatabaseFailure(AppStrings.unknownError));
    }
  }

  @override
  Future<Either<Failure, int>> isBookmarked(int tmdbId) async {
    try {
      final result = await _watchlistLocalDataSource.isBookmarked(tmdbId);
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure(AppStrings.databaseError));
    } catch (_) {
      return Left(DatabaseFailure(AppStrings.unknownError));
    }
  }
}
