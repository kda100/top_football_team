// ignore: file_names
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
        _message = "Something went wrong";

  ApiResponse.loading() : responseType = ApiResponseType.LOADING;

  String get message => _message;
}
