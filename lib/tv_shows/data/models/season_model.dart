import 'package:movies_app/core/utils/functions.dart';
import 'package:movies_app/tv_shows/domain/entities/season.dart';

class SeasonModel extends Season {
  const SeasonModel({
    required super.tmdbID,
    required super.name,
    required super.episodeCount,
    required super.airDate,
    required super.overview,
    required super.posterUrl,
    required super.seasonNumber,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
      tmdbID: json['id'],
      name: json['name'],
      episodeCount: json['episode_count'],
      airDate: getDate(json['air_date']),
      overview: json['overview'],
      posterUrl: getPosterUrl(json['poster_path']),
      seasonNumber: json['season_number'],
    );
  }
}
