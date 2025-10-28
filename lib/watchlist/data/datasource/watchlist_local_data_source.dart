import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/watchlist/data/models/watchlist_item_model.dart';

abstract class WatchlistLocalDataSource {
  Future<List<WatchlistItemModel>> getWatchListItems();
  Future<int> addWatchListItem(WatchlistItemModel item);
  Future<void> removeWatchListItem(int index);
  Future<int> isBookmarked(int tmdbID);
}

class WatchlistLocalDataSourceImpl extends WatchlistLocalDataSource {
  final Box<WatchlistItemModel> _box;

  WatchlistLocalDataSourceImpl(this._box);

  @override
  Future<List<WatchlistItemModel>> getWatchListItems() async {
    try {
      return _box.values.toList();
    } catch (e) {
      throw DatabaseException(errorMessage: e.toString());
    }
  }

  @override
  Future<int> addWatchListItem(WatchlistItemModel item) async {
    try {
      return await _box.add(item);
    } catch (e) {
      throw DatabaseException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> removeWatchListItem(int index) async {
    try {
      await _box.deleteAt(index);
    } catch (e) {
      throw DatabaseException(errorMessage: e.toString());
    }
  }

  @override
  Future<int> isBookmarked(int tmdbID) async {
    try {
      final models = _box.values.toList();
      return models.indexWhere((model) => model.tmdbID == tmdbID);
    } catch (e) {
      throw DatabaseException(errorMessage: e.toString());
    }
  }
}
