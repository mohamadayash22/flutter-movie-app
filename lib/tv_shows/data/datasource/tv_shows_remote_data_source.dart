import 'package:dio/dio.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/network/api_constants.dart';
import 'package:movies_app/core/network/error_message_model.dart';
import 'package:movies_app/tv_shows/data/models/season_details_model.dart';
import 'package:movies_app/tv_shows/data/models/tv_show_details_model.dart';
import 'package:movies_app/tv_shows/data/models/tv_show_model.dart';

abstract class TVShowsRemoteDataSource {
  Future<List<TVShowModel>> getOnAirTVShows();
  Future<List<TVShowModel>> getPopularTVShows();
  Future<List<TVShowModel>> getTopRatedTVShows();
  Future<List<List<TVShowModel>>> getTVShows();
  Future<TVShowDetailsModel> getTVShowDetails(int id);
  Future<SeasonDetailsModel> getSeasonDetails(int id, int seasonNumber);
  Future<List<TVShowModel>> getAllPopularTVShows(int page);
  Future<List<TVShowModel>> getAllTopRatedTVShows(int page);
}

class TVShowsRemoteDataSourceImpl extends TVShowsRemoteDataSource {
  final Dio dio;

  TVShowsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<TVShowModel>> getOnAirTVShows() async {
    final response = await dio.get(
      ApiConstants.onAirTvShowsPath,
      queryParameters: {'with_original_language': 'en'},
    );
    if (response.statusCode == 200) {
      return List<TVShowModel>.from(
        (response.data['results'] as List).map((e) => TVShowModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TVShowModel>> getPopularTVShows() async {
    final response = await dio.get(
      ApiConstants.popularTvShowsPath,
      queryParameters: {'with_original_language': 'en'},
    );
    if (response.statusCode == 200) {
      return List<TVShowModel>.from(
        (response.data['results'] as List).map((e) => TVShowModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TVShowModel>> getTopRatedTVShows() async {
    final response = await dio.get(
      ApiConstants.topRatedTvShowsPath,
      queryParameters: {'with_original_language': 'en'},
    );
    if (response.statusCode == 200) {
      return List<TVShowModel>.from(
        (response.data['results'] as List).map((e) => TVShowModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<List<TVShowModel>>> getTVShows() async {
    final response = Future.wait([
      getOnAirTVShows(),
      getPopularTVShows(),
      getTopRatedTVShows(),
    ], eagerError: true);
    return response;
  }

  @override
  Future<TVShowDetailsModel> getTVShowDetails(int id) async {
    final response = await dio.get(
      ApiConstants.tvShowDetailsPath(id),
      queryParameters: {'append_to_response': 'similar,videos'},
    );
    if (response.statusCode == 200) {
      return TVShowDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<SeasonDetailsModel> getSeasonDetails(int id, int seasonNumber) async {
    final response = await dio.get(
      ApiConstants.seasonDetailsPath(id: id, seasonNumber: seasonNumber),
    );
    if (response.statusCode == 200) {
      return SeasonDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TVShowModel>> getAllPopularTVShows(int page) async {
    final response = await dio.get(
      ApiConstants.popularTvShowsPath,
      queryParameters: {'page': page},
    );
    if (response.statusCode == 200) {
      return List<TVShowModel>.from(
        (response.data['results'] as List).map((e) => TVShowModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TVShowModel>> getAllTopRatedTVShows(int page) async {
    final response = await dio.get(
      ApiConstants.topRatedTvShowsPath,
      queryParameters: {'page': page},
    );
    if (response.statusCode == 200) {
      return List<TVShowModel>.from(
        (response.data['results'] as List).map((e) => TVShowModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
