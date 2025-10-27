import 'package:dio/dio.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/movies/data/models/movie_details_model.dart';

import 'package:movies_app/core/network/api_constants.dart';
import 'package:movies_app/core/network/error_message_model.dart';
import 'package:movies_app/movies/data/models/movie_model.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<List<List<MovieModel>>> getMovies();
  Future<MovieDetailsModel> getMovieDetails(int movieId);
  Future<List<MovieModel>> getAllPopularMovies(int page);
  Future<List<MovieModel>> getAllTopRatedMovies(int page);
}

class MoviesRemoteDataSourceImpl extends MoviesRemoteDataSource {
  final Dio dio;

  MoviesRemoteDataSourceImpl(this.dio);

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await dio.get(ApiConstants.nowPlayingMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map((e) => MovieModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await dio.get(ApiConstants.popularMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map((e) => MovieModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await dio.get(ApiConstants.topRatedMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map((e) => MovieModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<List<MovieModel>>> getMovies() async {
    final response = Future.wait([
      getNowPlayingMovies(),
      getPopularMovies(),
      getTopRatedMovies(),
    ], eagerError: true);
    return response;
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final response = await dio.get(
      ApiConstants.movieDetailsPath(movieId),
      queryParameters: {'append_to_response': 'videos,credits,reviews,similar'},
    );
    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getAllPopularMovies(int page) async {
    final response = await dio.get(
      ApiConstants.popularMoviesPath,
      queryParameters: {'page': page},
    );
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map((e) => MovieModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getAllTopRatedMovies(int page) async {
    final response = await dio.get(
      ApiConstants.topRatedMoviesPath,
      queryParameters: {'page': page},
    );
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data['results'] as List).map((e) => MovieModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
