import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/domain/usecase/base_use_case.dart';
import 'package:movies_app/watchlist/domain/repository/watchlist_repository.dart';

class RemoveWatchlistItemUseCase extends BaseUseCase<Unit, int> {
  final WatchlistRepository _watchlistRepository;

  RemoveWatchlistItemUseCase(this._watchlistRepository);

  @override
  Future<Either<Failure, Unit>> call(int p) async {
    return await _watchlistRepository.removeWatchListItem(p);
  }
}
