import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/domain/usecase/base_use_case.dart';
import 'package:movies_app/movies/domain/repository/movies_repository.dart';

class GetAllTopRatedMoviesUseCase extends BaseUseCase<List<Media>, int> {
  final MoviesRespository _moviesRespository;

  GetAllTopRatedMoviesUseCase(this._moviesRespository);

  @override
  Future<Either<Failure, List<Media>>> call(int p) async {
    return await _moviesRespository.getAllTopRatedMovies(p);
  }
}
