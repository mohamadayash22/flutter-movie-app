part of 'watchlist_bloc.dart';

class WatchlistState extends Equatable {
  final int? id;
  final List<Media> items;
  final WatchlistRequestStatus status;
  final BookmarkStatus actionStatus;
  final String message;

  const WatchlistState({
    this.id,
    this.items = const [],
    this.status = WatchlistRequestStatus.loading,
    this.actionStatus = BookmarkStatus.none,
    this.message = '',
  });

  WatchlistState copyWith({
    int? id,
    List<Media>? items,
    WatchlistRequestStatus? status,
    BookmarkStatus? actionStatus,
    String? message,
  }) {
    return WatchlistState(
      id: id ?? this.id,
      items: items ?? this.items,
      status: status ?? this.status,
      actionStatus: actionStatus ?? BookmarkStatus.none,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [id, items, status, actionStatus, message];
}
