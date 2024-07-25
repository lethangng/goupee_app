class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix $_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, 'Lỗi lấy dữ liệu:');
}

class BadRequestException extends AppException {
  // BadRequestException([message]) : super(message, 'Yêu cầu không hợp lệ:');
  BadRequestException([message]) : super(message, '');
}

// class UnauthorisedException extends AppException {
//   UnauthorisedException([message]) : super(message, "Unauthorised Request: ");
// }

// class InvalidInputException extends AppException {
//   InvalidInputException([String? message]) : super(message, "Invalid Input: ");
// }

class RequestTimeOut extends AppException {
  RequestTimeOut([message]) : super(message, 'Server không phản hồi:');
}
