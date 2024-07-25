// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../database/tables/token_table.dart';
import '../../../models/home_models/mascot_item.dart';
import '../../../models/login_models/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';

class MascotTabViewModel extends GetxController {
  final int? userId;
  final int? channelId;
  MascotTabViewModel({
    this.userId,
    this.channelId,
  });
  final RxList<MascotItem> listData = <MascotItem>[].obs;

  int _page = 1;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final Rx<ApiResponse<List<MascotItem>>> mascotRes =
      ApiResponse<List<MascotItem>>.loading().obs;
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  void setLinhVatRes(ApiResponse<List<MascotItem>> res) {
    mascotRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      final List res = await _accessServerRepository.postData(req.toMap());
      List<MascotItem> data =
          res.map((item) => MascotItem.fromMap(item)).toList();
      setLinhVatRes(ApiResponse.completed(data));
      listData.addAll(data);
      listData.refresh();
    } catch (e, s) {
      s.printError();
      refreshController.loadFailed();
      setLinhVatRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoad() async {
    await TokensTable.getToken().then((value) async {
      if (value == null) return;

      Map data = {
        'key': '',
        'page': _page,
        // 'user_id': userId ?? value.user_id,
        'user_id': '',
        'channel_id': channelId ?? '',
      };

      RequestData resquestData = RequestData(
        query: 'mascot_list',
        data: json.encode(data),
      );

      _fetchData(resquestData);
    });
  }

  Future<void> onLoading() async {
    _page++;
    await handleLoad();
    refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    _page = 1;
    listData.value = [];
    await handleLoad();
    refreshController.refreshCompleted();
  }

  @override
  void onInit() {
    super.onInit();
    handleLoad();
  }
}
