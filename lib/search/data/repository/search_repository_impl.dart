import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/resources/app_strings.dart';
import 'package:movies_app/search/data/datasource/search_remote_data_source.dart';
import 'package:movies_app/search/domain/entities/search_result_item.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_app/search/domain/repository/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource _searchRemoteDataSource;

  SearchRepositoryImpl(this._searchRemoteDataSource);

  @override
  Future<Either<Failure, List<SearchResultItem>>> search(String title) async {
    try {
      final result = await _searchRemoteDataSource.search(title);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } catch (_) {
      return Left(ServerFailure(AppStrings.unknownError));
    }
  }
}
