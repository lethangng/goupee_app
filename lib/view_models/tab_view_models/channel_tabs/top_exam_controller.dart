import 'dart:convert';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/home_models/top_exam_model.dart';
import '../../../models/login_models/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';
import '../../controllers/app_data_controller.dart';

class TopExamController extends GetxController {
  RxList<TopExamModel> listData = <TopExamModel>[].obs;
  final AppDataController _appDataController = Get.find<AppDataController>();

  int _page = 1;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final Rx<ApiResponse<bool>> topExamRes = ApiResponse<bool>.loading().obs;
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  void setTopExamRes(ApiResponse<bool> res) {
    topExamRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());
      List<TopExamModel> data =
          res.map((item) => TopExamModel.fromMap(item)).toList();

      // Xoa List cua top_exam va cap nhap lai List moi
      _appDataController.appDataRes.value.data!.top_exams.clear();
      _appDataController.appDataRes.value.data!.top_exams
          .addAll(data.map((item) => item.id).toList());

      setTopExamRes(ApiResponse.completed(true));

      listData.addAll(data);
      listData.refresh();
    } catch (e, s) {
      s.printError();
      setTopExamRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoad() async {
    Map<String, dynamic> data = {
      'limit': 15,
      'page': _page,
    };

    RequestData resquestData = RequestData(
      query: 'top_exam',
      data: json.encode(data),
    );

    await _fetchData(resquestData);
  }

  Future<void> onLoading() async {
    _page++;
    await _handleLoad();
    refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    _page = 1;
    listData.value = [];
    await _handleLoad();
    refreshController.refreshCompleted();
  }

  @override
  void onInit() {
    _handleLoad();
    super.onInit();
  }
}
