import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/movies/domain/usecases/get_all_popular_movies_usecase.dart';

import 'package:movies_app/core/utils/enums.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetAllPopularMoviesUseCase _allPopularMoviesUseCase;

  PopularMoviesBloc(this._allPopularMoviesUseCase)
      : super(const PopularMoviesState()) {
    on<GetPopularMoviesEvent>(_getAllPopularMovies);
    on<FetchMorePopularMoviesEvent>(_fetchMoreMovies);
  }

  int page = 1;

  Future<void> _getAllPopularMovies(
      GetPopularMoviesEvent event, Emitter<PopularMoviesState> emit) async {
    if (state.status == GetAllRequestStatus.loading) {
      await _getMovies(emit);
    } else if (state.status == GetAllRequestStatus.loaded) {
      await _getMovies(emit);
    } else {
      emit(
        state.copyWith(
          status: GetAllRequestStatus.loading,
        ),
      );
      await _getMovies(emit);
    }
  }

  Future<void> _getMovies(Emitter<PopularMoviesState> emit) async {
    final result = await _allPopularMoviesUseCase(page);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: GetAllRequestStatus.error,
        ),
      ),
      (r) {
        page++;
        emit(
          state.copyWith(
            status: GetAllRequestStatus.loaded,
            movies: state.movies + r,
          ),
        );
      },
    );
  }

  Future<void> _fetchMoreMovies(FetchMorePopularMoviesEvent event,
      Emitter<PopularMoviesState> emit) async {
    final result = await _allPopularMoviesUseCase(page);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: GetAllRequestStatus.fetchMoreError,
        ),
      ),
      (r) {
        page++;
        return emit(
          state.copyWith(
            status: GetAllRequestStatus.loaded,
            movies: state.movies + r,
          ),
        );
      },
    );
  }
}
