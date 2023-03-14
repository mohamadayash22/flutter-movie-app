part of 'tv_shows_bloc.dart';

abstract class TVShowsEvent extends Equatable {
  const TVShowsEvent();

  @override
  List<Object> get props => [];
}

class GetTVShowsEvent extends TVShowsEvent {}
