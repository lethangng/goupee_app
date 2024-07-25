import 'dart:convert';
import 'package:get/get.dart';

import '../../database/tables/token_table.dart';
import '../../models/app/app_data.dart';
import '../../models/login_models/request_data.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';

class AppDataController extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();
  final Rx<ApiResponse<AppData>> appDataRes =
      ApiResponse<AppData>.loading().obs;

  void setAppDataRes(ApiResponse<AppData> res) {
    appDataRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    setAppDataRes(ApiResponse.loading());
    try {
      final Map<String, dynamic> data =
          await _accessServerRepository.postData(req.toMap());

      AppData appData = AppData.fromMap(data);
      printInfo(info: appData.toString());

      setAppDataRes(ApiResponse.completed(appData));
    } catch (e, s) {
      s.printError();
      setAppDataRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleGetAppData() async {
    await TokensTable.getToken().then((token) async {
      if (token == null) {
        appDataRes(ApiResponse.completed(null));
        return;
      }

      Map data = {
        //
      };

      RequestData resquestData = RequestData(
        query: 'get_local_data',
        data: json.encode(data),
      );

      await _fetchData(resquestData);
    });
  }
}
