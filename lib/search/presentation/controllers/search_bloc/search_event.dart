part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class GetSearchResultsEvent extends SearchEvent {
  final String title;

  const GetSearchResultsEvent(this.title);

  @override
  List<Object?> get props => [title];
}
