import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../database/tables/token_table.dart';
import '../../models/login_models/request_data.dart';
import '../../models/table/token.dart';
import '../../models/table/user.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';

class UserController extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final Rx<ApiResponse<User>> userRes = ApiResponse<User>.loading().obs;

  void setUserRes(ApiResponse<User> res) {
    userRes.value = res;
  }

  Future<void> _fetchUserDetail(RequestData req) async {
    try {
      setUserRes(ApiResponse.loading());
      final Map<String, dynamic> data =
          await _accessServerRepository.postData(req.toMap());

      User user = User.fromMap(data);
      Token? token = await TokensTable.getToken();
      user.is_login = token?.is_login;

      debugPrint(user.toString());

      setUserRes(ApiResponse.completed(user));
    } catch (e, s) {
      s.printError();
      setUserRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleGetUser() async {
    await TokensTable.getToken().then((token) async {
      // Chưa đăng nhập thì không lấy data User nữa
      if (token == null || token.user_id == 0) {
        setUserRes(ApiResponse.completed(null));
        return;
        // throw Exception('Lỗi không có App id.');
      }

      Map<String, dynamic> data = {
        //
      };

      RequestData resquestData = RequestData(
        query: 'user_info',
        data: json.encode(data),
      );

      await _fetchUserDetail(resquestData);
    });
  }
}
