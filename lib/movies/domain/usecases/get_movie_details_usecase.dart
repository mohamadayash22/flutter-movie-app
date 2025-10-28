import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/entities/media_details.dart';
import 'package:movies_app/core/domain/usecase/base_use_case.dart';
import 'package:movies_app/movies/domain/repository/movies_repository.dart';

class GetMoviesDetailsUseCase extends BaseUseCase<MediaDetails, int> {
  final MoviesRespository _moviesRespository;

  GetMoviesDetailsUseCase(this._moviesRespository);

  @override
  Future<Either<Failure, MediaDetails>> call(int p) async {
    return await _moviesRespository.getMovieDetails(p);
  }
}
