import 'dart:convert';

import 'package:get/get.dart';

import '../../../../../../models/home_models/package_model.dart';
import '../../../../../../models/login_models/request_data.dart';
import '../../../../../../services/repository/access_server_repository.dart';
import '../../../../../../services/response/api_response.dart';

class NapGViewmodel extends GetxController {
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();
  final Rx<ApiResponse<List<PackageModel>>> packageRes =
      ApiResponse<List<PackageModel>>.loading().obs;

  final int _page = 1;

  RxList<PackageModel> listData = <PackageModel>[].obs;

  void setPackageRes(ApiResponse<List<PackageModel>> res) {
    packageRes.value = res;
  }

  Future<void> _fetchPackageData(RequestData req) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());
      List<PackageModel> data =
          res.map((item) => PackageModel.fromMap(item)).toList();
      setPackageRes(ApiResponse.completed(data));
      listData.addAll(data);
      listData.refresh();
    } catch (e, s) {
      s.printError();
      setPackageRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoad() async {
    Map data = {
      'page': _page,
    };

    RequestData resquestData = RequestData(
      query: 'package_list',
      data: json.encode(data),
    );

    _fetchPackageData(resquestData);
  }

  @override
  void onInit() {
    _handleLoad();
    super.onInit();
  }
}
