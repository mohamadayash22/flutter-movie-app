part of 'top_rated_tv_shows_bloc.dart';

abstract class TopRatedTVShowsEvent extends Equatable {
  const TopRatedTVShowsEvent();

  @override
  List<Object?> get props => [];
}

class GetTopRatedTVShowsEvent extends TopRatedTVShowsEvent {}

class FetchMoreTopRatedTVShowsEvent extends TopRatedTVShowsEvent {}
