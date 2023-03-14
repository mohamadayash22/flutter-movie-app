import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/entities/media.dart';

import 'package:movies_app/core/data/error/failure.dart';
import 'package:movies_app/core/domain/entities/media_details.dart';

abstract class MoviesRespository {
  Future<Either<Failure, List<List<Media>>>> getMovies();
  Future<Either<Failure, MediaDetails>> getMovieDetails(int movieId);
  Future<Either<Failure, List<Media>>> getAllPopularMovies(int page);
  Future<Either<Failure, List<Media>>> getAllTopRatedMovies(int page);
}
