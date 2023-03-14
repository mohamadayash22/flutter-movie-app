part of 'popular_tv_shows_bloc.dart';

abstract class PopularTVShowsEvent extends Equatable {
  const PopularTVShowsEvent();

  @override
  List<Object?> get props => [];
}

class GetPopularTVShowsEvent extends PopularTVShowsEvent {}

class FetchMorePopularTVShowsEvent extends PopularTVShowsEvent {}
