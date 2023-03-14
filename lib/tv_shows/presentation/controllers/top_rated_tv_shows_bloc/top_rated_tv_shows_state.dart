part of 'top_rated_tv_shows_bloc.dart';

class TopRatedTVShowsState extends Equatable {
  const TopRatedTVShowsState({
    this.tvShows = const [],
    this.status = GetAllRequestStatus.loading,
    this.message = '',
  });

  final List<Media> tvShows;
  final GetAllRequestStatus status;
  final String message;

  TopRatedTVShowsState copyWith({
    List<Media>? tvShows,
    GetAllRequestStatus? status,
    String? message,
  }) {
    return TopRatedTVShowsState(
      tvShows: tvShows ?? this.tvShows,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        tvShows,
        status,
        message,
      ];
}
