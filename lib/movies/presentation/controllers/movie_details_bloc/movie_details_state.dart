part of 'movie_details_bloc.dart';

class MovieDetailsState {
  final MediaDetails? movieDetails;
  final RequestStatus status;
  final String message;

  const MovieDetailsState({
    this.movieDetails,
    this.status = RequestStatus.loading,
    this.message = '',
  });

  MovieDetailsState copyWith({
    MediaDetails? movieDetails,
    RequestStatus? status,
    String? message,
  }) {
    return MovieDetailsState(
      movieDetails: movieDetails ?? this.movieDetails,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
