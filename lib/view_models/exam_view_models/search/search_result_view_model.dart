import 'dart:convert';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/home_models/exam_item_model.dart';
import '../../../models/home_models/search_exam_model.dart';
import '../../../models/login_models/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';

class SearchResultViewModel extends GetxController {
  final RxList<ExamItemModel> listData = <ExamItemModel>[].obs;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  late final String searchValue;
  // late final bool isHashtag;
  final RxInt totalResult = 0.obs;

  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final Rx<ApiResponse<SearchExamModel>> examRes =
      ApiResponse<SearchExamModel>.loading().obs;

  int _page = 1;

  void setExamRes(ApiResponse<SearchExamModel> res) {
    examRes.value = res;
  }

  Future<void> _fetchExamData(RequestData req) async {
    try {
      final Map<String, dynamic> res =
          await _accessServerRepository.postData(req.toMap());

      SearchExamModel data = SearchExamModel.fromMap(res);
      setExamRes(ApiResponse.completed(data));

      // Tu lan loading thu 2 thi khong can lay tong ket qua
      if (totalResult.value == 0) {
        totalResult.value = data.total_result!;
      }

      listData.addAll(data.exams);
      listData.refresh();
    } catch (e, s) {
      s.printError();
      setExamRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoadExam() async {
    Map data = {
      'key': searchValue,
      'page': _page,
      'get_total': totalResult.value == 0 ? 1 : '',
    };

    RequestData resquestData = RequestData(
      query: 'exam_search',
      data: json.encode(data),
    );

    await _fetchExamData(resquestData);
  }

  Future<void> onLoadingExam() async {
    _page++;
    await _handleLoadExam();
    refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    _page = 1;
    listData.value = [];
    await _handleLoadExam();
    refreshController.refreshCompleted();
  }

  @override
  void onInit() {
    // searchValue = searchViewViewModel.textSearchController.text;
    searchValue = Get.arguments['searchValue'];
    // isHashtag = Get.arguments['isHashtag'];
    _handleLoadExam();

    super.onInit();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
