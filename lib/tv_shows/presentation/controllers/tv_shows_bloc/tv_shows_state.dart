part of 'tv_shows_bloc.dart';

class TVShowsState extends Equatable {
  final List<List<Media>> tvShows;
  final RequestStatus status;
  final String message;

  const TVShowsState({
    this.tvShows = const [],
    this.status = RequestStatus.loading,
    this.message = '',
  });

  @override
  List<Object> get props => [
        tvShows,
        status,
        message,
      ];
}
