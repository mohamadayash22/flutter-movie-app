import 'package:movies_app/core/domain/entities/media_details.dart';
import 'package:movies_app/core/utils/functions.dart';
import 'package:movies_app/tv_shows/data/models/tv_show_model.dart';

import 'package:movies_app/tv_shows/data/models/episode_model.dart';
import 'package:movies_app/tv_shows/data/models/season_model.dart';

// ignore: must_be_immutable
class TVShowDetailsModel extends MediaDetails {
  TVShowDetailsModel({
    required super.tmdbID,
    required super.title,
    required super.posterUrl,
    required super.backdropUrl,
    required super.releaseDate,
    required super.lastEpisodeToAir,
    required super.genres,
    required super.overview,
    required super.voteAverage,
    required super.voteCount,
    required super.trailerUrl,
    required super.numberOfSeasons,
    required super.seasons,
    required super.similar,
  });

  factory TVShowDetailsModel.fromJson(Map<String, dynamic> json) {
    return TVShowDetailsModel(
      tmdbID: json['id'],
      title: json['name'],
      posterUrl: getPosterUrl(json['poster_path']),
      backdropUrl: getBackdropUrl(json['backdrop_path']),
      releaseDate: getDate(json['first_air_date']),
      lastEpisodeToAir: EpisodeModel.fromJson(json['last_episode_to_air']),
      genres: getGenres(json['genres']),
      numberOfSeasons: json['number_of_seasons'],
      voteAverage:
          double.parse((json['vote_average'] as double).toStringAsFixed(1)),
      voteCount: getVotesCount(json['vote_count']),
      overview: json['overview'],
      trailerUrl: getTrailerUrl(json),
      seasons: List<SeasonModel>.from(
        ((json['seasons'] as List)
            .where((e) => e['name'] != 'Specials')
            .map((e) => SeasonModel.fromJson(e))),
      ),
      similar: List<TVShowModel>.from((json['similar']['results'] as List)
          .map((e) => TVShowModel.fromJson(e))),
    );
  }
}
