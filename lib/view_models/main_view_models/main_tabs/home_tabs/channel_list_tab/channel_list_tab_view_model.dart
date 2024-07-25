import 'dart:convert';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../models/home_models/channel_item_model.dart';
import '../../../../../models/login_models/request_data.dart';
import '../../../../../services/repository/access_server_repository.dart';
import '../../../../../services/response/api_response.dart';

class ChannelListTabViewModel extends GetxController {
  RxList<ChannelItemModel> listData = <ChannelItemModel>[].obs;

  int _page = 1;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final Rx<ApiResponse<bool>> examRes = ApiResponse<bool>.loading().obs;
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  void setChannelRes(ApiResponse<bool> res) {
    examRes.value = res;
  }

  Future<void> _fetchChannelData(RequestData req) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());
      List<ChannelItemModel> data =
          res.map((item) => ChannelItemModel.fromMap(item)).toList();
      setChannelRes(ApiResponse.completed(true));
      listData.addAll(data);
      listData.refresh();
    } catch (e, s) {
      s.printError();
      setChannelRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> _handleLoad() async {
    Map<String, dynamic> data = {
      'key': '',
      'page': _page,
    };

    RequestData resquestData = RequestData(
      query: 'channel_suggest',
      data: json.encode(data),
    );

    _fetchChannelData(resquestData);
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
