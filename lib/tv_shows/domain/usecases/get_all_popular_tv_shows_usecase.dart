import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/domain/usecase/base_use_case.dart';
import 'package:movies_app/tv_shows/domain/repository/tv_shows_repository.dart';

class GetAllPopularTVShowsUseCase extends BaseUseCase<List<Media>, int> {
  final TVShowsRepository _tvShowsRepository;

  GetAllPopularTVShowsUseCase(this._tvShowsRepository);

  @override
  Future<Either<Failure, List<Media>>> call(int p) async {
    return await _tvShowsRepository.getAllPopularTVShows(p);
  }
}
