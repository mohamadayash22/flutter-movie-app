import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/domain/entities/media_details.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/tv_shows/domain/entities/season_details.dart';
import 'package:movies_app/tv_shows/domain/usecases/get_season_details_usecase.dart';
import 'package:movies_app/tv_shows/domain/usecases/get_tv_show_details_usecase.dart';
part 'tv_show_details_event.dart';
part 'tv_show_details_state.dart';

class TVShowDetailsBloc extends Bloc<TVShowDetailsEvent, TVShowDetailsState> {
  TVShowDetailsBloc(
    this._getTvShowDetailsUseCase,
    this._getSeasonDetailsUseCase,
  ) : super(const TVShowDetailsState()) {
    on<GetTVShowDetailsEvent>(_getTvShowDetails);
    on<GetSeasonDetailsEvent>(_getSeasonDetails);
  }

  final GetTVShowDetailsUseCase _getTvShowDetailsUseCase;
  final GetSeasonDetailsUseCase _getSeasonDetailsUseCase;

  Future<void> _getTvShowDetails(
      GetTVShowDetailsEvent event, Emitter<TVShowDetailsState> emit) async {
    emit(
      state.copyWith(
        tvShowDetailsStatus: RequestStatus.loading,
      ),
    );
    final result = await _getTvShowDetailsUseCase(event.id);
    result.fold(
      (l) => emit(
        TVShowDetailsState(
          tvShowDetailsStatus: RequestStatus.error,
          tvShowDetailsMessage: l.message,
        ),
      ),
      (r) => emit(
        TVShowDetailsState(
          tvShowDetailsStatus: RequestStatus.loaded,
          tvShowDetails: r,
        ),
      ),
    );
  }

  Future<void> _getSeasonDetails(
      GetSeasonDetailsEvent event, Emitter<TVShowDetailsState> emit) async {
    emit(
      state.copyWith(
        seasonDetailsStatus: RequestStatus.loading,
      ),
    );
    final result = await _getSeasonDetailsUseCase(
      SeasonDetailsParams(
        id: event.id,
        seasonNumber: event.seasonNumber,
      ),
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          seasonDetailsStatus: RequestStatus.error,
          seasonDetailsMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          seasonDetailsStatus: RequestStatus.loaded,
          seasonDetails: r,
        ),
      ),
    );
  }
}
