import 'package:flutter/material.dart';

import '../api/api_endpoints.dart';
import '../api/api_service.dart';
import '../exceptions/app_exceptions.dart';
import 'base_respository.dart';

class AppIdRepository implements BaseRepository {
  final ApiService apiService = ApiService();

  @override
  getData(data) async {
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
      rethrow;
    }
  }

  @override
  postData(data) {
    // TODO: implement postData
    throw UnimplementedError();
  }
}
