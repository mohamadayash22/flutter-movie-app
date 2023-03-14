import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/usecases/get_all_top_rated_movies_usecase.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  TopRatedMoviesBloc(this._getAllTopRatedMoviesUseCase)
      : super(const TopRatedMoviesState()) {
    on<TopRatedMoviesEvent>(_getAllTopRatedMovies);
    on<FetchMoreTopRatedMoviesEvent>(_fetchMoreMovies);
  }

  final GetAllTopRatedMoviesUseCase _getAllTopRatedMoviesUseCase;
  int page = 1;

  Future<void> _getAllTopRatedMovies(
      TopRatedMoviesEvent event, Emitter<TopRatedMoviesState> emit) async {
    if (state.status == GetAllRequestStatus.loading) {
      await _getMovies(emit);
    } else if (state.status == GetAllRequestStatus.loaded) {
      await _getMovies(emit);
    } else if (state.status == GetAllRequestStatus.error) {
      emit(
        state.copyWith(
          status: GetAllRequestStatus.loading,
        ),
      );
      await _getMovies(emit);
    }
  }

  Future<void> _getMovies(Emitter<TopRatedMoviesState> emit) async {
    final result = await _getAllTopRatedMoviesUseCase(page);
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

  Future<void> _fetchMoreMovies(FetchMoreTopRatedMoviesEvent event,
      Emitter<TopRatedMoviesState> emit) async {
    final result = await _getAllTopRatedMoviesUseCase(page);
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
