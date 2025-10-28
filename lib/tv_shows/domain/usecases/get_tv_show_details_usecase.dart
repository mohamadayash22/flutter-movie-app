import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/entities/media_details.dart';
import 'package:movies_app/core/domain/usecase/base_use_case.dart';
import 'package:movies_app/tv_shows/domain/repository/tv_shows_repository.dart';

class GetTVShowDetailsUseCase extends BaseUseCase<MediaDetails, int> {
  final TVShowsRepository _tvShowsRepository;

  GetTVShowDetailsUseCase(this._tvShowsRepository);
  @override
  Future<Either<Failure, MediaDetails>> call(int p) async {
    return await _tvShowsRepository.getTVShowDetails(p);
  }
}
