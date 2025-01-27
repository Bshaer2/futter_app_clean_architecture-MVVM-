import 'package:dio/dio.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

enum DataSource {
  success,
  noContent,
  badCertificate,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectionTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error){
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.defaultError.getFailure();
    }
  }

}
Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectionTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeout.getFailure();
    case DioExceptionType.badResponse:
      return _handleBadResponse(error);
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    default:
      return _handleDefaultError(error);
  }
}

_handleBadResponse(DioException error) {
  try {
    final code = error.response?.statusCode ?? ResponseCode.defaultError;
    String message = '';
    switch (code) {
      case ResponseCode.unAuthorised:
        return DataSource.unAuthorised.getFailure();
      case ResponseCode.forbidden:
        return DataSource.forbidden.getFailure();
      case ResponseCode.notFound:
        return DataSource.notFound.getFailure();
      default:
        message = _extractErrorMessage(error.response?.data);
        return Failure(code, message);
    }
  } catch (e) {
    return DataSource.defaultError.getFailure();
  }
}

String _extractErrorMessage(dynamic data) {
  if (data is String) return data;
  String message = '';
  if (data is Map) {
    data.forEach((key, value) {
      if (value is List) {
        message += value.join('\n');
      } else if (value is String) {
        message += value;
      } else {
        message += value.toString();
      }
    });
  }
  return message;
}

_handleDefaultError(DioException error) {
  if (error.response?.statusCode == ResponseCode.noInternetConnection) {
    return DataSource.noInternetConnection.getFailure();
  } else {
    return DataSource.defaultError.getFailure();
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badCertificate:
        return Failure(ResponseCode.badCertificate, ResponseMessage.badCertificate);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unAuthorised:
        return Failure(ResponseCode.unAuthorised, ResponseMessage.unAuthorised);
      case DataSource.notFound:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectionTimeout:
        return Failure(
            ResponseCode.connectionTimeout, ResponseMessage.connectionTimeout);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeout:
        return Failure(
            ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.defaultError:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
    }
  }
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badCertificate = 400;
  static const int forbidden = 403;
  static const int unAuthorised = 401;
  static const int notFound = 404;
  static const int internalServerError = 500;

  // local status code
  static const int connectionTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

class ResponseMessage {
  static const String success = AppStrings.success; // success with data
  static const String noContent =
      AppStrings.noContent; // success with no data (no content)
  static const String badCertificate =
      AppStrings.badCertificateError; // failure, API rejected request
  static const String forbidden =
      AppStrings.forbiddenError; //  failure, API rejected request
  static const String unAuthorised =
      AppStrings.unauthorizedError; // failure, user is not authorised
  static const String notFound =
      AppStrings.notFoundError; // failure, crash in server side
  static const String internalServerError =
      AppStrings.internalServerError; // failure, crash in server side
  // local status code
  static const String connectionTimeout = AppStrings.timeoutError;
  static const String cancel = AppStrings.defaultError;
  static const String receiveTimeout = AppStrings.timeoutError;
  static const String sendTimeout = AppStrings.timeoutError;
  static const String cacheError = AppStrings.cacheError;
  static const String noInternetConnection = AppStrings.noInternetError;
  static const String defaultError = AppStrings.defaultError;
}

class ApiInternalStatus {
  static const int apiSuccessStatus = 0;
  static const int apiFailureStatus = 1;
}