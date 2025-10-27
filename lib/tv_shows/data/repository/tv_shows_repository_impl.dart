import 'package:dio/dio.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/domain/entities/media_details.dart';
import 'package:movies_app/tv_shows/data/datasource/tv_shows_remote_data_source.dart';
import 'package:movies_app/tv_shows/domain/entities/season_details.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/tv_shows/domain/repository/tv_shows_repository.dart';
import 'package:movies_app/tv_shows/domain/usecases/get_season_details_usecase.dart';

class TVShowsRepositoryImpl extends TVShowsRepository {
  final TVShowsRemoteDataSource _baseTVShowsRemoteDataSource;

  TVShowsRepositoryImpl(this._baseTVShowsRemoteDataSource);

  @override
  Future<Either<Failure, List<List<Media>>>> getTVShows() async {
    try {
      final result = await _baseTVShowsRemoteDataSource.getTVShows();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message ?? 'Unknown error'));
    }
  }

  @override
  Future<Either<Failure, MediaDetails>> getTVShowDetails(int id) async {
    try {
      final result = await _baseTVShowsRemoteDataSource.getTVShowDetails(id);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message ?? 'Unknown error'));
    }
  }

  @override
  Future<Either<Failure, SeasonDetails>> getSeasonDetails(
    SeasonDetailsParams params,
  ) async {
    try {
      final result = await _baseTVShowsRemoteDataSource.getSeasonDetails(
        params.id,
        params.seasonNumber,
      );
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message ?? 'Unknown error'));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getAllPopularTVShows(int page) async {
    try {
      final result = await _baseTVShowsRemoteDataSource.getAllPopularTVShows(
        page,
      );
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message ?? 'Unknown error'));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getAllTopRatedTVShows(int page) async {
    try {
      final result = await _baseTVShowsRemoteDataSource.getAllTopRatedTVShows(
        page,
      );
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message ?? 'Unknown error'));
    }
  }
}
