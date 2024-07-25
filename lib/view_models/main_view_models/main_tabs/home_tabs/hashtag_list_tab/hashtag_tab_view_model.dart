import 'dart:convert';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../models/home_models/hashtag.dart';
import '../../../../../models/login_models/request_data.dart';
import '../../../../../services/repository/access_server_repository.dart';
import '../../../../../services/response/api_response.dart';

class HashtagTabViewModel extends GetxController {
  RxList<Hashtag> listData = <Hashtag>[].obs;

  // int _page = 1;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final Rx<ApiResponse<List<Hashtag>>> hashtagRes =
      ApiResponse<List<Hashtag>>.loading().obs;
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  void setHashtagRes(ApiResponse<List<Hashtag>> res) {
    hashtagRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());
      List<Hashtag> data = res.map((item) => Hashtag.fromMap(item)).toList();

      listData.addAll(data);
      listData.refresh();

      setHashtagRes(ApiResponse.completed(data));
    } catch (e, s) {
      s.printError();
      setHashtagRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoad() async {
    Map data = {
      //
    };

    RequestData resquestData = RequestData(
      query: 'hashtag_list',
      data: json.encode(data),
    );

    _fetchData(resquestData);
  }

  Future<void> onLoading() async {
    // _page++;
    // await _handleLoad();
    // // if failed,use loadFailed(),if no data return,use LoadNodata()
    // refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    // _page = 1;
    listData.value = [];
    await _handleLoad();
    refreshController.refreshCompleted();
  }

  @override
  void onInit() {
    super.onInit();
    _handleLoad();
  }
}
