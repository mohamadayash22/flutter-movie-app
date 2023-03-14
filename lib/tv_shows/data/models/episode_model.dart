import 'package:movies_app/core/utils/functions.dart';
import 'package:movies_app/tv_shows/domain/entities/episode.dart';

class EpisodeModel extends Episode {
  const EpisodeModel({
    required super.number,
    required super.season,
    required super.name,
    required super.runtime,
    required super.stillPath,
    required super.airDate,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      number: json['episode_number'],
      season: json['season_number'],
      name: json['name'],
      runtime: getLength(json['runtime']),
      stillPath: getStillUrl(json['still_path']),
      airDate: getDate(json['air_date']),
    );
  }
}
