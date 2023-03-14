import 'package:equatable/equatable.dart';
import 'package:movies_app/core/data/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/usecase/base_use_case.dart';
import 'package:movies_app/tv_shows/domain/entities/season_details.dart';
import 'package:movies_app/tv_shows/domain/repository/tv_shows_repository.dart';

class GetSeasonDetailsUseCase
    extends BaseUseCase<SeasonDetails, SeasonDetailsParams> {
  final TVShowsRepository _baseTVShowsRepository;

  GetSeasonDetailsUseCase(this._baseTVShowsRepository);
  @override
  Future<Either<Failure, SeasonDetails>> call(SeasonDetailsParams p) async {
    return await _baseTVShowsRepository.getSeasonDetails(p);
  }
}

class SeasonDetailsParams extends Equatable {
  final int id;
  final int seasonNumber;

  const SeasonDetailsParams({
    required this.id,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [
        id,
        seasonNumber,
      ];
}
