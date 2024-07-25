import 'dart:convert';

import 'package:get/get.dart';

import '../../../../../../models/login_models/request_data.dart';
import '../../../../../../models/table/user.dart';
import '../../../../../../services/repository/access_server_repository.dart';
import '../../../../../../services/response/api_response.dart';
import '../../../../../database/tables/token_table.dart';

class MyGioiThieuTab extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final Rx<ApiResponse<User>> userRes = ApiResponse<User>.loading().obs;

  void setUserRes(ApiResponse<User> res) {
    userRes.value = res;
  }

  Future<void> _fetchUserDetail(RequestData req) async {
    setUserRes(ApiResponse.loading());
    try {
      final Map<String, dynamic> data =
          await _accessServerRepository.postData(req.toMap());

      User user = User.fromMap(data);

      setUserRes(ApiResponse.completed(user));
    } catch (e, s) {
      s.printError();
      setUserRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleGetUser() async {
    await TokensTable.getToken().then((token) async {
      if (token == null) return;

      Map data = {
        'user_id': token.user_id,
      };

      RequestData resquestData = RequestData(
        query: 'user_detail',
        data: json.encode(data),
      );

      _fetchUserDetail(resquestData);
    });
  }

  @override
  void onInit() {
    super.onInit();
    handleGetUser();
  }
}
