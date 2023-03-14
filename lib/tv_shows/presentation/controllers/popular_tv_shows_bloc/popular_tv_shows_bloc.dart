import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/tv_shows/domain/usecases/get_all_popular_tv_shows_usecase.dart';

part 'popular_tv_shows_event.dart';
part 'popular_tv_shows_state.dart';

class PopularTVShowsBloc
    extends Bloc<PopularTVShowsEvent, PopularTVShowsState> {
  PopularTVShowsBloc(this._getAllPopularTvShowsUseCase)
      : super(const PopularTVShowsState()) {
    on<GetPopularTVShowsEvent>(_getPopularTvShows);
    on<FetchMorePopularTVShowsEvent>(_fetchMoreTVShows);
  }

  final GetAllPopularTVShowsUseCase _getAllPopularTvShowsUseCase;
  int page = 1;

  Future<void> _getPopularTvShows(
      GetPopularTVShowsEvent event, Emitter<PopularTVShowsState> emit) async {
    if (state.status == GetAllRequestStatus.loading) {
      await _getTVShows(emit);
    } else if (state.status == GetAllRequestStatus.loaded) {
      await _getTVShows(emit);
    } else {
      emit(
        state.copyWith(
          status: GetAllRequestStatus.loading,
        ),
      );
      await _getTVShows(emit);
    }
  }

  Future<void> _getTVShows(Emitter<PopularTVShowsState> emit) async {
    final result = await _getAllPopularTvShowsUseCase(page);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: GetAllRequestStatus.error,
          message: l.message,
        ),
      ),
      (r) {
        page++;
        emit(
          state.copyWith(
            status: GetAllRequestStatus.loaded,
            tvShows: state.tvShows + r,
          ),
        );
      },
    );
  }

  Future<void> _fetchMoreTVShows(FetchMorePopularTVShowsEvent event,
      Emitter<PopularTVShowsState> emit) async {
    final result = await _getAllPopularTvShowsUseCase(page);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: GetAllRequestStatus.fetchMoreError,
          message: l.message,
        ),
      ),
      (r) {
        page++;
        emit(
          state.copyWith(
            status: GetAllRequestStatus.loaded,
            tvShows: state.tvShows + r,
          ),
        );
      },
    );
  }
}
