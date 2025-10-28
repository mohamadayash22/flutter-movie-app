import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/domain/usecase/base_use_case.dart';
import 'package:movies_app/tv_shows/domain/repository/tv_shows_repository.dart';

class GetTVShowsUseCase extends BaseUseCase<List<List<Media>>, NoParameters> {
  final TVShowsRepository _tvShowsRepository;

  GetTVShowsUseCase(this._tvShowsRepository);

  @override
  Future<Either<Failure, List<List<Media>>>> call(NoParameters p) async {
    return await _tvShowsRepository.getTVShows();
  }
}
