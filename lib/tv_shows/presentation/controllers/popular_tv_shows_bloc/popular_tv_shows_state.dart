part of 'popular_tv_shows_bloc.dart';

class PopularTVShowsState extends Equatable {
  const PopularTVShowsState({
    this.tvShows = const [],
    this.status = GetAllRequestStatus.loading,
    this.message = '',
  });

  final List<Media> tvShows;
  final GetAllRequestStatus status;
  final String message;

  PopularTVShowsState copyWith({
    List<Media>? tvShows,
    GetAllRequestStatus? status,
    String? message,
  }) {
    return PopularTVShowsState(
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
