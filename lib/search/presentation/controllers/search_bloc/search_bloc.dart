import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/search/domain/entities/search_result_item.dart';
import 'package:movies_app/search/domain/usecases/search_usecase.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';
part 'search_state.dart';

const _duration = Duration(milliseconds: 400);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._searchUseCase) : super(const SearchState()) {
    on<GetSearchResultsEvent>(_getSearchResults,
        transformer: debounce(_duration));
  }

  final SearchUseCase _searchUseCase;

  Future<void> _getSearchResults(
      GetSearchResultsEvent event, Emitter<SearchState> emit) async {
    if (event.title.trim().isEmpty) {
      return emit(
        state.copyWith(
          status: SearchRequestStatus.empty,
        ),
      );
    }

    emit(
      state.copyWith(
        status: SearchRequestStatus.loading,
      ),
    );

    final result = await _searchUseCase(event.title);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: SearchRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) {
        if (r.isEmpty) {
          emit(
            state.copyWith(
              status: SearchRequestStatus.noResults,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: SearchRequestStatus.loaded,
              searchResults: r,
            ),
          );
        }
      },
    );
  }
}
