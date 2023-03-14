import 'package:equatable/equatable.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/movies/domain/entities/cast.dart';
import 'package:movies_app/movies/domain/entities/review.dart';
import 'package:movies_app/tv_shows/domain/entities/episode.dart';
import 'package:movies_app/tv_shows/domain/entities/season.dart';

// ignore: must_be_immutable
class MediaDetails extends Equatable {
  int? id;
  final int tmdbID;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final String releaseDate;
  final Episode? lastEpisodeToAir;
  final String genres;
  final String? runtime;
  final int? numberOfSeasons;
  final String overview;
  final double voteAverage;
  final String voteCount;
  final String trailerUrl;
  final List<Cast>? cast;
  final List<Review>? reviews;
  final List<Season>? seasons;
  final List<Media> similar;
  bool isAdded;

  MediaDetails({
    this.id,
    required this.tmdbID,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.releaseDate,
    this.lastEpisodeToAir,
    required this.genres,
    this.runtime,
    this.numberOfSeasons,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.trailerUrl,
    this.cast,
    this.reviews,
    this.seasons,
    required this.similar,
    this.isAdded = false,
  });

  @override
  List<Object?> get props => [
        id,
        tmdbID,
        title,
        posterUrl,
        backdropUrl,
        releaseDate,
        genres,
        overview,
        voteAverage,
        voteCount,
        trailerUrl,
        similar,
        isAdded,
      ];
}
