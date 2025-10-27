import 'package:dio/dio.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/network/api_constants.dart';
import 'package:movies_app/core/network/error_message_model.dart';
import 'package:movies_app/search/data/models/search_result_item_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchResultItemModel>> search(String title);
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final Dio dio;

  SearchRemoteDataSourceImpl(this.dio);

  @override
  Future<List<SearchResultItemModel>> search(String title) async {
    final response = await dio.get(
      ApiConstants.searchPath,
      queryParameters: {'query': title},
    );

    if (response.statusCode == 200) {
      return List<SearchResultItemModel>.from(
        (response.data['results'] as List)
            .where((e) => e['media_type'] != 'person')
            .map((e) => SearchResultItemModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
