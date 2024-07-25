import 'dart:convert';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/home_models/top_channel_model.dart';
import '../../../models/login_models/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';
import '../../controllers/app_data_controller.dart';

class TopChannelController extends GetxController {
  final RxList<ChannelRanking> listData = <ChannelRanking>[].obs;
  final AppDataController _appDataController = Get.find<AppDataController>();
  final RxString currentRanking = '0'.obs;

  int _page = 1;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final Rx<ApiResponse<bool>> topChannelRes = ApiResponse<bool>.loading().obs;
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  void setTopExamRes(ApiResponse<bool> res) {
    topChannelRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      final Map<String, dynamic> res =
          await _accessServerRepository.postData(req.toMap());
      TopChannelModel topChannelValue = TopChannelModel.fromMap(res);

      // Xoa List cua top_channels va cap nhap lai List moi
      _appDataController.appDataRes.value.data!.top_channels.clear();
      _appDataController.appDataRes.value.data!.top_channels
          .addAll(topChannelValue.top_channels.map((item) => item.id).toList());

      if (_page == 1) {
        // Cap nhap rank hien tai cua user
        currentRanking.value = topChannelValue.current_ranking!.toString();
      }

      setTopExamRes(ApiResponse.completed(true));

      // Cap nhap lai List rank
      listData.addAll(topChannelValue.top_channels);
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
      'show_ranking': _page == 1 ? 1 : '',
    };

    RequestData resquestData = RequestData(
      query: 'top_channel',
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
