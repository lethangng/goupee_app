import 'dart:convert';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../database/tables/token_table.dart';
import '../../../../../models/home_models/exam_item_model.dart';
import '../../../../../models/login_models/request_data.dart';
import '../../../../../services/repository/access_server_repository.dart';
import '../../../../../services/response/api_response.dart';

class MyExamTab extends GetxController {
  RxList<ExamItemModel> listData = <ExamItemModel>[].obs;

  int _page = 1;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final Rx<ApiResponse<List<ExamItemModel>>> examRes =
      ApiResponse<List<ExamItemModel>>.loading().obs;
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  void setExamRes(ApiResponse<List<ExamItemModel>> res) {
    examRes.value = res;
  }

  Future<void> _fetchExamData(RequestData req) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());
      List<ExamItemModel> data =
          res.map((item) => ExamItemModel.fromMap(item)).toList();
      setExamRes(ApiResponse.completed(data));
      listData.addAll(data);
      listData.refresh();
    } catch (e, s) {
      s.printError();
      setExamRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoad() async {
    await TokensTable.getToken().then((token) async {
      if (token == null) return;

      Map data = {
        'page': _page,
        'exam_ids': '',
        'mascot_id': '',
        'user_id': token.user_id,
      };

      RequestData resquestData = RequestData(
        query: 'exam_list',
        data: json.encode(data),
      );

      _fetchExamData(resquestData);
    });
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
    // if(failed){
    //   refreshController.refreshFailed();
    // }
  }

  @override
  void onInit() {
    _handleLoad();
    super.onInit();
  }
}
