part of 'tv_show_details_bloc.dart';

abstract class TVShowDetailsEvent extends Equatable {
  const TVShowDetailsEvent();
}

class GetTVShowDetailsEvent extends TVShowDetailsEvent {
  final int id;
  const GetTVShowDetailsEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetSeasonDetailsEvent extends TVShowDetailsEvent {
  final int id;
  final int seasonNumber;

  const GetSeasonDetailsEvent({
    required this.id,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [id, seasonNumber];
}
