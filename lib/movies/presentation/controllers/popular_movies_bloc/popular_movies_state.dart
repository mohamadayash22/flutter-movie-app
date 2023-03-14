part of 'popular_movies_bloc.dart';

class PopularMoviesState extends Equatable {
  final List<Media> movies;
  final GetAllRequestStatus status;
  final String message;

  const PopularMoviesState({
    this.movies = const [],
    this.status = GetAllRequestStatus.loading,
    this.message = '',
  });

  PopularMoviesState copyWith({
    List<Media>? movies,
    GetAllRequestStatus? status,
    String? message,
  }) {
    return PopularMoviesState(
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
