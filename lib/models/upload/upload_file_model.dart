import 'dart:io';

// import '../login_models/request_data.dart';

class UploadFileModel {
  final Map<String, String> requestData;
  final File file;

  UploadFileModel({required this.requestData, required this.file});
}
