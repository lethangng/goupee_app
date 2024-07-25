import 'package:flutter/material.dart';

import '../../database/tables/token_table.dart';
import '../../models/upload/upload_file_model.dart';
import '../api/api_endpoints.dart';
import '../api/api_service.dart';
import '../exceptions/app_exceptions.dart';
import 'base_respository.dart';

class AccessServerRepository implements BaseRepository<Map<String, dynamic>> {
  final ApiService apiService = ApiService();

  @override
  getData(Map<String, dynamic>? data) async {
    try {
      dynamic response = await apiService.getResponse(
        ApiEndPoints.getAppId(),
      );
      if (response is List) {
        // List<DataMessage> jsonData =
        //     response.map((item) => DataMessage.fromJson(item)).toList();
        // return jsonData;
      } else if (response is Map) {
        if (response['res'] == 'done') {
          var data = response['msg'];
          return data;
        } else {
          throw BadRequestException('${response['msg']}');
        }
      } else {
        throw const FormatException('Lỗi không đúng định dạng.');
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('$e');
    }
  }

  @override
  postData(Map<String, dynamic> data) async {
    dynamic responseValue;
    try {
      await TokensTable.getToken().then((value) async {
        if (value == null || value.app_id.isEmpty) {
          throw BadRequestException('Lỗi không có App id.');
        }

        Map<String, dynamic> resquestData = {
          'app_id': value.app_id,
          'user_id': value.user_id.toString(),
          'login_token': value.login_token,
          ...data,
        };

        dynamic response = await apiService.postResponse(
          url: ApiEndPoints.accessServer(),
          jsonBody: resquestData,
        );

        if (response is List) {
          // List<DataMessage> jsonData =
          //     response.map((item) => DataMessage.fromJson(item)).toList();
          // return jsonData;
        } else if (response is Map) {
          if (response['res'] == 'done') {
            responseValue = response['data'];
          } else {
            throw BadRequestException('${response['msg']}');
          }
        } else {
          throw const FormatException('Lỗi không đúng định dạng.');
        }
      });
    } catch (e) {
      debugPrint('Lỗi: $e');
      throw Exception('$e');
    }
    return responseValue;
  }

  uploadFile(UploadFileModel data) async {
    dynamic responseValue;
    try {
      await TokensTable.getToken().then((value) async {
        if (value == null || value.app_id.isEmpty) {
          throw BadRequestException('Lỗi không có App id.');
        }

        Map<String, String> resquestData = {
          'app_id': value.app_id,
          'user_id': value.user_id.toString(),
          'login_token': value.login_token,
          ...data.requestData,
        };

        dynamic response = await apiService.uploadFileResponse(
          url: ApiEndPoints.accessServer(),
          jsonBody: resquestData,
          file: data.file,
        );

        if (response is List) {
          // List<DataMessage> jsonData =
          //     response.map((item) => DataMessage.fromJson(item)).toList();
          // return jsonData;
        } else if (response is Map) {
          if (response['res'] == 'done') {
            responseValue = response['data'];
          } else {
            throw BadRequestException('${response['msg']}');
          }
        } else {
          throw const FormatException('Lỗi không đúng định dạng.');
        }
      });
    } catch (e) {
      debugPrint('Lỗi: $e');
      throw Exception('$e');
    }
    return responseValue;
  }
}
