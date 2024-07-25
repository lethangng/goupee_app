import 'dart:convert';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../models/Exam/exam_history.dart';
import '../../../../../models/login_models/request_data.dart';
import '../../../../../services/repository/access_server_repository.dart';
import '../../../../../services/response/api_response.dart';

class HistoryTabViewModel extends GetxController {
  RxList<ExamHistory> listData = <ExamHistory>[].obs;

  int _page = 1;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final Rx<ApiResponse<List<ExamHistory>>> examHistoryRes =
      ApiResponse<List<ExamHistory>>.loading().obs;
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  void setExamHistoryRes(ApiResponse<List<ExamHistory>> res) {
    examHistoryRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());
      List<ExamHistory> data =
          res.map((item) => ExamHistory.fromMap(item)).toList();

      listData.addAll(data);
      listData.refresh();

      setExamHistoryRes(ApiResponse.completed(data));
    } catch (e, s) {
      s.printError();
      setExamHistoryRes(ApiResponse.error(e.toString()));
      // setExamHistoryRes(ApiResponse.error(
      //     'Bạn cần phải đăng nhập để sử dụng chức năng này.'));
    }
  }

  Future<void> _handleLoad() async {
    Map data = {
      'status': 1,
      'page': _page,
    };

    RequestData resquestData = RequestData(
      query: 'exam_history_list',
      data: json.encode(data),
    );

    _fetchData(resquestData);
  }

  Future<void> onLoading() async {
    _page++;
    await _handleLoad();
    // if failed,use loadFailed(),if no data return,use LoadNodata()
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
