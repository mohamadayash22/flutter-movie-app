part of 'top_rated_movies_bloc.dart';

class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState({
    this.movies = const [],
    this.status = GetAllRequestStatus.loading,
    this.message = '',
  });

  final List<Media> movies;
  final GetAllRequestStatus status;
  final String message;

  TopRatedMoviesState copyWith({
    List<Media>? movies,
    GetAllRequestStatus? status,
    String? message,
  }) {
    return TopRatedMoviesState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        movies,
        status,
        message,
      ];
}
