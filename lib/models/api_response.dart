// ignore: file_names
import '../constants/strings.dart';

///Api Response Type.

// ignore_for_file: constant_identifier_names

enum ApiResponseType {
  LOADING,
  SUCCESS,
  ERROR,
}

///Api response object to communicate with view objects after app makes an api request.

class ApiResponse {
  final ApiResponseType responseType;
  String _message = "";

  ApiResponse.success() : responseType = ApiResponseType.SUCCESS;

  ApiResponse.error()
      : responseType = ApiResponseType.ERROR,
        _message = errorMessage;

  ApiResponse.loading() : responseType = ApiResponseType.LOADING;

  String get message => _message;
}
