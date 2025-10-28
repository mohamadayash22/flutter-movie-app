import 'package:movies_app/core/network/error_message_model.dart';

class ServerException implements Exception {
  final ErrorMessageModel errorMessageModel;

  const ServerException({required this.errorMessageModel});
}

class DatabaseException implements Exception {
  final String errorMessage;

  const DatabaseException({required this.errorMessage});
}
