import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/domain/usecase/base_use_case.dart';
import 'package:movies_app/watchlist/domain/usecases/add_watchlist_item_usecase.dart';
import 'package:movies_app/watchlist/domain/usecases/check_if_item_added_usecase.dart';
import 'package:movies_app/watchlist/domain/usecases/get_watchlist_items_usecase.dart';
import 'package:movies_app/watchlist/domain/usecases/remove_watchlist_item_usecase.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc(
    this._getWatchListItemsUseCase,
    this._addWatchListItemUseCase,
    this._removeWatchListItemUseCase,
    this._checkIfItemAddedUseCase,
  ) : super(const WatchlistState()) {
    on<GetWatchListItemsEvent>(_getWatchListItems);
    on<AddWatchListItemEvent>(_addWatchListItem);
    on<RemoveWatchListItemEvent>(_removeWatchListItem);
    on<CheckItemAddedEvent>(_checkItemAdded);
  }

  final GetWatchlistItemsUseCase _getWatchListItemsUseCase;
  final AddWatchlistItemUseCase _addWatchListItemUseCase;
  final RemoveWatchlistItemUseCase _removeWatchListItemUseCase;
  final CheckIfItemAddedUseCase _checkIfItemAddedUseCase;

  Future<void> _getWatchListItems(
      WatchlistEvent event, Emitter<WatchlistState> emit) async {
    emit(
      const WatchlistState(
        status: WatchlistRequestStatus.loading,
      ),
    );
    final result = await _getWatchListItemsUseCase.call(const NoParameters());
    result.fold(
      (l) => emit(
        WatchlistState(
          status: WatchlistRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) {
        if (r.isEmpty) {
          emit(
            const WatchlistState(
              status: WatchlistRequestStatus.empty,
            ),
          );
        } else {
          emit(
            WatchlistState(
              status: WatchlistRequestStatus.loaded,
              items: r,
            ),
          );
        }
      },
    );
  }

  Future<void> _addWatchListItem(
      AddWatchListItemEvent event, Emitter<WatchlistState> emit) async {
    emit(
      const WatchlistState(
        status: WatchlistRequestStatus.loading,
      ),
    );
    final result = await _addWatchListItemUseCase.call(event.media);
    result.fold(
      (l) => emit(
        WatchlistState(
          status: WatchlistRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(
        WatchlistState(
          status: WatchlistRequestStatus.itemAdded,
          id: r,
        ),
      ),
    );
  }

  Future<void> _removeWatchListItem(
      RemoveWatchListItemEvent event, Emitter<WatchlistState> emit) async {
    emit(
      const WatchlistState(
        status: WatchlistRequestStatus.loading,
      ),
    );
    final result = await _removeWatchListItemUseCase.call(event.index);
    result.fold(
      (l) => emit(
        WatchlistState(
          status: WatchlistRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(
        const WatchlistState(
          status: WatchlistRequestStatus.itemRemoved,
        ),
      ),
    );
  }

  FutureOr<void> _checkItemAdded(
      CheckItemAddedEvent event, Emitter<WatchlistState> emit) async {
    emit(
      const WatchlistState(
        status: WatchlistRequestStatus.loading,
      ),
    );
    final result = await _checkIfItemAddedUseCase.call(event.tmdbId);
    result.fold(
      (l) => emit(
        WatchlistState(
          status: WatchlistRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) => emit(
        WatchlistState(
          status: WatchlistRequestStatus.isItemAdded,
          id: r,
        ),
      ),
    );
  }
}
