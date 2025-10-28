import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/domain/usecase/base_use_case.dart';
import 'package:movies_app/watchlist/domain/repository/watchlist_repository.dart';

class AddWatchlistItemUseCase extends BaseUseCase<int, Media> {
  final WatchlistRepository _watchlistRepository;

  AddWatchlistItemUseCase(this._watchlistRepository);

  @override
  Future<Either<Failure, int>> call(Media p) async {
    return await _watchlistRepository.addWatchListItem(p);
  }
}
