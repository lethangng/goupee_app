import 'dart:convert';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/Exam/sentence_search.dart';
import '../../models/login_models/request_data.dart';
import '../../services/repository/access_server_repository.dart';
import '../../services/response/api_response.dart';

class CreateExamViewModel extends GetxController {
  final RxList<SentenceSearch> listData = <SentenceSearch>[].obs;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final Rx<ApiResponse<List<SentenceSearch>>> sentenceSearchRes =
      ApiResponse<List<SentenceSearch>>.loading().obs;

  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  // int examType = 0;

  void setSentenceSearchRes(ApiResponse<List<SentenceSearch>> res) {
    sentenceSearchRes.value = res;
  }

  Future<void> fetchData(RequestData req) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());
      List<SentenceSearch> data =
          res.map((item) => SentenceSearch.fromMap(item)).toList();
      setSentenceSearchRes(ApiResponse.completed(data));
      listData.addAll(data);
      listData.refresh();
    } catch (e, s) {
      s.printError();
      setSentenceSearchRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoad() async {
    Map data = {
      //
    };

    RequestData resquestData = RequestData(
      query: 'suggest_sentence_suggest',
      data: json.encode(data),
    );

    fetchData(resquestData);
  }

  @override
  void onInit() {
    handleLoad();
    super.onInit();
  }
}
